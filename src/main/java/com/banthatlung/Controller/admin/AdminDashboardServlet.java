package com.banthatlung.Controller.admin;

import java.io.IOException;
import java.util.List;

import com.banthatlung.Dao.AccountDAO;
import com.banthatlung.Dao.model.Account;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "AdminDashboardServlet", value = "/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/html_admin/admin_Disboard.jsp").forward(request, response);
    }
}

