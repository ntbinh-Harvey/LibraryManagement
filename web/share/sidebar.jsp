<%-- 
    Document   : sidebar
    Created on : Dec 14, 2021, 10:30:24 AM
    Author     : HarveyNguyen
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <aside class="h-100 list-group text-center">
            <a href="/LibraryManagement/HomePage" id="home-item" class="py-3 list-group-item list-group-item-action" aria-current="true">
                <i class="fas fa-home fa-2x"></i>
            </a>
            <c:choose>
                <c:when test="${sessionScope.user.getRole()=='reader'}" >
                    <div id="register-new-reader-item" class="fw-bold py-3 list-group-item list-group-item-action">Register new reader card</div>
                </c:when>
                <c:otherwise>
                    <div id="lend-the-book-item" class="fw-bold py-3 list-group-item">Lend the book</div>
                    <div id="receive-the-book-item" class="fw-bold py-3 list-group-item">Receive the book</div>
                </c:otherwise>
            </c:choose>
        </aside>
        <script>
            const currentPath = window.location.pathname.split('/').pop();
            switch (currentPath) {
                case "HomePage":
                {
                    document.querySelector("#home-item").classList.add("active");
                    break;
                }
                case "RegisterNewReader":
                {
                    document.querySelector("#register-new-reader-item").classList.add("active");
                    break;
                }
                case "LendTheBook":
                {
                    document.querySelector("#lend-the-book-item").classList.add("active");
                    break;
                }
                case "ReceiveTheBook":
                {
                    document.querySelector("#receive-the-book-item").classList.add("active");
                    break;
                }
            }
        </script>
    </body>
</html>
