<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Requests</title>

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
    max-width: 900px;
    margin: 60px auto;
}

.title {
    text-align: center;
    color: #245c3a;
}

.subtitle {
    text-align: center;
    color: #666;
    margin-bottom: 40px;
}

.cards {
    display: flex;
    gap: 30px;
    justify-content: center;
}

.card {
    width: 45%;
    background: white;
    padding: 40px 30px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 5px 18px rgba(0,0,0,0.08);
}

.card h2 {
    color: #245c3a;
}

.card p {
    color: #666;
    line-height: 1.6;
}

.btn {
    display: inline-block;
    margin-top: 20px;
    padding: 13px 25px;
    background: #218c5a;
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: bold;
}

.btn:hover {
    background: #176b44;
}

@media (max-width: 768px) {

    .navbar {
        flex-direction: column;
        gap: 15px;
        padding: 15px 20px;
    }

    .navbar a {
        margin: 5px;
    }

    .cards {
        flex-direction: column;
        align-items: center;
    }

    .card {
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

        <a href="searchMedicine.jsp">Find Medicine</a>

        <a href="findPharmacy.jsp">Find Pharmacy</a>

        <a href="request.jsp">Requests</a>

        <a href="logout">Logout</a>

    </div>

</div>


<div class="container">

    <h1 class="title">
        Medicine Requests
    </h1>

    <p class="subtitle">
        Choose an option
    </p>


    <div class="cards">


        <div class="card">

            <h2>
                Do Request
            </h2>

            <p>
                Submit a request for the medicine
                you need.
            </p>

            <a href="medicineRequest.jsp"
               class="btn">

                Do Request

            </a>

        </div>


        <div class="card">

            <h2>
                Check Request Status
            </h2>

            <p>
                View all your requests and their
                current status.
            </p>

            <a href="requestStatus.jsp"
               class="btn">

                Check Request Status

            </a>

        </div>


    </div>

</div>

</body>

</html>