<%-- 
    Document   : lendBookPage
    Created on : Dec 14, 2021, 11:35:51 AM
    Author     : HarveyNguyen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.LibCard"%>
<%@page import="model.BookCopies"%>
<%@page import="model.CallCard"%>
<%@page import="util.DateUtil"%>
<%@page import="java.util.ArrayList"%>
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
            CallCard cc = new CallCard();
            if (pageContext.getSession().getAttribute("callCard") != null) {
                cc = (CallCard) pageContext.getSession().getAttribute("callCard");
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
                            <form id="lend-the-book-form" class="container" action="LendTheBook" method="post">
                                <div class="mb-3 pt-4">
                                    <input hidden name="libCardId" value="${libCard.getCardId()}"/>
                                    <input hidden name="action" value="create call card"/>
                                    <label for="readerId" class="form-label">Reader Id</label>
                                    <input
                                        name="readerId"
                                        type="text"
                                        class="form-control"
                                        id="readerId"
                                        readonly
                                        value="${libCard.getR().getId()}"
                                        />
                                </div>
                                <div class="mb-3">
                                    <label for="readerName" class="form-label">Reader Name</label>
                                    <input
                                        name="readerName"
                                        type="text"
                                        class="form-control"
                                        id="readerName"
                                        readonly
                                        value="${libCard.getR().getFullname()}"
                                        />
                                </div>
                                <div class="mb-3">
                                    <label for="dueDate" class="form-label">Due Date</label>
                                    <input
                                        name="dueDate"
                                        type="date"
                                        class="form-control"
                                        id="dueDate"
                                        value="${sessionScope.dueDate}"
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
                                            </tr>
                                        </thead>
                                        <tbody id="lent_book_body">
                                            <c:choose>
                                                <c:when test="${listCurrentBook == null || listCurrentBook.size() == 0}">
                                                    <tr id="empty-state-row">
                                                        <td colspan="3">
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
                                    <c:if test="${not empty errorLendTheBookPage}">
                                        <div class="alert alert-danger" role="alert">
                                            ${errorLendTheBookPage}
                                        </div>
                                    </c:if>
                                    <form action="LendTheBook" class="mt-2 pt-2" method="get">
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
                                    <form action="LendTheBook" class="mt-3 pt-2" method="get">
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
                        <h5 class="modal-title" id="staticBackdropLabel">Preview Call Card</h5>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="readerId" class="form-label">Reader Id</label>
                            <input name="readerId" 
                                   type="text" 
                                   class="form-control" 
                                   id="readerId" 
                                   value="${callCard.getBorrower().getR().getId()}"
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
                                value="${callCard.getBorrower().getR().getFullname()}"
                                readonly
                                />
                        </div>
                        <div class="mb-3">
                            <label for="borrowingDate" class="form-label">Borrowing Date</label>
                            <input
                                name="borrowingDate"
                                type="text"
                                class="form-control"
                                id="borrowingDate"
                                value="<%=DateUtil.convertDateToString(new Date())%>"
                                readonly
                                />
                        </div>
                        <div class="mb-3">
                            <label for="dueDate" class="form-label">Due Date</label>
                            <input
                                name="dueDate"
                                type="text"
                                class="form-control"
                                id="dueDate"
                                value="<%=DateUtil.convertDateToString(cc.getDueDate())%>"
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
                                value="${callCard.getLibrarian().getId()}"
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
                                value="${callCard.getLibrarian().getFullname()}"
                                readonly
                                />
                        </div>
                        <div class="mb-3">
                            <label for="listBooks" class="form-label">List Books</label>
                            <div class="table-wrapper border mt-2">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bar Code</th>
                                            <th scope="col">Title</th>
                                            <th scope="col">Author</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${callCard.getLb()}" var="book">
                                            <tr class="option">
                                                <th scope="row">${book.getBarcode()}</th>
                                                <td>${book.getTitle()}</td>
                                                <td>${book.getAuthor()}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
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
                                                                        if (${callCard != null}) {
                                                                            $("#staticBackdrop").modal('show');
                                                                        }
                                                                    });
                                                                    if (window.history.replaceState) {
                                                                        window.history.replaceState(null, null, window.location.href);
                                                                    }
                                                                    const handleRemove = function (barcode) {
                                                                        $.ajax({
                                                                            url: "LendTheBook",
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
                                                                                url: "LendTheBook",
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
                                                                    $("#dueDate").change(function (e) {
                                                                        $.ajax({
                                                                            url: "LendTheBook",
                                                                            method: "post",
                                                                            data:
                                                                                    {
                                                                                        action: "set due date",
                                                                                        dueDate: e.target.value
                                                                                    },
                                                                            success: function () {
                                                                                location.reload();
                                                                                console.log("set reader successfully");
                                                                            }
                                                                        });
                                                                    })
        </script>
    </body>
</html>
