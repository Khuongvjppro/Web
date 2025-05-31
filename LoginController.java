package com.banthatlung.Controller;

import com.banthatlung.Dao.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "LoginController", value = "/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("username");
	    String password = req.getParameter("password");

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

	    HttpSession session = req.getSession();
	    session.setAttribute("username", username);
	    session.setAttribute("accountId", accountId);
	    session.setAttribute("role", role);

	    if (role == 1) {
	        resp.sendRedirect("/TTLTW_Project/html_admin/admin_Disboard.jsp");
	    } else {
	        resp.sendRedirect("HomeController");
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

