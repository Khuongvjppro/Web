package com.banthatlung.Controller;

import com.banthatlung.Dao.model.Product;
import com.banthatlung.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;


@WebServlet(name = "HomeController", value = "/home")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductService productService = new ProductService();

        int page = 1; // Mặc định trang 1
        int pageSize = 8; // Mỗi trang 8 sản phẩm

        try {
            String pageParam = req.getParameter("page");
            if (pageParam != null) page = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        List<Product> products = productService.getAll(page, pageSize);
        int totalProducts = productService.getTotalProductCount();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        req.setAttribute("products", products);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/View/home.jsp").forward(req, resp);
    }
}
