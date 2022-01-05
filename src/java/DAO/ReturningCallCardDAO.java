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
import model.ReturningCallCard;

/**
 *
 * @author HarveyNguyen
 */
public class ReturningCallCardDAO {
    public ReturningCallCard createReturningCallCard(ReturningCallCard returningCallCard) throws SQLException {
        ReturningCallCard rcc = new ReturningCallCard();
        int returningCallCardId = 0;
        String insertReturningCallCard = "INSERT INTO tblReturningCallCard(fine, returningDate, libCardId, userId) VALUES(?, ?, ?, ?)";
        try {
            con.setAutoCommit(false);
            PreparedStatement ps = con.prepareStatement(insertReturningCallCard, Statement.RETURN_GENERATED_KEYS);
            ps.setFloat(1, returningCallCard.getFine());
            ps.setDate(2, new java.sql.Date(returningCallCard.getReturningDate().getTime()));
            ps.setInt(3, returningCallCard.getBorrower().getCardId());
            ps.setInt(4, returningCallCard.getLibrarian().getId());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                returningCallCardId = rs.getInt(1);
            }
            try {
                String updateBookCopies = "UPDATE tblBookCopies SET status = ?, returningCallCardId = ? WHERE barcode = ?";
                for (BookCopies b : returningCallCard.getLb()) {
                    PreparedStatement ps2 = con.prepareStatement(updateBookCopies);
                    ps2.setString(1, b.getStatus());
                    ps2.setInt(2, returningCallCardId);
                    ps2.setInt(3, b.getBarcode());
                    ps2.executeUpdate();
                }
            } catch (SQLException e) {
                con.rollback();
                logger.log(Level.SEVERE, "Error createReturningCallCard", e);
            }
            rcc = returningCallCard;
            con.commit();
        } catch (SQLException e) {
            con.rollback();
            logger.log(Level.SEVERE, "Error createReturningCallCard", e);
        }
        return rcc;
    }
}
