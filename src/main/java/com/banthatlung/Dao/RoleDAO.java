/**
 * 
 */
package com.banthatlung.Dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.banthatlung.Dao.db.DBConnect2;
import com.banthatlung.Dao.model.Role;

/**
 * 
 */
public class RoleDAO {
	
	private Role mapRole(ResultSet rs) throws SQLException {
        return new Role(rs.getInt(1), rs.getString(2), rs.getInt(3));
    }
	
	public RoleDAO() {}
	
	public List<Role> getAll() throws SQLException {
		List<Role> result = new ArrayList<Role>();
		String sql = "SELECT * FROM roles";
		try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
                result.add(mapRole(rs));
            }
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public void addRole(Role r) throws SQLException {
		String sql = "INSERT INTO roles(account_id, role) VALUES(?, ?)";
		try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
			stmt.setString(1, r.getAccount_id());
            stmt.setInt(2, r.getRole());
            stmt.executeUpdate();
		}
	}
	
	public void updateRole(Role r) {
		String sql = "ALTER roles SET role = ? WHERE account_id = ?";
		try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
			stmt.setInt(1, r.getRole());
			stmt.setString(2, r.getAccount_id());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// Sinh mã ID cho người dùng mới
    public int generateID() {
        String query = "SELECT COUNT(*) AS total FROM roles";
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
		RoleDAO dao = new RoleDAO();
		
		dao.addRole(new Role(dao.generateID() + 1, "u11", 0));
		for (Role r : dao.getAll()) {
			System.out.println(r);
		}
	}

}
