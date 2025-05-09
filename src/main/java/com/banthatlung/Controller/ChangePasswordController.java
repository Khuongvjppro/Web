package com.banthatlung.Controller;

import com.banthatlung.Dao.AccountDAO;
import com.banthatlung.Dao.UserDao;
import com.banthatlung.Dao.model.Account;
import com.banthatlung.Dao.model.User;
import com.banthatlung.services.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

@WebServlet(name = "ChangePasswordController", value = "/change-password")
public class ChangePasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getUserFromCookie(req);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String currentPassword = req.getParameter("currentPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        // Kiểm tra xác nhận mật khẩu mới
        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("errorMessage", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            req.getRequestDispatcher("/View/change-password.jsp").forward(req, resp);
            return;
        }

        AuthService authService = new AuthService();
        UserDao userDao = new UserDao();
        AccountDAO dao = new AccountDAO(); 
        Account a = null;
        Map<String, Account> map = userDao.getAccountAndUser();
        for (User u : userDao.getAll()) {
        	if (u.getId() == user.getId()) {
        		a = map.get(u.getAccountID());
        		break;
        	}
        }

        // Đổi mật khẩu
        boolean isUpdated = false;
		try {
			isUpdated = authService.changePassword(a.getId(), currentPassword, newPassword);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (isUpdated) {
            req.getSession().invalidate(); // Đăng xuất sau khi đổi mật khẩu thành công
            req.setAttribute("message", "Đổi mật khẩu thành công. Vui lòng đăng nhập lại.");
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("errorMessage", "Mật khẩu hiện tại không đúng hoặc đổi mật khẩu thất bại.");
            req.getRequestDispatcher("/View/change-password.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getUserFromCookie(req);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.getRequestDispatcher("/View/change-password.jsp").forward(req, resp);
        }
    }

    private User getUserFromCookie(HttpServletRequest req) {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userId".equals(cookie.getName())) {
                    int userId = Integer.parseInt(cookie.getValue());
                    AuthService authService = new AuthService();
                    return authService.findByUserId(userId);
                }
            }
        }
        return null;
    }
}
