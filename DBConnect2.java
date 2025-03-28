package com.banthatlung.Dao.db;

import com.banthatlung.Dao.model.Brand;
import com.banthatlung.Dao.model.Category;
import com.banthatlung.Dao.model.Material;
import com.banthatlung.Dao.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DBConnect2 {
	private static final String URL = "jdbc:mysql://localhost:3306/BanThatLung";
	private static final String USER = "root";
	private static final String PASSWORD = "Cden2004!";
	
	
	public static Connection getConnection() throws SQLException {
		try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        return DriverManager.getConnection(URL, USER, PASSWORD);
	    } catch (ClassNotFoundException e) {
	        throw new SQLException("JDBC Driver không được tìm thấy!", e);
	    }
    }
	
    public static PreparedStatement getPreparedStatement(String sql) throws SQLException {
    	Connection connection = getConnection();
        if (connection == null) {
            System.out.println("Lỗi: Không thể lấy kết nối từ DBConnect2!");
            return null;
        }
        try {
            return connection.prepareStatement(sql);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    private static void makeConnect() throws ClassNotFoundException, SQLException {
    	Connection connection = getConnection();
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(URL,DBProperties.username(),DBProperties.password());
    }

    public static void main(String[] args) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products";
        PreparedStatement pstmt = getPreparedStatement(sql);
         // Giả định rằng đây là đầu vào
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            // Lấy thông tin từ ResultSet và khởi tạo đối tượng Product
            Category category = new Category(); // Khởi tạo Category (nếu cần lấy thêm thông tin từ bảng liên quan)
            category.setId(rs.getInt("category_id")); // Lấy ID của danh mục từ cột `category_id`

            Brand brand = new Brand(); // Khởi tạo Brand (tương tự như Category)
            brand.setId(rs.getInt("brand_id"));

            Material material = new Material(); // Khởi tạo Material (nếu có dữ liệu liên quan)
            material.setId(rs.getInt("material_id"));

            Product product = new Product(
                    rs.getInt("product_id"),                  // id
                    rs.getString("name"),             // name
                    rs.getInt("price"),               // price
                    rs.getString("description"),      // description
                    rs.getInt("p_status"),              // status
                    rs.getInt("quantity"),            // quantity
                    rs.getString("created"),          // date (created)
                    rs.getString("image"),category,brand,material   // image
            );

            product.setCategory(category);           // Gán đối tượng Category
            product.setBrand(brand);                 // Gán đối tượng Brand
            product.setMaterial(material);           // Gán đối tượng Material

            products.add(product);
        }
        for(Product product : products) {
            System.out.println(product);
        }
        // Hiển thị danh sách sản phẩm

    }

}
