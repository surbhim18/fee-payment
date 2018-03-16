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
        <script src="js/check_pay_fee.js"></script>
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

        <h3>Offline payment- modify records</h3>

        <form action="admin_view_1.jsp" method="post" onsubmit="return validate_pay_fee()"> <!-- validation to see if columns are selected && roll no is valid -->
            <input type="hidden" name="submitted" value="true"/>
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
                                <option value="${row.cid}" ${(param.submitted && param.course==row.cid)? 'selected' : ''}>${row.cname}</option> <!-- from table -->
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
                            <option value="1" ${(param.submitted && param.year=="1")? 'selected' : ''}>1</option>
                            <option value="2" ${(param.submitted && param.year=="2")? 'selected' : ''}>2</option>
                            <option value="3" ${(param.submitted && param.year=="3")? 'selected' : ''}>3</option>
                        </select>
                    </td>
                    <td><div id="yearDiv" style="color:red"></div></td>
                </tr>
                <tr>
                    <td>Roll no: </td>
                    <td><input type="text" name="rollno" id="rollno" value="${param.rollno}"></td>
                    <td><div id="rollNoDiv" style="color:red"></div></td>
                </tr>
            </table> 
            <br>
            <input type="submit" value="Next">
        </form>

        <c:if test="${param.submitted}">
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
                document.getElementById("rollNoDiv").innerHTML = "The roll no you entered is inconsistent with your course or year!";
            </script>
            <%
            } else {
            %>
            <sql:query dataSource="${conn}" var="result">
                select cname, s1.year, name, sex, phoneno, email, feeStatus from studentinfo s1, studentfeeinfo s2, courses c where c.cid = s1.cid and s1.cid = s2.cid and s1.sid=s2.sid and s1.year = s2.year and s1.sid=? and s1.year=? and s1.cid=?;
                <sql:param value="${fn:substring(param.rollno,5,9)}" />
                <sql:param value="${param.year}" />
                <sql:param value="${param.course}" />
            </sql:query>

            <c:choose>
                <c:when test="${result.rowCount==0}">
                    <script>
                        document.getElementById("rollNoDiv").innerHTML = "The roll no you entered is not in our records!";
                    </script>
                </c:when>
                <c:otherwise>
                    <br>
                    <div id="feeDiv">
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
                                    <c:set var="status" value="${row.feeStatus}" scope="session"/>
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
                        </c:forEach>
                    </table>

                    <br>
                    <form method="post" action="admin_view_1.jsp">
                        <input type="hidden" name="submitted" value="true">
                        <input type="hidden" name="submitted2" value="true">
                        <input type="hidden" name="rollno" value="${param.rollno}"/>
                        <input type="hidden" name="course" value="${param.course}"/>
                        <input type="hidden" name="year" value="${param.year}"/>
                        <c:choose>
                            <c:when test="${status=='0'}">
                                <input type="submit" value="Set as PAID"/>
                            </c:when>
                            <c:otherwise>
                                <input type="submit" value="Set as NOT PAID"/>
                            </c:otherwise>
                        </c:choose>
                    </form> 
                </c:otherwise>
            </c:choose>
            <%
                }
            %>
            </div>
        </c:if>

        <c:if test="${param.submitted2}">
            <br>
            <div id="feeMsgDiv"></div>
            <c:choose>
                <c:when test="${sessionScope.status=='0'}">
                    <c:catch var="catchException">
                        <sql:update dataSource="${conn}" var="count">
                            update studentfeeinfo
                            set feeStatus=1
                            where sid=? and year=? and cid=?;
                            <sql:param value="${fn:substring(param.rollno,5,9)}" />
                            <sql:param value="${param.year}" />
                            <sql:param value="${param.course}" />
                        </sql:update>
                    </c:catch>

                    <c:choose>
                        <c:when test = "${catchException != null}">
                            <script>
                                document.getElementById("feeDiv").innerHTML = "Fee cannot be set to paid!";
                            </script>
                        </c:when>
                        <c:otherwise>
                            <script>
                                document.getElementById("feeDiv").innerHTML = "Record successfully updated! Fee set as paid.";
                            </script>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <c:catch var="catchException">
                        <sql:update dataSource="${conn}" var="count">
                            update studentfeeinfo
                            set feeStatus=0
                            where sid=? and year=? and cid=?;
                            <sql:param value="${fn:substring(param.rollno,5,9)}" />
                            <sql:param value="${param.year}" />
                            <sql:param value="${param.course}" />
                        </sql:update>
                    </c:catch>
                    <c:choose>
                        <c:when test = "${catchException != null}">
                            <script>
                                document.getElementById("feeDiv").innerHTML = "Fee can not be set to not paid!";
                            </script>
                        </c:when>
                        <c:otherwise>
                            <script>
                                document.getElementById("feeDiv").innerHTML = "Record successfully updated! Fee set to not paid.";
                            </script>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>       
        </c:if>

        <br><br><input type="button" onclick="document.location.href = 'logout.jsp'" value="Log Out">
        <%
            }
        %>
    </body>
</html>
<jsp:directive.include file="footer.jsp"/>