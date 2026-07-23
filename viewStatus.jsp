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

    List<Map<String, Object>> leaves = (List<Map<String, Object>>) request.getAttribute("leaves");
    if (leaves == null && request.getAttribute("error") == null) {
        response.sendRedirect("ViewStatusServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Leave Applications</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="dashboard-container">
        <header class="dashboard-header">
            <div>
                <h2 class="dashboard-title">Your Leave Applications</h2>
                <p style="color: var(--text-secondary); margin-top: 0.25rem;">Track history and status of requests</p>
            </div>
            <div class="user-info">
                <span class="user-tag">Employee: <%= username %></span>
                <a href="employeeHome.jsp" class="btn btn-secondary btn-sm" id="backBtn">Dashboard</a>
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
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (leaves != null && !leaves.isEmpty()) {
                            for (Map<String, Object> leave : leaves) {
                                String status = (String) leave.get("status");
                                String badgeClass = "badge-pending";
                                if ("approved".equalsIgnoreCase(status)) {
                                    badgeClass = "badge-approved";
                                } else if ("rejected".equalsIgnoreCase(status)) {
                                    badgeClass = "badge-rejected";
                                }
                    %>
                        <tr>
                            <td><%= leave.get("startDate") %></td>
                            <td><%= leave.get("endDate") %></td>
                            <td><span class="badge <%= badgeClass %>"><%= status %></span></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="3" style="text-align: center; color: var(--text-secondary); padding: 2rem;">
                                No leave applications found.
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
