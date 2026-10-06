<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%

String ownerName = (String) session.getAttribute("owner_name");
String pharmacyName = (String) session.getAttribute("pharmacy_name");
String email = (String) session.getAttribute("email");
Integer pharmacyId = (Integer) session.getAttribute("pharmacy_id");

if (pharmacyName == null || pharmacyId == null) {

    response.sendRedirect("pharmacyLogin.jsp");

    return;
}

String address = "";
String city = "";
String pincode = "";
double latitude = 0;
double longitude = 0;

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection c = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/medicinefinder",
        "root",
        "Password"
    );

    PreparedStatement ps = c.prepareStatement(
        "SELECT address, city, pincode, latitude, longitude " +
        "FROM pharmacy WHERE pharmacy_id = ?"
    );

    ps.setInt(1, pharmacyId);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {

        address = rs.getString("address");
        city = rs.getString("city");
        pincode = rs.getString("pincode");
        latitude = rs.getDouble("latitude");
        longitude = rs.getDouble("longitude");

    }

    rs.close();
    ps.close();
    c.close();

} catch (Exception e) {

    e.printStackTrace();

}

%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Pharmacy Home - MedicineFinder</title>

<link rel="stylesheet"
      href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f4faf6;
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

.nav-links {
    display: flex;
    align-items: center;
    gap: 25px;
}

.nav-links a {
    text-decoration: none;
    color: #444;
    font-size: 15px;
}

.nav-links a:hover {
    color: #218c5a;
}

.profile {
    background: #e8f7ef;
    color: #218c5a;
    padding: 10px 18px;
    border-radius: 25px;
    font-weight: bold;
}

.hero {
    min-height: 390px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 55px 8%;
    background: linear-gradient(135deg, #e9f8ef, #f8fcf9);
}

.hero-content {
    max-width: 620px;
}

.hero-content h1 {
    font-size: 45px;
    line-height: 1.2;
    color: #183d29;
    margin-bottom: 18px;
}

.hero-content h1 span {
    color: #218c5a;
}

.hero-content p {
    font-size: 18px;
    line-height: 1.7;
    color: #657168;
    margin-bottom: 25px;
}

.manage-btn {
    display: inline-block;
    background: #218c5a;
    color: white;
    text-decoration: none;
    padding: 14px 27px;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
}

.manage-btn:hover {
    background: #176b44;
}

.hero-card {
    width: 320px;
    background: white;
    padding: 35px;
    border-radius: 20px;
    text-align: center;
    box-shadow: 0 10px 35px rgba(0,0,0,0.10);
}

.pharmacy-icon {
    font-size: 65px;
    margin-bottom: 15px;
}

.hero-card h2 {
    color: #218c5a;
    margin-bottom: 10px;
}

.hero-card p {
    color: #777;
    line-height: 1.6;
}

.welcome {
    text-align: center;
    padding: 45px 20px 20px;
}

.welcome h2 {
    font-size: 30px;
    color: #183d29;
    margin-bottom: 10px;
}

.welcome p {
    color: #777;
}

.features {
    padding: 35px 8% 65px;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 25px;
}

.feature-card {
    background: white;
    padding: 32px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 5px 20px rgba(0,0,0,0.07);
    transition: 0.3s;
}

.feature-card:hover {
    transform: translateY(-5px);
}

.feature-icon {
    font-size: 42px;
    margin-bottom: 18px;
}

.feature-card h3 {
    color: #218c5a;
    margin-bottom: 12px;
}

.feature-card p {
    color: #777;
    line-height: 1.6;
}

.feature-card a {
    display: inline-block;
    margin-top: 18px;
    color: #218c5a;
    text-decoration: none;
    font-weight: bold;
}

.info-section {
    padding: 10px 8% 60px;
}

.info-box {
    background: white;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.07);
}

.info-box h2 {
    color: #183d29;
    margin-bottom: 20px;
}

.info-row {
    display: flex;
    justify-content: space-between;
    padding: 12px 0;
    border-bottom: 1px solid #edf1ee;
}

.info-row:last-child {
    border-bottom: none;
}

.info-label {
    color: #777;
}

.info-value {
    color: #333;
    font-weight: bold;
    text-align: right;
}

.location-section {
    padding: 10px 8% 65px;
}

.location-box {
    background: white;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.07);
}

.location-box h2 {
    color: #183d29;
    margin-bottom: 10px;
}

.location-address {
    color: #666;
    line-height: 1.7;
    margin-bottom: 20px;
}

#map {
    width: 100%;
    height: 400px;
    border-radius: 12px;
    border: 1px solid #e1ebe5;
}

.direction-btn {
    display: inline-block;
    margin-top: 18px;
    background: #218c5a;
    color: white;
    text-decoration: none;
    padding: 12px 22px;
    border-radius: 7px;
    font-size: 14px;
    font-weight: bold;
}

