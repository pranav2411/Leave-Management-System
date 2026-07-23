<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Secure login for the Leave Management System.">
    <title>Leave Management System - Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <h2>Welcome Back</h2>
            <p class="subtitle">Log in to manage and request leaves</p>
            
            <form method="post" action="LoginServlet">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter your username" required />
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required />
                </div>
                <button type="submit" class="btn btn-primary" id="loginBtn">Login</button>
            </form>
            
            <a href="register.jsp" class="footer-link">Don't have an account? Register here</a>
        </div>
    </div>
</body>
</html>
