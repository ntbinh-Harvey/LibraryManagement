<%-- 
    Document   : readerHomePage
    Created on : Dec 14, 2021, 11:35:23 AM
    Author     : HarveyNguyen
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
            />
        <link rel="stylesheet" href="css/style.css" />
        <title>Library Management System</title>
    </head>
    <body>
        <div class="wrapper d-flex flex-column">
            <%@include file="../share/header.jsp"%>
            <div class="content flex-grow-1 row me-0">
                <div class="col-2">
                    <%@include file="../share/sidebar.jsp"%>
                </div>
                <div class="col-10">
                    <div class="text-center fs-5 fw-bold my-5">Please choose an action to perform</div>
                    <div class="d-grid gap-2 col-6 mx-auto">
                        <c:choose>
                            <c:when test="${sessionScope.user.getRole()=='reader'}" >
                                <a href="/LibraryManagement/RegisterNewReader"><button class="btn btn-primary my-3 w-100" type="button">Register new reader card</button></a>
                            </c:when>
                            <c:otherwise>
                                <a href="/LibraryManagement/LendTheBook"><button class="btn btn-primary my-3 w-100" type="button">Lend The Book</button></a>
                                <a href="/LibraryManagement/ReceiveTheBook"><button class="btn btn-primary my-3 w-100" type="button">Receive the book</button></a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <%@include file="../share/footer.jsp"%>
        </div>
    </body>
</html>
