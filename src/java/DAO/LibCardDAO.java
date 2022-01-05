/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.LibCard;
import model.Reader;
import util.DateUtil;

/**
 *
 * @author HarveyNguyen
 */
public class LibCardDAO extends DAO {
    DateUtil dc = new DateUtil();
    static final Logger logger = Logger.getLogger(UserDAO.class.getName());

    public LibCard registerNewReader(int id, String fullname, Date DoB, String address, String telephone, String email) throws SQLException {
        LibCard lc = new LibCard();
        String insertUser = "UPDATE tblUser SET fullname = ?, DoB = ?, address = ?, telephone = ?, email = ? WHERE id = ?";
        String insertLibCard = "INSERT INTO tblLibCard(expDate, userId) VALUES(DATE_ADD(NOW(), INTERVAL 30 DAY), ?)";
        try {
            con.setAutoCommit(false);
            PreparedStatement ps = con.prepareStatement(insertUser);
            PreparedStatement ps2 = con.prepareStatement(insertLibCard);
            ps.setString(1, fullname);
            ps.setDate(2, new java.sql.Date(DoB.getTime()));
            ps.setString(3, address);
            ps.setString(4, telephone);
            ps.setString(5, email);
            ps.setInt(6, id);
            ps2.setInt(1, id);
            int rowAffected = ps.executeUpdate();
            int rowAffected2 = ps2.executeUpdate();
            if (rowAffected == 1 && rowAffected2 == 1) {
                Reader r = new Reader(fullname, DoB, address, telephone, email);
                lc.setExp_date(dc.convertStringToDate(dc.convertDateToString(dc.getNDaysLater(30))));
                lc.setR(r);
            }
            con.commit();
        } catch (SQLException e) {
            con.rollback();
            logger.log(Level.SEVERE, "Error registerNewReader", e);
        }
        return lc;
    }
    
    public LibCard getLibCardInfo(int libCardId) {
        LibCard lc = new LibCard();
        String findLibCard = "SELECT lc.cardId as cardId, u.id as readerId, u.fullname as readerName FROM tblLibCard as lc, tblUser as u WHERE lc.userId = u.id AND lc.cardId = ?";
        try {
            PreparedStatement ps = con.prepareStatement(findLibCard);
            ps.setInt(1, libCardId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lc.setCardId(Integer.parseInt(rs.getString("cardId")));
                Reader r = new Reader();
                r.setId(Integer.parseInt(rs.getString("readerId")));
                r.setFullname(rs.getString("readerName"));
                lc.setR(r);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getLibCardInfo", e);
        }
        return lc;
    }
}
