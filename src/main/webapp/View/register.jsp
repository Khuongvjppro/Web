<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng ký</title>
</head>
<body>
<div class="section">
  <h2>Đăng ký</h2>
  <form action="${pageContext.request.contextPath}/register" method="post">
    <label for="first-name">Email</label>
    <input type="text" id="first-name" name="email" required>

    <label for="last-name">Tên tài khoản</label>
    <input type="text" id="last-name" name="username" required>

    <label for="register-password">Mật khẩu</label>
    <input type="password" id="register-password" name="password" required>

    <label for="confirm-password">Xác nhận mật khẩu</label>
    <input type="password" id="confirm-password" name="cpassword" required>
    <button type="submit" class="btn">Đăng ký</button>
  </form>
</div>
</body>
</html>

