package com.banthatlung.Controller.admin;

import com.banthatlung.Dao.InventoryReportDAO;
import com.banthatlung.Dao.model.Inventory;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(urlPatterns = {"/admin_Inventory"})
public class InventoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Khởi tạo DAO và lấy danh sách báo cáo tồn kho
		InventoryReportDAO reportDAO = new InventoryReportDAO();
		List<Inventory> inventories = reportDAO.getInventoryReport();

		// Đưa danh sách báo cáo vào request scope
		request.setAttribute("inventories", inventories);

        // Forward request sang JSP hiển thị báo cáo
        request.getRequestDispatcher("/html_admin/admin_Inventory.jsp").forward(request, response);
    }
}
