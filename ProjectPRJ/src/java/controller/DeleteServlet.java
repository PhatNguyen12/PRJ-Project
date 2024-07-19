/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.DocumentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Documents;

@WebServlet(name="DeleteServlet", urlPatterns={"/DeleteDocumentServlet"})
public class DeleteServlet extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int documentId = Integer.parseInt(request.getParameter("documentID"));
        
        DocumentDAO documentDAO = new DocumentDAO();
        Documents document = documentDAO.getDocumentById(documentId);
        
        if (document != null) {
            documentDAO.deleteDocument(document);
            response.sendRedirect(request.getContextPath() + "/document");
        } else {
            request.setAttribute("errorMessage", "Failed to delete document.");
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        }
    }
}
