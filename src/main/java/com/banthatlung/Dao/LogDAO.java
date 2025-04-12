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
import com.banthatlung.Dao.model.Log;

/**
 * 
 */
public class LogDAO {
	private Log mapResource(ResultSet rs) throws SQLException {
		return new Log(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5));
	}
	
	public LogDAO() {}
	
	public List<Log> getAll() {
		List<Log> result = new ArrayList<>();
		String sql = "SELECT * FROM log";
		try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				result.add(mapResource(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public void addLog(Log l) {
		String sql = "INSERT INTO log(account_id, event_type, description) VALUE(?, ?, ?)";
		try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
			stmt.setString(1, l.getAccountID());
			stmt.setInt(2, l.getEvent_type());
			stmt.setString(3, l.getDescription());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// Sinh mã ID mới
    public int generateID() {
        String query = "SELECT COUNT(*) AS total FROM log";
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
		LogDAO dao = new LogDAO();
		
		dao.addLog(new Log(dao.generateID() + 1, "u6", 2, null, "User xem thong tin ca nhan"));
		for(Log l: dao.getAll()) {
			System.out.println(l);
		}
	}

}
