<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:directive.include file="header.jsp"/>
<html>
    <head>
        <title>Online Fee Payment System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%
            if((session.getAttribute("username") == null) || (session.getAttribute("username") == "")  || (session.getAttribute("level").equals("s")))
            {
        %>
        You are not logged in.<br>
        Please <a href="admin_login.jsp">login</a>
        <%
            } else {
  
        %>      
        
        <h3>Admin</h3>
   
        1. Offline payment:<a href="admin_view_1.jsp">change records</a><br>
        2. Refund Status of student: <a href="admin_view_2.jsp">update</a><br>
        3. View <a href="admin_view_3.jsp">list</a> of refund students<br>
        4. Fee: <a href="admin_view_4.jsp">change for a course</a><br>
        5. Count of students who haven't paid fees, course-wise: <a href="staff_view_1.jsp">View</a><br>
        6. View <a href="staff_view_2.jsp">list</a> of students who haven't paid fees.<br>
        7. <a href="create_staff.jsp">Create new staff account</a><br>
        
        <br><br>
        <input type="button" value="Click this button when year ends"> <!-- program this button -->
        <input type="button" value="Mistake? Roll back changes"> <!-- program this button -->
        
        <br><br>
        <br><br><input type="button" onclick="document.location.href='logout.jsp'" value="Log Out">
        <%
            }
        %>
    </body>
</html>
<jsp:directive.include file="footer.jsp"/>