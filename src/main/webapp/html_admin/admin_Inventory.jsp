<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Simple Responsive Admin</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
  <style><%@include file="../asset/css/style.css"%></style>
  <style><%@include file="../asset/css/custom.css"%></style>
  <style><%@include file="../asset/css/bootstrap.css"%></style>

	<style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: auto;
        }
        th, td {
            border: 1px solid #333;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #DDD;
        }
    </style>
	
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
        <a class="navbar-brand" href="../html/home.jsp">Quản Lý Trang Web Thắt Lưng</a>
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


        <li>
          <a href="admin_Disboard.jsp" class="active-link"><i class="fa fa-desktop "></i>Dashboard</a>
        </li>
        <li>
          <a href=admin_user.html ><i class="fa fa-table "></i>USER<span class="badge"></span></a>
        </li>
        <li>
          <a href="admin_Products.html"><i class="fa fa-edit "></i>PRODUCT<span></span></a>
        </li>
        <li>
          <a href="admin_Orders.html" ><i class="fa fa-qrcode "></i>ORDERS</a>
        </li>
        <li>
          <a href="admin_Category.html"><i class="fa fa-bar-chart-o"></i>Category</a>
        </li>

        <li>
          <a href="#"><i class="fa fa-edit "></i>My Link Three </a>
        </li>
        <li>
          <a href="#"><i class="fa fa-table "></i>My Link Four</a>
        </li>
        <li>
          <a href="#"><i class="fa fa-edit "></i>My Link Five </a>
        </li>
        <li>
          <a href="admin_Inventory.jsp"><i class="fa fa-table"></i>Inventory</a>
        </li>

      </ul>
    </div>

  </nav>
  <!-- /. NAV SIDE  -->
  <div id="page-wrapper">
    <div id="page-inner">
    <h2 style="text-align:center;">Báo cáo tồn kho sản phẩm theo quý</h2>
    
	<!-- Hiển thị thông báo lỗi nếu có -->
    <c:if test="${not empty errorMessage}">
        <div style="color: red; text-align: center;">
            ${errorMessage}
        </div>
    </c:if>
    
    <!-- Hiển thị bảng báo cáo tồn kho -->
    <form action="InventoryServlet" method="get">
    <table>
        <thead>
            <tr>
                <th>Mã sản phẩm</th>
                <th>Số lượng ban đầu</th>
                <th>Số lượng hiện tại</th>
                <th>Tình trạng nhập kho</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="report" items="${reports}">
                <tr>
                    <td>${report.productID}</td>
                    <td>${report.initialQuantity}</td>
                    <td>${report.currentQuantity}</td>
                    <td>${report.reorderStatus}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </form>
    
  </div>
</div>
</div>
</body>
</html>