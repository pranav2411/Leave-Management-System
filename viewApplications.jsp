<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<Map<String, Object>> applications = (List<Map<String, Object>>) request.getAttribute("applications");
    if (applications == null && request.getAttribute("error") == null) {
        response.sendRedirect("ManageLeaveServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Leave Applications</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="dashboard-container">
        <header class="dashboard-header">
            <div>
                <h2 class="dashboard-title">Manage Leave Applications</h2>
                <p style="color: var(--text-secondary); margin-top: 0.25rem;">Review employee leave requests</p>
            </div>
            <div class="user-info">
                <span class="user-tag">Admin: <%= username %></span>
                <a href="adminHome.jsp" class="btn btn-secondary btn-sm" id="backBtn">Dashboard</a>
            </div>
        </header>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="alert-error">
                Failed to load applications: <%= error %>
            </div>
        <%
            }
        %>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Employee</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Reason</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (applications != null && !applications.isEmpty()) {
                            for (Map<String, Object> app : applications) {
                                int lid = (Integer) app.get("id");
                                String status = (String) app.get("status");
                                String badgeClass = "badge-pending";
                                if ("approved".equalsIgnoreCase(status)) {
                                    badgeClass = "badge-approved";
                                } else if ("rejected".equalsIgnoreCase(status)) {
                                    badgeClass = "badge-rejected";
                                }
                    %>
                        <tr>
                            <td><%= app.get("username") %></td>
                            <td><%= app.get("startDate") %></td>
                            <td><%= app.get("endDate") %></td>
                            <td><%= app.get("reason") %></td>
                            <td><span class="badge <%= badgeClass %>"><%= status %></span></td>
                            <td>
                                <%
                                    if ("pending".equalsIgnoreCase(status)) {
                                %>
                                    <div class="action-links">
                                        <a href="updateLeave?id=<%= lid %>&action=approve" class="btn btn-primary btn-sm" style="background-color: var(--status-approved-text); padding: 0.25rem 0.6rem; font-size: 0.8rem;">Approve</a>
                                        <a href="updateLeave?id=<%= lid %>&action=reject" class="btn btn-danger btn-sm" style="padding: 0.25rem 0.6rem; font-size: 0.8rem;">Reject</a>
                                    </div>
                                <%
                                    } else {
                                %>
                                    <span style="color: var(--text-muted); font-size: 0.85rem;">None</span>
                                <%
                                    }
                                %>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="6" style="text-align: center; color: var(--text-secondary); padding: 2rem;">
                                No applications found.
                            </td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
