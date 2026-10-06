<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Pharmacy Registration - MedicineFinder</title>

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

.container {
    width: 90%;
    max-width: 650px;
    margin: 45px auto;
    background: white;
    padding: 35px 45px;
    border-radius: 15px;
    box-shadow: 0 8px 30px rgba(0,0,0,0.08);
}

.heading {
    text-align: center;
    margin-bottom: 30px;
}

.heading h1 {
    color: #218c5a;
    margin-bottom: 8px;
}

.heading p {
    color: #777;
}

.form-group {
    margin-bottom: 18px;
}

.form-group label {
    display: block;
    margin-bottom: 7px;
    font-weight: bold;
    color: #333;
}

.form-group input,
.form-group textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #d5ddd8;
    border-radius: 7px;
    font-size: 15px;
    outline: none;
}

.form-group input:focus,
.form-group textarea:focus {
    border-color: #218c5a;
}

.form-group textarea {
    height: 90px;
    resize: none;
}

.location-section {
    margin-bottom: 20px;
    padding: 18px;
    background: #f5faf7;
    border: 1px solid #dcebe2;
    border-radius: 8px;
}

.location-section label {
    display: block;
    margin-bottom: 10px;
    font-weight: bold;
    color: #333;
}

.location-btn {
    width: 100%;
    padding: 11px;
    border: none;
    border-radius: 7px;
    background: #218c5a;
    color: white;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
}

.location-btn:hover {
    background: #176b44;
}

.location-status {
    margin-top: 10px;
    font-size: 13px;
    color: #777;
}

.location-values {
    display: flex;
    gap: 10px;
    margin-top: 10px;
}

.location-values input {
    width: 50%;
    background: #ffffff;
}

.register-btn {
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

.register-btn:hover {
    background: #176b44;
}

.login-link {
    text-align: center;
    margin-top: 20px;
    color: #777;
}

.login-link a {
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

<div class="container">

    <div class="heading">

        <h1>Pharmacy Registration</h1>

        <p>Create your pharmacy owner account</p>

    </div>

    <form action="${pageContext.request.contextPath}/pharmacyRegister"
          method="post">

        <div class="form-group">

            <label>Owner Name</label>

            <input type="text"
                   name="owner_name"
                   required>

        </div>

        <div class="form-group">

            <label>Pharmacy Name</label>

            <input type="text"
                   name="pharmacy_name"
                   required>

        </div>

        <div class="form-group">

            <label>Email</label>

            <input type="email"
                   name="email"
                   required>

        </div>

        <div class="form-group">

            <label>Mobile Number</label>

            <input type="tel"
                   name="mobile"
                   maxlength="15"
                   required>

        </div>

        <div class="form-group">

            <label>Password</label>

            <input type="password"
                   name="password"
                   required>

        </div>

        <div class="form-group">

            <label>Pharmacy Address</label>

            <textarea name="address"
                      required></textarea>

        </div>

        <div class="form-group">

            <label>City</label>

            <input type="text"
                   name="city"
                   required>

        </div>

        <div class="form-group">

            <label>Pincode</label>

            <input type="text"
                   name="pincode"
                   maxlength="10"
                   required>

        </div>

        <div class="location-section">

            <label>Pharmacy Location</label>

            <button type="button"
                    class="location-btn"
                    onclick="getLocation()">

                Get Current Location

            </button>

            <div id="locationStatus"
                 class="location-status">

                Click the button to get pharmacy location.

            </div>

            <div class="location-values">

                <input type="text"
                       id="latitude"
                       name="latitude"
                       placeholder="Latitude"
                       readonly
                       required>

                <input type="text"
                       id="longitude"
                       name="longitude"
                       placeholder="Longitude"
                       readonly
                       required>

            </div>

        </div>

        <button type="submit"
                class="register-btn">

            Register Pharmacy

        </button>

    </form>

    <div class="login-link">

        Already registered?

        <a href="pharmacyLogin.jsp">
            Login here
        </a>

    </div>

</div>

<footer class="footer">

    © 2026 MedicineFinder. All Rights Reserved.

</footer>

<script>

function getLocation() {

    let status = document.getElementById("locationStatus");

    if (!navigator.geolocation) {

        status.innerHTML = "Location is not supported by this browser.";

        return;
    }

    status.innerHTML = "Getting your location...";

    navigator.geolocation.getCurrentPosition(

        function(position) {

            let latitude = position.coords.latitude;
            let longitude = position.coords.longitude;

            document.getElementById("latitude").value = latitude;
            document.getElementById("longitude").value = longitude;

            status.innerHTML = "Location captured successfully.";

        },

        function(error) {

            if (error.code === 1) {

                status.innerHTML =
                    "Location permission was denied.";

            } else if (error.code === 2) {

                status.innerHTML =
                    "Location is unavailable.";

            } else if (error.code === 3) {

                status.innerHTML =
                    "Location request timed out.";

            } else {

                status.innerHTML =
                    "Unable to get location.";

            }

        }

    );

}

</script>

</body>

</html>