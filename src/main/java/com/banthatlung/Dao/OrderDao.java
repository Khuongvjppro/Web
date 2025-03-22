package com.banthatlung.Dao;

import com.banthatlung.Dao.db.DBConnect;
import com.banthatlung.Dao.model.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static com.banthatlung.Dao.db.DBConnect2.getPreparedStatement;

public class OrderDao {
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public OrderDao() {
    }

    public List<Order> getList() throws SQLException {
        List<Order> orders = new ArrayList<Order>();
        String sql = "select * from orders";
        PreparedStatement ps = getPreparedStatement(sql);
        rs = ps.executeQuery();
        while (rs.next()) {
            orders.add(new Order(rs.getInt("id"), rs.getString("name"), rs.getString("phone"), rs.getString("address"), rs.getDate("orderDate").toString(), rs.getDate("update_date").toString(), rs.getInt("status"), rs.getInt("total_amount")));
        }
        return orders;
    }

    public Order getOrder(int id) throws SQLException {
        Order order = null;
        con = new DBConnect().getConnection();
        ps = con.prepareStatement("SELECT * from orders where id = ?");
        ps.setInt(1, id);
        rs = ps.executeQuery();
        while (rs.next()) {
            order = new Order(rs.getInt("id"), rs.getString("name"), rs.getString("phone"), rs.getString("address"), rs.getDate("orderDate").toString(), rs.getDate("update_date").toString(), rs.getInt("status"), rs.getInt("total_amount"));
        }
        return order;
    }

    public int addOrder(Order order) {
        int generatedId = -1; // Default value if the insertion fails
        String sql = "INSERT INTO orders (name, phone, address, status, total_amount) VALUES (?, ?, ?, ?, ?)";

        try {
            // Set the values for the prepared statement
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // Request generated keys
            ps.setString(1, order.getName());
            ps.setString(2, order.getphone());
            ps.setString(3, order.getAddress());
            ps.setInt(4, 1);
            ps.setInt(5, order.getTotal_amount());

            // Execute the insert statement
            ps.executeUpdate();

            // Retrieve the generated keys
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    generatedId = rs.getInt(1); // Get the generated ID
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions
        } finally {
            // Close resources to prevent memory leaks
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return generatedId; // Return the generated ID
    }


    public void updateOrder(Order order) {
        try {
            String sql = "UPDATE orders SET name = ?, phone = ?, address = ?, status = ? WHERE id = ?";
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, order.getName());
            ps.setString(2, order.getphone());
            ps.setString(3, order.getAddress());
            ps.setInt(4, order.getStatus());
            ps.setInt(5, order.getId());
            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Order updated successfully!");
            }
        } catch (
                SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) throws SQLException {
        con = new DBConnect().getConnection();
        ps = con.prepareStatement("DELETE FROM Orders WHERE id = ?");
        ps.setInt(1, id);
        ps.executeUpdate();
    }

    public static void main(String[] args) throws SQLException {
        OrderDao orderDao = new OrderDao();
        Order order = new Order("123", "123", "123", 2);
       orderDao.addOrder(order);

    }

}
