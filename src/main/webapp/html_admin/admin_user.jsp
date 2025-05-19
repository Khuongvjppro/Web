<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.banthatlung.Dao.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<p>Tổng user: ${fn:length(users)}</p>
<%
    User authUser = (User) session.getAttribute("auth");
    if (authUser == null || authUser.getRole() != 1) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Quản lý người dùng</title>

    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    <style><%@include file="../asset/css/style.css"%></style>
    <style><%@include file="../asset/css/custom.css"%></style>
    <style><%@include file="../asset/css/bootstrap.css"%></style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
<!-- FORM MODAL -->
<div class="modal js-modal">
    <form class="form__content" action="" method="POST">
        <div class="form__title">
            <button type="button" class="js-modal-close">Đóng</button>
            <h3>Chỉnh sửa thông tin user</h3>
        </div>
        <label for="email">Email</label>
        <div class="form__item">
            <input type="email" id="email" name="email" required placeholder="Email"><br>
        </div>
        <label for="name">Tên người dùng</label>
        <div class="form__item">
            <input type="text" id="name" name="name" required><br>
        </div>
        <label for="matkhau">Mật khẩu</label>
        <div class="form__item">
            <input type="text" id="matkhau" name="pass" required><br>
        </div>
        <label for="phone">Số Điện Thoại:</label>
        <div class="form__item">
            <input type="text" id="phone" name="phone" required><br>
        </div>
        <div class="commit">
            <button type="submit">Xác nhận</button>
        </div>
    </form>
</div>

<!-- MAIN WRAPPER -->
<div id="wrapper">
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="adjust-nav">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="../html/home.jsp">Trang chủ</a>
            </div>
            <span class="logout-spn">
                <a href="#" style="color:#fff;">Đăng xuất</a>
            </span>
        </div>
    </div>

    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <li>
          			<a href="admin_Disboard.jsp" class="active-link"><i class="fa fa-desktop "></i>Dashboard</a>
        		</li>
        		<li>
          			<a href=admin_user.jsp ><i class="fa fa-table "></i>USER<span class="badge"></span></a>
        		</li>
        		<li>
          			<a href="admin_Products.jsp"><i class="fa fa-edit "></i>PRODUCT<span></span></a>
        		</li>
        		<li>
          			<a href="admin_Orders.jsp" ><i class="fa fa-qrcode "></i>ORDERS</a>
        		</li>
        		<li>
          			<a href="admin_Categories.jsp"><i class="fa fa-bar-chart-o"></i>Category</a>
        		</li>
        		<li>
         			 <a href="admin_Inventory.jsp"><i class="fa fa-table"></i>Inventory</a>
        		</li>
            </ul>
        </div>
    </nav>

    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-md-12">
                    <h2>Trang USER</h2>
                </div>
            </div>
            <label>
                <input class="search__input" type="text" name="" placeholder="Nhập email, sdt,.. ">
            </label>
            <button class="search__submit">
                <i class="fa-solid fa-magnifying-glass"></i>
                <span>Tìm kiếm</span>
            </button>
            <table class="table table-striped">
                <thead style="background:#5cb85c">
                <tr>
                    <th>ID</th>
                    <th>Tên Tài Khoản</th>
                    <th>Email</th>
                    <th>Mật khẩu</th>
                    <th>Số điện thoại</th>
                    <th>Loại tài khoản</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.username}</td>
                        <td>${user.email}</td>
                        <td>${user.pass}</td>
                        <td>${user.phone}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.role == 1}">Admin</c:when>
                                <c:otherwise>User</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button class="btn js-edit"><i class="fa-solid fa-pen-to-square fa_in_admin"></i></button>
                            <button class="btn js-edit"><i class="fa-solid fa-trash fa_in_admin"></i></button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    const editBtns = document.querySelectorAll('.js-edit')
    const modal = document.querySelector('.js-modal')
    const modalClose = document.querySelector('.js-modal-close')

    function showForm() {
        modal.classList.add('open')
    }

    function hideForm() {
        modal.classList.remove('open')
    }

    editBtns.forEach(btn => btn.addEventListener('click', showForm))
    modalClose.addEventListener('click', hideForm)
</script>
</body>
</html>