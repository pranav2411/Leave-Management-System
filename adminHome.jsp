<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) response.sendRedirect("index.jsp");
%>
<h2>Welcome Admin: <%= username %></h2>
<ul>
    <li><a href="viewApplications.jsp">View All Applications</a></li>
    <li><a href="index.jsp">Logout</a></li>
</ul>
