package com.banthatlung.services;


import com.banthatlung.Dao.AccountDAO;
import com.banthatlung.Dao.UserDao;
import com.banthatlung.Dao.model.Account;
import com.banthatlung.Dao.model.User;

import jakarta.mail.MessagingException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Map;

public class ForgetPasswordService {

    private final UserDao userDao;
    private final EmailService mailService;

    public ForgetPasswordService() {
        this.userDao = new UserDao();
        this.mailService = new EmailService();
    }

    public boolean handleForgotPassword(String email) {
        // Tìm tài khoản theo email
        User user = userDao.findUserByEmail(email);
        AccountDAO dao = new AccountDAO(); 
        Account a = null;
        Map<String, Account> map = userDao.getAccountAndUser();
        for (User u : userDao.getAll()) {
        	a = map.get(u.getAccountID()); 
        }

        if (user == null) {
            return false; // Không tìm thấy tài khoản
        }

        // Tạo mật khẩu tạm
        String tempPassword = generateTemporaryPassword();

        boolean isUpdated = dao.updatePassword(a.getId(), tempPassword);
        if (!isUpdated) {
            return false;
        }

        // Gửi email thông báo mật khẩu tạm
        String subject = "Quên mật khẩu - Mật khẩu tạm thời của bạn";
        String body = "Xin chào " + a.getUsername() + ",\n\n"
                + "Mật khẩu tạm thời của bạn là: " + tempPassword + "\n"
                + "Vui lòng đăng nhập và đổi mật khẩu để đảm bảo an toàn.\n\n"
                + "Trân trọng,\n"
                + "Đội ngũ hỗ trợ của chúng tôi.";

        try {
            mailService.sendMail(email, subject, body);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

        return true; // Thành công
    }

    private String generateTemporaryPassword() {
        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[8];
        random.nextBytes(bytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }
}

