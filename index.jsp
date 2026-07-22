<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Leave Management System - Login</title>
</head>
<body>
    <h2>Login to Leave Management System</h2>

    <form method="post" action="LoginServlet">
        <table>
            <tr>
                <td>Username:</td>
                <td><input type="text" name="username" required /></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="password" required /></td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <input type="submit" value="Login" />
                </td>
            </tr>
        </table>
    </form>

    <p>Don't have an account? <a href="register.jsp">Register here</a></p>
</body>
</html>
