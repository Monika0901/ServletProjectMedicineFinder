
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String adminName =
        (String) session.getAttribute("admin_name");

if (adminName == null) {

    response.sendRedirect("adminLogin.jsp");

    return;
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Admin Dashboard - MedicineFinder</title>

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
    gap: 24px;
}

.nav-links a {
    text-decoration: none;
    color: #444;
    font-size: 14px;
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

/* Welcome */

.welcome {
    padding: 45px 8% 25px;
}

.welcome h1 {
    font-size: 34px;
    color: #183d29;
    margin-bottom: 10px;
}

.welcome h1 span {
    color: #218c5a;
}

.welcome p {
    color: #777;
    font-size: 16px;
}

/* Dashboard */

.dashboard {
    padding: 20px 8% 60px;
}

.dashboard h2 {
    color: #183d29;
    margin-bottom: 25px;
}

/* Cards */

.cards {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 22px;
}

.card {
    background: white;
    padding: 28px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.07);
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-5px);
}

.card-icon {
    font-size: 38px;
    margin-bottom: 15px;
}

.card h3 {
    color: #218c5a;
    margin-bottom: 8px;
}

.card p {
    color: #777;
    line-height: 1.5;
}

.card a {
    display: inline-block;
    margin-top: 15px;
    color: #218c5a;
    text-decoration: none;
    font-weight: bold;
}

/* Admin Actions */

.actions {
    margin-top: 40px;
}

.actions h2 {
    color: #183d29;
    margin-bottom: 20px;
}

.action-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 22px;
}

.action-card {
    background: white;
    padding: 30px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 5px 20px rgba(0,0,0,0.07);
}

.action-card .icon {
    font-size: 45px;
    margin-bottom: 15px;
}

.action-card h3 {
    color: #183d29;
    margin-bottom: 10px;
}

.action-card p {
    color: #777;
    line-height: 1.5;
}

.action-btn {
    display: inline-block;
    margin-top: 18px;
    padding: 11px 20px;
    background: #218c5a;
    color: white;
    text-decoration: none;
    border-radius: 7px;
    font-weight: bold;
}

.action-btn:hover {
    background: #176b44;
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

/* Responsive */

@media (max-width: 1000px) {

    .nav-links {
        display: none;
    }

    .cards {
        grid-template-columns: repeat(2, 1fr);
    }

    .action-container {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 600px) {

    .cards {
        grid-template-columns: 1fr;
    }

    .welcome h1 {
        font-size: 28px;
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

        <a href="adminHome.jsp">
            Dashboard
        </a>

        <a href="adminUsers.jsp">
            Users
        </a>

        <a href="adminPharmacies.jsp">
            Pharmacies
        </a>

        <a href="adminMedicines.jsp">
            Medicines
        </a>

        <a href="adminRequests.jsp">
            Requests
        </a>

        <a href="adminReports.jsp">
            Reports
        </a>

        <a href="adminProfile.jsp">
            Profile
        </a>

        <a href="adminLogout"
           onclick="return confirm('Are you sure you want to logout?');">
            Logout
        </a>

    </div>


    <div class="adminProfile.jsp">
        <%= adminName %>
    </div>

</nav>


<!-- Welcome -->

<section class="welcome">

    <h1>
        Welcome, <span><%= adminName %></span>!
    </h1>

    <p>
        Manage and monitor the MedicineFinder system
        from your admin dashboard.
    </p>

</section>


<!-- Dashboard -->

<section class="dashboard">

    <h2>
        System Overview
    </h2>


    <div class="cards">


        <!-- Users -->

        <div class="card">

            <div class="card-icon">
                👤
            </div>

            <h3>
                Users
            </h3>

            <p>
                Manage registered MedicineFinder users.
            </p>

            <a href="adminUsers.jsp">
                Manage Users →
            </a>

        </div>


        <!-- Pharmacies -->

        <div class="card">

            <div class="card-icon">
                🏥
            </div>

            <h3>
                Pharmacies
            </h3>

            <p>
                View and manage registered pharmacies.
            </p>

            <a href="adminPharmacies.jsp">
                Manage Pharmacies →
            </a>

        </div>


        <!-- Medicines -->

        <div class="card">

            <div class="card-icon">
                💊
            </div>

            <h3>
                Medicines
            </h3>

            <p>
                Monitor medicines added by pharmacies.
            </p>

            <a href="adminMedicines.jsp">
                Manage Medicines →
            </a>

        </div>


        <!-- Requests -->

        <div class="card">

            <div class="card-icon">
                📋
            </div>

            <h3>
                Requests
            </h3>

            <p>
                Monitor customer medicine requests.
            </p>

            <a href="adminRequests.jsp">
                View Requests →
            </a>

        </div>

    </div>


    <!-- Admin Actions -->

    <div class="actions">

        <h2>
            Admin Actions
        </h2>


        <div class="action-container">


            <!-- Pharmacy Verification -->

            <div class="action-card">

                <div class="icon">
                    ✅
                </div>

                <h3>
                    Pharmacy Verification
                </h3>

                <p>
                    Review and manage pharmacy
                    registrations.
                </p>

                <a href="adminPharmacies.jsp"
                   class="action-btn">
                    View Pharmacies
                </a>

            </div>


            <!-- Reports -->

            <div class="action-card">

                <div class="icon">
                    📊
                </div>

                <h3>
                    Reports
                </h3>

                <p>
                    View MedicineFinder system
                    reports and statistics.
                </p>

                <a href="adminReports"
                   class="action-btn">
                    View Reports
                </a>

            </div>


            <!-- Profile -->

            <div class="action-card">

                <div class="icon">
                    ⚙️
                </div>

                <h3>
                    Admin Profile
                </h3>

                <p>
                    View and manage your admin
                    account information.
                </p>

                <a href="adminProfile.jsp"
                   class="action-btn">
                    View Profile
                </a>

            </div>


        </div>

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

