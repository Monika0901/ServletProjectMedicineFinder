<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>My Requests</title>

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
    width: 92%;
    max-width: 1000px;
    margin: 45px auto;
}

.title {
    text-align: center;
    color: #245c3a;
}

.subtitle {
    text-align: center;
    color: #666;
    margin-bottom: 30px;
}

.request-card {
    background: white;
    padding: 25px;
    margin-bottom: 25px;
    border-radius: 15px;
    box-shadow: 0 5px 18px rgba(0,0,0,0.08);
}

.request-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #ddd;
    padding-bottom: 15px;
    margin-bottom: 15px;
}

.request-id {
    font-size: 18px;
    font-weight: bold;
    color: #245c3a;
}

.status {
    padding: 8px 18px;
    border-radius: 20px;
    background: #fff3cd;
    color: #856404;
    font-weight: bold;
}

.info {
    line-height: 2;
}

.info b {
    color: #245c3a;
}

.buttons {
    margin-top: 20px;
    display: flex;
    gap: 10px;
}

.update-btn {
    display: inline-block;
    padding: 11px 20px;
    background: #218c5a;
    color: white;
    text-decoration: none;
    border-radius: 7px;
    font-weight: bold;
}

.delete-btn {
    padding: 11px 20px;
    background: #c0392b;
    color: white;
    border: none;
    border-radius: 7px;
    font-weight: bold;
    cursor: pointer;
}

.empty {
    background: white;
    padding: 50px;
    text-align: center;
    border-radius: 15px;
}

.new-request {
    display: inline-block;
    margin-top: 20px;
    padding: 12px 20px;
    background: #218c5a;
    color: white;
    text-decoration: none;
    border-radius: 7px;
    font-weight: bold;
}

@media (max-width: 768px) {

    .navbar {
        flex-direction: column;
        gap: 15px;
        padding: 15px 20px;
    }

    .navbar a {
        margin: 5px;
        font-size: 14px;
    }

    .request-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 12px;
    }

    .buttons {
        flex-direction: column;
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

        <a href="findPharmacy.jsp">Find Pharmacy</a>

        <a href="request.jsp">Requests</a>

        <a href="logout">Logout</a>

    </div>

</div>


<div class="container">

<h1 class="title">
    My Requests
</h1>

<p class="subtitle">
    View all your medicine requests
</p>


<%

Object userIdObject =
        session.getAttribute("user_id");


if (userIdObject == null) {

    response.sendRedirect("userLogin.jsp");

} else {

    int userId =
            (Integer) userIdObject;

    boolean found = false;


    try {

        Class.forName(
                "com.mysql.cj.jdbc.Driver"
        );


        Connection c =
                DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/medicinefinder",
                        "root",
                        "Password"
                );


        String sql =
                "SELECT request_id, user_name, age, " +
                "medicine_name, quantity, address, phone, " +
                "request_status, requested_at " +
                "FROM medicine_request " +
                "WHERE user_id = ? " +
                "ORDER BY requested_at DESC";


        PreparedStatement ps =
                c.prepareStatement(sql);


        ps.setInt(1, userId);


        ResultSet rs =
                ps.executeQuery();


        while (rs.next()) {

            found = true;

%>


<div class="request-card">


    <div class="request-header">

        <div class="request-id">

            Request ID:
            <%= rs.getInt("request_id") %>

        </div>


        <div class="status">

            <%= rs.getString("request_status") %>

        </div>

    </div>


    <div class="info">

        <b>User Name:</b>
        <%= rs.getString("user_name") %>

        <br>

        <b>Age:</b>
        <%= rs.getInt("age") %>

        <br>

        <b>Medicine Name:</b>
        <%= rs.getString("medicine_name") %>

        <br>

        <b>Quantity:</b>
        <%= rs.getInt("quantity") %>

        <br>

        <b>Address:</b>
        <%= rs.getString("address") %>

        <br>

        <b>Phone:</b>
        <%= rs.getString("phone") %>

        <br>

        <b>Requested At:</b>
        <%= rs.getTimestamp("requested_at") %>

    </div>


    <div class="buttons">


        <a href="updateRequest.jsp?request_id=<%= rs.getInt("request_id") %>"
           class="update-btn">

            Update Request

        </a>


        <form action="deleteRequest"
              method="post"
              onsubmit="return confirm('Are you sure you want to delete this request?');">

            <input type="hidden"
                   name="request_id"
                   value="<%= rs.getInt("request_id") %>">


            <button type="submit"
                    class="delete-btn">

                Delete Request

            </button>

        </form>


    </div>


</div>


<%

        }


        if (!found) {

%>


<div class="empty">

    <h2>
        No Requests Found
    </h2>

    <p>
        You have not submitted any medicine request yet.
    </p>

    <a href="request.jsp"
       class="new-request">

        Do Request

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

    <h2>
        Error
    </h2>

    <p>
        <%= e.getMessage() %>
    </p>

</div>


<%

    }

}

%>


</div>

</body>

</html>