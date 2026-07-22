<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head><title>User Registration</title></head>
<body>
    <h2>Register</h2>
    <form method="post" action="RegisterServlet">
        Username: <input type="text" name="username" required /><br/>
        Password: <input type="password" name="password" required /><br/>
        Role:
        <select name="role">
            <option value="employee">Employee</option>
            <option value="admin">Admin</option>
        </select><br/>
        <input type="submit" value="Register" />
    </form>
    <p><a href="index.jsp">Back to Login</a></p>
</body>
</html>
