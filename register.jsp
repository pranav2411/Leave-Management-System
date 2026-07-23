<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Register an account for the Leave Management System.">
    <title>Leave Management System - Register</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <h2>Create Account</h2>
            <p class="subtitle">Join the Leave Management System</p>
            
            <form method="post" action="RegisterServlet">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Choose a username" required />
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Create a strong password" required />
                </div>
                <div class="form-group">
                    <label for="role">Select Role</label>
                    <select id="role" name="role">
                        <option value="employee">Employee</option>
                        <option value="admin">Admin</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary" id="registerBtn">Register</button>
            </form>
            
            <a href="index.jsp" class="footer-link">Already have an account? Login here</a>
        </div>
    </div>
</body>
</html>
