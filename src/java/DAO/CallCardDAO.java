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
import java.sql.Statement;
import java.util.logging.Level;
import model.BookCopies;
import model.CallCard;

/**
 *
 * @author HarveyNguyen
 */
public class CallCardDAO {

    public CallCard createCallCard(CallCard callcard) throws SQLException {
        CallCard cc = new CallCard();
        int callCardId = 0;
        String insertCallCard = "INSERT INTO tblCalllCard(borrowingDate, dueDate, libCardId, userId) VALUES(NOW(), ?, ?, ?)";
        try {
            con.setAutoCommit(false);
            PreparedStatement ps = con.prepareStatement(insertCallCard, Statement.RETURN_GENERATED_KEYS);
            ps.setDate(1, new java.sql.Date(callcard.getDueDate().getTime()));
            ps.setInt(2, callcard.getBorrower().getCardId());
            ps.setInt(3, callcard.getLibrarian().getId());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                callCardId = rs.getInt(1);
            }
            try {
                String updateBookCopies = "UPDATE tblBookCopies SET status = 'borrowed', callCardId = ? WHERE barcode = ?";
                for (BookCopies b : callcard.getLb()) {
                    PreparedStatement ps2 = con.prepareStatement(updateBookCopies);
                    ps2.setInt(1, callCardId);
                    ps2.setInt(2, b.getBarcode());
                    ps2.executeUpdate();
                }
            } catch (SQLException e) {
                con.rollback();
                logger.log(Level.SEVERE, "Error createCallCard", e);
            }
            cc = callcard;
            con.commit();
        } catch (SQLException e) {
            con.rollback();
            logger.log(Level.SEVERE, "Error createCallCard", e);
        }
        return cc;
    }
}
