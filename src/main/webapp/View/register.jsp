<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng ký</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
  <link rel="stylesheet" href="../css/header.css">
  <link rel="stylesheet" href="../css/footer.css">
  <style>
    body {
      background-color: #212121;
      color: #ffffff;
      margin: 0;
      padding: 0;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .register-container {
      width: 40%;
      margin-top: 50px;
      padding: 20px;
      background: #333;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(255, 255, 255, 0.1);
    }

    .register-container h2 {
      text-align: center;
    }

    .register-container input {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      background-color: #444;
      border: 1px solid #555;
      color: #fff;
    }

    .register-container .btn {
      width: 100%;
      background-color: #000;
      color: #fff;
      padding: 10px;
      border: none;
      cursor: pointer;
      font-weight: bold;
    }

    .login-link {
      text-align: center;
      margin-top: 15px;
    }

    .login-link a {
      color: #1e90ff;
      text-decoration: none;
    }
  </style>
</head>
<body>
<header>
  <div class="header">
    <a href="${pageContext.request.contextPath}/home"><h1>Trang chủ</h1></a>
  </div>
</header>

<div class="register-container">
  <h2>Đăng ký tài khoản</h2>

  <c:if test="${not empty error}">
    <div style="color: red; text-align: center;">${error}</div>
  </c:if>

  <form action="${pageContext.request.contextPath}/register" method="post">
    <label for="fullname">Họ và tên</label>
    <input type="text" id="username" name="username" required>

    <label for="email">Email</label>
    <input type="email" id="email" name="email" required>

    <label for="password">Mật khẩu</label>
    <input type="password" id="password" name="password" required>

    <label for="confirmPassword">Xác nhận mật khẩu</label>
    <input type="password" id="cpassword" name="cpassword" required>

    <button type="submit" class="btn">Đăng ký</button>
  </form>

  <div class="login-link">
    <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập ngay</a></p>
  </div>
</div>

<footer>
  <p>&copy; 2024 Chuyên cung cấp thắt lưng các loại</p>
</footer>
</body>
</html>