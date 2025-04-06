package com.banthatlung.Controller;

import com.banthatlung.Dao.model.Account;
import com.banthatlung.Dao.model.User;
import com.banthatlung.services.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
@WebServlet(name = "Registry", value = "/register")
public class Registry extends HttpServlet {
    private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        AuthService authService = new AuthService();

        String fname = req.getParameter("email");
        String uname = req.getParameter("username");
        String pwd = req.getParameter("password");
        String cpwd = req.getParameter("cpassword");

        if (!pwd.equals(cpwd)) {
            req.setAttribute("error", "Mật khẩu không khớp");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        String hashedPassword = PasswordUtils.encryptPassword(pwd);
        User u = new User();
        Account account = new Account();
        account.setUsername(uname);
        u.setEmail(fname);
        account.setPass(hashedPassword);

        try {
			if (authService.register(account)) {
			    req.setAttribute("success", "Đăng ký thành công, vui lòng đăng nhập!");
			    req.getRequestDispatcher("/login.jsp").forward(req, resp);
			} else {
			    req.setAttribute("error", "Tên tài khoản đã tồn tại");
			    req.getRequestDispatcher("/register.jsp").forward(req, resp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
}