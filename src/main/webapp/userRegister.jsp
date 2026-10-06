
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>User Registration - MedicineFinder</title>

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
    padding: 30px;
}

.register-container {
    width: 600px;
    background: white;
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.10);
}

.heading {
    text-align: center;
    margin-bottom: 25px;
}

.logo {
    font-size: 30px;
    margin-bottom: 8px;
}

h1 {
    color: #173b2b;
    margin-bottom: 8px;
}

.subtitle {
    color: #777;
    font-size: 14px;
}

.form-row {
    display: flex;
    gap: 20px;
    margin-bottom: 18px;
}

.form-group {
    flex: 1;
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

.register-btn {
    width: 100%;
    padding: 13px;
    border: none;
    border-radius: 7px;
    background-color: #159957;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    margin-top: 5px;
}

.register-btn:hover {
    background-color: #117a45;
}

.login-text {
    text-align: center;
    margin-top: 20px;
    color: #777;
    font-size: 14px;
}

.login-text a {
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

@media (max-width: 650px) {

    .register-container {
        width: 100%;
        padding: 25px;
    }

    .form-row {
        flex-direction: column;
        gap: 0;
    }
}

</style>

</head>

<body>

<div class="register-container">

    <div class="heading">

        <div class="logo">💊</div>

        <h1>Create Your Account</h1>

        <p class="subtitle">
            Register with MedicineFinder
        </p>

    </div>

    <form action="${pageContext.request.contextPath}/userRegister"
          method="post">

        <div class="form-row">

            <div class="form-group">

                <label>Full Name</label>

                <input type="text"
                       name="full_name"
                       placeholder="Enter your full name"
                       required>

            </div>

            <div class="form-group">

                <label>Age</label>

                <input type="number"
                       name="age"
                       min="1"
                       max="120"
                       placeholder="Enter your age"
                       required>

            </div>

        </div>

        <div class="form-row">

            <div class="form-group">

                <label>Email</label>

                <input type="email"
                       name="email"
                       placeholder="Enter your email"
                       required>

            </div>

            <div class="form-group">

                <label>Mobile Number</label>

                <input type="tel"
                       name="mobile"
                       maxlength="10"
                       placeholder="Enter mobile number"
                       required>

            </div>

        </div>

        <div class="form-row">

            <div class="form-group">

                <label>Password</label>

                <input type="password"
                       name="password"
                       placeholder="Create password"
                       required>

            </div>

        </div>

        <div class="form-row">

            <div class="form-group">

                <label>Address</label>

                <input type="text"
                       name="address"
                       placeholder="Enter your address"
                       required>

            </div>

        </div>

        <div class="form-row">

            <div class="form-group">

                <label>City</label>

                <input type="text"
                       name="city"
                       placeholder="Enter your city"
                       required>

            </div>

            <div class="form-group">

                <label>Pincode</label>

                <input type="text"
                       name="pincode"
                       maxlength="6"
                       placeholder="Enter pincode"
                       required>

            </div>

        </div>

        <button type="submit" class="register-btn">
            Create Account
        </button>

    </form>

    <p class="login-text">

        Already have an account?

        <a href="userLogin.jsp">
            Login
        </a>

    </p>

    <a href="index.jsp" class="home-link">
        ← Back to Home
    </a>


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
</div>

</body>

</html>

