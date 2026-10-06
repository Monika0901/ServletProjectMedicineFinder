<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
Integer pharmacyId = (Integer) session.getAttribute("pharmacy_id");

if (pharmacyId == null) {
    response.sendRedirect("pharmacyLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Manage Medicine - MedicineFinder</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f1f8f4;
    color: #26352b;
}

.navbar {
    height: 64px;
    background: #ffffff;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 6%;
    border-bottom: 1px solid #e1ebe5;
}

.logo {
    font-size: 24px;
    font-weight: bold;
    color: #218c5a;
}

.logo span {
    color: #333;
}

.nav-links {
    display: flex;
    align-items: center;
    gap: 25px;
}

.nav-links a {
    text-decoration: none;
    color: #444;
    font-size: 14px;
}

.nav-links a:hover {
    color: #218c5a;
}

.main {
    min-height: calc(100vh - 64px);
    padding: 40px 5%;
}

.page-title {
    text-align: center;
    margin-bottom: 25px;
}

.page-title h1 {
    color: #183d29;
    font-size: 28px;
    margin-bottom: 7px;
}

.page-title p {
    color: #7a847d;
    font-size: 14px;
}

.search-container {
    max-width: 700px;
    margin: 0 auto 30px auto;
}

.search-box {
    width: 100%;
    height: 45px;
    padding: 0 16px;
    border: 1px solid #ccd8d0;
    border-radius: 7px;
    outline: none;
    font-size: 14px;
    background: #ffffff;
}

.search-box:focus {
    border-color: #218c5a;
}

.medicine-container {
    width: 100%;
    max-width: 1400px;
    margin: auto;
}

.medicine-card {
    background: #ffffff;
    border: 1px solid #e1ebe5;
    border-radius: 10px;
    margin-bottom: 15px;
    padding: 18px 20px;
}

.medicine-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 15px;
    padding-bottom: 12px;
    border-bottom: 1px solid #e6eee9;
}

.medicine-header h2 {
    color: #218c5a;
    font-size: 19px;
    font-weight: 600;
}

.update-btn {
    background: #218c5a;
    color: #ffffff;
    text-decoration: none;
    padding: 8px 17px;
    border-radius: 6px;
    font-size: 13px;
    font-weight: 600;
}

.update-btn:hover {
    background: #176b44;
}

.medicine-details {
    display: grid;
    grid-template-columns: repeat(6, 1fr);
    gap: 10px;
}

.detail {
    background: #f5faf7;
    border: 1px solid #e5eee8;
    padding: 12px;
    border-radius: 7px;
    min-width: 0;
}

.detail label {
    display: block;
    color: #7a847d;
    font-size: 11px;
    margin-bottom: 6px;
}

