/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieubd.controllers;

import hieubd.account.AccountDAO;
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
@WebServlet(name = "DeleteController", urlPatterns = {"/DeleteController"})
public class DeleteController extends HttpServlet {

    private final String DELETE_ERROR_PAGE = "deleteErr.html";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String pk = request.getParameter("pk");
        String lastSearchValue = request.getParameter("lastSearchValue");
        String confirm = request.getParameter("confirm");
        String url = DELETE_ERROR_PAGE;
        try {
            if (confirm == null) {
                url = "DispatchController?btnAction=Search";
            } else if (confirm.equals("delete")) {
                AccountDAO dao = new AccountDAO();
                boolean result = dao.deleteAccount(pk);
                if (result) {
                    url = "DispatchController?btnAction=Search&searchValue=" + lastSearchValue;
                }
            } else if (confirm.equals("not yet")) {
                url = "DispatchController?btnAction=Search&searchValue=" + lastSearchValue + "&confirm=delete&pk=" + pk;
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
