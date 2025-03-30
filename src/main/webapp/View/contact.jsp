<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 3/30/2025
  Time: 1:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Liên Hệ</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
  <h1>Liên Hệ Chúng Tôi</h1>
  <form action="contact" method="post">
    <div class="mb-3">
      <label class="form-label">Họ Tên</label>
      <input type="text" class="form-control" name="name" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Email</label>
      <input type="email" class="form-control" name="email" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Tin Nhắn</label>
      <textarea class="form-control" name="message" rows="4" required></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Gửi</button>
  </form>
</div>
</body>
</html>
