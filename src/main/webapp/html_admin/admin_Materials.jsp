<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Simple Responsive Admin</title>

    <link href="../asset/css/bootstrap.css" rel="stylesheet"/>

    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    <style>
        <%@include file="../asset/css/style.css" %>
    </style>
    <style>
        <%@include file="../asset/css/custom.css" %>
    </style>
    <style>
        <%@include file="../asset/css/bootstrap.css" %>
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

</head>
<body>


<div id="wrapper">
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="adjust-nav">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="../home.html">Quản Lý Trang Web Thắt Lưng</a>
            </div>

            <span class="logout-spn">
                  <a href="#" style="color:#fff;">Xin chào admin</a>

                </span>
        </div>
    </div>
    <!-- /. NAV TOP  -->

    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <!--LINK-->

                <li>
                    <a href="admin_Disboard.html"><i class="fa fa-desktop "></i>Dashboard</a>
                </li>


                <li>
                    <a href=<%=request.getContextPath()%>/admin_Users ><i class="fa fa-table "></i>USER<span class="badge"></span></a>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/admin_Products"><i class="fa fa-edit "></i>PRODUCT<span></span></a>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/admin_Orders"><i class="fa fa-qrcode "></i>ORDERS</a>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/admin_Categories" ><i class="fa fa-bar-chart-o"></i>Category</a>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/admin_Brands"><i class="fa fa-edit "></i>Brands</a>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/admin_Materials"><i class="fa fa-edit "></i>Materials</a>
                </li>

            </ul>
        </div>

    </nav>
    <!-- /. NAV SIDE  -->
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-md-12">
                    <h2>Loại sản phẩm</h2>
                </div>
            </div>
            <a href="<%=request.getContextPath()%>/admin_Materials/add"><i class="fa-solid fa-plus"></i>Thêm loại thắt
                lưng</a>
            <table id="example" class="display" style="width:100%">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Thao tác </th>

                </tr>
                </thead>
                <tbody>
                <%-- Ví dụ: Lặp qua danh sách dữ liệu từ backend --%>
                <c:forEach items="${materialList}" var="mate">
                    <tr>
                        <th scope="row">${mate.getId()}</th>
                        <td>${mate.getName()}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin_Material/edit?id=${mate.getId()}&action=edit">
                                <i
                                        class="fa-solid fa-pen-to-square"></i></a>
                            <a href="${pageContext.request.contextPath}/admin_Materials/delete?id=${mate.getId()}&action=delete"><i
                                    class="fa-solid fa-trash"></i></a>
                        </td>
                    </tr>

                </c:forEach>
                </tbody>
            </table>

            <!-- /. ROW  -->
        </div>
        <!-- /. PAGE INNER  -->
    </div>

</div>
<script>
    $(document).ready(function () {
        $('#example').DataTable({
            "paging": true,        // Bật phân trang
            "searching": true,     // Bật tìm kiếm
            "ordering": true,      // Bật sắp xếp
            "info": true           // Hiển thị thông tin tổng quan
        });
    });
</script>
</body>
</html>
