<%-- 
    Document   : search
    Created on : Mar 14, 2021, 9:47:53 AM
    Author     : CND
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.FULLNAME}">
    <c:redirect url="login.html" />
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/search.css">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" 
              integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" 
              crossorigin="anonymous"/>

        <title>Search Page</title>
    </head>
    <body>
        <%-- BEGIN: dua ra cau xac nhan nguoi dung muon xoa hay update khong --%>
        <c:set var="confirm" value="${param.confirm}" />
        <c:if test="${not empty confirm}">
            <c:url var="search" value="DispatchController">
                <c:param name="btnAction" value="Search" />
                <c:param name="searchValue" value="${param.searchValue}" />
            </c:url>
            <c:if test='${confirm eq "delete"}'>
                <div class="out-confirm">
                    <div class="wrap-confirm-delete">
                        <div class="confirm-delete">
                            <div>
                                Do you want to delete
                            </div>
                            <div class="action-confirm">
                                <c:url var="deleted" value="DispatchController">
                                    <c:param name="btnAction" value="Delete" />
                                    <c:param name="pk" value="${param.pk}" />
                                    <c:param name="confirm" value="delete" />
                                    <c:param name="lastSearchValue" value="${param.searchValue}" />
                                </c:url>
                                <a class="action-btn action-btn-1" href="${deleted}">Delete</a>
                                <a class="action-btn action-btn-1" href="${search}">No</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test='${confirm eq "update"}'>
                <div class="out-confirm">
                    <div class="wrap-confirm-delete">
                        <div class="confirm-delete">
                            <div>Do you want to update</div>
                            <div class="action-confirm">
                                <form action="DispatchController" method="POST">
                                    <div class="not-show">
                                        <input type="hidden" name="txtUsrename" value="${param.txtUsrename}" />
                                        <input minlength="6" maxlength="20" class="password-control" type="hidden" name="txtPassword" value="${param.txtPassword}" />
                                        <input type="checkbox" name="chkIsAdmin" value="ON" 
                                               <c:if test='${param.chkIsAdmin eq "ON"}'>
                                                   checked="checked"
                                               </c:if>
                                               />
                                        <input type="hidden" name="confirm" value="update" />
                                        <input type="hidden" name="lastSearchValue" value="${param.searchValue}" />

                                    </div>
                                    <input class="action-btn action-btn-1" class="action-btn" type="submit" value="Update" name="btnAction" />
                                    <a class="action-btn action-btn-1" href="${search}">No</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>
        <%-- END --%>

        <header class="welcome">
            <h1>Welcome, <span class="welcome-name">${sessionScope.FULLNAME}</span></h1>
            <div class="logout">
                <a href="DispatchController?btnAction=Logout">Logout</a>
            </div>
        </header>

        <main>
            <%-- BEGIN: thuc hien chuc nang search --%>

            <div class="search-form">
                <form action="DispatchController">
                    <input class="search-control" 
                           type="text" 
                           name="searchValue" 
                           value="<c:if test="${not empty param.searchValue}">${param.searchValue}</c:if>" 
                               placeholder="Search..." />
                           <input class="search-btn" type="submit" value="Search" name="btnAction" />
                    </form>
                </div>
            <%-- END --%>





            <div class="warp-table">
                <c:if test="${not empty param.searchValue}">
                    <c:set var="listAccount" value="${requestScope.listAccount}"/>
                    <c:if test="${not empty listAccount}">
                        <table>
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Username</th>
                                    <th>Password</th>
                                    <th>Full name</th>
                                    <th>Role</th>
                                    <th>Delete</th>
                                    <th>Update</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="dto" items="${listAccount}" varStatus="counter">
                                <form action="DispatchController" method="POST">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>
                                            ${dto.username}
                                            <input type="hidden" name="txtUsrename" value="${dto.username}" />
                                        </td>
                                        <td>
                                            <input minlength="6" maxlength="20" class="password-control" type="text" name="txtPassword" value="${dto.password}" />
                                        </td>
                                        <td>${dto.fullname}</td>
                                        <td>
                                            <input type="checkbox" name="chkIsAdmin" value="ON" 
                                                   <c:if test="${dto.isAdmin}">
                                                       checked="checked"
                                                   </c:if>
                                                   />
                                        </td>
                                        <td>
                                            <c:url var="urlRewriting" value="DispatchController">
                                                <c:param name="btnAction" value="Delete" />
                                                <c:param name="pk" value="${dto.username}" />
                                                <c:param name="lastSearchValue" value="${param.searchValue}" />                        
                                                <c:param name="confirm" value="not yet" />
                                            </c:url>
                                            <a class="action-btn" href="${urlRewriting}">Delete</a>
                                        </td>
                                        <td>                          
                                            <input type="hidden" name="confirm" value="not yet" />
                                            <input class="action-btn" type="submit" value="Update" name="btnAction" />
                                            <input type="hidden" name="lastSearchValue" value="${param.searchValue}" />
                                        </td>
                                    </tr>
                                </form>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${empty listAccount}">
                        <font color="red">
                        <h1>Don't have the name is "${param.searchValue}"</h1>
                        </font>
                    </c:if>
                </c:if>
            </div>
        </main>

        <footer>
            <div>
                <a href="https://www.facebook.com/cnd.duchieu" target="_blank" ><i class="fab fa-facebook"></i></a>
                <a href="https://github.com/CNDvn" target="_blank" ><i class="fab fa-github"></i></a>
            </div>
            <div>
                Copyright &COPY; 2021 CNDvn
            </div>
        </footer>
    </body>
</html>
