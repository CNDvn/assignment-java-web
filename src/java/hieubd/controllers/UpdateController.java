/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieubd.controllers;

import hieubd.account.AccountDAO;
import hieubd.account.AccountUpdateErr;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author CND
 */
@WebServlet(name = "UpdateController", urlPatterns = {"/UpdateController"})
public class UpdateController extends HttpServlet {

    private final String UPDATE_ERROR_PAGE = "updateErr.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("txtUsrename");
        String password = request.getParameter("txtPassword");
        String isAdmin = request.getParameter("chkIsAdmin");
        String searchValue = request.getParameter("lastSearchValue");
        String confirm = request.getParameter("confirm");
        boolean role = false;
        if (isAdmin != null) {
            role = true;
        }
        String url = UPDATE_ERROR_PAGE;

        try {
            boolean flagErr = false;
            AccountUpdateErr updateErr = new AccountUpdateErr();

            if (username == null || password == null || confirm == null) {
                url = "DispatchController?btnAction=Search";
            } else {

                if (password.trim().length() < 6 || password.trim().length() > 20) {
                    flagErr = true;
                    updateErr.setPasswordErrLength("Password must 6 - 20 character");
                }

                if (flagErr) {
                    request.setAttribute("UpdateErr", updateErr);
                    url = UPDATE_ERROR_PAGE + "?searchValue=" + searchValue;
                    request.getRequestDispatcher(url).forward(request, response);
                    return;
                } else if (confirm.equals("update")) {
                    AccountDAO dao = new AccountDAO();
                    boolean result = dao.updateAccount(username, password, role);
                    if (result) {
                        url = "DispatchController?btnAction=Search&searchValue=" + searchValue;
                    }
                } else if (confirm.equals("not yet")) {
                    url = "DispatchController?btnAction=Search&searchValue=" + searchValue
                            + "&txtUsrename=" + username
                            + "&txtPassword=" + password
                            + "&chkIsAdmin=" + isAdmin
                            + "&confirm=update";
                }
            }

        } catch (NamingException e) {
            log("NamingException. msg = " + e.getMessage());
//            e.printStackTrace();
        } catch (SQLException e) {
            log("SQLException. msg = " + e.getMessage());
//            e.printStackTrace();
        } finally {
            response.sendRedirect(url);
            out.close();
        }
    }

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
        processRequest(request, response);
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
        processRequest(request, response);
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
