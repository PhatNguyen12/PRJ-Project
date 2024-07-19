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
import model.Documents;

@WebServlet("/EditDocumentServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class EditDocumentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int documentID = Integer.parseInt(request.getParameter("documentID"));
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
            //đường dẫn lưu ảnh
            String path = request.getServletContext().getRealPath("/documents");
            File dir = new File(path);
            //ko có đường dẫn => tự tạo ra
            if (!dir.exists()) {
                dir.mkdirs();
            }

            File file = new File(dir, filePart.getSubmittedFileName());
            filePart.write(file.getAbsolutePath());
            filePath = request.getContextPath() + "/documents/" + file.getName();

        }

        // Update the document in the database
        DocumentDAO documentDAO = new DocumentDAO();
        Documents document = Documents.builder()
                .DocumentID(documentID)
                .Title(title)
                .Description(description)
                .FilePath(filePath)
                .UploadDate(sqlUploadDate)
                .DocumentTypeID(documentTypeID)
                .build();
        documentDAO.updateDocument(document);

        response.sendRedirect(request.getContextPath() + "/document");
    }
}
