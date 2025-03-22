package com.banthatlung.Dao;

import com.banthatlung.Dao.db.DBConnect;
import com.banthatlung.Dao.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public CategoryDao() {
    }

    public Category getCategory(int id) throws SQLException {
        Category category = new Category();
        con = new DBConnect().getConnection();
        ps = con.prepareStatement("SELECT * from categories where id = ?");
        ps.setInt(1, id);
        rs = ps.executeQuery();
        while (rs.next()) {
            category.setId(rs.getInt("id"));
            category.setName(rs.getString("name"));
            category.setDescription(rs.getString("description"));
        }

        return category;
    }

    public List<Category> getAllCategory() throws SQLException {
        List<Category> categories = new ArrayList<Category>();
        con = new DBConnect().getConnection();
        ps = con.prepareStatement("SELECT * from categories");
        rs = ps.executeQuery();
        while (rs.next()) {
            categories.add(new Category(rs.getInt("id"), rs.getString("name"), rs.getString("description")));
        }
        return categories;
    }

    public void add(Category category) throws SQLException {
        con = new DBConnect().getConnection();
        ps = con.prepareStatement("INSERT INTO categories (name, description) VALUES (?,?)");
        ps.setString(1, category.getName());
        ps.setString(2, category.getDescription());
        ps.executeUpdate();
    }

    public void update(Category category) throws SQLException {
        con = new DBConnect().getConnection();
        ps = con.prepareStatement("UPDATE categories SET name = ?, Description = ? WHERE id = ?");
        ps.setString(1, category.getName());
        ps.setString(2, category.getDescription());
        ps.setInt(3, category.getId());
        ps.executeUpdate();
    }
    public void delete(int id) throws SQLException {
        con = new DBConnect().getConnection();
        ps = con.prepareStatement("DELETE FROM categories WHERE id = ?");
        ps.setInt(1, id);
        ps.executeUpdate();
    }

    public static void main(String[] args) throws SQLException {
        CategoryDao categoryDao = new CategoryDao();
        Category category = new Category("zzdsadazzz","zzcấcz");
        category.setId(1);
        categoryDao.update(category);
    }
}
