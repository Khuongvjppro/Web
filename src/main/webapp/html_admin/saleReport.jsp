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
        <a class="navbar-brand" href="../View/home.jsp">Quản Lý Trang Web Thắt Lưng</a>
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
          <a href="admin_user.jsp"><i class="fa fa-table "></i>USER<span class="badge"></span></a>
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
        <li>
          <a href="saleReport.jsp" class="active-link"><i class="fa fa-table"></i>Sale report</a>
        </li>
        

      </ul>
    </div>

  </nav>
  <!-- /. NAV SIDE  -->
    <div id="page-wrapper">
    <div id="page-inner">
      <h2 style="text-align:center;">Báo cáo bán hàng theo quý</h2>
      <form action="${pageContext.request.contextPath}/saleReport" method="get" style="text-align:center;">
        Chọn năm:
        <input type="number" name="year" value="${year}" min="2000" max="2100" required="required"/>
        Chọn quý:
        <input type="number" name="quarter" value="${quarter}" min="1" max="4" required="required"/>
        <input type="submit" value="Xem báo cáo"/>
      </form>

      <c:if test="${not empty quarterlyReport}">
        <table class="table table-bordered">
          <thead>
            <tr>
              <th>Mã SP</th>
              <th>Tên SP</th>
              <th>Quý</th>
              <th>Số lượng bán</th>
              <th>Doanh thu</th>
            </tr>
          </thead>
          <tbody>
          	<c:forEach var="report" items="${quarterlyReport}">
              <tr>
                <td>${report.productID}</td>
                <td>${report.productName}</td>
                <td>Q${report.quarter}</td>
                <td>${report.totalQuantity}</td>
                <td>${report.totalRevenue}</td>
              </tr>
          	</c:forEach>
          </tbody>
        </table>
      </c:if>
    </div>
  </div>
</div>
</body>
</html>