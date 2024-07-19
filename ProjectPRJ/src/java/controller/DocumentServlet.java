package controller;

import dal.DocumentDAO;
import dal.DocumentTypesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.DocumentTypes;
import model.Documents;
import model.Users;

public class DocumentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the current user from the session
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");

        // Retrieve documents based on the current user's ID
        DocumentDAO documentDAO = new DocumentDAO();
        List<Documents> documents = documentDAO.getDocumentsByUserId(currentUser.getUserID());

        // Retrieve all document types
        DocumentTypesDAO documentTypesDAO = new DocumentTypesDAO();
        List<DocumentTypes> documentTypes = documentTypesDAO.getAllDocumentTypes();

        // Set the documents and document types as request attributes to be used in the JSP
        request.setAttribute("documents", documents);
        request.setAttribute("documentTypes", documentTypes);

        // Forward the request to the dashboard.jsp
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }
}
