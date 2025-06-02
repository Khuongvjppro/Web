package com.banthatlung.Controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.banthatlung.Dao.AccountDAO;
import com.banthatlung.Dao.LogDAO;
import com.banthatlung.Dao.model.Account;
import com.banthatlung.Dao.model.Log;

/**
 * Servlet implementation class LogServlet
 */
@WebServlet(name = "LogServlet", value = "/log")
public class LogServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public LogServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AccountDAO accDAO = new AccountDAO();
        List<Account> accountList = accDAO.getAll();
        request.setAttribute("accountList", accountList);
        LogDAO logDAO = new LogDAO();

        String accountId = request.getParameter("accountID");
        String eventType = request.getParameter("eventType");
        if (accountId.isEmpty() || accountId == null) accountId = "all";
        if (eventType.isEmpty() || eventType == null) eventType = "all";

        if ("all".equals(accountId) && "all".equals(eventType)) {
            List<Log> logList = logDAO.getAll();
            request.setAttribute("logList", logList);
            request.getRequestDispatcher("/html_admin/Log.jsp").forward(request, response);
        } else if ("all".equals(accountId) && !"all".equals(eventType)) {
            int type = Integer.parseInt(eventType);
            List<Log> logList = logDAO.getLogFromType(type);
            request.setAttribute("logList", logList);
            request.getRequestDispatcher("/html_admin/Log.jsp").forward(request, response);
        } else if (!"all".equals(accountId) && "all".equals(eventType)) {
            List<Log> logList = logDAO.getLogFromAccountID(accountId);
            request.setAttribute("logList", logList);
            request.getRequestDispatcher("/html_admin/Log.jsp").forward(request, response);
        } else {
            int type = Integer.parseInt(eventType);
            List<Log> logList = logDAO.filterLog(accountId, type);
            request.setAttribute("logList", logList);
            request.getRequestDispatcher("/html_admin/Log.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
