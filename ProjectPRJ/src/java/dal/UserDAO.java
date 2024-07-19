package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Users;

public class UserDAO extends DBContext {

    public Users getUserByUsernameAndPassword(String username, String password) {
        try {
            String sql = "SELECT * FROM Users WHERE Username = ? AND Password = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                Users user = Users.builder()
                        .UserID(resultSet.getInt("UserID"))
                        .Username(resultSet.getString("Username"))
                        .Password(resultSet.getString("Password"))
                        .Email(resultSet.getString("Email"))
                        .RoleID(resultSet.getInt("RoleID"))
                        .build();
                return user;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Users> getAll() {
        PreparedStatement stm;
        ResultSet rs;
        List<Users> list = new ArrayList<>();
        try {
            String strSelect = "select * from Users";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                Users us = new Users(rs.getInt("UserID")
                        , rs.getString("Username")
                        , rs.getString("Password")
                        , rs.getString("Email")
                        , rs.getInt("RoleID"));
                        
                list.add(us);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Users getUserByUsername(String username) {
        Users user = null;
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM Users WHERE Username=?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new Users(rs.getInt("UserID"), rs.getString("Username"), rs.getString("Password"), rs.getString("Email"), rs.getInt("RoleID"));
            }
        } catch (SQLException e) {
        }
        return user;
    }

    public void saveUser(Users user) {
        try {
            PreparedStatement ps = connection.prepareStatement("INSERT INTO Users (Username, Password, Email) VALUES (?, ?, ?)");
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        Users user = userDAO.getUserByUsernameAndPassword("admin", "123");
        if (user != null) {
            System.out.println("User found: " + user.getUsername());
        } else {
            System.out.println("User not found");
        }
    }
}
