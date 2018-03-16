<%@page import="java.util.*,java.lang.*,java.text.*"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:directive.include file="header.jsp"/>
<html>
    <head>
        <title>Online Fee Payment System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%
            if ((session.getAttribute("username") == null) || (session.getAttribute("username") == "") || (session.getAttribute("level").equals("s"))) {
        %>
        You are not logged in.<br>
        Please <a href="admin_login.jsp">login</a>
        <%
        } else {
        %>     
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

        <h3>Student Details</h3>
        <!-- get refundAmt as well, and print in column in case of refundStatus 1 -->
        <sql:query dataSource="${conn}" var="result">
            select cname, s1.year, name, sex, phoneno, email, feeStatus, refundStatus from studentinfo s1, studentfeeinfo s2, courses c where c.cid = s1.cid and s1.cid = s2.cid and s1.sid=s2.sid and s1.year = s2.year and s1.sid=? and s1.year=? and s1.cid=?;
            <sql:param value="${fn:substring(param.rollno,5,9)}" />
            <sql:param value="${param.year}" />
            <sql:param value="${param.course}" />
        </sql:query>


        <c:if test="${result.rowCount==0}">
            <script>
                alert("The roll no you entered is not in our records!");
            </script>
            <%
                response.sendRedirect("admin_view_2.jsp");
            %>
        </c:if>

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
                    <th>Fee Status</th>
                    <td>
                        <c:set var="fstatus" value="${row.feeStatus}" scope="session"/>
                        <c:choose>
                            <c:when test="${row.feeStatus=='0'}">
                                Not paid
                            </c:when>       
                            <c:otherwise>
                                Paid
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>Refund Status</th>
                    <td>
                        <c:set var="rstatus" value="${row.refundStatus}" scope="session"/>
                        <c:choose>
                            <c:when test="${row.refundStatus=='0'}">
                                Not refunded
                            </c:when>       
                            <c:otherwise>
                                Refunded
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <br>
        <form method="post" action="admin_view_2_2.jsp">
            <input type="hidden" name="rollno" value="${param.rollno}"/>
            <input type="hidden" name="course" value="${param.course}"/>
            <input type="hidden" name="year" value="${param.year}"/>
            <c:choose>
                <c:when test="${rstatus=='0' && fstatus=='1'}">
                    <input type="submit" value="Refund"/>
                </c:when>
            </c:choose>
        </form> 

        <%
            }
        %>
        <br>
        <br><br><input type="button" onclick="document.location.href = 'logout.jsp'" value="Log Out">
        <%
            }
        %>
    </body>
</html>
<jsp:directive.include file="footer.jsp"/>