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
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="dashboard-container">
        <header class="dashboard-header">
            <div>
                <h2 class="dashboard-title">Admin Console</h2>
                <p style="color: var(--text-secondary); margin-top: 0.25rem;">Monitor employee leave requests</p>
            </div>
            <div class="user-info">
                <span class="user-tag">Admin: <%= username %></span>
                <a href="index.jsp" class="btn btn-secondary btn-sm" id="logoutBtn">Logout</a>
            </div>
        </header>

        <h3 style="margin-bottom: 1rem;">Quick Actions</h3>
        <div class="menu-grid">
            <a href="ManageLeaveServlet" class="menu-card" id="manageLeavesCard">
                <h4>View All Applications</h4>
                <p>Approve or reject pending leave requests submitted by employees.</p>
            </a>
        </div>
    </div>
</body>
</html>
