package com.banthatlung.Dao;

import com.banthatlung.Dao.db.DBConnect;
import com.banthatlung.Dao.db.DBConnect2;
import com.banthatlung.Dao.model.Brand;
import com.banthatlung.Dao.model.Material;
import com.banthatlung.Dao.model.Product;
import com.banthatlung.Dao.model.Category;

import java.sql.*;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {

    private Product mapProduct(ResultSet rs) throws SQLException {
        Category category = new CategoryDao().getCategory(rs.getInt("category_id"));


        Brand brand = new BrandDao().getBrand(rs.getInt("brand_id"));
        Material material = new MaterialDao().getMaterial(rs.getInt("material_id"));


        material.setId(rs.getInt("material_id"));
        material.setName(rs.getString("material_name"));

        return new Product(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getInt("price"),
                rs.getString("description"), rs.getInt("quantity"),
                rs.getInt("status"),
                rs.getString("created"),
                rs.getString("image"),
                category, brand, material
        );
    }

    // Lấy tất cả sản phẩm
    public List<Product> getAll() {
        List<Product> result = new ArrayList<>();
        String sql = """
                SELECT p.*, 
                       c.id AS category_id, c.name AS category_name,
                       b.id AS brand_id, b.name AS brand_name,
                       m.id AS material_id, m.name AS material_name
                FROM products p
                JOIN categories c ON p.category_id = c.id
                JOIN brands b ON p.brand_id = b.id
                JOIN materials m ON p.material_id = m.id
                """;
        try (PreparedStatement ps = DBConnect2.getPreparedStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.add(mapProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Lấy sản phẩm phân trang
    public List<Product> getAll(int page, int pageSize) {
        List<Product> result = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = """
                SELECT p.*, 
                       c.id AS category_id, c.name AS category_name,
                       b.id AS brand_id, b.name AS brand_name,
                       m.id AS material_id, m.name AS material_name
                FROM products p
                JOIN categories c ON p.category_id = c.id
                JOIN brands b ON p.brand_id = b.id
                JOIN materials m ON p.material_id = m.id
                LIMIT ? OFFSET ?
                """;
        try (PreparedStatement ps = DBConnect2.getPreparedStatement(sql)) {
            ps.setInt(1, pageSize);
            ps.setInt(2, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    result.add(mapProduct(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Lấy tổng số sản phẩm
    public int getTotalProductCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM products";
        try (PreparedStatement ps = DBConnect2.getPreparedStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // Lấy sản phẩm theo ID
    public Product getById(int id) {
        String sql = """
                SELECT p.*, 
                       c.id AS category_id, c.name AS category_name,
                       b.id AS brand_id, b.name AS brand_name,
                       m.id AS material_id, m.name AS material_name
                FROM products p
                JOIN categories c ON p.category_id = c.id
                JOIN brands b ON p.brand_id = b.id
                JOIN materials m ON p.material_id = m.id
                WHERE p.id = ?
                """;
        try (PreparedStatement ps = DBConnect2.getPreparedStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapProduct(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Tìm kiếm sản phẩm theo tên
    public List<Product> search(String name) {
        List<Product> result = new ArrayList<>();
        String sql = """
                SELECT p.*, 
                       c.id AS category_id, c.name AS category_name,
                       b.id AS brand_id, b.name AS brand_name,
                       m.id AS material_id, m.name AS material_name
                FROM products p
                JOIN categories c ON p.category_id = c.id
                JOIN brands b ON p.brand_id = b.id
                JOIN materials m ON p.material_id = m.id
                WHERE p.name LIKE ?
                """;
        try (PreparedStatement ps = DBConnect2.getPreparedStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    result.add(mapProduct(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////


    // Cập nhật sản phẩm
    public void update(Product product) {
        String sql = " UPDATE products SET name = ?, price = ?, description = ?, status = ?, quantity = ? , image = ?, category_id =?,brand_id = ?, material_id = ?WHERE id = ?"
                ;
        try (PreparedStatement ps = DBConnect2.getPreparedStatement(sql)) {
            setProductParameters(ps, product);
            ps.setInt(10, product.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa sản phẩm
    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE id = ?";
        try (PreparedStatement ps = DBConnect2.getPreparedStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public boolean addProduct(Product product) {
        String sql = " INSERT INTO products (name, price, description, status, quantity, image, category_id, brand_id, material_id) VALUES (? , ?, ?, ?, ?, ?, ?, ?, ?) ";
        try (PreparedStatement ps = DBConnect2.getPreparedStatement(sql)) {
            setProductParameters(ps, product);
            int rowsInserted= ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    private void setProductParameters(PreparedStatement ps, Product product) throws SQLException {
        ps.setString(1, product.getName());
        ps.setInt(2, product.getPrice());
        ps.setString(3, product.getDescription());
        ps.setInt(4, product.getStatus());
        ps.setInt(5, product.getQuantity());
        ps.setString(6, product.getImage());
        ps.setInt(7, product.getCategory().getId());
        ps.setInt(8, product.getBrand().getId());
        ps.setInt(9, product.getMaterial().getId());

    }
    // Lấy danh sách sản phẩm liên quan dựa trên category_id (hoặc brand_id)
    public List<Product> getRelatedProducts(int categoryId, int excludeProductId) {
        List<Product> result = new ArrayList<>();
        String sql = """
            SELECT p.*, 
                   c.id AS category_id, c.name AS category_name,
                   b.id AS brand_id, b.name AS brand_name,
                   m.id AS material_id, m.name AS material_name
            FROM products p
            JOIN categories c ON p.category_id = c.id
            JOIN brands b ON p.brand_id = b.id
            JOIN materials m ON p.material_id = m.id
            WHERE p.category_id = ? AND p.id != ? LIMIT 4
            """;
        try (PreparedStatement ps = DBConnect2.getPreparedStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, excludeProductId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    result.add(mapProduct(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }


    public static void main(String[] args) {
    	ProductDao dao = new ProductDao();
    	for(Product p : dao.getAll(1, 8)) {
    		System.out.println(p);
    	}
    }
}
