<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

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

                response.sendRedirect("admin_view_4.jsp");

            } else {
        %>     

        <c:catch var="catchException">
            <sql:update dataSource="${conn}" var="count">
                update fee
                set feeAmt=?
                where cid=? and year =?;
                <sql:param value="${param.feeamt}" />
                <sql:param value="${param.course}" />
                <sql:param value="${param.year}" />
            </sql:update>
        </c:catch>

        <c:choose>
            <c:when test = "${catchException != null}">
                <script>
                    alert("Changes could not be made");
                </script>
            </c:when>
            <c:otherwise>
                <script>
                    alert("Changes made successfully!");
                </script>                
            </c:otherwise>
        </c:choose>

        <%
            response.sendRedirect("admin_view_4.jsp");
        %>           


        <br><br><input type="button" onclick="document.location.href = 'logout.jsp'" value="Log Out">
        <%
            }
        %>
    </body>
</html>
<jsp:directive.include file="footer.jsp"/>