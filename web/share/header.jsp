<%-- 
    Document   : header
    Created on : Dec 14, 2021, 10:28:59 AM
    Author     : HarveyNguyen
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <header class="py-3 px-5 border-bottom d-flex justify-content-between align-items-center">
            <a href="/LibraryManagement" class="mb-2 mb-md-0 text-dark text-decoration-none">
                <i class="fas fa-book-open fa-2x align-middle"></i>
                <span class="fs-4 text-uppercase align-middle ms-2"
                      >library management</span
                >
            </a>
            <c:if test="${sessionScope.user != null && sessionScope.user.getId() != 0}">
                <div>
                    <span>Hello <em>${sessionScope.user.getRole()} ${sessionScope.user.getUsername()}</em></span>
                    <a href="/LibraryManagement/Login"><button type="button" class="btn btn-danger ms-4">Logout</button></a>
                </div>
            </c:if>
        </header>
    </body>
</html>
