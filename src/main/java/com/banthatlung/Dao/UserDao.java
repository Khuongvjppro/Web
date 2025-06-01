package com.banthatlung.Dao;

import com.banthatlung.Dao.db.DBConnect2;
import com.banthatlung.Dao.model.Account;
import com.banthatlung.Dao.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDao {

    private User mapUser(ResultSet rs) throws SQLException {
        return new User(
        		rs.getInt(1),
                rs.getString(2),  // accountID
                rs.getString(3),  // full_name
                rs.getString(4),  // email
                rs.getString(5),  // phone_number
                rs.getDate(6),    // date_of_birth
                rs.getString(7),  // gender
                rs.getString(8)  // image
        );
    }

    // Lấy tất cả người dùng
    public List<User> getAll() {
        List<User> result = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (PreparedStatement ps = DBConnect2.getPreparedStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.add(mapUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public Map<String, Account> getAccountAndUser() {
    	Map<String, Account> result = new HashMap<String, Account>();
    	result.clear();
    	AccountDAO dao = new AccountDAO();
    	List<Account> accounts = dao.getAll();
    	List<User> users = getAll();
    	for (User u : users) {
    		for (Account a : accounts) {
    			if (u.getAccountID().equals(a.getId())) {
    				result.put(u.getAccountID(), a);
    			}
    		}
    	}
		return result;
    }

    // Tìm người dùng theo tên đăng nhập
    public User findUser(String accountID) {
        String sql = "SELECT * FROM users WHERE account_id = ?";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setString(1, accountID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User findUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Tìm người dùng theo ID
    public User findUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật thông tin cá nhân người dùng
    public boolean updateProfile(User user) {
        String sql = "UPDATE users SET full_name = ?, email = ?, phone_number = ?, date_of_birth = ? WHERE user_id = ?";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setDate(4, user.getBirthday());
            stmt.setInt(5, user.getId());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Đăng ký người dùng mới
    public void registerUser(User u) throws SQLException {
    	String sql = "INSERT INTO users (account_id, full_name, email, phone_number) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setString(1, u.getAccountID());
            stmt.setString(2, u.getName());
            stmt.setString(3, u.getEmail());
            stmt.setString(4, u.getPhone());
            stmt.executeUpdate();
        }
    }

    // Sinh mã ID cho người dùng mới
    public int generateID() {
        String query = "SELECT COUNT(*) AS total FROM users";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public static void main(String[] args) throws SQLException {
        UserDao userDao = new UserDao();
        
        Map<String, Account> map = userDao.getAccountAndUser();
        for (User u : userDao.getAll()) {
        	System.out.println(u + "\n" + map.get(u.getAccountID()));
        }
    }
}
