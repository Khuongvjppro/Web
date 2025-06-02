package com.banthatlung.Controller;

import com.banthatlung.Dao.model.Product;
import com.banthatlung.Dao.model.Review;
import com.banthatlung.services.ProductService;
import com.banthatlung.services.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductDetail", value = "/product")
public class ProductDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pid = req.getParameter("pid");
        ProductService service = new ProductService();
        Product detail = service.getDetail(pid);
        req.setAttribute("pd", detail);

        // Lấy đánh giá sản phẩm
        ReviewService reviewService = new ReviewService();
        List<Review> list = reviewService.getReviewsByProductId(pid);
        req.setAttribute("reviews", list);

        // Lấy sản phẩm liên quan
        List<Product> relatedProducts = service.getRelatedProducts(detail.getCategory().getId(), detail.getId());
        req.setAttribute("relatedProducts", relatedProducts);

        req.getRequestDispatcher("/View/product-detail.jsp").forward(req, resp);
    }
}
