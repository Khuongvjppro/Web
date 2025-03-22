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
          <a href="<%=request.getContextPath()%>/admin_Brands" class="active-link"><i class="fa fa-edit "></i>Brands</a>
        </li>
        <a href="/fake_war_exploded/admin_Brands"><i class="fa fa-edit "></i>Brands</a>
        </li>

      </ul>
    </div>

  </nav>
  <!-- /. NAV SIDE  -->
  <div id="page-wrapper">
    <div id="page-inner">
      <div class="row">
        <div class="col-md-12">
          <h2>Thêm hãng thắt lưng</h2>
        </div>
      </div>
      <!-- /. ROW  -->
      <form method="POST">
        <div class="mb-3">
          <label for="name" class="form-label">Tên hãng thắt lưng</label>
          <input type="text" name="name" class="form-control" id="name" placeholder="Hãng thắt lưng">
        </div>
        <div class="mb-3">
          <label for="created_At" class="form-label">Ngày</label>
          <input type="text" name="created_At" class="form-control" id="created_At" placeholder="Ngày">
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
      </form>
      <a href="${pageContext.request.contextPath}/admin_Brands">Quay về</a>
    </div>
  </div>
</div>
</body>
</html>
