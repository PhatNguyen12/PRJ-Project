package controller;

import dal.NoteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Note;
import model.Users;

@WebServlet(name = "NoteServlet", urlPatterns = {"/notes"})
public class NoteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the user ID from the session
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");

        if (currentUser == null) {
            // If the user ID is not available in the session, redirect to the login page
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get the notes for the user
        NoteDAO noteDAO = new NoteDAO();
        List<Note> notes = noteDAO.getNotesByUserId(currentUser.getUserID());

        // Set the notes as an attribute in the request
        request.setAttribute("notes", notes);

        // Forward the request to the note.jsp page
        request.getRequestDispatcher("/note.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the user ID from the session
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");

        if (currentUser == null) {
            // If the user ID is not available in the session, redirect to the login page
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        NoteDAO noteDAO = new NoteDAO();
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "create":
                    String title = request.getParameter("title");
                    String note = request.getParameter("note");
                    noteDAO = new NoteDAO();
                    noteDAO.createNote(title, note, currentUser.getUserID());
                    response.sendRedirect(request.getContextPath() + "/notes");
                    break;
                case "edit":
                    int noteID = Integer.parseInt(request.getParameter("noteID"));
                    title = request.getParameter("title");
                    note = request.getParameter("note");
                    noteDAO.updateNote(noteID, title, note);
                    response.sendRedirect(request.getContextPath() + "/notes");
                    break;
                case "delete":
                    noteID = Integer.parseInt(request.getParameter("noteID"));
                    noteDAO.deleteNote(noteID);
                    response.sendRedirect(request.getContextPath() + "/notes");
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/notes");
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/notes");
        }
    }
}
