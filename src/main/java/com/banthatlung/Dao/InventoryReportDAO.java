package com.banthatlung.Dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.banthatlung.Dao.db.DBConnect2;
import com.banthatlung.Dao.model.Inventory;

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
    public List<Inventory> getQuarterlyReport() throws SQLException {
        List<Inventory> reports = new ArrayList<>();

        //bảng warehouse lưu thông tin cho từng sản phẩm, gồm product_id, initial_quantity và quantity hiện tại
        String sql = "SELECT product_id, initial_quantity, quantity FROM warehouse";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while(rs.next()){
                int productId = rs.getInt("product_id");
                int initialQuantity = rs.getInt("initial_quantity");
                int currentQuantity = rs.getInt("quantity");

                Inventory report = new Inventory(productId, initialQuantity, currentQuantity);
                reports.add(report);
            }
        }
        return reports;
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
		
		for (Inventory i : dao.getInventoryReport()) {
			System.out.println(i);
		}
	}
}
