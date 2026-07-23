/*
 * Decompiled with CFR 0.152.
 * 
 * Could not load the following classes:
 *  javax.servlet.ServletException
 *  javax.servlet.http.HttpServlet
 *  javax.servlet.http.HttpServletRequest
 *  javax.servlet.http.HttpServletResponse
 */
package com.lms.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateLeaveServlet
extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int leaveId = Integer.parseInt(request.getParameter("id"));
        String status = "";
        if ("approve".equalsIgnoreCase(action)) {
            status = "Approved";
        } else if ("reject".equalsIgnoreCase(action)) {
            status = "Rejected";
        }
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_system", "root", "root");
            PreparedStatement ps = conn.prepareStatement("UPDATE leave_applications SET status=? WHERE id=?");
            ps.setString(1, status);
            ps.setInt(2, leaveId);
            ps.executeUpdate();
            response.sendRedirect("ManageLeaveServlet");
        }
        catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("Error updating leave status: " + e.getMessage());
        }
    }
}
