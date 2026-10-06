
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Pharmacy Login - MedicineFinder</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f3faf6;
    color: #26352b;
}

.navbar {
    height: 70px;
    background: white;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 7%;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
}

.logo {
    font-size: 25px;
    font-weight: bold;
    color: #218c5a;
}

.logo span {
    color: #333;
}

.navbar a {
    text-decoration: none;
    color: #444;
    font-size: 15px;
}

.navbar a:hover {
    color: #218c5a;
}

.login-container {
    width: 90%;
    max-width: 450px;
    margin: 70px auto;
    background: white;
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 8px 30px rgba(0,0,0,0.08);
}

.login-heading {
    text-align: center;
    margin-bottom: 30px;
}

.login-icon {
    font-size: 55px;
    margin-bottom: 10px;
}

.login-heading h1 {
    color: #218c5a;
    margin-bottom: 8px;
}

.login-heading p {
    color: #777;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #333;
}

.form-group input {
    width: 100%;
    padding: 13px;
    border: 1px solid #d5ddd8;
    border-radius: 7px;
    font-size: 15px;
    outline: none;
}

.form-group input:focus {
    border-color: #218c5a;
}

.login-btn {
    width: 100%;
    padding: 13px;
    border: none;
    border-radius: 7px;
    background: #218c5a;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

.login-btn:hover {
    background: #176b44;
}

.register-link {
    text-align: center;
    margin-top: 22px;
    color: #777;
}

.register-link a {
    color: #218c5a;
    text-decoration: none;
    font-weight: bold;
}

.footer {
    text-align: center;
    padding: 20px;
    color: #777;
    font-size: 14px;
}

</style>

</head>

<body>

<nav class="navbar">

    <div class="logo">
        Medicine<span>Finder</span>
    </div>

    <a href="index.jsp">Home</a>

</nav>


<div class="login-container">

    <div class="login-heading">

        <div class="login-icon">🏥</div>

        <h1>Pharmacy Login</h1>

        <p>Login to manage your pharmacy</p>

    </div>


    <form action="${pageContext.request.contextPath}/pharmacyLogin" method="post">

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


    <div class="register-link">

        Don't have a pharmacy account?

        <a href="pharmacyRegister.jsp">
            Register here
        </a>

    </div>

</div>


<footer class="footer">

    © 2026 MedicineFinder. All Rights Reserved.

</footer>

</body>

</html>

