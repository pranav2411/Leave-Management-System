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
    <title>Apply for Leave</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <h2>Apply for Leave</h2>
            <p class="subtitle">Submit details for your leave request</p>

            <form action="ApplyLeaveServlet" method="post">
                <div class="form-group">
                    <label for="start">Start Date</label>
                    <input type="date" id="start" name="start" required />
                </div>
                <div class="form-group">
                    <label for="end">End Date</label>
                    <input type="date" id="end" name="end" required />
                </div>
                <div class="form-group">
                    <label for="reason">Reason / Comments</label>
                    <textarea id="reason" name="reason" placeholder="Explain the reason for your leave request" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary" id="applyBtn">Apply Leave</button>
            </form>
            
            <a href="employeeHome.jsp" class="footer-link">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
