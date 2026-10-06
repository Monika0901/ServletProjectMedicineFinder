<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Do Request</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f3faf5;
    color: #333;
}

.navbar {
    background: #d8f3dc;
    padding: 18px 50px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    font-size: 25px;
    font-weight: bold;
    color: #245c3a;
}

.navbar a {
    text-decoration: none;
    color: #245c3a;
    margin-left: 25px;
    font-weight: bold;
}

.container {
    width: 90%;
    max-width: 600px;
    margin: 45px auto;
}

.form-card {
    background: white;
    padding: 35px;
    border-radius: 15px;
    box-shadow: 0 5px 18px rgba(0,0,0,0.08);
}

h1 {
    text-align: center;
    color: #245c3a;
    margin-bottom: 30px;
}

label {
    display: block;
    margin-top: 18px;
    margin-bottom: 7px;
    font-weight: bold;
    color: #245c3a;
}

input,
textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #cddfd3;
    border-radius: 7px;
    font-size: 15px;
}

textarea {
    height: 90px;
    resize: none;
}

button {
    width: 100%;
    margin-top: 25px;
    padding: 14px;
    border: none;
    background: #218c5a;
    color: white;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

button:hover {
    background: #176b44;
}

.back {
    display: block;
    text-align: center;
    margin-top: 20px;
    color: #245c3a;
    text-decoration: none;
}

</style>

</head>

<body>

<div class="navbar">

    <div class="logo">
        MedicineFinder
    </div>

    <div>

        <a href="userHome.jsp">Home</a>

        <a href="request.jsp">Requests</a>

        <a href="logout">Logout</a>

    </div>

</div>


<div class="container">

<div class="form-card">

<h1>
    Do Medicine Request
</h1>


<form action="medicineRequest"
      method="post">


<label>
    User Name
</label>

<input type="text"
       name="user_name"
       placeholder="Enter your name"
       required>


<label>
    Age
</label>

<input type="number"
       name="age"
       min="1"
       max="120"
       placeholder="Enter your age"
       required>


<label>
    Medicine Name
</label>

<input type="text"
       name="medicine_name"
       placeholder="Enter medicine name"
       required>


<label>
    Quantity
</label>

<input type="number"
       name="quantity"
       min="1"
       placeholder="Enter quantity"
       required>


<label>
    Address
</label>

<textarea name="address"
          placeholder="Enter your address"
          required></textarea>


<label>
    Phone Number
</label>

<input type="tel"
       name="phone"
       pattern="[0-9]{10}"
       maxlength="10"
       placeholder="Enter 10 digit phone number"
       required>


<button type="submit">
    Submit Request
</button>

</form>


<a href="request.jsp"
   class="back">

    Back to Requests

</a>

</div>

</div>

</body>

</html>