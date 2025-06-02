package com.banthatlung.services;

import java.sql.SQLException;

import com.banthatlung.Controller.PasswordUtils;
import com.banthatlung.Dao.AccountDAO;
import com.banthatlung.Dao.UserDao;
import com.banthatlung.Dao.model.Account;
import com.banthatlung.Dao.model.User;

public class AuthService {
    public Account checkLogin(String username, String pass){
        AccountDAO dao = new AccountDAO();
        Account account = dao.findAccount(username);

        if(account != null) {
            String hashedInput = PasswordUtils.encryptPassword(pass);
            if (hashedInput.equals(account.getPass())) {
                return account;
            }
        }

        return null;
    }


    public User findByUserId(int userId){
        UserDao dao = new UserDao();
        return dao.findUserById(userId);
    }


    public boolean register(Account account) throws SQLException {
    	AccountDAO dao = new AccountDAO();
        Account a = dao.findAccount(account.getUsername());
        if(a != null) {
            return false;
        }
        return dao.createAccount(account);
    }

    public boolean changePassword(String accountId, String oldPassword, String newPassword) throws SQLException {
        AccountDAO dao = new AccountDAO();
        Account a = dao.getAccountById(accountId);
        if (a != null && a.getPass().equals(oldPassword)) {
        	return dao.updatePassword(accountId, newPassword);
        }
        return false;
    }

}
