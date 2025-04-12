/**
 * 
 */
package com.banthatlung.Dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.banthatlung.Dao.db.DBConnect2;

public class WareHouseDAO {
	
	public WareHouseDAO() {}
	
	/**
     * Tính tổng số lượng nhập của 1 sản phẩm từ bảng stock.
     *
     * @param productId id của sản phẩm
     * @return tổng số lượng nhập
     * @throws SQLException
     */
    public int getTotalImported(int productId) throws SQLException {
        int totalImported = 0;
        String sql = "SELECT IFNULL(SUM(quantity), 0) AS total_imported FROM stock WHERE product_id = ?";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalImported = rs.getInt("total_imported");
                }
            }
        }
        return totalImported;
    }

	public static void main(String[] args) throws SQLException {
		WareHouseDAO dao = new WareHouseDAO();
		
		System.out.println(dao.getTotalImported(33));
	}

}
