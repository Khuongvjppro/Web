<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
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

        .login-container {
            width: 40%;
            margin-top: 50px;
            padding: 20px;
            background: #333;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(255, 255, 255, 0.1);
        }

        .login-container h2 {
            text-align: center;
        }

        .login-container input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            background-color: #444;
            border: 1px solid #555;
            color: #fff;
        }

        .login-container .btn {
            width: 100%;
            background-color: #000;
            color: #fff;
            padding: 10px;
            border: none;
            cursor: pointer;
            font-weight: bold;
        }

        .register-link {
            text-align: center;
            margin-top: 15px;
        }

        .register-link a {
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

<div class="login-container">
    <h2>Đăng nhập</h2>
    <c:if test="${not empty error}">
        <div style="color: red; text-align: center;">${error}</div>
    </c:if>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <label for="email">Tên tài khoản</label>
        <input type="text" id="email" name="uname" required>

        <label for="password">Mật khẩu</label>
        <input type="password" id="password" name="pass" required>

        <button type="submit" class="btn">Đăng nhập</button>
    </form>

    <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/projectl_war_exploded/login&response_type=code&client_id=911076308152-ecrt2m1eksasdgf9dqqug578lqk2j5p7.apps.googleusercontent.com&approval_prompt=force"
       style="display: flex; justify-content: center; align-items: center;
       margin-top: 15px; padding: 10px; background-color: #ffffff;
       color: #000000; text-decoration: none;
       border-radius: 4px; font-weight: bold;
       border: 1px solid #e0e0e0;
       box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png"
             alt="Google logo"
             style="width: 20px; height: 20px; margin-right: 10px;">
        Đăng nhập với Google
    </a>

    <div class="register-link">
        <p>Nếu bạn chưa có tài khoản, <a href="${pageContext.request.contextPath}/register">Đăng ký tài khoản</a></p>
    </div>
</div>

<footer>
    <p>&copy; 2024 Chuyên cung cấp thắt lưng các loại</p>
</footer>
</body>
</html>
