<%-- 
    Document   : updateErr
    Created on : Mar 16, 2021, 6:27:03 PM
    Author     : CND
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/search.css">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" 
              integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" 
              crossorigin="anonymous"/>
        <title>Update error</title>
    </head>
    <body>
        <header class="welcome">
            <h1>Welcome, <span class="welcome-name">${sessionScope.FULLNAME}</span></h1>
            <div class="logout">
                <a href="DispatchController?btnAction=Logout">Logout</a>
            </div>
        </header>
        <main>
            <%-- BEGIN: Neu password update khong dung theo yeu cau thi hien thong bao sai --%>
            <div class="show-error">
                <c:set var="errorUpdate" value="${requestScope.UpdateErr}" />
                <c:if test="${not empty errorUpdate}">
                    <span>Sorry update failed</span><br/>
                    <c:if test="${not empty errorUpdate.passwordErrLength}">
                        <span>${errorUpdate.passwordErrLength}</span>
                    </c:if>
                </c:if>
                <c:url var="search" value="DispatchController">
                    <c:param name="btnAction" value="Search" />
                    <c:param name="searchValue" value="${param.searchValue}" />
                </c:url>
                        <br/><a class="action-btn" href="${search}">Go back to Search Page</a>
            </div>
            <%-- END --%>

        </main>
        <footer>
            <div>
                <a href="https://www.facebook.com/cnd.duchieu" target="_blank" ><i class="fab fa-facebook"></i></a>
                <a href="https://github.com/CNDvn" target="_blank" ><i class="fab fa-github"></i></a>
            </div>
            <div>
                Copyright &COPY; CNDvn
            </div>
        </footer>
    </body>
</html>
