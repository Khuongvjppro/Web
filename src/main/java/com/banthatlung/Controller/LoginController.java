package com.banthatlung.Controller;

import com.banthatlung.Dao.model.Account;
import com.banthatlung.services.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "LoginController", value = "/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("uname");
        String password = req.getParameter("pass");

        String hashpass = PasswordUtils.encryptPassword(password);
        AuthService authService = new AuthService();
        Account acc = authService.checkLogin(username, hashpass);

        if (acc != null) {
            HttpSession session = req.getSession();
            session.setAttribute("auth", acc);

            Cookie userCookie = new Cookie("userId", String.valueOf(acc.getId()));
            userCookie.setMaxAge(60 * 60 * 24 * 7);
            userCookie.setPath(req.getContextPath());
            resp.addCookie(userCookie);

            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            req.setAttribute("error", "Invalid username or password");
            req.getRequestDispatcher("/View/Login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/View/Login.jsp").forward(req, resp);
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String code = request.getParameter("code");
        GoogleLogin gg = new GoogleLogin();
        String accessToken = GoogleLogin.getToken(code);
        GoogleAccount acc = GoogleLogin.getUserInfo(accessToken);
        System.out.println(acc);
    }
}