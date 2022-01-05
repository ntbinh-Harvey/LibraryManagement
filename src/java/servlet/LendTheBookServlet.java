/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import DAO.BookCopiesDAO;
import DAO.CallCardDAO;
import DAO.LibCardDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.BookCopies;
import model.CallCard;
import model.LibCard;
import model.Librarian;
import model.User;
import util.DateUtil;

/**
 *
 * @author HarveyNguyen
 */
@WebServlet(name = "LendTheBook", urlPatterns = {"/LendTheBook"})
public class LendTheBookServlet extends HttpServlet {

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
        if (request.getParameter("libCardId") != null && !"".equals(request.getParameter("libCardId"))) {
            LibCardDAO lcd = new LibCardDAO();
            LibCard lc = lcd.getLibCardInfo(Integer.parseInt(request.getParameter("libCardId")));
            if (lc.getCardId() != 0) {
                request.getSession().setAttribute("libCard", lc);
                request.getSession().removeAttribute("errorLendTheBookPage");
            } else {
                request.getSession().setAttribute("errorLendTheBookPage", "No valid result found");
            }
        }
        if (!"".equals(request.getParameter("title"))) {
            BookCopiesDAO bd = new BookCopiesDAO();
            ArrayList<BookCopies> lb = bd.getListBookCopies(request.getParameter("title"), "lend");
            request.getSession().setAttribute("listBook", lb);
        }
        request.getRequestDispatcher("page/lendTheBookPage.jsp").forward(request, response);
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
        switch (request.getParameter("action")) {
            case "add book" -> {
                ArrayList<BookCopies> lb = new ArrayList<>();
                ArrayList<BookCopies> lcb = (ArrayList<BookCopies>) request.getSession().getAttribute("listCurrentBook");
                if (lcb != null && !lcb.isEmpty()) {
                    lb = lcb;
                }
                BookCopies b = new BookCopies();
                b.setBarcode(Integer.parseInt(request.getParameter("barcode")));
                b.setTitle(request.getParameter("title"));
                b.setAuthor(request.getParameter("author"));
                lb.add(b);
                request.getSession().setAttribute("listCurrentBook", lb);
            }
            case "remove book" -> {
                ArrayList<BookCopies> lb = (ArrayList<BookCopies>) request.getSession().getAttribute("listCurrentBook");
                for (BookCopies b : lb) {
                    if (b.getBarcode() == Integer.parseInt(request.getParameter("barcode"))) {
                        lb.remove(b);
                        break;
                    }
                }
                request.getSession().setAttribute("listCurrentBook", lb);
            }
            case "set due date" -> {
                request.getSession().setAttribute("dueDate", request.getParameter("dueDate"));
            }
            case "create call card" -> {
                User u = (User) request.getSession().getAttribute("user");
                Librarian l = new Librarian();
                CallCard cc = new CallCard();
                ArrayList<BookCopies> lb = (ArrayList<BookCopies>)request.getSession().getAttribute("listCurrentBook");
                l.setId(u.getId());
                l.setFullname(u.getFullname());
                LibCard lc = (LibCard) request.getSession().getAttribute("libCard");
                cc.setDueDate(DateUtil.convertStringToDate(request.getParameter("dueDate")));
                cc.setBorrower(lc);
                cc.setLibrarian(l);
                cc.setLb(lb);
                CallCardDAO ccd = new CallCardDAO();
                try {
                    CallCard callCard = ccd.createCallCard(cc);
                    request.getSession().setAttribute("callCard", callCard);
                } catch (SQLException ex) {
                    Logger.getLogger(LendTheBookServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        request.getRequestDispatcher("page/lendTheBookPage.jsp").forward(request, response);
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
