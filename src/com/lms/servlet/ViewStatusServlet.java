package com.lms.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ViewStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String)session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        List<Map<String, Object>> leaves = new ArrayList<>();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_system", "root", "root");
            PreparedStatement ps1 = conn.prepareStatement("SELECT id FROM users WHERE username=?");
            ps1.setString(1, username);
            ResultSet rs1 = ps1.executeQuery();
            int uid = 0;
            if (rs1.next()) {
                uid = rs1.getInt("id");
            }
            PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM leave_applications WHERE user_id=?");
            ps2.setInt(1, uid);
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                Map<String, Object> leave = new HashMap<>();
                leave.put("startDate", rs2.getDate("start_date"));
                leave.put("endDate", rs2.getDate("end_date"));
                leave.put("status", rs2.getString("status"));
                leaves.add(leave);
            }
            rs2.close();
            ps2.close();
            rs1.close();
            ps1.close();
            conn.close();
            
            request.setAttribute("leaves", leaves);
            request.getRequestDispatcher("viewStatus.jsp").forward(request, response);
        }
        catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("viewStatus.jsp").forward(request, response);
        }
    }
}
