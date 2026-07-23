<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="dashboard-container">
        <header class="dashboard-header">
            <div>
                <h2 class="dashboard-title">Employee Portal</h2>
                <p style="color: var(--text-secondary); margin-top: 0.25rem;">Manage your leave applications</p>
            </div>
            <div class="user-info">
                <span class="user-tag">Employee: <%= username %></span>
                <a href="index.jsp" class="btn btn-secondary btn-sm" id="logoutBtn">Logout</a>
            </div>
        </header>

        <h3 style="margin-bottom: 1rem;">Quick Actions</h3>
        <div class="menu-grid">
            <a href="applyLeave.jsp" class="menu-card" id="applyLeaveCard">
                <h4>Apply for Leave</h4>
                <p>Submit a new leave request specifying dates and reason.</p>
            </a>
            <a href="ViewStatusServlet" class="menu-card" id="viewStatusCard">
                <h4>View Leave Status</h4>
                <p>Check the status and history of your leave applications.</p>
            </a>
        </div>
    </div>
</body>
</html>
