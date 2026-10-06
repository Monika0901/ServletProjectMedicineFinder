<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Search Medicine</title>

<style>

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f1f8f4;
}

.navbar {
    background: #d8f3dc;
    padding: 18px 50px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    font-size: 24px;
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
    width: 500px;
    margin: 80px auto;
    background: white;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

h1 {
    text-align: center;
    color: #245c3a;
}

p {
    text-align: center;
    color: #666;
}

.search-box {
    display: flex;
    gap: 10px;
    margin-top: 30px;
}

.search-box input {
    flex: 1;
    padding: 14px;
    border: 1px solid #b7d8c2;
    border-radius: 6px;
    font-size: 16px;
}

.search-box button {
    padding: 14px 25px;
    border: none;
    background: #52b788;
    color: white;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
}

.search-box button:hover {
    background: #40916c;
}

.location-section {
    margin-top: 25px;
    padding: 18px;
    background: #f1f8f4;
    border-radius: 8px;
}

.location-btn {
    width: 100%;
    padding: 12px;
    border: none;
    background: #245c3a;
    color: white;
    border-radius: 6px;
    cursor: pointer;
    font-size: 15px;
}

.location-btn:hover {
    background: #183d29;
}

.location-status {
    text-align: center;
    margin-top: 12px;
    font-size: 14px;
    color: #666;
}

.location-values {
    display: flex;
    gap: 10px;
    margin-top: 12px;
}

.location-values input {
    width: 50%;
    padding: 10px;
    border: 1px solid #b7d8c2;
    border-radius: 5px;
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
        <a href="requestStatus.jsp">My Requests</a>
        <a href="logout">Logout</a>
    </div>

</div>

<div class="container">

    <h1>Search Medicine</h1>

    <p>
        Enter the medicine name to find nearby pharmacies.
    </p>

    <form action="searchMedicine" method="get" onsubmit="return checkLocation()">

        <div class="search-box">

            <input type="text"
                   name="medicine_name"
                   placeholder="Enter medicine name"
                   required>

            <button type="submit">
                Search
            </button>

        </div>

        <div class="location-section">

            <button type="button"
                    class="location-btn"
                    onclick="getLocation()">
                Get My Current Location
            </button>

            <div id="locationStatus" class="location-status">
                Please get your location before searching.
            </div>

            <div class="location-values">

                <input type="text"
                       id="latitude"
                       name="user_latitude"
                       placeholder="Latitude"
                       readonly
                       required>

                <input type="text"
                       id="longitude"
                       name="user_longitude"
                       placeholder="Longitude"
                       readonly
                       required>

            </div>

        </div>

    </form>

</div>

<script>

function getLocation() {

    let status = document.getElementById("locationStatus");

    if (!navigator.geolocation) {

        status.innerHTML =
            "Location is not supported by this browser.";

        return;
    }

    status.innerHTML =
        "Getting your current location...";

    navigator.geolocation.getCurrentPosition(

        function(position) {

            let latitude =
                position.coords.latitude;

            let longitude =
                position.coords.longitude;

            document.getElementById("latitude").value =
                latitude;

            document.getElementById("longitude").value =
                longitude;

            status.innerHTML =
                "Your location captured successfully.";

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
                    "Unable to get your location.";
            }
        }
    );
}

function checkLocation() {

    let latitude =
        document.getElementById("latitude").value;

    let longitude =
        document.getElementById("longitude").value;

    if (latitude === "" || longitude === "") {

        alert("Please get your current location first.");

        return false;
    }

    return true;
}

</script>

</body>

</html>