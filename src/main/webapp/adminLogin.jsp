
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Login - MedicineFinder</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f4faf6;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}

.login-container {
    width: 400px;
    background: white;
    padding: 40px;
    border-radius: 18px;
    box-shadow: 0 10px 35px rgba(0,0,0,0.10);
}

.logo {
    text-align: center;
    font-size: 28px;
    font-weight: bold;
    color: #218c5a;
    margin-bottom: 10px;
}

.logo span {
    color: #333;
}

.login-title {
    text-align: center;
    color: #183d29;
    margin-bottom: 8px;
}

.login-subtitle {
    text-align: center;
    color: #777;
    margin-bottom: 30px;
    font-size: 14px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #333;
    font-weight: bold;
}

.form-group input {
    width: 100%;
    padding: 13px;
    border: 1px solid #d6e3da;
    border-radius: 8px;
    font-size: 15px;
    outline: none;
}

.form-group input:focus {
    border-color: #218c5a;
}

.login-btn {
    width: 100%;
    padding: 14px;
    border: none;
    border-radius: 8px;
    background: #218c5a;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

.login-btn:hover {
    background: #176b44;
}

.back-link {
    text-align: center;
    margin-top: 20px;
}

.back-link a {
    text-decoration: none;
    color: #218c5a;
    font-weight: bold;
}

.back-link a:hover {
    color: #176b44;
}

</style>

</head>

<body>

<div class="login-container">

    <div class="logo">
        Medicine<span>Finder</span>
    </div>

    <h2 class="login-title">
        Admin Login
    </h2>

    <p class="login-subtitle">
        Login to manage MedicineFinder
    </p>


    <form action="adminLogin" method="post">

        <div class="form-group">

            <label>
                Email
            </label>

            <input type="email"
                   name="email"
                   placeholder="Enter admin email"
                   required>

        </div>


        <div class="form-group">

            <label>
                Password
            </label>

            <input type="password"
                   name="password"
                   placeholder="Enter password"
                   required>

        </div>


        <button type="submit" class="login-btn">
            Login
        </button>

    </form>


    <div class="back-link">

        <a href="index.jsp">
            ← Back to Home
        </a>

    </div>

</div>

</body>

</html>

