package com.banthatlung.Dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.banthatlung.Dao.db.DBConnect2;
import com.banthatlung.Dao.model.Inventory;
import com.banthatlung.Dao.model.QuarterlyReport;

public class InventoryReportDAO {

    public InventoryReportDAO() {

    }

    /**
     * Lấy báo cáo tồn kho cho từng sản phẩm dựa vào snapshot tồn kho ban đầu (initial_quantity)
     * và số lượng hiện tại (quantity) trong bảng Warehouse.
     * Lưu ý: Báo cáo này được giả định là chụp snapshot tại đầu quý và tại thời điểm hiện tại.
     *
     * @return List<ProductInventoryReport>
     * @throws SQLException
     */
    public List<QuarterlyReport> getQuarterlyReport(int year, int quarter) throws SQLException {
    	 List<QuarterlyReport> list = new ArrayList<>();

         String sql = """
             SELECT QUARTER(o.orderDate) AS quarter,
                 p.id AS product_id,
                 p.name AS product_name,
                 SUM(od.quantity) AS total_quantity,
                 SUM(od.quantity * od.price) AS total_revenue
         	FROM orders o
         	JOIN order_details od ON o.id = od.id
         	JOIN products p ON od.id = p.id
         	WHERE YEAR(o.orderDate) = ? AND QUARTER(o.orderDate) = ?
         	GROUP BY quarter, p.id
         	ORDER BY quarter, p.id;
         """;

         try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
             stmt.setInt(1, year);
             stmt.setInt(2, quarter);
             ResultSet rs = stmt.executeQuery();

             while (rs.next()) {
                 QuarterlyReport qr = new QuarterlyReport();
                 qr.setQuarter(rs.getInt("quarter"));
                 qr.setProductID(rs.getInt("product_id"));
                 qr.setProductName(rs.getString("product_name"));
                 qr.setTotalQuantity(rs.getInt("total_quantity"));
                 qr.setTotalRevenue(rs.getDouble("total_revenue"));
                 list.add(qr);
             }

         } catch (SQLException e) {
             e.printStackTrace();
         }

         return list;
    }
    
    public List<Inventory> getInventoryReport() {
        List<Inventory> reports = new ArrayList<>();

        String sql = "SELECT p.id, " +
                     "       COALESCE(SUM(wi.quantity), 0) AS initial_quantity, " +
                     "       (COALESCE(SUM(wi.quantity), 0) - COALESCE(SUM(od.quantity), 0)) AS current_quantity " +
                     "FROM products p " +
                     "LEFT JOIN warehouse wi ON p.id = wi.product_id " +
                     "LEFT JOIN order_details od ON p.id = od.product_id " +
                     "GROUP BY p.id";

        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Inventory report = new Inventory();
                int initialQty = rs.getInt("initial_quantity");
                int currentQty = rs.getInt("current_quantity");

                report.setProductID(rs.getInt("id"));
                report.setInitialQuantity(initialQty);
                report.setCurrentQuantity(currentQty);
                
                double consumption = (initialQty == 0) ? 0 : ((initialQty - currentQty) * 1.0 / initialQty) * 100;
                report.setConsumptionPercent(consumption);

                if (consumption >= 40.0) {
                    report.setReorderStatus("Cần nhập kho");
                } else if (consumption >= 20.0) {
                    report.setReorderStatus("Nên nhập kho");
                } else {
                    report.setReorderStatus("Không cần nhập kho");
                }

                reports.add(report);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reports;
    }

    
    public static void main(String[] args) throws SQLException {
		InventoryReportDAO dao = new InventoryReportDAO();
		
		System.out.println(dao.getInventoryReport());
		System.out.println(dao.getQuarterlyReport(2025, 1));
	}
}
