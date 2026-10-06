
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<%
String adminName = (String) session.getAttribute("admin_name");

if (adminName == null) {
    response.sendRedirect("adminLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Admin - Medicine Requests</title>

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
    padding: 0 5%;
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
    gap: 20px;
    align-items: center;
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

/* Heading */

.heading {
    text-align: center;
    padding: 40px 20px 25px;
}

.heading h1 {
    color: #183d29;
    margin-bottom: 10px;
}

.heading p {
    color: #777;
}

/* Table */

.table-container {
    width: 95%;
    margin: auto;
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
    padding: 13px;
    text-align: left;
}

td {
    padding: 13px;
    border-bottom: 1px solid #e5eee8;
    color: #444;
}

tr:hover {
    background: #f7fbf8;
}

/* Status */

.status {
    padding: 6px 12px;
    border-radius: 15px;
    font-size: 13px;
    font-weight: bold;
}

.pending {
    background: #fff3cd;
    color: #856404;
}

.accepted {
    background: #d4edda;
    color: #155724;
}

.rejected {
    background: #f8d7da;
    color: #721c24;
}

/* Delete Button */

.delete-btn {
    background: #dc3545;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}

.delete-btn:hover {
    background: #b02a37;
}

/* Empty */

.empty {
    text-align: center;
    padding: 40px;
    color: #777;
}

/* Footer */

.footer {
    margin-top: 50px;
    background: #183d29;
    color: white;
    text-align: center;
    padding: 20px;
}

.footer p {
    color: #d8e8df;
}

@media (max-width: 900px) {

    .nav-links {
        display: none;
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
            Home
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

        <a href="adminLogout">
            Logout
        </a>

    </div>

    <div class="profile">
        <%= adminName %>
    </div>

</nav>


<!-- Heading -->

<section class="heading">

    <h1>
        Medicine Requests
    </h1>

    <p>
        View and manage all medicine requests submitted by users.
    </p>

</section>


<!-- Requests Table -->

<div class="table-container">

<%
Connection c = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    c = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/medicinefinder",
        "root",
        "Password"
    );

    String sql =
        "SELECT request_id, user_id, user_name, age, " +
        "medicine_name, quantity, address, phone, " +
        "request_status, requested_at " +
        "FROM medicine_request " +
        "ORDER BY requested_at DESC";

    ps = c.prepareStatement(sql);

    rs = ps.executeQuery();

    boolean hasData = false;
%>

<table>

    <tr>

        <th>Request ID</th>
        <th>User ID</th>
        <th>User Name</th>
        <th>Age</th>
        <th>Medicine</th>
        <th>Quantity</th>
        <th>Address</th>
        <th>Phone</th>
        <th>Status</th>
        <th>Requested At</th>
        <th>Action</th>

    </tr>

<%

    while (rs.next()) {

        hasData = true;

        String status = rs.getString("request_status");

%>

    <tr>

        <td>
            <%= rs.getInt("request_id") %>
        </td>

        <td>
            <%= rs.getInt("user_id") %>
        </td>

        <td>
            <%= rs.getString("user_name") %>
        </td>

        <td>
            <%= rs.getInt("age") %>
        </td>

        <td>
            <%= rs.getString("medicine_name") %>
        </td>

        <td>
            <%= rs.getInt("quantity") %>
        </td>

        <td>
            <%= rs.getString("address") %>
        </td>

        <td>
            <%= rs.getString("phone") %>
        </td>

        <td>

            <span class="status
                <%= status.equalsIgnoreCase("Pending") ? "pending" :
                    status.equalsIgnoreCase("Accepted") ? "accepted" :
                    "rejected" %>">

                <%= status %>

            </span>

        </td>

        <td>
            <%= rs.getTimestamp("requested_at") %>
        </td>

        <td>

            <form action="deleteAdminRequest"
                  method="post"
                  onsubmit="return confirm('Are you sure you want to delete this request?');">

                <input type="hidden"
                       name="request_id"
                       value="<%= rs.getInt("request_id") %>">

                <button type="submit"
                        class="delete-btn">

                    Delete

                </button>

            </form>

        </td>

    </tr>

<%

    }

    if (!hasData) {

%>

    <tr>

        <td colspan="11" class="empty">
            No medicine requests found.
        </td>

    </tr>

<%
    }

%>

</table>

<%

} catch (Exception e) {

    out.println("<h3>Error: " + e.getMessage() + "</h3>");

} finally {

    try {
        if (rs != null) rs.close();
    } catch (Exception e) {}

    try {
        if (ps != null) ps.close();
    } catch (Exception e) {}

    try {
        if (c != null) c.close();
    } catch (Exception e) {}

}

%>

</div>


<footer class="footer">

    <p>
        © 2026 MedicineFinder. All Rights Reserved.
    </p>

</footer>

</body>

</html>

