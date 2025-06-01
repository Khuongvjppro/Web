package com.banthatlung.Controller.admin;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin_dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra quyền admin
        HttpSession session = request.getSession(false);
        if (session == null || !"1".equals(session.getAttribute("role"))) {
            response.sendRedirect("/TTLTW_Project/View/Login.jsp");
            return;
        }
        response.sendRedirect("InventoryServlet");
    }
}

