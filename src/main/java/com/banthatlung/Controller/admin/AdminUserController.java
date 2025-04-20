package com.banthatlung.Controller.admin;

import com.banthatlung.Dao.UserDao;
import com.banthatlung.Dao.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminUserController", value = "/admin/users")
public class AdminUserController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDao userDao = new UserDao();
        List<User> userList = userDao.getAll();


        // In log ra console để test
        System.out.println("User count: " + userList.size());



        req.setAttribute("users", userList);
        req.getRequestDispatcher("/html_admin/admin_user.jsp").forward(req, resp);
    }
}
