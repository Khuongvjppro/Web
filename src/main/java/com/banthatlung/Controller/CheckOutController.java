package com.banthatlung.Controller;

import com.banthatlung.Dao.OrderDao;
import com.banthatlung.Dao.OrderDetailDao;
import com.banthatlung.Dao.model.Order;
import com.banthatlung.Dao.model.OrderDetail;
import com.banthatlung.Dao.model.ProductCart;
import com.banthatlung.services.ProductService;
import com.banthatlung.services.ShippingService; // 🆕 Import dịch vụ tính phí ship
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/checkOut"})
public class CheckOutController extends HttpServlet {
    OrderDao orderDao = new OrderDao();
    OrderDetailDao orderDetailDao = new OrderDetailDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        HttpSession session = req.getSession(false);
        HashMap<Integer, ProductCart> cart = (HashMap<Integer, ProductCart>) session.getAttribute("cart");

        int total = 0;
        if (cart != null) {
            for (ProductCart item : cart.values()) {
                total += item.getQuantity() * item.getProduct().getPrice();
            }
        }

        req.setAttribute("cart", cart);
        req.setAttribute("total", total);  // Gửi total xuống JSP
        req.getRequestDispatcher("/View/CheckOut.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String address = req.getParameter("province") + ", " +
                req.getParameter("district") + ", " +
                req.getParameter("ward");

        HttpSession session = req.getSession(false);
        HashMap<Integer, ProductCart> cart = (HashMap<Integer, ProductCart>) session.getAttribute("cart");
        int total = Integer.parseInt(req.getParameter("totalAmount"));

        Order order = new Order(name, address, phone, total);
        int orderId = orderDao.addOrder(order);
        for (ProductCart item : cart.values()) {
            OrderDetail detail = new OrderDetail(orderId, item.getProduct().getId(),
                    item.getQuantity(), item.getQuantity() * item.getProduct().getPrice());
            orderDetailDao.addOrderDetail(detail);
        }

        session.setAttribute("cart", null);
        resp.sendRedirect(req.getContextPath() + "/View/checkOutDone.jsp");
    }

}

