
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>MedicineFinder</title>

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

.nav-links > a {
    text-decoration: none;
    color: #444;
    font-size: 15px;
}

.nav-links > a:hover {
    color: #218c5a;
}

/* Login Dropdown */

.dropdown {
    position: relative;
}

.dropbtn {
    background: none;
    border: none;
    color: #444;
    font-size: 15px;
    cursor: pointer;
    padding: 0;
}

.dropbtn:hover {
    color: #218c5a;
}

.dropdown-content {
    display: none;
    position: absolute;
    top: 32px;
    right: 0;
    width: 190px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.12);
    overflow: hidden;
    z-index: 1000;
}

.dropdown-content a {
    display: block;
    padding: 14px 18px;
    color: #444;
    text-decoration: none;
    font-size: 14px;
}

.dropdown-content a:hover {
    background: #e8f7ef;
    color: #218c5a;
}

.dropdown-content.show {
    display: block;
}

/* Hero */

.hero {
    min-height: 500px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 70px 8%;
    background: linear-gradient(135deg, #e9f8ef, #f8fcf9);
}

.hero-content {
    max-width: 620px;
}

.hero-content h1 {
    font-size: 52px;
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

.hero-buttons {
    display: flex;
    gap: 15px;
}

.primary-btn {
    display: inline-block;
    background: #218c5a;
    color: white;
    text-decoration: none;
    padding: 14px 28px;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
}

.primary-btn:hover {
    background: #176b44;
}

.secondary-btn {
    display: inline-block;
    background: white;
    color: #218c5a;
    text-decoration: none;
    padding: 14px 28px;
    border: 1px solid #218c5a;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
}

.secondary-btn:hover {
    background: #e8f7ef;
}

/* Hero Card */

.hero-card {
    width: 340px;
    background: white;
    padding: 40px;
    border-radius: 20px;
    text-align: center;
    box-shadow: 0 10px 35px rgba(0,0,0,0.10);
}

.medical-icon {
    font-size: 75px;
    margin-bottom: 18px;
}

.hero-card h2 {
    color: #218c5a;
    margin-bottom: 12px;
}

.hero-card p {
    color: #777;
    line-height: 1.6;
}

/* Features */

.features-section {
    padding: 65px 8%;
}

.section-title {
    text-align: center;
    margin-bottom: 40px;
}

.section-title h2 {
    font-size: 32px;
    color: #183d29;
    margin-bottom: 10px;
}

.section-title p {
    color: #777;
}

.features {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 25px;
}

.feature-card {
    background: white;
    padding: 35px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 5px 20px rgba(0,0,0,0.07);
    transition: 0.3s;
}

.feature-card:hover {
    transform: translateY(-5px);
}

.feature-icon {
    font-size: 45px;
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

/* About */

.about-section {
    padding: 20px 8% 70px;
}

.about-box {
    background: white;
    padding: 45px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 5px 20px rgba(0,0,0,0.07);
}

.about-box h2 {
    color: #183d29;
    margin-bottom: 15px;
}

.about-box p {
    max-width: 800px;
    margin: auto;
    color: #777;
    line-height: 1.8;
}

/* CTA */

.cta {
    margin: 0 8% 70px;
    padding: 45px;
    background: #218c5a;
    color: white;
    border-radius: 18px;
    text-align: center;
}

.cta h2 {
    font-size: 30px;
    margin-bottom: 12px;
}

.cta p {
    margin-bottom: 25px;
    color: #e5f5ec;
}

.cta a {
    display: inline-block;
    background: white;
    color: #218c5a;
    text-decoration: none;
    padding: 13px 27px;
    border-radius: 7px;
    font-weight: bold;
}

.cta a:hover {
    background: #f0f8f3;
}

/* Footer */

.footer {
    background: #183d29;
    color: white;
    text-align: center;
    padding: 28px;
}

.footer p {
    font-size: 14px;
    color: #d8e8df;
}

/* Responsive */

@media (max-width: 850px) {

    .nav-links {
        gap: 15px;
    }

    .hero {
        flex-direction: column;
        text-align: center;
        gap: 45px;
    }

    .hero-content h1 {
        font-size: 40px;
    }

    .hero-buttons {
        justify-content: center;
    }

    .features {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 600px) {

    .navbar {
        padding: 0 5%;
    }

    .logo {
        font-size: 21px;
    }

    .nav-links {
        gap: 10px;
    }

    .nav-links > a,
    .dropbtn {
        font-size: 13px;
    }

    .hero {
        padding: 50px 5%;
    }

    .hero-card {
        width: 100%;
    }

    .hero-buttons {
        flex-direction: column;
    }

    .features-section,
    .about-section {
        padding-left: 5%;
        padding-right: 5%;
    }

    .cta {
        margin-left: 5%;
        margin-right: 5%;
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

        <a href="index.jsp">
            Home
        </a>


        <a href="userLogin.jsp">
            Find Medicine
        </a>


        <a href="pharmacyRegister.jsp">
            Pharmacy
        </a>


        <div class="dropdown">

            <button class="dropbtn" onclick="toggleDropdown()">
                Login ▾
            </button>


            <div class="dropdown-content" id="loginDropdown">

                <a href="userLogin.jsp">
                    User Login
                </a>


                <a href="pharmacyLogin.jsp">
                    Pharmacy Login
                </a>

            </div>

        </div>


        <a href="adminLogin.jsp">
            Admin
        </a>

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
            MedicineFinder helps you search for medicines,
            check availability and find pharmacies where
            your required medicine is available.
        </p>


        <div class="hero-buttons">

            <a href="userLogin.jsp" class="primary-btn">
                Find Medicine
            </a>


            <a href="userRegister.jsp" class="secondary-btn">
                Create Account
            </a>

        </div>

    </div>


    <div class="hero-card">

        <div class="medical-icon">
            💊
        </div>


        <h2>
            MedicineFinder
        </h2>


        <p>
            Search medicines and discover nearby
            pharmacies with availability.
        </p>

    </div>

</section>


<!-- Features -->

<section class="features-section">

    <div class="section-title">

        <h2>
            Everything You Need
        </h2>


        <p>
            Simple and convenient medicine searching.
        </p>

    </div>


    <div class="features">


        <div class="feature-card">

            <div class="feature-icon">
                🔍
            </div>


            <h3>
                Search Medicine
            </h3>


            <p>
                Search for the medicine you need
                quickly and easily.
            </p>

        </div>


        <div class="feature-card">

            <div class="feature-icon">
                🏥
            </div>


            <h3>
                Find Pharmacies
            </h3>


            <p>
                Find pharmacies where your required
                medicine is available.
            </p>

        </div>


        <div class="feature-card">

            <div class="feature-icon">
                📦
            </div>


            <h3>
                Check Availability
            </h3>


            <p>
                Check medicine stock and availability
                before visiting a pharmacy.
            </p>

        </div>

    </div>

</section>


<!-- About -->

<section class="about-section">

    <div class="about-box">

        <h2>
            About MedicineFinder
        </h2>


        <p>
            MedicineFinder is a platform that connects
            customers with pharmacies. Users can search
            for medicines and check their availability,
            while pharmacy owners can manage their
            medicines and stock.
        </p>

    </div>

</section>


<!-- CTA -->

<section class="cta">

    <h2>
        Looking for a Medicine?
    </h2>


    <p>
        Create your account and start searching
        for medicines near you.
    </p>


    <a href="userRegister.jsp">
        Get Started
    </a>

</section>


<!-- Footer -->

<footer class="footer">

    <p>
        © 2026 MedicineFinder. All Rights Reserved.
    </p>

</footer>


<script>

function toggleDropdown() {

    var dropdown = document.getElementById("loginDropdown");

    dropdown.classList.toggle("show");

}


window.onclick = function(event) {

    if (!event.target.matches('.dropbtn')) {

        var dropdown =
            document.getElementById("loginDropdown");

        if (dropdown.classList.contains("show")) {

            dropdown.classList.remove("show");

        }

    }

}

</script>


</body>

</html>

