package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import dal.DocumentDAO;
import jakarta.servlet.http.HttpSession;
import model.Documents;
import model.Users;

@WebServlet("/createDocument")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class CreateDocumentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Get the current user from the session
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String uploadDateStr = request.getParameter("uploadDate");
        int documentTypeID = Integer.parseInt(request.getParameter("documentTypeID"));
        Part filePart = request.getPart("file");

        // Convert the uploaded date string to a java.sql.Date object
        LocalDateTime uploadDate = LocalDateTime.parse(uploadDateStr, DateTimeFormatter.ISO_DATE_TIME);
        java.sql.Date sqlUploadDate = java.sql.Date.valueOf(uploadDate.toLocalDate());

        String filePath = null;
        if (filePart != null && filePart.getSize() > 0) {
            // Path to save the uploaded file
            String path = request.getServletContext().getRealPath("/documents");
            File dir = new File(path);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            File file = new File(dir, filePart.getSubmittedFileName());
            filePart.write(file.getAbsolutePath());
            filePath = request.getContextPath() + "/documents/" + file.getName();
        }

        // Create a new document and save it to the database
        DocumentDAO documentDAO = new DocumentDAO();
        Documents document = Documents.builder()
                .Title(title)
                .Description(description)
                .FilePath(filePath)
                .UploadDate(sqlUploadDate)
                .UploadedBy(currentUser.getUserID())
                .DocumentTypeID(documentTypeID)
                .build();
        documentDAO.createDocument(document);

        response.sendRedirect(request.getContextPath() + "/document");
    }
}
