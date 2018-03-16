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

        <h3>Course-wise list of students who haven't paid fee</h3>
        
        <sql:query dataSource="${conn}" var="result">
            select cname, count(*) as 'count' from studentfeeinfo s, courses c 
            where feestatus =0 and s.cid = c.cid 
            group by s.cid;
        </sql:query>

        <table border="1" width="30%">
            <tr>
                <th>Course Name</th>
                <th>Number of Students</th>
            </tr>
            <c:forEach var="row" items="${result.rows}">
                <tr>
                    <td><c:out value="${row.cname}"/></td>
                    <td><c:out value="${row.count}"/></td>
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