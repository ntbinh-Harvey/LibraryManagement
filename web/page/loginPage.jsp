<%-- 
    Document   : index
    Created on : Dec 14, 2021, 10:35:13 AM
    Author     : HarveyNguyen
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Library Management System</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
            />
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <div class="wrapper d-flex flex-column">
            <%@include file="../share/header.jsp"%>
            <div class="content flex-grow-1">
                <h2 class="text-center my-5">Sign in</h2>
                <form id="login-form" class="container" action="Login" method="post">
                    <div class="mb-3 pt-4">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>
                        <label for="username" class="form-label">Username</label>
                        <input
                            name="username"
                            type="text"
                            class="form-control"
                            id="username"
                            />
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input
                            name="password"
                            type="password"
                            class="form-control"
                            id="password"
                            />
                    </div>
                    <div class="d-grid">
                        <button class="btn btn-primary mt-3" type="submit">Sign In</button>
                    </div>
                    <div class="text-center mt-3">Or</div>
                    <div class="d-grid">
                        <button class="btn btn-info mt-3" type="button">
                            Sign Up A New Account
                        </button>
                    </div>
                </form>
            </div>
            <%@include file="../share/footer.jsp"%>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
    </body>
</html>

