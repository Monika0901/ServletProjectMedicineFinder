<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // Check admin login
    if (session.getAttribute("admin_id") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String adminName =
        (String) session.getAttribute("admin_name");

    String adminEmail =
        (String) session.getAttribute("admin_email");

    Integer adminId =
        (Integer) session.getAttribute("admin_id");
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Admin Profile - MedicineFinder</title>

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
    gap: 22px;
}

.nav-links a {
    text-decoration: none;
    color: #444;
    font-size: 14px;
}

.nav-links a:hover {
    color: #218c5a;
}

.profile-btn {
    background: #e8f7ef;
    color: #218c5a !important;
    padding: 10px 18px;
    border-radius: 25px;
    font-weight: bold;
}

/* Main */

.container {
    width: 90%;
    max-width: 1000px;
    margin: 50px auto;
}

/* Heading */

.page-heading {
    margin-bottom: 30px;
}

.page-heading h1 {
    font-size: 34px;
    color: #183d29;
    margin-bottom: 8px;
}

.page-heading p {
    color: #777;
    font-size: 15px;
}

/* Profile Card */

.profile-card {
    background: white;
    border-radius: 18px;
    padding: 40px;
    box-shadow: 0 8px 30px rgba(0,0,0,0.08);
}

/* Profile Header */

.profile-header {
    display: flex;
    align-items: center;
    gap: 25px;
    padding-bottom: 30px;
    border-bottom: 1px solid #e8eee9;
}

.admin-icon {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    background: #e8f7ef;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 45px;
}

.profile-header h2 {
    color: #183d29;
    margin-bottom: 8px;
}

.profile-header p {
    color: #777;
}

/* Details */

.details {
    margin-top: 30px;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 18px 5px;
    border-bottom: 1px solid #edf1ee;
}

.detail-row:last-child {
    border-bottom: none;
}

.label {
    color: #777;
    font-size: 15px;
}

.value {
    color: #26352b;
    font-weight: bold;
}

/* Back Button */

.back-btn {
    display: inline-block;
    margin-top: 30px;
    padding: 12px 24px;
    background: #218c5a;
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: bold;
}

.back-btn:hover {
    background: #176b44;
}

/* Footer */

.footer {
    margin-top: 80px;
    background: #183d29;
    color: white;
    text-align: center;
    padding: 25px;
}

.footer p {
    color: #d8e8df;
    font-size: 14px;
}

/* Responsive */

@media (max-width: 900px) {

    .nav-links {
        display: none;
    }

    .container {
        width: 92%;
    }

    .profile-card {
        padding: 25px;
    }

}

@media (max-width: 600px) {

    .profile-header {
        flex-direction: column;
        text-align: center;
    }

    .detail-row {
        flex-direction: column;
        align-items: flex-start;
        gap: 6px;
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

        <a href="adminReports">
            Reports
        </a>

        <a href="adminProfile.jsp"
           class="profile-btn">
            Profile
        </a>

        <a href="<%= request.getContextPath() %>/adminLogout">
            Logout
        </a>

    </div>

</nav>


<!-- Main -->

<div class="container">

    <div class="page-heading">

        <h1>
            Admin Profile
        </h1>

        <p>
            View your MedicineFinder administrator information.
        </p>

    </div>


    <div class="profile-card">


        <!-- Profile Header -->

        <div class="profile-header">

            <div class="admin-icon">
                👤
            </div>

            <div>

                <h2>
                    <%= adminName %>
                </h2>

                <p>
                    MedicineFinder Administrator
                </p>

            </div>

        </div>


        <!-- Profile Details -->

        <div class="details">

            <div class="detail-row">

                <span class="label">
                    Admin ID
                </span>

                <span class="value">
                    <%= adminId %>
                </span>

            </div>


            <div class="detail-row">

                <span class="label">
                    Admin Name
                </span>

                <span class="value">
                    <%= adminName %>
                </span>

            </div>


            <div class="detail-row">

                <span class="label">
                    Email
                </span>

                <span class="value">
                    <%= adminEmail %>
                </span>

            </div>


            <div class="detail-row">

                <span class="label">
                    Role
                </span>

                <span class="value">
                    Administrator
                </span>

            </div>

        </div>


        <a href="adminHome.jsp"
           class="back-btn">
            ← Back to Dashboard
        </a>

    </div>

</div>


<!-- Footer -->

<footer class="footer">

    <p>
        © 2026 MedicineFinder. All Rights Reserved.
    </p>

</footer>

</body>

</html>