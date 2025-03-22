package com.banthatlung.Controller;

import com.banthatlung.Dao.model.User;
import com.banthatlung.services.ProfileService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(name = "AvatarController", value = "/update-avatar")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AvatarController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("auth");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/View/login.jsp");
            return;
        }

        Part filePart = req.getPart("avatar");
        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "avatars";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String avatarPath = uploadPath + File.separator + user.getId() + "_" + fileName;
            filePart.write(avatarPath);

            // Cập nhật đường dẫn ảnh đại diện
            String avatarUrl = "images/" + fileName;
            user.setImage(avatarUrl);
            // Cập nhật vào cơ sở dữ liệu
            ProfileService profileService = new ProfileService();
            try {
                profileService.updateUserProfile(user);
            } catch (Exception e) {
                throw new ServletException(e);
            }

            // Cập nhật session và chuyển hướng
            session.setAttribute("auth", user);
        }

        resp.sendRedirect(req.getContextPath() + "/View/profile.jsp");
    }
}
