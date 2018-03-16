<%@page import="java.util.*,java.lang.*,java.text.*"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <title>Redirecting</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%
            if ((session.getAttribute("username") == null) || (session.getAttribute("username") == "") || (session.getAttribute("level").equals("s"))) {

                response.sendRedirect("admin_view_1_1.jsp");

            } else {
        %>     

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
                       
                            Fee can not be set to paid
                       
                        <%
                            response.sendRedirect("admin_view_1.jsp");
                        %>
                    </c:when>
                    <c:otherwise>

                       
                            Record successfully updated
                          
                        <%
                            response.sendRedirect("admin_view_1.jsp");
                        %>
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
                            alert("Fee can not be set to not paid");
                        </script>
                        <%
                            response.sendRedirect("admin_view_1.jsp");
                        %>
                    </c:when>
                    <c:otherwise>
                        <script>
                            alert("Record successfully updated.");
                        </script>
                        <%
                            response.sendRedirect("admin_view_1.jsp");
                        %>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>       


        <br><br><input type="button" onclick="document.location.href = 'logout.jsp'" value="Log Out">
        <%
            }
        %>
    </body>
</html>