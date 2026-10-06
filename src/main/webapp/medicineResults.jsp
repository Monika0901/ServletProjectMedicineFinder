
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Medicine Results</title>

<link rel="stylesheet"
      href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

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
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
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
    transition: 0.3s;
}

.navbar a:hover {
    color: #218c5a;
}

.container {
    width: 90%;
    max-width: 1100px;
    margin: 40px auto;
}

.page-title {
    text-align: center;
    color: #245c3a;
    margin-bottom: 35px;
    font-size: 30px;
}

.result-card {
    background: white;
    padding: 28px;
    margin-bottom: 30px;
    border-radius: 16px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.08);
    border: 1px solid #e1eee5;
}

.medicine-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 20px;
    margin-bottom: 20px;
    border-bottom: 1px solid #e5eee8;
    padding-bottom: 15px;
}

.medicine-name {
    color: #218c5a;
    margin: 0;
    font-size: 25px;
}

.category {
    background: #e4f5e9;
    color: #218c5a;
    padding: 7px 14px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: bold;
}

.medicine-info {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 15px;
    margin-bottom: 25px;
}

.info-box {
    background: #f6fbf7;
    padding: 15px;
    border-radius: 10px;
    border-left: 4px solid #6fcf97;
}

.info-title {
    display: block;
    color: #777;
    font-size: 13px;
    margin-bottom: 6px;
}

.info-value {
    font-size: 16px;
    font-weight: bold;
    color: #333;
}

.price {
    color: #218c5a;
    font-size: 19px;
}

.quantity {
    color: #218c5a;
}

.pharmacy-section {
    background: #f1f8f4;
    padding: 20px;
    border-radius: 12px;
    margin-top: 10px;
}

.pharmacy-title {
    color: #245c3a;
    margin-top: 0;
    margin-bottom: 12px;
    font-size: 20px;
}

.pharmacy-details {
    color: #555;
    line-height: 1.7;
    margin-bottom: 15px;
}

.map {
    width: 100%;
    height: 350px;
    border-radius: 12px;
    margin-top: 20px;
    overflow: hidden;
    border: 1px solid #d9e9df;
}

.direction-btn {
    display: inline-block;
    margin-top: 18px;
    padding: 12px 22px;
    background: #218c5a;
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: bold;
    transition: 0.3s;
}

.direction-btn:hover {
    background: #176b44;
    transform: translateY(-1px);
}

.location-unavailable {
    background: #fff7e6;
    color: #9a6700;
    padding: 12px;
    border-radius: 8px;
    margin-top: 15px;
}

.no-result {
    text-align: center;
    padding: 50px 20px;
}

.no-result h2 {
    color: #245c3a;
}

.no-result p {
    color: #666;
}

@media (max-width: 768px) {

    .navbar {
        padding: 15px 20px;
        flex-direction: column;
        gap: 15px;
    }

    .navbar a {
        margin-left: 10px;
        margin-right: 10px;
        font-size: 14px;
    }

    .container {
        width: 94%;
        margin: 25px auto;
    }

    .page-title {
        font-size: 24px;
    }

    .result-card {
        padding: 20px;
    }

    .medicine-header {
        flex-direction: column;
        align-items: flex-start;
    }

    .medicine-info {
        grid-template-columns: 1fr;
    }

    .map {
        height: 280px;
    }

}

</style>

</head>

<body>


<div class="navbar">

    <div class="logo">
        MedicineFinder
    </div>

    <div>

        <a href="userHome.jsp">
            Home
        </a>

        <a href="searchMedicine.jsp">
            Search Medicine
        </a>

        <a href="requestStatus.jsp">
            My Requests
        </a>

        <a href="logout">
            Logout
        </a>

    </div>

</div>


<div class="container">

    <h1 class="page-title">
        Medicine Search Results
    </h1>


<%

ResultSet rs =
    (ResultSet) request.getAttribute("resultSet");

boolean found = false;

int mapNumber = 0;

if (rs != null) {

    while (rs.next()) {

        found = true;

        mapNumber++;

        String medicineName =
            rs.getString("medicine_name");

        String category =
            rs.getString("category");

        String manufacturer =
            rs.getString("manufacturer");

        double price =
            rs.getDouble("price");

        int quantity =
            rs.getInt("quantity");

        String pharmacyName =
            rs.getString("pharmacy_name");

        String address =
            rs.getString("address");

        String city =
            rs.getString("city");

        String pincode =
            rs.getString("pincode");

        double latitude =
            rs.getDouble("latitude");

        double longitude =
            rs.getDouble("longitude");

%>


<div class="result-card">


    <div class="medicine-header">

        <h2 class="medicine-name">
            <%= medicineName %>
        </h2>

        <span class="category">
            <%= category %>
        </span>

    </div>


    <div class="medicine-info">


        <div class="info-box">

            <span class="info-title">
                Manufacturer
            </span>

            <span class="info-value">
                <%= manufacturer %>
            </span>

        </div>


        <div class="info-box">

            <span class="info-title">
                Price
            </span>

            <span class="info-value price">
                ₹<%= price %>
            </span>

        </div>


        <div class="info-box">

            <span class="info-title">
                Available Quantity
            </span>

            <span class="info-value quantity">
                <%= quantity %>
            </span>

        </div>


    </div>


    <div class="pharmacy-section">


        <h3 class="pharmacy-title">
            Pharmacy: <%= pharmacyName %>
        </h3>


        <div class="pharmacy-details">

            <b>Address:</b>

            <%= address %>,
            <%= city %> -
            <%= pincode %>

        </div>


<%

if (latitude != 0.0 && longitude != 0.0) {

%>


        <div id="map<%= mapNumber %>"
             class="map">
        </div>


        <a href="https://www.google.com/maps/dir/?api=1&destination=<%= latitude %>,<%= longitude %>"
           target="_blank"
           class="direction-btn">

            Get Directions

        </a>


<script>

let latitude<%= mapNumber %> = <%= latitude %>;

let longitude<%= mapNumber %> = <%= longitude %>;

let map<%= mapNumber %> = L.map(
    'map<%= mapNumber %>'
).setView(
    [
        latitude<%= mapNumber %>,
        longitude<%= mapNumber %>
    ],
    16
);

L.tileLayer(
    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    {
        maxZoom: 19,
        attribution: '&copy; OpenStreetMap contributors'
    }
).addTo(
    map<%= mapNumber %>
);

L.marker(
    [
        latitude<%= mapNumber %>,
        longitude<%= mapNumber %>
    ]
)
.addTo(
    map<%= mapNumber %>
)
.bindPopup(
    "<b><%= pharmacyName %></b><br>" +
    "<%= address %><br>" +
    "<%= city %> - <%= pincode %>"
);

</script>


<%

} else {

%>


        <div class="location-unavailable">

            Pharmacy location is not available.

        </div>


<%

}

%>


    </div>


</div>


<%

    }

}


if (!found) {

%>


<div class="result-card no-result">

    <h2>
        No Medicine Found
    </h2>

    <p>
        This medicine is currently not available
        in any pharmacy.
    </p>

</div>


<%

}

%>


</div>

</body>

</html>

