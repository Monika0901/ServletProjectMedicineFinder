<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String fullName = (String) session.getAttribute("full_name");
String email = (String) session.getAttribute("email");

if (fullName == null) {
    response.sendRedirect("userLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>MedicineFinder - Home</title>

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

/* Navbar */

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
    gap: 30px;
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

/* Hero */

.hero {
    min-height: 430px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 60px 8%;
    background: linear-gradient(135deg, #e9f8ef, #f8fcf9);
}

.hero-content {
    max-width: 600px;
}

.hero-content h1 {
    font-size: 48px;
    line-height: 1.15;
    color: #183d29;
    margin-bottom: 20px;
}

.hero-content h1 span {
    color: #218c5a;
}

.hero-content p {
    font-size: 18px;
    line-height: 1.7;
    color: #657168;
    margin-bottom: 30px;
}

.search-btn {
    display: inline-block;
    background: #218c5a;
    color: white;
    text-decoration: none;
    padding: 14px 28px;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
}

.search-btn:hover {
    background: #176b44;
}

.hero-card {
    width: 330px;
    background: white;
    padding: 35px;
    border-radius: 20px;
    box-shadow: 0 10px 35px rgba(0,0,0,0.10);
    text-align: center;
}

.medical-icon {
    font-size: 70px;
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

/* Welcome */

.welcome {
    text-align: center;
    padding: 50px 20px 20px;
}

.welcome h2 {
    font-size: 30px;
    color: #183d29;
    margin-bottom: 10px;
}

.welcome p {
    color: #777;
}

/* Features */

.features {
    padding: 40px 8% 70px;
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

.feature-card a:hover {
    color: #176b44;
}

/* Footer */

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

/* Mobile */

@media (max-width: 800px) {

    .nav-links {
        display: none;
    }

    .hero {
        flex-direction: column;
        text-align: center;
        gap: 40px;
    }

    .hero-content h1 {
        font-size: 38px;
    }

    .features {
        grid-template-columns: 1fr;
    }

    .hero-card {
        width: 100%;
        max-width: 330px;
    }

}

</style>

</head>

<body>

<!-- Navbar -->

<nav class="navbar">

    <div class="logo">
        Medicine<span>Finder</span>
    </div>

    <div class="nav-links">

        <a href="userHome.jsp">
            Home
        </a>

        <a href="searchMedicine.jsp">
            Find Medicine
        </a>

        <a href="findPharmacy.jsp">
            Find Pharmacy
        </a>

        <a href="request.jsp">
            My Requests
        </a>

        <a href="userProfile.jsp">
            Profile
        </a>

     <a href="logout"
   onclick="return confirm('Are you sure you want to logout?');">
    Logout
</a>

    </div>

    <div class="profile">
        <%= fullName %>
    </div>

</nav>


<!-- Hero -->

<section class="hero">

    <div class="hero-content">

        <h1>
            Find the right
            <span>medicine</span>
            near you.
        </h1>

        <p>
            Search for medicines, check their availability,
            and find nearby pharmacies quickly and easily.
        </p>

        <a href="searchMedicine.jsp"
           class="search-btn">

            Search Medicine

        </a>

    </div>


    <div class="hero-card">

        <div class="medical-icon">
            💊
        </div>

        <h2>
            MedicineFinder
        </h2>

        <p>
            Your simple solution to find medicines
            and nearby pharmacies.
        </p>

    </div>

</section>


<!-- Welcome -->

<section class="welcome">

    <h2>
        Welcome, <%= fullName %>!
    </h2>

    <p>
        What would you like to do today?
    </p>

</section>


<!-- Features -->

<section class="features">


    <!-- Search Medicine -->

    <div class="feature-card">

        <div class="feature-icon">
            🔍
        </div>

        <h3>
            Search Medicine
        </h3>

        <p>
            Search for the medicine you need
            and check its availability.
        </p>

        <a href="searchMedicine.jsp">
            Search Now →
        </a>

    </div>


    <!-- Find Pharmacy -->

    <div class="feature-card">

        <div class="feature-icon">
            🏥
        </div>

        <h3>
            Find Pharmacy
        </h3>

        <p>
            Find pharmacies according to your
            current location from nearest to farthest.
        </p>

        <a href="findPharmacy.jsp">
            Find Pharmacy →
        </a>

    </div>


    <!-- My Requests -->

    <div class="feature-card">

        <div class="feature-icon">
            📋
        </div>

        <h3>
            My Requests
        </h3>

        <p>
            View the medicine requests you have
            submitted and check their status.
        </p>

        <a href="request.jsp">
            View Requests →
        </a>

    </div>


</section>


<!-- Footer -->

<footer class="footer">

    <p>
        © 2026 MedicineFinder. All Rights Reserved.
    </p>

</footer>

</body>

</html>