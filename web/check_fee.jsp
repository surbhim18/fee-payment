<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<jsp:directive.include file="header.jsp"/>
<html>
    <head>
        <title>Online Fee Payment System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="js/check_pay_fee.js"></script>
    </head>
    <body>
        <form action="check_fee.jsp" method="post" onsubmit="return validate_check_fee()"> <!-- validation to see if columns are selected -->
            <input type="hidden" name="submitted" value="true">
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
            </table> 
            <br>
            <input type="submit" value="Check fee">
        </form>

        <c:if test="${param.submitted}">
            <sql:query dataSource="${conn}" var="result">
                select cname, year, feeAmt from Fee, Courses where courses.cid=? and year=? and Fee.cid = Courses.cid;
                <sql:param value="${param.course}" />
                <sql:param value="${param.year}" />
            </sql:query>
            <br><br>

            <table border="1" width="30%">
                <tr>
                    <th>Course Name</th>
                    <th>Year</th>
                    <th>Fee</th>
                </tr>
                <c:forEach var="row" items="${result.rows}">
                    <tr>
                        <td><c:out value="${row.cname}"/></td>
                        <td><c:out value="${row.year}"/></td>
                        <td><c:out value="${row.feeAmt}"/></td>
                    </tr>
                </c:forEach>
            </table>

            <br><br>
            <form action="pay_fee.jsp" method="post">                   <!-- to send this data to next page -->
                <input type="hidden" name="valuesSet" value="true">
                <input type="hidden" name="course" value="${param.course}">
                <input type="hidden" name="year" value="${param.year}">

                <input type="submit" value="Proceed to Payment">
            </form>            
        </c:if>      

    </body>
</html>
<jsp:directive.include file="footer.jsp"/>