/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author HarveyNguyen
 */
public class UserDAO extends DAO {
    static final Logger logger = Logger.getLogger(UserDAO.class.getName());

    public UserDAO() {
    }

    public User checkLogin(String username, String password) {
        User u = new User();
        String query = "SELECT * FROM tblUser WHERE username = ? AND password = ?";
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new User(rs.getInt("id"), rs.getString("username"), rs.getString("fullname"), rs.getDate("DoB"), rs.getString("address"), rs.getString("email"), rs.getString("telephone"), rs.getString("role"));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checkLogin", e);
        }
        return u;
    }
}
