
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

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

<title>Manage Users - MedicineFinder</title>

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

.profile {
    background: #e8f7ef;
    color: #218c5a;
    padding: 10px 18px;
    border-radius: 25px;
    font-weight: bold;
}

/* Page */

.page {
    padding: 45px 7%;
    min-height: 600px;
}

.page-title {
    margin-bottom: 25px;
}

.page-title h1 {
    color: #183d29;
    margin-bottom: 8px;
}

.page-title p {
    color: #777;
}

/* Table */

.table-container {
    background: white;
    padding: 25px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.07);
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 1100px;
}

th {
    background: #218c5a;
    color: white;
    padding: 14px;
    text-align: left;
    font-size: 14px;
}

td {
    padding: 13px;
    border-bottom: 1px solid #edf1ee;
    color: #444;
    font-size: 14px;
}

tr:hover {
    background: #f7fcf9;
}

/* Delete Button */

.delete-btn {
    background: #dc3545;
    color: white;
    border: none;
    padding: 8px 14px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}

.delete-btn:hover {
    background: #b52a37;
}

/* Back Button */

.back-btn {
    display: inline-block;
    margin-top: 25px;
    background: #218c5a;
    color: white;
    text-decoration: none;
    padding: 11px 20px;
    border-radius: 7px;
    font-weight: bold;
}

.back-btn:hover {
    background: #176b44;
}

/* Footer */

.footer {
    background: #183d29;
    color: white;
    text-align: center;
    padding: 25px;
    margin-top: 30px;
}

.footer p {
    font-size: 14px;
    color: #d8e8df;
}

/* Mobile */

@media (max-width: 900px) {

    .nav-links {
        display: none;
    }

    .page {
        padding: 30px 4%;
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

    <div class="profile">
        <%= adminName %>
    </div>

</nav>


<!-- Page -->

<section class="page">

    <div class="page-title">

        <h1>
            Manage Users
        </h1>

        <p>
            View and manage all registered MedicineFinder users.
        </p>

    </div>


    <div class="table-container">

        <table>

            <thead>

                <tr>

                    <th>ID</th>

                    <th>Full Name</th>

                    <th>Age</th>

                    <th>Email</th>

                    <th>Mobile</th>

                    <th>Address</th>

                    <th>City</th>

                    <th>Pincode</th>

                    <th>Created At</th>

                    <th>Action</th>

                </tr>

            </thead>


            <tbody>

<%

    try {

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection c =
                DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/medicinefinder",
                    "root",
                    "Password"
                );

        String sql =
                "SELECT user_id, full_name, age, " +
                "email, mobile, address, city, " +
                "pincode, created_at " +
                "FROM users " +
                "ORDER BY user_id DESC";

        PreparedStatement ps =
                c.prepareStatement(sql);

        ResultSet rs =
                ps.executeQuery();

        boolean found = false;


        while (rs.next()) {

            found = true;

%>

                <tr>

                    <td>
                        <%= rs.getInt("user_id") %>
                    </td>

                    <td>
                        <%= rs.getString("full_name") %>
                    </td>

                    <td>
                        <%= rs.getInt("age") %>
                    </td>

                    <td>
                        <%= rs.getString("email") %>
                    </td>

                    <td>
                        <%= rs.getString("mobile") %>
                    </td>

                    <td>
                        <%= rs.getString("address") %>
                    </td>

                    <td>
                        <%= rs.getString("city") %>
                    </td>

                    <td>
                        <%= rs.getString("pincode") %>
                    </td>

                    <td>
                        <%= rs.getTimestamp("created_at") %>
                    </td>

                    <td>

                        <form action="deleteAdminUser"
                              method="post"
                              onsubmit="return confirm('Are you sure you want to delete this user?');">

                            <input type="hidden"
                                   name="user_id"
                                   value="<%= rs.getInt("user_id") %>">

                            <button type="submit"
                                    class="delete-btn">

                                Delete

                            </button>

                        </form>

                    </td>

                </tr>

<%

        }


        if (!found) {

%>

                <tr>

                    <td colspan="10"
                        style="text-align:center; padding:30px;">

                        No registered users found.

                    </td>

                </tr>

<%

        }


        rs.close();
        ps.close();
        c.close();

    }

    catch (Exception e) {

%>

                <tr>

                    <td colspan="10"
                        style="text-align:center;
                               color:red;
                               padding:30px;">

                        Error loading users:
                        <%= e.getMessage() %>

                    </td>

                </tr>

<%

    }

%>

            </tbody>

        </table>

    </div>


    <a href="adminHome.jsp"
       class="back-btn">

        ← Back to Dashboard

    </a>

</section>


<!-- Footer -->

<footer class="footer">

    <p>
        © 2026 MedicineFinder. All Rights Reserved.
    </p>

</footer>

</body>

</html>

