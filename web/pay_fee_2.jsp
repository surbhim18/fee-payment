<jsp:directive.include file="header.jsp"/>
<%@page import="java.util.*,java.lang.*,java.text.*"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <title>Online Fee Payment System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>

        <%
            String course = request.getParameter("course").toUpperCase();
            int year = Integer.parseInt(request.getParameter("year"));
            String rollno = request.getParameter("rollno");

            int y = Integer.parseInt(rollno.substring(0, 2)) + 2000;
            String c = rollno.substring(2, 5);
            String r = rollno.substring(5, 9);

            Date d = new Date();
            SimpleDateFormat ft = new SimpleDateFormat("y");
            int currentYear = Integer.parseInt(ft.format(d));

            if ((currentYear - y + 1 != year) || !c.equals(course)) {
        %>
        <script>
            alert("The roll no you entered is inconsistent with your course or year!");
        </script>
        <%
            response.sendRedirect("admin_view_2.jsp");

        } else {
        %>
        <sql:query dataSource="${conn}" var="result">
            select cname, s.year, name, sex, phoneno, email, feeAmt from studentinfo s,fee f, courses c where c.cid = s.cid and f.cid = c.cid and s.year = f.year and sid=? and s.year=? and s.cid=?;
            <sql:param value="${fn:substring(param.rollno,5,9)}" />
            <sql:param value="${param.year}" />
            <sql:param value="${param.course}" />
        </sql:query>
        <br><br>


        <c:choose>
            <c:when test="${result.rowCount==0}">
                <script>
                    alert("The roll no you entered is not in our records!");
                </script>
                <%
                    response.sendRedirect("pay_fee.jsp");
                %>
            </c:when>
            <c:otherwise>
                <table border="1" width="35%">
                    <c:forEach var="row" items="${result.rows}">
                        <tr>
                            <th>Course Name</th>
                            <td><c:out value="${row.cname}"/></td>
                        </tr>
                        <tr>
                            <th>Year</th>
                            <td><c:out value="${row.year}"/></td>
                        </tr>
                        <tr>
                            <th>Name</th>
                            <td><c:out value="${row.name}"/></td>
                        </tr>
                        <tr>
                            <th>Sex</th>
                            <td><c:out value="${row.sex}"/></td>
                        </tr>
                        <tr>
                            <th>Phone no</th>
                            <td><c:out value="${row.phoneno}"/></td>
                        </tr>
                        <tr>
                            <th>Email Address</th>
                            <td><c:out value="${row.email}"/></td>
                        </tr>
                        <tr>
                            <th>Fee</th>
                            <td><c:out value="${row.feeAmt}"/></td>
                        </tr>
                    </c:forEach>
                </table>

                <br><br>
                <input type="button" onclick="document.location.href = 'payment.html'" value="PAY">
            </c:otherwise>
        </c:choose>
        <%
            }
        %>
    </body>
</html>
<jsp:directive.include file="footer.jsp"/>