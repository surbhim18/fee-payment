<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
            <%
                session.setAttribute("username", null);
                session.invalidate();
                response.sendRedirect("index.jsp");
            %>
    </body>
</html>
