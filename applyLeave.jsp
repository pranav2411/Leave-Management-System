<%@ page session="true" %>
<form action="ApplyLeaveServlet" method="post">
    Start Date: <input type="date" name="start"/><br/>
    End Date: <input type="date" name="end"/><br/>
    Reason: <textarea name="reason"></textarea><br/>
    <input type="submit" value="Apply Leave"/>
</form>
