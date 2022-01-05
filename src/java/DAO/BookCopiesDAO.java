/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import static DAO.DAO.con;
import static DAO.DAO.logger;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import model.BookCopies;

/**
 *
 * @author HarveyNguyen
 */
public class BookCopiesDAO {

    public ArrayList<BookCopies> getListBookCopies(String name, String action) {
        ArrayList<BookCopies> lb = new ArrayList<>();
        String getListBookCopiesQuery = "SELECT bc.barcode as barcode, b.title as title, b.author as author FROM tblBookCopies as bc, tblBook as b WHERE b.title LIKE ? AND bc.status = ? AND bc.bookId = b.bookId";
        try {
            PreparedStatement ps = con.prepareStatement(getListBookCopiesQuery);
            ps.setString(1, "%" + name + "%");
            if ("lend".equals(action)) {
                ps.setString(2, "available");
            }
            else {
                ps.setString(2, "borrowed");
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookCopies bc = new BookCopies();
                bc.setBarcode(rs.getInt("barcode"));
                bc.setTitle(rs.getString("title"));
                bc.setAuthor(rs.getString("author"));
                lb.add(bc);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getListReader", e);
        }
        return lb;
    }
}
