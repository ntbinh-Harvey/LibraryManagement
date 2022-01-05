<%-- 
    Document   : receiveBookPage
    Created on : Dec 14, 2021, 11:36:00 AM
    Author     : HarveyNguyen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.LibCard"%>
<%@page import="model.BookCopies"%>
<%@page import="model.ReturningCallCard"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="util.DateUtil"%>
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
            ReturningCallCard rcc = new ReturningCallCard();
            if (pageContext.getSession().getAttribute("returningCallCard") != null) {
                rcc = (ReturningCallCard) pageContext.getSession().getAttribute("returningCallCard");
            }
        %>
        <div class="wrapper d-flex flex-column">
            <%@include file="../share/header.jsp"%>
            <div class="content flex-grow-1 row me-0">
                <div class="col-2">
                    <%@include file="../share/sidebar.jsp"%>
                </div>
                <div class="col-10">
                    <div class="row h-100">
                        <div class="col-6 border-end">
                            <form id="receive-the-book-form" class="container" action="ReceiveTheBook" method="post">
                                <div class="mb-3 pt-4">
                                    <input hidden name="libCardId" value="${libCard.getCardId()}"/>
                                    <input hidden name="action" value="create returning call card"/>
                                    <label for="readerId" class="form-label">Reader Id</label>
                                    <input
                                        name="readerId"
                                        type="text"
                                        class="form-control"
                                        id="readerId"
                                        value="${libCard.getR().getId()}"
                                        readonly
                                        />
                                </div>
                                <div class="mb-3">
                                    <label for="readerName" class="form-label">Reader Name</label>
                                    <input
                                        name="readerName"
                                        type="text"
                                        class="form-control"
                                        id="readerName"
                                        value="${libCard.getR().getFullname()}"
                                        readonly
                                        />
                                </div>
                                <div class="mb-3">
                                    <label for="returningDate" class="form-label">Return Date</label>
                                    <input
                                        name="returningDate"
                                        type="text"
                                        class="form-control"
                                        id="returningDate"
                                        value="<%=DateUtil.convertDateToString(new Date())%>"
                                        readonly
                                        />
                                </div>
                                <div class="mb-3">
                                    <label for="librarianId" class="form-label">Librarian Id</label>
                                    <input
                                        name="librarianId"
                                        type="text"
                                        class="form-control"
                                        id="librarianId"
                                        value="${user.getId()}"
                                        readonly
                                        />
                                </div>
                                <div class="mb-3">
                                    <label for="librarianName" class="form-label">Librarian Name</label>
                                    <input
                                        name="librarianName"
                                        type="text"
                                        class="form-control"
                                        id="librarianName"
                                        value="${user.getFullname()}"
                                        readonly
                                        />
                                </div>
                                <label class="form-label">List Books</label>
                                <div class="table-wrapper border">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th scope="col">Bar Code</th>
                                                <th scope="col">Title</th>
                                                <th scope="col">Author</th>
                                                <th scope="col">Status</th>
                                                <th scope="col">Fine(optional)</th>
                                            </tr>
                                        </thead>
                                        <tbody id="lent_book_body">
                                            <c:choose>
                                                <c:when test="${listCurrentBook == null || listCurrentBook.size() == 0}">
                                                    <tr id="empty-state-row">
                                                        <td colspan="5">
                                                            <div id="empty-state">
                                                                <em>Empty List</em>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${listCurrentBook}" var="book">
                                                        <tr class="option">
                                                            <th scope="row">${book.getBarcode()}</th>
                                                            <td>${book.getTitle()}</td>
                                                            <td>${book.getAuthor()}</td>
                                                            <td>
                                                                <select form="receive-the-book-form" name="status" class="form-select form-select-sm" aria-label="Default select example">
                                                                    <option value="available" selected>Received</option>
                                                                    <option value="damaged">Damaged</option>
                                                                    <option value="lost">Lost</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                                <div class="input-group input-group-sm">
                                                                    <label for="fine" hidden class="form-label">Fine</label>
                                                                    <input type="number" id="fine" form="receive-the-book-form" class="form-control" name="fine"/>
                                                                </div>
                                                            </td>
                                                            <td><button type="button" class="py-0 btn btn-danger" onclick="handleRemove(${book.getBarcode()})">Remove</button></td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="d-flex justify-content-end mt-4">
                                    <div>
                                        <button type="submit" class="btn btn-success">Save</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="col-6 px-3">
                            <div class="row border-bottom h-50">
                                <div class="col-12 align-self-center">
                                    <c:if test="${not empty errorReceiveTheBookPage}">
                                        <div class="alert alert-danger" role="alert">
                                            ${errorReceiveTheBookPage}
                                        </div>
                                    </c:if>
                                    <form action="ReceiveTheBook" class="mt-2 pt-2" method="get">
                                        <div class="mb-3">
                                            <input
                                                name="libCardId"
                                                type="text"
                                                class="form-control"
                                                id="libCardId"
                                                placeholder="Search library card id..."
                                                />
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <form class="mt-3 pt-2">
                                        <div class="mb-3">
                                            <input
                                                name="title"
                                                type="text"
                                                class="form-control"
                                                id="username"
                                                placeholder="Search book..."
                                                />
                                        </div>
                                    </form>
                                    <div class="table-wrapper border mt-5">
                                        <table class="table table-hover mb-0">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Bar Code</th>
                                                    <th scope="col">Title</th>
                                                    <th scope="col">Author</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:choose>
                                                    <c:when test="${listBook == null || listBook.size() == 0}">
                                                        <tr>
                                                            <td colspan="3">
                                                                <div id="empty-state">
                                                                    <img src="binoculars.svg" alt="No Result Found">
                                                                    <h5 class="mt-2">No Result Found</h5>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach items="${listBook}" var="book">
                                                            <tr class="option">
                                                                <th scope="row">${book.getBarcode()}</th>
                                                                <td>${book.getTitle()}</td>
                                                                <td>${book.getAuthor()}</td>
                                                                <td><button type="button" class="py-0 btn btn-success" onclick="handleAdd(${book.getBarcode()}, '${book.getTitle()}', '${book.getAuthor()}')">Add</button></td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="../share/footer.jsp"%>
        </div>
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">Preview Returning Call Card</h5>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="readerId" class="form-label">Reader Id</label>
                            <input name="readerId" 
                                   type="text" 
                                   class="form-control" 
                                   id="readerId" 
                                   value="${returningCallCard.getBorrower().getR().getId()}"
                                   readonly
                                   />
                        </div>
                        <div class="mb-3">
                            <label for="readerName" class="form-label">Reader Name</label>
                            <input
                                name="readerName"
                                type="text"
                                class="form-control"
                                id="readerName"
                                value="${returningCallCard.getBorrower().getR().getFullname()}"
                                readonly
                                />
                        </div>
                        <div class="mb-3">
                            <label for="returningDate" class="form-label">Return Date</label>
                            <input
                                name="returningDate"
                                type="text"
                                class="form-control"
                                id="returningDate"
                                value="<%=DateUtil.convertDateToString(rcc.getReturningDate())%>"
                                readonly
                                />
                        </div>
                        <div class="mb-3">
                            <label for="librarianId" class="form-label">Librarian Id</label>
                            <input
                                name="librarianId"
                                type="text"
                                class="form-control"
                                id="librarianId"
                                value="${returningCallCard.getLibrarian().getId()}"
                                readonly
                                />
                        </div>
                        <div class="mb-3">
                            <label for="librarianName" class="form-label">Librarian Name</label>
                            <input
                                name="librarianName"
                                type="text"
                                class="form-control"
                                id="librarianName"
                                value="${returningCallCard.getLibrarian().getFullname()}"
                                readonly
                                />
                        </div>
                        <div class="mb-3">
                            <label for="listBooks" class="form-label">List Returning Books</label>
                            <div class="table-wrapper border mt-2">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bar Code</th>
                                            <th scope="col">Title</th>
                                            <th scope="col">Author</th>
                                            <th scope="col">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${returningCallCard.getLb()}" var="book">
                                            <c:if test="${book.getStatus() != 'lost'}">
                                                <tr class="option">
                                                    <th scope="row">${book.getBarcode()}</th>
                                                    <td>${book.getTitle()}</td>
                                                    <td>${book.getAuthor()}</td>
                                                    <td>${book.getStatus() == "available" ? "": book.getStatus()}</td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="mb-3 w-50">
                            <label for="totalFine" class="form-label">Total Fine</label>
                            <input
                                name="totalFine"
                                type="text"
                                class="form-control"
                                id="totalFine"
                                value="${returningCallCard.getFine()}"
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
                                                                    $(document).ready(function () {
                                                                        if (${returningCallCard != null}) {
                                                                            $("#staticBackdrop").modal('show');
                                                                        }
                                                                    });
                                                                    if (window.history.replaceState) {
                                                                        window.history.replaceState(null, null, window.location.href);
                                                                    }
                                                                    const handleRemove = function (barcode) {
                                                                        $.ajax({
                                                                            url: "ReceiveTheBook",
                                                                            method: "post",
                                                                            data:
                                                                                    {
                                                                                        action: "remove book",
                                                                                        barcode
                                                                                    },
                                                                            success: function () {
                                                                                location.reload();
                                                                                console.log("remove book out of table successfully");
                                                                            }
                                                                        });
                                                                    };
                                                                    const handleAdd = function (barcode, title, author) {
                                                                        // block adding multiple similar row
                                                                        if ($("#lent_book_body:contains(" + barcode + ")").length === 0) {
                                                                            $.ajax({
                                                                                url: "ReceiveTheBook",
                                                                                method: "post",
                                                                                data:
                                                                                        {
                                                                                            action: "add book",
                                                                                            barcode,
                                                                                            title,
                                                                                            author
                                                                                        },
                                                                                success: function () {
                                                                                    location.reload();
                                                                                    console.log("add book to table successfully");
                                                                                }
                                                                            });
                                                                        }
                                                                    };
        </script>
    </body>
</html>
