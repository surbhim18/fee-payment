<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:directive.include file="header.jsp"/>
<html>
    <head>
        <title>Online Fee Payment System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>

        <%
            if ((session.getAttribute("username") == null) || (session.getAttribute("username") == "")) {
        %>
        You are not logged in.<br>
        Please <a href="admin_login.jsp">login</a>
        <%
        } else {
        %>        
        <h3>List of students who haven't paid fee</h3>

        <sql:query dataSource="${conn}" var="result">
            select name, cname, s1.year, phoneno, email 
            from studentinfo s1, studentfeeinfo s2, courses c 
            where feestatus =0 and s1.cid=s2.cid and s2.cid = c.cid and s1.year=s2.year and s1.sid=s2.sid;
        </sql:query>

        <table border="1" width="70%">
            <tr>
                <th>Student Name</th>
                <th>Course Name</th>
                <th>Year</th>
                <th>Phone No</th>
                <th>Email Address</th>
            </tr>
            <c:forEach var="row" items="${result.rows}">
                <tr>
                    <td><c:out value="${row.name}"/></td>
                    <td><c:out value="${row.cname}"/></td>
                    <td><c:out value="${row.year}"/></td>
                    <td><c:out value="${row.phoneno}"/></td>
                    <td><c:out value="${row.email}"/></td>
                </tr>
            </c:forEach>
        </table>      

        <!-- see if you can find a query to export to excel and then provide a button for downloading as an excel sheet -->
        <br><br><input type="button" onclick="document.location.href = 'logout.jsp'" value="Log Out">
        <%
            }
        %>
    </body>
</html>
<jsp:directive.include file="footer.jsp"/>