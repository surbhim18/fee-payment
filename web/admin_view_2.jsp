<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<jsp:directive.include file="header.jsp"/>
<html>
    <head>
        <title>Online Fee Payment System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <script src="js/check_pay_fee.js"></script>
    </head>
    <body>
        <%
            if((session.getAttribute("username") == null) || (session.getAttribute("username") == "") || (session.getAttribute("level").equals("s")))
            {
        %>
        You are not logged in.<br>
        Please <a href="admin_login.jsp">login</a>
        <%
            } else {
        %>       
        
        <h3>View and change fee refund status</h3>
        <br>
        <form action="admin_view_2_1.jsp" method="post" onsubmit="return validate_pay_fee()"> <!-- validation to see if columns are selected && roll no is valid -->
            <table>
                <tr>
                    <td>Course: </td>
                    <td>
                        <sql:query dataSource="${conn}" var="result">
                            select * from courses;
                        </sql:query>
                        <select name="course" id="course">
                            <option value="default" selected>select</option>
                            <c:forEach var="row" items="${result.rows}">
                                <option value="${row.cid}">${row.cname}</option> <!-- from table -->
                            </c:forEach>
                        </select>
                    </td>
                    <td><div id="courseDiv" style="color:red"></div></td>
                </tr>
                <tr>
                    <td>Year: </td>
                    <td>
                        <select name="year" id="year">
                            <option value="default" selected>select</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                        </select>
                    </td>
                    <td><div id="yearDiv" style="color:red"></div></td>
                </tr>
                <tr>
                    <td>Roll no: </td>
                    <td><input type="text" name="rollno" id="rollno"></td>
                    <td><div id="rollNoDiv" style="color:red"></div></td>
                </tr>
            </table> 
            <br>
            <input type="submit" value="Next">
        </form>

        <br><br><input type="button" onclick="document.location.href='logout.jsp'" value="Log Out">
        <%
            }
        %>
    </body>
</html>
<jsp:directive.include file="footer.jsp"/>