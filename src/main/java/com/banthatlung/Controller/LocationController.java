package com.banthatlung.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.charset.StandardCharsets;

@WebServlet("/api/locations")
public class LocationController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json");
        InputStream inputStream = getServletContext().getResourceAsStream("/data/vietnam_location.json");
        if (inputStream != null) {
            String json = new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);
            resp.getWriter().write(json);
        } else {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.getWriter().write("{\"error\":\"File not found\"}");
        }
    }
}