.direction-btn:hover {
    background: #176b44;
}

.footer {
    background: #183d29;
    color: white;
    text-align: center;
    padding: 25px;
}

.footer p {
    font-size: 14px;
    color: #d8e8df;
}

@media (max-width: 850px) {

    .nav-links {
        display: none;
    }

    .hero {
        flex-direction: column;
        text-align: center;
        gap: 35px;
    }

    .hero-content h1 {
        font-size: 38px;
    }

    .features {
        grid-template-columns: 1fr;
    }

    .info-row {
        flex-direction: column;
        gap: 5px;
    }

    .info-value {
        text-align: left;
    }

}

</style>

</head>

<body>

<nav class="navbar">

    <div class="logo">
        Medicine<span>Finder</span>
    </div>

    <div class="nav-links">

        <a href="pharmacyHome.jsp">
            Home
        </a>

        <a href="addMedicine.jsp">
            Add Medicine
        </a>

        <a href="updateMedicine.jsp">
            Manage Stock
        </a>

        <a href="pharmacyProfile.jsp">
            Profile
        </a>

        <a href="logout">
            Logout
        </a>

    </div>

    <div class="profile">
        <%= pharmacyName %>
    </div>

</nav>

<section class="hero">

    <div class="hero-content">

        <h1>
            Manage your
            <span>pharmacy</span>
            easily.
        </h1>

        <p>
            Add medicines, update stock and availability,
            and help customers find the medicines they need.
        </p>

        <a href="addMedicine.jsp" class="manage-btn">
            Add Medicine
        </a>

    </div>

    <div class="hero-card">

        <div class="pharmacy-icon">
            🏥
        </div>

        <h2>
            <%= pharmacyName %>
        </h2>

        <p>
            Welcome to your MedicineFinder pharmacy dashboard.
        </p>

    </div>

</section>

<section class="welcome">

    <h2>
        Welcome, <%= ownerName %>!
    </h2>

    <p>
        Manage your pharmacy medicines and availability from here.
    </p>

</section>

<section class="features">

    <div class="feature-card">

        <div class="feature-icon">
            💊
        </div>

        <h3>
            Add Medicine
        </h3>

        <p>
            Add new medicines with their price,
            quantity and availability.
        </p>

        <a href="addMedicine.jsp">
            Add Now →
        </a>

    </div>

    <div class="feature-card">

        <div class="feature-icon">
            📦
        </div>

        <h3>
            Manage Stock
        </h3>

        <p>
            Update medicine quantity, price
            and availability whenever required.
        </p>

        <a href="updateMedicine.jsp">
            Manage Stock →
        </a>

    </div>

    <div class="feature-card">

        <div class="feature-icon">
            🔎
        </div>

        <h3>
            Medicine Requests
        </h3>

        <p>
            Check customer medicine requests
            and respond according to availability.
        </p>

        <a href="pharmacyRequests.jsp">User Requests →</a>
           
        </a>

    </div>

</section>

<section class="info-section">

    <div class="info-box">

        <h2>
            Pharmacy Information
        </h2>

        <div class="info-row">

            <span class="info-label">
                Pharmacy Name
            </span>

            <span class="info-value">
                <%= pharmacyName %>
            </span>

        </div>

        <div class="info-row">

            <span class="info-label">
                Owner Name
            </span>

            <span class="info-value">
                <%= ownerName %>
            </span>

        </div>

        <div class="info-row">

            <span class="info-label">
                Email
            </span>

            <span class="info-value">
                <%= email %>
            </span>

        </div>

        <div class="info-row">

            <span class="info-label">
                Address
            </span>

            <span class="info-value">
                <%= address %>, <%= city %> - <%= pincode %>
            </span>

        </div>

    </div>

</section>

<section class="location-section">

    <div class="location-box">

        <h2>
            📍 Pharmacy Location
        </h2>

        <p class="location-address">
            <%= address %>, <%= city %> - <%= pincode %>
        </p>

        <div id="map"></div>

        <a href="https://www.google.com/maps/dir/?api=1&destination=<%= latitude %>,<%= longitude %>"
           target="_blank"
           class="direction-btn">

            Open in Google Maps

        </a>

    </div>

</section>

<footer class="footer">

    <p>
        © 2026 MedicineFinder. All Rights Reserved.
    </p>

</footer>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<script>

let latitude = <%= latitude %>;
let longitude = <%= longitude %>;

let map = L.map('map').setView(
    [latitude, longitude],
    16
);

L.tileLayer(
    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    {
        maxZoom: 19,
        attribution: '&copy; OpenStreetMap contributors'
    }
).addTo(map);

L.marker([latitude, longitude])
    .addTo(map)
    .bindPopup(
        "<b><%= pharmacyName %></b><br><%= address %>, <%= city %>"
    )
    .openPopup();

</script>

</body>

</html>