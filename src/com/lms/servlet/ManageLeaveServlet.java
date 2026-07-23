package com.lms.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ManageLeaveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, Object>> applications = new ArrayList<>();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_system", "root", "root");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT l.id, u.username, l.start_date, l.end_date, l.reason, l.status FROM leave_applications l JOIN users u ON l.user_id = u.id");
            while (rs.next()) {
                Map<String, Object> app = new HashMap<>();
                app.put("id", rs.getInt("id"));
                app.put("username", rs.getString("username"));
                app.put("startDate", rs.getDate("start_date"));
                app.put("endDate", rs.getDate("end_date"));
                app.put("reason", rs.getString("reason"));
                app.put("status", rs.getString("status"));
                applications.add(app);
            }
            rs.close();
            stmt.close();
            conn.close();

            request.setAttribute("applications", applications);
            request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
        }
        catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
        }
    }
}
