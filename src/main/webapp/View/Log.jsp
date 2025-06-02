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
                    <a href="${pageContext.request.contextPath}/dashboard"><i class="fa fa-desktop "></i>Dashboard</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/html_admin/admin_user.jsp"><i class="fa fa-table "></i>USER<span class="badge"></span></a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin_Products"><i class="fa fa-edit "></i>PRODUCT<span></span></a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin_Orders" ><i class="fa fa-qrcode "></i>ORDERS</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin_Categories"><i class="fa fa-bar-chart-o"></i>Category</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin_Brands"><i class="fa fa-edit "></i>Brands</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin_Materials"><i class="fa fa-edit "></i>Materials</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin_Inventory"><i class="fa fa-table"></i>Inventory</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/html_admin/saleReport.jsp" class="fa fa-table">Sale report</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/html_admin/Log.jsp"><i class="active-link"></i>Log</a>
                </li>
            </ul>
        </div>

    </nav>
    <!-- /. NAV SIDE  -->
    <div id="page-wrapper">
        <div id="page-inner">
            <h2 style="text-align:center;">Tra cứu Log Hoạt Động</h2>
            <form action="${pageContext.request.contextPath}/log" method="get" class="filter-form">
                <!-- ComboBox Account ID -->
                <label>Account ID:
                    <input type="text" name="accountID" />
                </label>

                <!-- ComboBox Event Type -->
                <label>Event Type:
                    <select name="eventType">
                        <option value="all">All</option>
                        <c:forEach var="type" begin="1" end="4">
                            <option value="${type}" <c:if test="${param.eventType == type}">selected</c:if>>${type}</option>
                        </c:forEach>
                    </select>
                </label>

                <!-- Nút submit -->
                <input type="submit" value="Xem log"/>
            </form>

            <div style="text-align:center;">
                <c:choose>
                    <c:when test="${not empty logList}">
                        <table>
                            <thead>
                            <tr>
                                <th>Log ID</th>
                                <th>Account ID</th>
                                <th>Event Type</th>
                                <th>Timestamp</th>
                                <th>Description</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="log" items="${logList}">
                                <tr>
                                    <td>${log.id}</td>
                                    <td>${log.accountID}</td>
                                    <td>${log.event_type}</td>
                                    <td>${log.timeStamp}</td>
                                    <td>${log.description}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:when test="${param.accountID != null}">
                        <p style="color:red;">Không tìm thấy log phù hợp.</p>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </div>
</div>
</body>
</html>