.detail span {
    display: block;
    color: #333333;
    font-size: 13px;
    font-weight: 600;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.no-result {
    display: none;
    background: #ffffff;
    border: 1px solid #e1ebe5;
    padding: 40px;
    text-align: center;
    border-radius: 10px;
    color: #7a847d;
}

.empty {
    background: #ffffff;
    border: 1px solid #e1ebe5;
    padding: 55px 30px;
    text-align: center;
    border-radius: 10px;
}

.empty h2 {
    color: #4d5a51;
    font-size: 21px;
    margin-bottom: 10px;
}

.empty p {
    color: #7a847d;
    font-size: 14px;
    margin-bottom: 22px;
}

.add-btn {
    display: inline-block;
    background: #218c5a;
    color: #ffffff;
    text-decoration: none;
    padding: 10px 20px;
    border-radius: 6px;
    font-size: 13px;
    font-weight: 600;
}

.add-btn:hover {
    background: #176b44;
}

@media (max-width: 1100px) {

    .medicine-details {
        grid-template-columns: repeat(3, 1fr);
    }

}

@media (max-width: 700px) {

    .navbar {
        height: auto;
        padding: 17px 5%;
        flex-direction: column;
        gap: 15px;
    }

    .nav-links {
        gap: 15px;
        flex-wrap: wrap;
        justify-content: center;
    }

    .nav-links a {
        font-size: 12px;
    }

    .main {
        padding: 30px 5%;
    }

    .page-title h1 {
        font-size: 24px;
    }

    .medicine-header {
        align-items: flex-start;
        gap: 12px;
    }

    .medicine-header h2 {
        font-size: 17px;
    }

    .medicine-details {
        grid-template-columns: repeat(2, 1fr);
    }

}

@media (max-width: 450px) {

    .medicine-details {
        grid-template-columns: 1fr;
    }

    .medicine-header {
        flex-direction: column;
    }

    .update-btn {
        width: 100%;
        text-align: center;
    }

}

</style>

</head>

<body>

<nav class="navbar">

    <div class="logo">
        Medicine<span>Finder</span>
    </div>

    <div class="nav-links">

        <a href="pharmacyHome.jsp">Home</a>

        <a href="addMedicine.jsp">Add Medicine</a>

        <a href="updateMedicine.jsp">Manage Stock</a>

        <a href="pharmacyHome.jsp">Profile</a>

        <a href="logout">Logout</a>

    </div>

</nav>

<div class="main">

    <div class="page-title">

        <h1>Manage Medicine</h1>

        <p>View and update medicines available in your pharmacy.</p>

    </div>

    <div class="search-container">

        <input type="text"
               id="searchMedicine"
               class="search-box"
               placeholder="Search medicine by name..."
               onkeyup="searchMedicine()">

    </div>

    <div class="medicine-container">

        <%

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection c = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/medicinefinder",
                "root",
                "Password"
            );

            PreparedStatement ps = c.prepareStatement(
                "SELECT * FROM medicine WHERE pharmacy_id = ? ORDER BY medicine_id DESC"
            );

            ps.setInt(1, pharmacyId);

            ResultSet rs = ps.executeQuery();

            boolean found = false;

            while (rs.next()) {

                found = true;

        %>

            <div class="medicine-card">

                <div class="medicine-header">

                    <h2 class="medicine-name">
                        <%= rs.getString("medicine_name") %>
                    </h2>

                    <a href="<%= request.getContextPath() %>/editMedicine.jsp?medicine_id=<%= rs.getInt("medicine_id") %>"
                       class="update-btn">
                        Update
                    </a>

                </div>

                <div class="medicine-details">

                    <div class="detail">

                        <label>Category</label>

                        <span>
                            <%= rs.getString("category") %>
                        </span>

                    </div>

                    <div class="detail">

                        <label>Manufacturer</label>

                        <span>
                            <%= rs.getString("manufacturer") %>
                        </span>

                    </div>

                    <div class="detail">

                        <label>Price</label>

                        <span>
                            ₹ <%= rs.getDouble("price") %>
                        </span>

                    </div>

                    <div class="detail">

                        <label>Quantity</label>

                        <span>
                            <%= rs.getInt("quantity") %>
                        </span>

                    </div>

                    <div class="detail">

                        <label>Expiry Date</label>

                        <span>
                            <%= rs.getDate("expiry_date") %>
                        </span>

                    </div>

                    <div class="detail">

                        <label>Added On</label>

                        <span>
                            <%= rs.getTimestamp("created_at") %>
                        </span>

                    </div>

                </div>

            </div>

        <%

            }

            if (!found) {

        %>

            <div class="empty">

                <h2>No Medicine Added</h2>

                <p>You have not added any medicine to your pharmacy yet.</p>

                <a href="addMedicine.jsp" class="add-btn">
                    Add Medicine
                </a>

            </div>

        <%

            }

            rs.close();
            ps.close();
            c.close();

        } catch (Exception e) {

            e.printStackTrace();

        %>

            <div class="empty">

                <h2>Unable to Load Medicines</h2>

                <p>Please try again.</p>

            </div>

        <%

        }

        %>

        <div id="noResult" class="no-result">
            No medicine found.
        </div>

    </div>

</div>

<script>

function searchMedicine() {

    let input = document.getElementById("searchMedicine");

    let searchValue = input.value.toLowerCase();

    let cards = document.getElementsByClassName("medicine-card");

    let found = false;

    for (let i = 0; i < cards.length; i++) {

        let medicineName = cards[i]
            .getElementsByClassName("medicine-name")[0]
            .innerText
            .toLowerCase();

        if (medicineName.includes(searchValue)) {

            cards[i].style.display = "block";

            found = true;

        } else {

            cards[i].style.display = "none";
        }
    }

    let noResult = document.getElementById("noResult");

    if (!found && cards.length > 0) {

        noResult.style.display = "block";

    } else {

        noResult.style.display = "none";
    }
}

</script>

</body>

</html>