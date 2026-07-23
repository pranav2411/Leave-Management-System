/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.servlet.ServletException
 *  javax.servlet.http.HttpServlet
 *  javax.servlet.http.HttpServletRequest
 *  javax.servlet.http.HttpServletResponse
 *  javax.servlet.http.HttpSession
 */
package com.lms.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ApplyLeaveServlet
extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String)session.getAttribute("username");
        String start = request.getParameter("start");
        String end = request.getParameter("end");
        String reason = request.getParameter("reason");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_system", "root", "root");
            PreparedStatement ps1 = conn.prepareStatement("SELECT id FROM users WHERE username=?");
            ps1.setString(1, username);
            ResultSet rs = ps1.executeQuery();
            int uid = 0;
            if (rs.next()) {
                uid = rs.getInt("id");
            }
            PreparedStatement ps2 = conn.prepareStatement("INSERT INTO leave_applications (user_id, start_date, end_date, reason) VALUES (?, ?, ?, ?)");
            ps2.setInt(1, uid);
            ps2.setString(2, start);
            ps2.setString(3, end);
            ps2.setString(4, reason);
            ps2.executeUpdate();
            response.sendRedirect("employeeHome.jsp");
        }
        catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("Error updating leave status: " + e.getMessage());
        }
    }
}
