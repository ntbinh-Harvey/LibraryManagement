/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import DAO.BookCopiesDAO;
import DAO.LibCardDAO;
import DAO.ReturningCallCardDAO;
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
import model.LibCard;
import model.Librarian;
import model.ReturningCallCard;
import model.User;
import util.DateUtil;
/**
 *
 * @author HarveyNguyen
 */
@WebServlet(name = "ReceiveTheBook", urlPatterns = {"/ReceiveTheBook"})
public class ReceiveTheBookServlet extends HttpServlet {

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
                request.getSession().removeAttribute("errorReceiveTheBookPage");
            } else {
                request.getSession().setAttribute("errorReceiveTheBookPage", "No valid result found");
            }
        }
        if (!"".equals(request.getParameter("title"))) {
            BookCopiesDAO bd = new BookCopiesDAO();
            ArrayList<BookCopies> lb = bd.getListBookCopies(request.getParameter("title"), "receive");
            request.getSession().setAttribute("listBook", lb);
        }
        request.getRequestDispatcher("page/receiveTheBookPage.jsp").forward(request, response);
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
            case "create returning call card" -> {
                String[] statusList = request.getParameterValues("status");
                String[] fineList = request.getParameterValues("fine");
                float totalFine = 0;
                for(String s: fineList) {
                    if("".equals(s.trim())) {
                        continue;
                    }
                    totalFine += Integer.parseInt(s);
                }
                User u = (User) request.getSession().getAttribute("user");
                Librarian l = new Librarian();
                ReturningCallCard rcc = new ReturningCallCard();
                ArrayList<BookCopies> lb = (ArrayList<BookCopies>)request.getSession().getAttribute("listCurrentBook");
                for(int i = 0; i < lb.size(); i++) {
                    lb.get(i).setStatus(statusList[i]);
                }
                request.getSession().setAttribute("listCurrentBook", lb);
                l.setId(u.getId());
                l.setFullname(u.getFullname());
                LibCard lc = (LibCard) request.getSession().getAttribute("libCard");
                rcc.setReturningDate(DateUtil.convertStringToDate(request.getParameter("returningDate")));
                rcc.setBorrower(lc);
                rcc.setLibrarian(l);
                rcc.setLb(lb);
                rcc.setFine(totalFine);
                ReturningCallCardDAO rccd = new ReturningCallCardDAO();
                try {
                    ReturningCallCard returningCallCard = rccd.createReturningCallCard(rcc);
                    request.getSession().setAttribute("returningCallCard", returningCallCard);
                } catch (SQLException ex) {
                    Logger.getLogger(LendTheBookServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        request.getRequestDispatcher("page/receiveTheBookPage.jsp").forward(request, response);
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
