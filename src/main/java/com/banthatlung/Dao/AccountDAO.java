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
import com.banthatlung.Dao.model.Account;
import com.banthatlung.Dao.model.User;

/**
 *
 */
public class AccountDAO {
    private Account mapAccount(ResultSet rs) throws SQLException {
        return new Account(
                rs.getString(1),  // account_id
                rs.getString(2),  // username
                rs.getString(3)  // password
        );
    }

    public AccountDAO() {}

    public List<Account> getAll() {
        List<Account> result = new ArrayList<Account>();
        String sql = "SELECT * FROM accounts";
        try (PreparedStatement ps = DBConnect2.getPreparedStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.add(mapAccount(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean createAccount(Account account) throws SQLException {
        String sql = "INSERT INTO accounts (account_id, username, password) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setString(1,"u" + (generateID() + 1));
            stmt.setString(2, account.getUsername());
            stmt.setString(3, account.getPass());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Account getAccountById(String accountId) throws SQLException {
        String sql = "SELECT * FROM accounts WHERE account_id = ?";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setString(1, accountId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Account account = new Account();
                    account.setId(rs.getString("account_id"));
                    account.setUsername(rs.getString("username"));
                    account.setPass(rs.getString("password"));
                    return account;
                }
            }
        }
        return null;
    }

    // Sinh mã ID cho người dùng mới
    public int generateID() {
        String query = "SELECT COUNT(*) AS total FROM accounts";
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

    // Cập nhật mật khẩu người dùng
    public boolean updatePassword(String accountId, String newPassword) {
        String sql = "UPDATE accounts SET password = ? WHERE account_id = ?";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setString(1, newPassword);
            stmt.setString(2, accountId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean login(String username, String password) {
        String sql = "SELECT * FROM accounts WHERE username = ? AND password = ?";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Tìm người dùng theo tên đăng nhập
    public Account findAccount(String username) {
        String sql = "SELECT * FROM accounts WHERE username = ?";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapAccount(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getAccountRole(String accountID) {
        int result = 0;
        String sql = "SELECT r.role\r\n"
                + "FROM roles r\r\n"
                + "JOIN accounts a ON r.account_id = a.account_id\r\n"
                + "WHERE a.account_id = ?;";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setString(1, accountID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                result = rs.getInt("role");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void main(String[] args) throws SQLException {
        AccountDAO dao = new AccountDAO();

        for (Account a : dao.getAll()) {
            System.out.println(a);
        }
        System.out.println(dao.createAccount(new Account("aaa", "111")));
        System.out.println(dao.getAccountIdByUsername("frank"));
        System.out.println(dao.findAccount("frank"));
        System.out.println(dao.login("aaa", "111"));
        System.out.println(dao.login("frank", "111"));
        System.out.println(dao.login("frank", "123"));
        System.out.println(dao.getAccountRole("u101"));
    }

    public String getAccountIdByUsername(String username) {
        String sql = "SELECT account_id FROM accounts WHERE username = ?";
        try (PreparedStatement stmt = DBConnect2.getPreparedStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("account_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
