package com.banthatlung.Controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.charset.StandardCharsets;

@WebServlet("/api/locations")
public class LocationController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.setContentType("application/json; charset=UTF-8");
        InputStream is = getServletContext().getResourceAsStream("/data/vietnam_location.json");

        if (is != null) {
            String json = new String(is.readAllBytes(), StandardCharsets.UTF_8);
            resp.getWriter().write(json);
        } else {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.getWriter().write("{\"error\":\"Không tìm thấy file JSON\"}");
        }
    }
}