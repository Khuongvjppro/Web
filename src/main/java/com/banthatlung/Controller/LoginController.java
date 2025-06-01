package com.banthatlung.Controller;

import com.banthatlung.Dao.AccountDAO;
import com.banthatlung.Dao.RoleDAO;
import com.banthatlung.Dao.UserDao;
import com.banthatlung.Dao.model.Account;
import com.banthatlung.Dao.model.User;
import com.banthatlung.services.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet(name = "LoginController", value = "/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("uname");
        String password = req.getParameter("pass");

        AccountDAO accountDAO = new AccountDAO();
        String accountId = accountDAO.getAccountIdByUsername(username);

        if (accountId == null) {
            req.setAttribute("error", "Username không tồn tại");
            req.getRequestDispatcher("/View/Login.jsp").forward(req, resp);
            return;
        }

        boolean isValid = accountDAO.login(username, password);
        if (!isValid) {
            req.setAttribute("error", "Sai mật khẩu");
            req.getRequestDispatcher("/View/Login.jsp").forward(req, resp);
            return;
        }

        int role = accountDAO.getAccountRole(accountId);

        // Gán thông tin session nếu cần
        HttpSession session = req.getSession();
        session.setAttribute("username", username);
        session.setAttribute("accountId", accountId);
        session.setAttribute("role", role);

        if (role == 1) {
            resp.sendRedirect("html_admin/admin_Disboard.jsp");
        } else {
            resp.sendRedirect("View/home.jsp");
        }
        return;
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

