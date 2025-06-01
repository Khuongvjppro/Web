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
import com.banthatlung.Dao.model.Resource;

/**
 * 
 */
public class ResourceDAO {
	private Resource mapResource(ResultSet rs) throws SQLException {
		return new Resource(rs.getInt(1), rs.getString(2), rs.getInt(3));
	}
	
	public ResourceDAO() {}
	
	public List<Resource> getAll() {
		List<Resource> result = new ArrayList<>();
		String sql = "SELECT * FROM resources";
		try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				result.add(mapResource(rs));
			}
			return result;
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void addResource(Resource r) {
		String sql = "INSERT INTO resources(account_id, permission) VALUES(?, ?)";
		try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
			stmt.setString(1, r.getAccountID());
			stmt.setInt(2, r.getPermission());
			stmt.executeUpdate();
		} catch (SQLException e) {
			
		}
	}
	
	public void setPermission(String accountID, int permission) {
		if (permission < -1 || permission > 7) {
	        throw new IllegalArgumentException("Permission must be between -1 and 7");
	    }
		
		String sql = "UPDATE resources SET permission = ? WHERE account_id = ?";
		try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
			stmt.setInt(1, permission);
			stmt.setString(2, accountID);
			stmt.executeUpdate();
			stmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	// Sinh mã ID cho người dùng mới
    public int generateID() {
        String query = "SELECT COUNT(*) AS total FROM resources";
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
	public static void main(String[] args) {
		ResourceDAO dao = new ResourceDAO();
		
		dao.addResource(new Resource(dao.generateID() + 1, "u11", 7));
		dao.setPermission("u11", 4);
		for (Resource r: dao.getAll()) {
			System.out.println(r);
		}
	}

}
