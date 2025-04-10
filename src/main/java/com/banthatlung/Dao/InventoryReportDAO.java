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
    
    public static void main(String[] args) throws SQLException {
		InventoryReportDAO dao = new InventoryReportDAO();
		
		for (Inventory i : dao.getQuarterlyReport()) {
			System.out.println(i);
		}
	}
}
