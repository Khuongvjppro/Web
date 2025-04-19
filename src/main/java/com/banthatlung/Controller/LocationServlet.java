package com.banthatlung.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

public class LocationServlet extends HttpServlet {

    private static final String BASE_API = "https://provinces.open-api.vn/api";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");
        String code = request.getParameter("code");

        String apiUrl = null;

        if ("province".equals(type)) {
            apiUrl = BASE_API + "/p/";
        } else if ("district".equals(type) && code != null) {
            apiUrl = BASE_API + "/p/" + code + "?depth=2";
        } else if ("ward".equals(type) && code != null) {
            apiUrl = BASE_API + "/d/" + code + "?depth=2";
        }

        if (apiUrl == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"error\":\"Invalid type or missing code\"}");
            return;
        }

        HttpURLConnection conn = (HttpURLConnection) new URL(apiUrl).openConnection();
        conn.setRequestMethod("GET");

        BufferedReader reader = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder result = new StringBuilder();
        String line;

        while ((line = reader.readLine()) != null) {
            result.append(line);
        }
        reader.close();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(result.toString());
    }
}