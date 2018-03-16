<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<html>
    <head>
        <title>Redirecting...</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <sql:query dataSource="${conn}" var="result">
            select privileges from login where username=? and password=?; 
            <sql:param value="${param.username}" />
            <sql:param value="${param.password}" />
        </sql:query>
        <c:choose>
            <c:when test="${result.rowCount==0}">
                <%
                    response.sendRedirect("admin_login.jsp");
                %>
            </c:when>
            <c:otherwise>
                <c:set var="username" scope="session" value="${param.username}"/>
                <c:forEach var="row" items="${result.rows}">
                    <c:set var="level" scope="session" value="${row.privileges}"/>
                    <c:choose>
                        <c:when test="${row.privileges=='a'}">
                            <%
                                response.sendRedirect("admin.jsp");
                            %>
                        </c:when>
                        <c:otherwise>
                            <%
                                response.sendRedirect("staff.jsp");
                            %>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </body>
</html>