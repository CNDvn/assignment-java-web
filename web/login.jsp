<%-- 
    Document   : login
    Created on : Mar 17, 2021, 10:50:55 AM
    Author     : CND
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Login page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="assets/css/login.css">
    </head>
    <body>
        <div class="login-page">
            <div class="wrap-form">
            <h1 class="title-form" >Login</h1>
            <form action="DispatchController" method="POST">
                <input class="input-control" type="text" name="txtUsername" value="" placeholder="Username"/><br/>
                <input class="input-control" type="password" name="txtPassword" value="" placeholder="Password"/><br/>
                <input class="btn" type="submit" value="Login" name="btnAction" />
                <input class="btn" type="reset" value="Reset" />
            </form>
            <c:if test="${not empty requestScope.err}">
                <span class="err-login">${requestScope.err}</span>
            </c:if>
        </div>
        </div>
    </body>
</html>