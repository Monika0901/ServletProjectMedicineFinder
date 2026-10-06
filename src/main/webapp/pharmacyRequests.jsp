
<%@ page import="java.sql.*" %>

<%
    Object pharmacyIdObject = session.getAttribute("pharmacy_id");

    if (pharmacyIdObject == null) {
        response.sendRedirect("pharmacyLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <title>User Requests</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f3faf5;
        }

        .navbar {
            background: #198754;
            padding: 15px;
            text-align: center;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin: 0 20px;
            font-size: 16px;
        }

        .container {
            width: 95%;
            margin: 30px auto;
        }

        h2 {
            text-align: center;
            color: #198754;
            margin-bottom: 25px;
        }

        .request-card {
            background: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.1);
        }

        .row {
            display: flex;
            margin-bottom: 10px;
        }

        .label {
            width: 160px;
            font-weight: bold;
            color: #444;
        }

        .value {
            color: #222;
        }

        .status {
            font-weight: bold;
        }

        .pending {
            color: #f0ad4e;
        }

        .accepted {
            color: #198754;
            font-weight: bold;
        }

        .rejected {
            color: #dc3545;
            font-weight: bold;
        }

        .buttons {
            margin-top: 20px;
        }

        .accept,
        .reject {
            border: none;
            padding: 10px 18px;
            border-radius: 6px;
            color: white;
            cursor: pointer;
            margin-right: 10px;
        }

        .accept {
            background: #198754;
        }

        .reject {
            background: #dc3545;
        }

        .accept:hover {
            background: #146c43;
        }

        .reject:hover {
            background: #bb2d3b;
        }

        .empty {
            background: white;
            padding: 30px;
            text-align: center;
            border-radius: 10px;
        }

    </style>

</head>

<body>

<div class="navbar">

    <a href="pharmacyHome.jsp">Home</a>

    <a href="pharmacyRequests.jsp">
        User Requests
    </a>

    <a href="logout">Logout</a>

</div>


<div class="container">

    <h2>User Medicine Requests</h2>

<%

    try {

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection c = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/medicinefinder",
                "root",
                "Password"
        );

        String sql =
                "SELECT request_id, user_name, age, medicine_name, " +
                "quantity, address, phone, request_status, requested_at " +
                "FROM medicine_request " +
                "ORDER BY requested_at DESC";

        PreparedStatement ps =
                c.prepareStatement(sql);

        ResultSet rs =
                ps.executeQuery();

        boolean found = false;

        while (rs.next()) {

            found = true;

            int requestId =
                    rs.getInt("request_id");

            String currentStatus =
                    rs.getString("request_status");

%>

    <div class="request-card">


        <div class="row">

            <div class="label">
                Request ID:
            </div>

            <div class="value">
                <%= requestId %>
            </div>

        </div>


        <div class="row">

            <div class="label">
                User Name:
            </div>

            <div class="value">
                <%= rs.getString("user_name") %>
            </div>

        </div>


        <div class="row">

            <div class="label">
                Age:
            </div>

            <div class="value">
                <%= rs.getInt("age") %>
            </div>

        </div>


        <div class="row">

            <div class="label">
                Medicine:
            </div>

            <div class="value">
                <%= rs.getString("medicine_name") %>
            </div>

        </div>


        <div class="row">

            <div class="label">
                Quantity:
            </div>

            <div class="value">
                <%= rs.getInt("quantity") %>
            </div>

        </div>


        <div class="row">

            <div class="label">
                Address:
            </div>

            <div class="value">
                <%= rs.getString("address") %>
            </div>

        </div>


        <div class="row">

            <div class="label">
                Phone:
            </div>

            <div class="value">
                <%= rs.getString("phone") %>
            </div>

        </div>


        <div class="row">

            <div class="label">
                Status:
            </div>

            <div class="value status">

<%
                if ("Pending".equalsIgnoreCase(currentStatus)) {
%>

                    <span class="pending">
                        Pending
                    </span>

<%
                }
                else if ("Accepted".equalsIgnoreCase(currentStatus)) {
%>

                    <span class="accepted">
                        Accepted
                    </span>

<%
                }
                else if ("Rejected".equalsIgnoreCase(currentStatus)) {
%>

                    <span class="rejected">
                        Rejected
                    </span>

<%
                }
                else {
%>

                    <%= currentStatus %>

<%
                }
%>

            </div>

        </div>


        <div class="row">

            <div class="label">
                Requested At:
            </div>

            <div class="value">
                <%= rs.getString("requested_at") %>
            </div>

        </div>


        <div class="buttons">

<%
            if ("Pending".equalsIgnoreCase(currentStatus)) {
%>

            <form action="updateRequestStatus"
                  method="post"
                  style="display:inline;">

                <input type="hidden"
                       name="request_id"
                       value="<%= requestId %>">

                <input type="hidden"
                       name="status"
                       value="Accepted">

                <button type="submit"
                        class="accept">

                    Accept

                </button>

            </form>


            <form action="updateRequestStatus"
                  method="post"
                  style="display:inline;">

                <input type="hidden"
                       name="request_id"
                       value="<%= requestId %>">

                <input type="hidden"
                       name="status"
                       value="Rejected">

                <button type="submit"
                        class="reject">

                    Reject

                </button>

            </form>

<%
            }
            else if ("Accepted".equalsIgnoreCase(currentStatus)) {
%>

                <span class="accepted">
                    Request Accepted
                </span>

<%
            }
            else if ("Rejected".equalsIgnoreCase(currentStatus)) {
%>

                <span class="rejected">
                    Request Rejected
                </span>

<%
            }
%>

        </div>


    </div>

<%

        }

        if (!found) {

%>

        <div class="empty">

            <h3>
                No User Requests Found
            </h3>

        </div>

<%
        }

        rs.close();

        ps.close();

        c.close();

    }
    catch (Exception e) {

        e.printStackTrace();

%>

        <div class="empty">

            Error: <%= e.getMessage() %>

        </div>

<%
    }

%>

</div>

</body>

</html>

