package com.banthatlung.Dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.banthatlung.Dao.db.DBConnect2;

public class InventoryDAO {

    public InventoryDAO() {}

    /**
     * Tính tồn kho cho 1 sản phẩm theo productId.
     *
     * Công thức: tồn kho = tổng số lượng nhập (NhậpKho) - tổng số lượng bán (order_detail)
     *
     * @param productId id của sản phẩm
     * @return số lượng tồn kho của sản phẩm
     * @throws SQLException
     */
    public int getInventoryForProduct(int productId) throws SQLException {
        int totalImported = 0;
        int totalSold = 0;
        
        // Tính tổng số lượng nhập từ bảng warehouse
        String sqlNhapKho = "SELECT IFNULL(SUM(quantity), 0) AS total_imported FROM warehouse WHERE product_id = ?";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sqlNhapKho)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalImported = rs.getInt("total_imported");
                }
            }
        }
        
        // Tính tổng số lượng bán từ bảng order_details
        String sqlOrderDetail = "SELECT IFNULL(SUM(quantity), 0) AS total_sold FROM order_details WHERE product_id = ?";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sqlOrderDetail)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalSold = rs.getInt("total_sold");
                }
            }
        }
        
        return totalImported - totalSold;
    }
    
    /**
     * Tính tồn kho cho tất cả các sản phẩm hiện có trong bảng products.
     *
     * @return Map<Integer, Integer> với key là product_id và value là tồn kho tương ứng.
     * @throws SQLException
     */
    public Map<Integer, Integer> getInventoryForAllProducts() throws SQLException {
        Map<Integer, Integer> inventoryMap = new HashMap<>();
        // Giả sử bảng products có trường id làm khóa chính
        String sqlProducts = "SELECT id FROM products";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sqlProducts);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int productId = rs.getInt("id");
                int inventory = getInventoryForProduct(productId);
                inventoryMap.put(productId, inventory);
            }
        }
        return inventoryMap;
    }
    
    public static void main(String[] args) throws SQLException {
		InventoryDAO dao = new InventoryDAO();
		
		System.out.println(dao.getInventoryForAllProducts());
	}
}
