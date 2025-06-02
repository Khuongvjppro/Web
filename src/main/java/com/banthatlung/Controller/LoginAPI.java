package com.banthatlung.Controller;

import com.banthatlung.Dao.model.Account;
import com.banthatlung.services.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.Cookie;

import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONObject;

@WebServlet(name = "LoginAPI", value = "/loginAPI")
public class LoginAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        String username = req.getParameter("uname");
        String password = req.getParameter("pass");

        String hashpass = PasswordUtils.encryptPassword(password);
        AuthService authService = new AuthService();
        Account user = authService.checkLogin(username, hashpass);

        JSONObject responseJson = new JSONObject();
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("auth", user);

            Cookie userCookie = new Cookie("user_id", String.valueOf(user.getId()));
            userCookie.setMaxAge(60 * 60 * 24 * 7);
            userCookie.setPath(req.getContextPath());
            resp.addCookie(userCookie);

            responseJson.put("status", "success");
            responseJson.put("message", "Login successful");
            responseJson.put("user_id", user.getId());
        } else {
            responseJson.put("status", "error");
            responseJson.put("message", "Invalid username or password");
        }
        out.print(responseJson.toString());
        out.flush();
    }
}
