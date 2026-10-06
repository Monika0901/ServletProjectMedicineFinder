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

<title>Update Request</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f3faf5;
}

.navbar {
    background: #d8f3dc;
    padding: 18px 50px;
    display: flex;
    justify-content: space-between;
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

.container {
    width: 90%;
    max-width: 600px;
    margin: 50px auto;
}

.card {
    background: white;
    padding: 35px;
    border-radius: 15px;
    box-shadow: 0 5px 18px rgba(0,0,0,0.08);
}

h1 {
    text-align: center;
    color: #245c3a;
    margin-bottom: 30px;
}

label {
    display: block;
    margin-top: 18px;
    margin-bottom: 7px;
    font-weight: bold;
    color: #245c3a;
}

input,
textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #cddfd3;
    border-radius: 7px;
    font-size: 15px;
}

textarea {
    height: 90px;
    resize: none;
}

.readonly {
    background: #f3f7f4;
}

button {
    width: 100%;
    margin-top: 25px;
    padding: 13px;
    border: none;
    background: #218c5a;
    color: white;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

.back {
    display: block;
    text-align: center;
    margin-top: 20px;
    color: #245c3a;
    text-decoration: none;
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

        <a href="requestStatus.jsp">My Requests</a>

        <a href="logout">Logout</a>

    </div>

</div>


<div class="container">

<div class="card">

<h1>
    Update Request
</h1>


<%

Object userIdObject =
        session.getAttribute("user_id");

String requestIdValue =
        request.getParameter("request_id");


if (userIdObject == null) {

    response.sendRedirect("userLogin.jsp");

} else if (requestIdValue == null) {

    response.sendRedirect("requestStatus.jsp");

} else {

    int userId =
            (Integer) userIdObject;

    int requestId =
            Integer.parseInt(requestIdValue);


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


        PreparedStatement ps =
                c.prepareStatement(
                        "SELECT user_name, age, medicine_name, " +
                        "quantity, address, phone, request_status " +
                        "FROM medicine_request " +
                        "WHERE request_id = ? AND user_id = ?"
                );


        ps.setInt(1, requestId);

        ps.setInt(2, userId);


        ResultSet rs =
                ps.executeQuery();


        if (rs.next()) {

%>


<form action="updateUserRequest"
      method="post">


<input type="hidden"
       name="request_id"
       value="<%= requestId %>">


<label>
    User Name
</label>

<input type="text"
       class="readonly"
       value="<%= rs.getString("user_name") %>"
       readonly>


<label>
    Age
</label>

<input type="number"
       class="readonly"
       value="<%= rs.getInt("age") %>"
       readonly>


<label>
    Medicine Name
</label>

<input type="text"
       name="medicine_name"
       value="<%= rs.getString("medicine_name") %>"
       required>


<label>
    Quantity
</label>

<input type="number"
       name="quantity"
       min="1"
       value="<%= rs.getInt("quantity") %>"
       required>


<label>
    Address
</label>

<textarea name="address"
          required><%= rs.getString("address") %></textarea>


<label>
    Phone Number
</label>

<input type="tel"
       name="phone"
       value="<%= rs.getString("phone") %>"
       pattern="[0-9]{10}"
       maxlength="10"
       required>


<label>
    Current Status
</label>

<input type="text"
       class="readonly"
       value="<%= rs.getString("request_status") %>"
       readonly>


<button type="submit">
    Update Request
</button>

</form>


<%

        } else {

%>

<p>
    Request not found.
</p>

<%

        }


        rs.close();

        ps.close();

        c.close();


    } catch (Exception e) {

        e.printStackTrace();

%>

<p>
    <%= e.getMessage() %>
</p>

<%

    }

}

%>


<a href="requestStatus.jsp"
   class="back">

    Back to My Requests

</a>

</div>

</div>

</body>

</html>