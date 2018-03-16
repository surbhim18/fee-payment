<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:directive.include file="header.jsp"/>
<html>
    <head>
        <title>Online Fee Payment System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="js/create_staff.js"></script>
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

        <h3>New staff account</h3>
        <form action="create_staff.jsp" method="post" onsubmit="return validate()">      <!-- validate information before creation -->
            <input type="hidden" name="submitted" value="true">
            <table>
                <tr>
                    <td><label for="username">Enter username: </label></td>
                    <td><input type="text" name="username" id="username"></td>
                    <td><div id="usernameDiv" style="color:red"></div></td>
                </tr>
                <tr>
                    <td><label for="password">Enter password: </label></td>
                    <td><input type="password" name="password" id="password"></td>
                    <td><div id="passwordDiv" style="color:red"></div></td>
                </tr>
                <tr>
                    <td><label for="password2">Re-enter password: </label></td>
                    <td><input type="password" name="password2" id="password2"></td>
                    <td><div id="password2Div" style="color:red"></div></td>
                </tr>
                <tr>
                    <td></td><td colspan="3"><input type="submit" value="Create staff account"></td>
                </tr>
                <tr></tr>
                <tr>
                    <td></td><td colspan="3"><div id="msgDiv" style="color:red"></div></td>
                </tr>
            </table>
        </form>

        <!-- alerts user on successful account creation -->
        <c:if test="${param.submitted}">   
            <c:catch var="catchException">
                <sql:update dataSource="${conn}" var="count">
                    insert into login values(?,?,'s');
                    <sql:param value="${param.username}" />
                    <sql:param value="${param.password}" />
                </sql:update>
            </c:catch>

            <c:choose>
                <c:when test = "${catchException != null}">
                    <script>
                        document.getElementById("msgDiv").innerHTML = "Username already exists!";
                    </script>
                </c:when>
                <c:otherwise>
                    <script>
                        document.getElementById("msgDiv").innerHTML = "Account has been created successfully!";
                    </script>                
                </c:otherwise>
            </c:choose>
        </c:if>

        <br><input type="button" onclick="document.location.href = 'logout.jsp'" value="Log Out">
        <%
            }
        %>
    </body>
</html>
<jsp:directive.include file="footer.jsp"/>