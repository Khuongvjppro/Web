<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">Quản Lý Trang Web Thắt Lưng</a>
      </div>

      <span class="logout-spn">
                  <a href="#" style="color:#fff;">Xin chào ${sessionScope.username}</a>

                </span>
    </div>
  </div>
  
  <!-- /. NAV TOP  -->
  <nav class="navbar-default navbar-side" role="navigation">
    <div class="sidebar-collapse">
      <ul class="nav" id="main-menu">


        <li>
          <a href="admin_Disboard.jsp"><i class="fa fa-desktop "></i>Dashboard</a>
        </li>
        <li>
          <a href="admin_user.jsp" ><i class="fa fa-table "></i>USER<span class="badge"></span></a>
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
          <a href="admin_Inventory.jsp" class="active-link"><i class="fa fa-table"></i>Inventory</a>
        </li>
        <li>
          <a href="saleReport.jsp"><i class="fa fa-table"></i>Sale report</a>
        </li>

      </ul>
    </div>

  </nav>
  <!-- /. NAV SIDE  -->
    <div id="page-wrapper">
    <div id="page-inner">
        <h2 style="text-align:center;">Báo cáo tồn kho sản phẩm</h2>
	    <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty errorMessage}">
            <div style="color: red; text-align: center;">
                ${errorMessage}
            </div>
        </c:if>
    
        <!-- Kiểm tra có lấy được dữ liệu tồn kho không -->
        <c:if test="${empty reports}">
    	    <p style="color:red;text-align:center;">Không có dữ liệu tồn kho để hiển thị.</p>
	    </c:if>
    
        <!-- Hiển thị bảng báo cáo tồn kho -->
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
                <c:forEach items="report" var="reports">
                    <tr>
                        <td>${report.getProductID()}</td>
                        <td>${report.getInitialQuantity()}</td>
                        <td>${report.getCurrentQuantity()}</td>
                        <td>${report.getReorderStatus()}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    </div>
</div>
</body>
</html>