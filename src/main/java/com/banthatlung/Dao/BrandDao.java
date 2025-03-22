package com.banthatlung.Dao;

import com.banthatlung.Dao.db.DBConnect;
import com.banthatlung.Dao.model.Brand;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import static com.banthatlung.Dao.db.DBConnect2.getPreparedStatement;

public class BrandDao {
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public BrandDao() {
    }

    public List<Brand> getList() throws SQLException {
        List<Brand> brands = new ArrayList<Brand>();
        String sql = "select * from brands";
        PreparedStatement ps = getPreparedStatement(sql);
        rs = ps.executeQuery();
        while (rs.next()) {
            brands.add(new Brand(rs.getInt("id"), rs.getString("name"), rs.getDate("Create_At").toString()));
        }
        return brands;

    }

    public Brand getBrand(int id) throws SQLException {
        Brand brand = new Brand();
        con = new DBConnect().getConnection();
        ps = con.prepareStatement("SELECT * from brands where id = ?");
        ps.setInt(1, id);
        rs = ps.executeQuery();
        while (rs.next()) {
            brand.setId(rs.getInt("id"));
            brand.setName(rs.getString("name"));
            brand.setCreateAt(String.valueOf(rs.getDate("Create_At")));
        }

        return brand;
    }

    public void add(Brand brand) throws SQLException {
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement("INSERT INTO brands (name, create_At) VALUES (?,?)");
            ps.setString(1, brand.getName());
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String dateString = brand.getCreateAt();
            java.util.Date utilDate = null;
            utilDate = dateFormat.parse(dateString);
            Date sqlDate = new Date(utilDate.getTime());
            ps.setDate(2, sqlDate);
            ps.executeUpdate();
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }

    }

    public void update(Brand brand) throws SQLException {
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement("UPDATE brands SET name = ?, create_At = ? WHERE id = ?");
            ps.setString(1, brand.getName());
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String dateString = brand.getCreateAt();
            java.util.Date utilDate = dateFormat.parse(dateString);
            Date sqlDate = new Date(utilDate.getTime());
            ps.setDate(2, sqlDate);
            ps.setInt(3, brand.getId());
            ps.executeUpdate();
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(int id) throws SQLException {
        con = new DBConnect().getConnection();
        ps = con.prepareStatement("DELETE FROM brands WHERE id = ?");
        ps.setInt(1, id);
        ps.executeUpdate();
    }

    public static void main(String[] args) throws SQLException {

        BrandDao dao = new BrandDao();
        for (Brand brand : dao.getList()) {
            System.out.println(brand);
        }
    }
}
