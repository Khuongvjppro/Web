package com.banthatlung.Controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.banthatlung.Dao.InventoryReportDAO;
import com.banthatlung.Dao.model.QuarterlyReport;

/**
 * Servlet implementation class SaleReportServlet
 */
@WebServlet(urlPatterns = {"/saleReport"})
public class SaleReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SaleReportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int year = Integer.parseInt(request.getParameter("year"));
        int quarter = Integer.parseInt(request.getParameter("quarter"));

        InventoryReportDAO dao = new InventoryReportDAO();
        List<QuarterlyReport> reports;
		try {
			reports = dao.getQuarterlyReport(year, quarter);
			request.setAttribute("quarterlyReports", reports);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        request.getRequestDispatcher("saleReport.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
