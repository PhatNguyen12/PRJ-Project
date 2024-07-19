package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Documents;

/**
 * Data Access Object (DAO) class for the Documents table. Provides methods to
 * interact with the Documents table in the database.
 */
public class DocumentDAO extends DBContext {

    /**
     * Retrieves all documents from the database.
     *
     * @return a list of Documents objects representing the retrieved documents
     */
    public List<Documents> getAllDocuments() {
        List<Documents> documents = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Documents";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Documents document = Documents.builder()
                        .DocumentID(resultSet.getInt("DocumentID"))
                        .Title(resultSet.getString("Title"))
                        .Description(resultSet.getString("Description"))
                        .FilePath(resultSet.getString("FilePath"))
                        .UploadedBy(resultSet.getInt("UploadedBy"))
                        .UploadDate(resultSet.getDate("UploadDate"))
                        .build();
                documents.add(document);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DocumentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return documents;
    }

    /**
     * Retrieves all documents from the database.
     *
     * @return a list of Documents objects representing the retrieved documents
     */
    public List<Documents> getDocumentsByUserId(Object userId) {
        List<Documents> documents = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Documents WHERE UploadedBy = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setObject(1, userId);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Documents document = Documents.builder()
                        .DocumentID(resultSet.getInt("DocumentID"))
                        .Title(resultSet.getString("Title"))
                        .Description(resultSet.getString("Description"))
                        .FilePath(resultSet.getString("FilePath"))
                        .UploadedBy(resultSet.getInt("UploadedBy"))
                        .UploadDate(resultSet.getDate("UploadDate"))
                        .DocumentTypeID(resultSet.getInt("DocumentTypeID"))
                        .build();
                documents.add(document);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DocumentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return documents;
    }

    /**
     * Updates an existing document in the database.
     *
     * @param document the updated document information
     */
    public void updateDocument(Documents document) {
        try {
            String sql = "UPDATE Documents SET Title = ?, Description = ?, FilePath = ?, UploadDate = ?, DocumentTypeID = ? WHERE DocumentID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, document.getTitle());
            statement.setString(2, document.getDescription());
            statement.setString(3, document.getFilePath());
            statement.setDate(4, document.getUploadDate());
            statement.setInt(5, document.getDocumentTypeID());
            statement.setInt(6, document.getDocumentID());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DocumentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void createDocument(Documents document) {
        try {
            String sql = "INSERT INTO Documents (Title, Description, FilePath, UploadDate, DocumentTypeID, UploadedBy) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, document.getTitle());
            statement.setString(2, document.getDescription());
            statement.setString(3, document.getFilePath());
            statement.setDate(4, document.getUploadDate());
            statement.setInt(5, document.getDocumentTypeID());
            statement.setInt(6, document.getUploadedBy());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DocumentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * * Retrieves a document by its ID from the database. * * @param
     * documentId the ID of the document to retrieve * @return the Documents
     * object representing the retrieved document, or null if not found
     */
    public Documents getDocumentById(int documentId) {
        try {
            String sql = "SELECT * FROM Documents WHERE DocumentID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, documentId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return Documents.builder().DocumentID(resultSet.getInt("DocumentID")).Title(resultSet.getString("Title")).Description(resultSet.getString("Description")).FilePath(resultSet.getString("FilePath")).UploadedBy(resultSet.getInt("UploadedBy")).UploadDate(resultSet.getDate("UploadDate")).DocumentTypeID(resultSet.getInt("DocumentTypeID")).build();
            }
        } catch (SQLException ex) {
            Logger.getLogger(DocumentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * * Deletes a document from the database. * * @param document the document
     * to be deleted
     */
    public void deleteDocument(Documents document) {
        try {
            String sql = "DELETE FROM Documents WHERE DocumentID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, document.getDocumentID());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DocumentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        // Create an instance of the DocumentDAO   
        DocumentDAO documentDAO = new DocumentDAO();
        // Retrieve all documents from the database      
        List<Documents> documents = documentDAO.getDocumentsByUserId(2);
        // Print the retrieved documents   
        for (Documents document : documents) {
            System.out.println(document);
        }
    }
}
