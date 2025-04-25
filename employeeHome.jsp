<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) response.sendRedirect("index.jsp");
%>
<h2>Welcome Employee: <%= username %></h2>
<ul>
    <li><a href="applyLeave.jsp">Apply for Leave</a></li>
    <li><a href="viewStatus.jsp">View Leave Status</a></li>
    <li><a href="index.jsp">Logout</a></li>
</ul>
