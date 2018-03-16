<jsp:directive.include file="header.jsp"/>
<html>
    <head>
        <title>Online Fee Payment System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
         <%
            if((session.getAttribute("username") == null) || (session.getAttribute("username") == ""))
            {
        %>
        You are not logged in.<br>
        Please <a href="admin_login.jsp">login</a>
        <%
            } else {
        %>        
        
        <h3>Staff</h3>
        
        1. Count of students who haven't paid fees, course-wise: <a href="staff_view_1.jsp">View</a><br>
        2. View <a href="staff_view_2.jsp">list</a> of students who haven't paid fees.<br>
        3. <a href="create_staff.jsp">Create new staff account</a><br>

        <br><br><input type="button" onclick="document.location.href='logout.jsp'" value="Log Out">
        
        <%
            }
        %>        
    </body>
</html>
<jsp:directive.include file="footer.jsp"/>