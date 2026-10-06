
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>User Login - MedicineFinder</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    min-height: 100vh;
    background-color: #f4fbf7;
    display: flex;
    justify-content: center;
    align-items: center;
}

.login-container {
    width: 420px;
    background-color: white;
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.10);
}

.heading {
    text-align: center;
    margin-bottom: 30px;
}

.logo {
    font-size: 32px;
    margin-bottom: 10px;
}

h1 {
    color: #173b2b;
    margin-bottom: 8px;
}

.subtitle {
    color: #777;
    font-size: 14px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    color: #333;
    font-weight: bold;
    font-size: 14px;
    margin-bottom: 7px;
}

.form-group input {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 7px;
    outline: none;
    font-size: 14px;
}

.form-group input:focus {
    border-color: #159957;
}

.login-btn {
    width: 100%;
    padding: 13px;
    border: none;
    border-radius: 7px;
    background-color: #159957;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

.login-btn:hover {
    background-color: #117a45;
}

.register-text {
    text-align: center;
    margin-top: 22px;
    color: #777;
    font-size: 14px;
}

.register-text a {
    color: #159957;
    text-decoration: none;
    font-weight: bold;
}

.home-link {
    display: block;
    text-align: center;
    margin-top: 15px;
    color: #555;
    text-decoration: none;
    font-size: 14px;
}

.home-link:hover {
    color: #159957;
}

</style>

</head>

<body>

<div class="login-container">

    <div class="heading">

        <div class="logo">💊</div>

        <h1>User Login</h1>

        <p class="subtitle">
            Login to MedicineFinder
        </p>

    </div>

    <form action="${pageContext.request.contextPath}/userLogin"
          method="post">

        <div class="form-group">

            <label>Email</label>

            <input type="email"
                   name="email"
                   placeholder="Enter your email"
                   required>

        </div>

        <div class="form-group">

            <label>Password</label>

            <input type="password"
                   name="password"
                   placeholder="Enter your password"
                   required>

        </div>

        <button type="submit" class="login-btn">
            Login
        </button>

    </form>

    <p class="register-text">

        Don't have an account?

        <a href="userRegister.jsp">
            Register
        </a>

    </p>

    <a href="index.jsp" class="home-link">
        ← Back to Home
    </a>

</div>

<%
String message = request.getParameter("message");

if (message != null) {
%>

<script>
alert("<%= message %>");
</script>

<%
}
%>

</body>

</html>

