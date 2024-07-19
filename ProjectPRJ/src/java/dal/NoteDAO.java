package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Note;

public class NoteDAO extends DBContext {

    public List<Note> getNotesByUserId(int userId) {
        List<Note> notes = new ArrayList<>();

        try (Connection conn = new NoteDAO().connection; PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Note WHERE userId = ?")) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Note note = new Note();
                note.setId(rs.getInt("id"));
                note.setTitle(rs.getString("title"));
                note.setNote(rs.getString("note"));
                note.setUserId(rs.getInt("userId"));
                note.setCreateDate(rs.getTimestamp("createDate").toLocalDateTime());
                note.setModifiedDate(rs.getTimestamp("modifiedDate").toLocalDateTime());

                notes.add(note);
            }
        } catch (SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return notes;
    }

    public void createNote(String title, String note, int userId) {
        try (Connection conn = new NoteDAO().connection; PreparedStatement stmt = conn.prepareStatement("INSERT INTO Note (title, note, userId, createDate, modifiedDate) VALUES (?, ?, ?, ?, ?)")) {

            java.time.LocalDateTime now = java.time.LocalDateTime.now();
            stmt.setString(1, title);
            stmt.setString(2, note);
            stmt.setInt(3, userId);
            stmt.setTimestamp(4, Timestamp.valueOf(now));
            stmt.setTimestamp(5, Timestamp.valueOf(now));

            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateNote(int noteId, String title, String note) {
        try (Connection conn = new NoteDAO().connection; PreparedStatement stmt = conn.prepareStatement("UPDATE Note SET title = ?, note = ?, modifiedDate = ? WHERE id = ?")) {

            java.time.LocalDateTime now = java.time.LocalDateTime.now();
            stmt.setString(1, title);
            stmt.setString(2, note);
            stmt.setTimestamp(3, Timestamp.valueOf(now));
            stmt.setInt(4, noteId);

            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteNote(int noteId) {
        try (Connection conn = new NoteDAO().connection; PreparedStatement stmt = conn.prepareStatement("DELETE FROM Note WHERE id = ?")) {

            stmt.setInt(1, noteId);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(NoteDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
