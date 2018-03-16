<jsp:directive.include file="header.jsp"/>
<html>
    <head>
        <title>Online Fee Payment System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="js/admin_login.js"></script>
    </head>
    <body>

        <h3>Login Page</h3>
        <div>
            <form action="redirection.jsp" method="post" onsubmit="return validate()">
                <table>
                    <tr>
                        <td><label for="username">Username: </label></td>
                        <td><input type="text" name="username" id="username"></td>
                        <td><div id="usernameDiv" style="color:red"></div></td>
                    </tr>
                    <tr>
                        <td><label for="password">Password: </label></td>
                        <td><input type="password" name="password" id="password"></td>
                        <td><div id="passwordDiv" style="color:red"></div></td>
                    </tr>
                    <tr>
                        <td></td><td colspan="3"><input type="submit" value="Log In"></td>
                    </tr>
                </table>
            </form>
        </div>


    </body>
</html>
<jsp:directive.include file="footer.jsp"/>