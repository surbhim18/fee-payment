<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<jsp:directive.include file="header.jsp"/>
<html>
    <head>
        <title>Online Fee Payment System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
      <br><br>
        <h3>For admin</h3>
        <a href="admin_login.jsp">use admin interface</a>

        <br><br>
        <h3>For students</h3>
        1. <a href="check_fee.jsp">Check fee</a><br>
        2. <a href="pay_fee.jsp">Proceed to payment</a>
        
        <br><br>
        View fees of all courses <a href="pdfs/a.pdf">here</a>.

         <sql:setDataSource var="conn" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/feemgtsys" user="root" password="root" scope="session"/>
    </body>
</html>
<jsp:directive.include file="footer.jsp"/>
