<%-- 
    Document   : registerNewReaderPage
    Created on : Dec 26, 2021, 10:09:13 AM
    Author     : HarveyNguyen
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.LibCard"%>
<%@page import="util.DateUtil"%>
<%@page import="java.util.Date"%>
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
        <%
            DateUtil dc = new DateUtil();
            LibCard lc = (LibCard) request.getSession().getAttribute("libCard");
        %>
        <div class="wrapper d-flex flex-column">
            <%@include file="../share/header.jsp"%>
            <div class="content flex-grow-1 row me-0">
                <div class="col-2">
                    <%@include file="../share/sidebar.jsp"%>
                </div>
                <div class="col-10">
                    <h3 class="text-center mt-5">Register new reader</h3>
                    <div class="d-grid gap-2 col-6 mx-auto">
                        <form id="register-new-reader-form" class="container" action="RegisterNewReader" method="post">
                            <div class="mb-3 pt-4">
                                <input name="id" hidden value="${user.getId()}" />
                                <label for="fullname" class="form-label">Full name</label>
                                <input
                                    name="fullname"
                                    type="text"
                                    class="form-control"
                                    id="fullname"
                                    placeholder="Nguyen Thanh Binh"
                                    />
                            </div>
                            <div class="mb-3">
                                <label for="DoB" class="form-label">Date Of Birth</label>
                                <input
                                    name="DoB"
                                    type="date"
                                    class="form-control"
                                    id="DoB"
                                    />
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <input
                                    name="address"
                                    type="text"
                                    class="form-control"
                                    id="address"
                                    placeholder="X Street Y City Z"
                                    />
                            </div>
                            <div class="mb-3">
                                <label for="telephone" class="form-label">Telephone</label>
                                <input
                                    name="telephone"
                                    type="text"
                                    class="form-control"
                                    id="telephone"
                                    placeholder="012345678"
                                    />
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input
                                    name="email"
                                    type="email"
                                    class="form-control"
                                    id="email"
                                    placeholder="abc@email.com"
                                    />
                            </div>
                            <div class="d-grid">
                                <button class="btn btn-primary mt-3" type="submit">Register</button>
                            </div>
                            <div class="d-grid">
                                <a href="/LibraryManagement/HomePage"><button class="btn btn-danger mt-4 w-100" type="button">Cancel</button></a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%@include file="../share/footer.jsp"%>
        </div>
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">Preview Library Card</h5>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="expDate" class="form-label">Expire Date</label>
                            <input name="expDate" 
                                   type="text" 
                                   class="form-control" 
                                   id="expDate" 
                                   value="<%= dc.convertDateToString(lc.getExp_date())%>"
                                   readonly
                                   />
                        </div>
                        <div class="mb-3">
                            <label for="fullname" class="form-label">Full name</label>
                            <input
                                name="fullname"
                                type="text"
                                class="form-control"
                                id="fullname"
                                value="${libCard.getR().getFullname()}"
                                readonly
                                />
                        </div>
                        <div class="mb-3">
                            <label for="DoB" class="form-label">Date Of Birth</label>
                            <input
                                name="DoB"
                                type="text"
                                class="form-control"
                                id="DoB"
                                value="<%= dc.convertDateToString(lc.getR().getDoB())%>"
                                readonly
                                />
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <input
                                name="address"
                                type="text"
                                class="form-control"
                                id="address"
                                value="${libCard.getR().getAddress()}"
                                readonly
                                />
                        </div>
                        <div class="mb-3">
                            <label for="telephone" class="form-label">Telephone</label>
                            <input
                                name="telephone"
                                type="text"
                                class="form-control"
                                id="telephone"
                                value="${libCard.getR().getTelephone()}"
                                readonly
                                />
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input
                                name="email"
                                type="email"
                                class="form-control"
                                id="email"
                                value="${libCard.getR().getEmail()}"
                                readonly
                                />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <a href="/LibraryManagement/HomePage"><button type="button" class="btn btn-primary" id="print-btn" data-bs-dismiss="modal">Print</button></a>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            // refresh the page will not re-post the form 
            if (window.history.replaceState) {
                window.history.replaceState(null, null, window.location.href);
            }
            $(document).ready(function () {
                if (${libCard != null}) {
                    $("#staticBackdrop").modal('show');
                }
            });
        </script>
    </body>
</html>
