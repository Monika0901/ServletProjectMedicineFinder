<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Find Pharmacy</title>

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
}

.navbar a:hover {
    color: #218c5a;
}

.container {
    width: 90%;
    max-width: 700px;
    margin: 70px auto;
}

.card {
    background: white;
    padding: 40px;
    border-radius: 18px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.08);
    text-align: center;
}

h1 {
    color: #245c3a;
    margin-bottom: 10px;
}

.subtitle {
    color: #666;
    margin-bottom: 30px;
}

.location-btn {
    border: none;
    background: #218c5a;
    color: white;
    padding: 14px 25px;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

.location-btn:hover {
    background: #176b44;
}

.location-values {
    display: flex;
    gap: 15px;
    margin-top: 25px;
}

.location-values input {
    width: 50%;
    padding: 13px;
    border: 1px solid #cddfd3;
    border-radius: 8px;
    background: #f7fbf8;
}

.search-btn {
    margin-top: 25px;
    width: 100%;
    border: none;
    background: #245c3a;
    color: white;
    padding: 14px;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

.search-btn:hover {
    background: #176b44;
}

.message {
    margin-top: 20px;
    color: #c0392b;
}

@media (max-width: 768px) {

    .navbar {
        padding: 15px 20px;
        flex-direction: column;
        gap: 15px;
    }

    .navbar a {
        margin-left: 8px;
        margin-right: 8px;
        font-size: 14px;
    }

    .container {
        width: 94%;
        margin: 40px auto;
    }

    .card {
        padding: 25px;
    }

    .location-values {
        flex-direction: column;
    }

    .location-values input {
        width: 100%;
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

    <div class="card">

        <h1>
            Find Nearby Pharmacies
        </h1>

        <p class="subtitle">
            Find all pharmacies near you, sorted by distance
        </p>


        <button type="button"
                class="location-btn"
                onclick="getLocation()">

            Get Current Location

        </button>


        <form action="findPharmacy"
              method="get"
              onsubmit="return checkLocation()">

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


            <button type="submit"
                    class="search-btn">

                Find Pharmacies

            </button>

        </form>


        <div id="message"
             class="message">
        </div>

    </div>

</div>


<script>

function getLocation() {

    let message =
        document.getElementById("message");

    if (!navigator.geolocation) {

        message.innerHTML =
            "Geolocation is not supported by your browser.";

        return;
    }

    message.innerHTML =
        "Getting your location...";

    navigator.geolocation.getCurrentPosition(

        function(position) {

            document.getElementById("latitude").value =
                position.coords.latitude;

            document.getElementById("longitude").value =
                position.coords.longitude;

            message.innerHTML =
                "Location detected successfully.";

        },

        function(error) {

            message.innerHTML =
                "Unable to get your location. Please allow location permission.";

        }

    );
}


function checkLocation() {

    let latitude =
        document.getElementById("latitude").value;

    let longitude =
        document.getElementById("longitude").value;

    if (latitude === "" || longitude === "") {

        document.getElementById("message").innerHTML =
            "Please click Get Current Location first.";

        return false;
    }

    return true;
}

</script>

</body>

</html>