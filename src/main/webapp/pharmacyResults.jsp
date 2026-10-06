<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tka.findPharmacy.Pharmacy"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Nearby Pharmacies</title>

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

.navbar a:hover {
    color: #218c5a;
}

.container {
    width: 90%;
    max-width: 1000px;
    margin: 40px auto;
}

.title {
    text-align: center;
    color: #245c3a;
}

.subtitle {
    text-align: center;
    color: #666;
    margin-bottom: 30px;
}

.pharmacy-card {
    background: white;
    padding: 25px;
    margin-bottom: 25px;
    border-radius: 15px;
    box-shadow: 0 5px 18px rgba(0,0,0,0.08);
}

.pharmacy-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #ddd;
    padding-bottom: 15px;
    margin-bottom: 15px;
}

.pharmacy-name {
    color: #218c5a;
    margin: 0;
}

.rank {
    display: inline-flex;
    width: 35px;
    height: 35px;
    align-items: center;
    justify-content: center;
    background: #245c3a;
    color: white;
    border-radius: 50%;
    margin-right: 8px;
}

.distance {
    background: #e4f5e9;
    color: #218c5a;
    padding: 8px 15px;
    border-radius: 20px;
    font-weight: bold;
}

.info {
    background: #f6fbf7;
    padding: 18px;
    border-radius: 10px;
    line-height: 1.8;
}

.info b {
    color: #245c3a;
}

.direction-btn {
    display: inline-block;
    margin-top: 18px;
    padding: 12px 20px;
    background: #218c5a;
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: bold;
}

.direction-btn:hover {
    background: #176b44;
}

.no-result {
    background: white;
    padding: 50px;
    text-align: center;
    border-radius: 15px;
}

@media (max-width: 768px) {

    .navbar {
        flex-direction: column;
        gap: 15px;
        padding: 15px 20px;
    }

    .navbar a {
        margin: 5px;
        font-size: 14px;
    }

    .pharmacy-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 15px;
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

        <a href="userHome.jsp">Home</a>

        <a href="searchMedicine.jsp">Search Medicine</a>

        <a href="findPharmacy.jsp">Find Pharmacy</a>

        <a href="requestStatus.jsp">My Requests</a>

        <a href="logout">Logout</a>

    </div>

</div>


<div class="container">

    <h1 class="title">
        Nearby Pharmacies
    </h1>

    <p class="subtitle">
        Pharmacies are displayed from nearest to farthest
    </p>


<%

List<Pharmacy> pharmacyList =
        (List<Pharmacy>)
        request.getAttribute("pharmacyList");


if (pharmacyList != null &&
    !pharmacyList.isEmpty()) {

    int count = 0;

    for (Pharmacy pharmacy : pharmacyList) {

        count++;

%>


<div class="pharmacy-card">

    <div class="pharmacy-header">

        <h2 class="pharmacy-name">

            <span class="rank">
                <%= count %>
            </span>

            <%= pharmacy.getPharmacyName() %>

        </h2>


        <% if (pharmacy.isLocationAvailable()) { %>

        <div class="distance">

            <%= String.format(
                    "%.2f",
                    pharmacy.getDistance()
                ) %>
            km

        </div>

        <% } else { %>

        <div class="distance">

            Distance unavailable

        </div>

        <% } %>

    </div>


    <div class="info">

        <b>Owner:</b>
        <%= pharmacy.getOwnerName() %>

        <br>

        <b>Address:</b>
        <%= pharmacy.getAddress() %>

        <br>

        <b>City:</b>
        <%= pharmacy.getCity() %>

        <br>

        <b>Pincode:</b>
        <%= pharmacy.getPincode() %>

        <br>

        <b>Mobile:</b>
        <%= pharmacy.getMobile() %>

    </div>


    <% if (pharmacy.isLocationAvailable()) { %>

    <a class="direction-btn"
       href="https://www.google.com/maps/dir/?api=1&destination=<%= pharmacy.getLatitude() %>,<%= pharmacy.getLongitude() %>"
       target="_blank">

        Get Directions

    </a>

    <% } %>


</div>


<%

    }

} else {

%>


<div class="no-result">

    <h2>
        No Pharmacy Found
    </h2>

    <p>
        No pharmacies are registered.
    </p>

</div>


<%

}

%>


</div>

</body>

</html>