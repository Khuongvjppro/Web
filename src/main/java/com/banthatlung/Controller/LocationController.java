package com.banthatlung.Controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet("/api/locations")
public class LocationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");

        // Đọc file vietnam_location.json từ thư mục data
        InputStream is = getServletContext().getResourceAsStream("/data/vietnam_location.json");

        if (is != null) {
            // Đọc hết nội dung file thành chuỗi
            byte[] bytes = is.readAllBytes();
            String jsonContent = new String(bytes, "UTF-8");

            // Ghi dữ liệu trả về response
            resp.getWriter().write(jsonContent);
        } else {
            // Nếu không tìm thấy file
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.getWriter().write("{\"error\": \"Không tìm thấy dữ liệu!\"}");
        }
    }
}
