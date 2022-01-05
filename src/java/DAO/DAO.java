/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HarveyNguyen
 */
public class DAO {

    public static Connection con;
    static final Logger logger = Logger.getLogger(DAO.class.getName());

    public DAO() {
        boolean checkDB = getDBConnection();
        if (!checkDB) {
            logger.log(Level.SEVERE, "DB Failed");
            return;
        }
    }

    private boolean getDBConnection() {
        String dbUrl = "jdbc:mysql://localhost:3306/library_management?autoReconnect=true&useSSL=false";
        String dbClass = "com.mysql.cj.jdbc.Driver";
        try {
            Class.forName(dbClass);
            con = (Connection) DriverManager.getConnection(dbUrl, "root", "");
            logger.log(Level.INFO, "Connected to DB successfully");
        } catch (ClassNotFoundException | SQLException e) {
            logger.log(Level.SEVERE, "Error DB Connection", e);
        }
        return true;
    }
}
