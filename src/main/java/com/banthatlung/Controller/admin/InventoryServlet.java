package com.banthatlung.Controller.admin;

import com.banthatlung.Dao.InventoryReportDAO;
import com.banthatlung.Dao.model.Inventory;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet(urlPatterns = {"/admin_Inventory"})
public class InventoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Khởi tạo DAO và lấy danh sách báo cáo tồn kho
            InventoryReportDAO reportDAO = new InventoryReportDAO();
            List<Inventory> reports = reportDAO.getQuarterlyReport();

            // Đưa danh sách báo cáo vào request scope
            request.setAttribute("reports", reports);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi kết nối Database: " + e.getMessage());
        }

        // Forward request sang JSP hiển thị báo cáo
        request.getRequestDispatcher(request.getContextPath() + "/admin_Inventory.jsp").forward(request, response);
    }
}
