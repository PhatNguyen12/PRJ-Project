package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DocumentTypes;

/**
 * Data Access Object (DAO) class for DocumentTypes entity.
 * Handles database operations related to DocumentTypes.
 */
public class DocumentTypesDAO extends DBContext {

    /**
     * Retrieves all DocumentTypes from the database.
     * @return List of DocumentTypes
     */
    public List<DocumentTypes> getAllDocumentTypes() {
        List<DocumentTypes> documentTypes = new ArrayList<>();
        try {
            String sql = "SELECT id, name FROM DocumentTypes";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                DocumentTypes documentType = DocumentTypes.builder()
                        .id(resultSet.getInt("id"))
                        .name(resultSet.getString("name"))
                        .build();
                documentTypes.add(documentType);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DocumentTypesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return documentTypes;
    }

    /**
     * Main method to test the DocumentTypesDAO.
     * @param args command line arguments (not used)
     */
    public static void main(String[] args) {
        DocumentTypesDAO dao = new DocumentTypesDAO();
        List<DocumentTypes> documentTypes = dao.getAllDocumentTypes();
        for (DocumentTypes documentType : documentTypes) {
            System.out.println(documentType);
        }
    }
}
