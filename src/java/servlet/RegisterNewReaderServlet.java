/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import DAO.LibCardDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.LibCard;
import util.DateUtil;

/**
 *
 * @author HarveyNguyen
 */
@WebServlet(name = "RegisterNewReader", urlPatterns = {"/RegisterNewReader"})
public class RegisterNewReaderServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("page/registerNewReaderPage.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DateUtil dc = new DateUtil();
        LibCardDAO ld = new LibCardDAO();
        LibCard lc = new LibCard();
        try {
            lc = ld.registerNewReader(Integer.parseInt(request.getParameter("id")), request.getParameter("fullname"), dc.convertStringToDate(request.getParameter("DoB")), request.getParameter("address"), request.getParameter("telephone"), request.getParameter("email"));
        } catch (SQLException ex) {
            Logger.getLogger(RegisterNewReaderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (lc != null) {
            request.getSession().setAttribute("libCard", lc);
            request.getRequestDispatcher("page/registerNewReaderPage.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("error", "There is something wrong, please try again");
            request.getRequestDispatcher("page/registerNewReaderPage.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
