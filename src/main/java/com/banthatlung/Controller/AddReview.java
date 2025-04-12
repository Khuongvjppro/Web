package com.banthatlung.Controller;

import com.banthatlung.Dao.UserDao;
import com.banthatlung.Dao.model.Account;
import com.banthatlung.Dao.model.Review;
import com.banthatlung.Dao.model.User;
import com.banthatlung.services.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Map;

@WebServlet(name = "AddReview", value = "/review")
public class AddReview extends HttpServlet {
    private static final long serialVersionUID = 1L;
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("auth");
        UserDao userDao = new UserDao();
        Account a = null;
        Map<String, Account> map = userDao.getAccountAndUser();
        for (User u : userDao.getAll()) {
        	if (u.getId() == user.getId()) {
        		a = map.get(u.getAccountID()); 
        	}
        }
        String uid = a.getId();

        String productId = req.getParameter("pid");

        int rating = Integer.parseInt(req.getParameter("rating"));
        String url = req.getParameter("url");
        String reviewText = req.getParameter("reviewText");
        String reviewDate = (Date.valueOf(LocalDate.now())).toString();

        Review review = new Review("r", Integer.parseInt(productId), uid, rating, url, reviewText, reviewDate);
        ReviewService service = new ReviewService();
        service.addReview(review);

        resp.sendRedirect(req.getContextPath() + "/product?pid=" + productId);

    }
}
