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

String medicineId = request.getParameter("medicine_id");

if (medicineId == null || medicineId.isEmpty()) {
    response.sendRedirect("updateMedicine.jsp");
    return;
}

String medicineName = "";
String category = "";
String manufacturer = "";
String price = "";
String quantity = "";
String expiryDate = "";

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection c = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/medicinefinder",
        "root",
        "Password"
    );

    PreparedStatement ps = c.prepareStatement(
        "SELECT * FROM medicine WHERE medicine_id = ? AND pharmacy_id = ?"
    );

    ps.setInt(1, Integer.parseInt(medicineId));
    ps.setInt(2, pharmacyId);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {

        medicineName = rs.getString("medicine_name");
        category = rs.getString("category");
        manufacturer = rs.getString("manufacturer");
        price = String.valueOf(rs.getDouble("price"));
        quantity = String.valueOf(rs.getInt("quantity"));
        expiryDate = rs.getDate("expiry_date").toString();

    } else {

        rs.close();
        ps.close();
        c.close();

        response.sendRedirect("updateMedicine.jsp");
        return;
    }

    rs.close();
    ps.close();
    c.close();

} catch (Exception e) {

    e.printStackTrace();

    response.sendRedirect("updateMedicine.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Update Medicine - MedicineFinder</title>

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
    padding: 45px 5%;
}

.form-container {
    width: 100%;
    max-width: 1450px;
    margin: auto;
    background: #ffffff;
    padding: 32px 35px;
    border: 1px solid #e1ebe5;
    border-radius: 12px;
}

h2 {
    margin-bottom: 25px;
    color: #218c5a;
}

.form-row {
    display: flex;
    align-items: flex-end;
    gap: 12px;
    width: 100%;
}

.form-group {
    flex: 1;
    min-width: 0;
}

label {
    display: block;
    margin-bottom: 7px;
    font-size: 14px;
    font-weight: 600;
}

input,
select {
    width: 100%;
    height: 40px;
    padding: 0 10px;
    border: 1px solid #ccd8d0;
    border-radius: 6px;
    outline: none;
}

input:focus,
select:focus {
    border-color: #218c5a;
}

.button-group {
    display: flex;
    gap: 10px;
    align-items: center;
}

.submit-btn {
    height: 40px;
    padding: 0 22px;
    background: #218c5a;
    color: #ffffff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    white-space: nowrap;
}

.submit-btn:hover {
    background: #176c44;
}

.delete-btn {
    height: 40px;
    padding: 11px 22px;
    background: #dc3545;
    color: #ffffff;
    border-radius: 6px;
    text-decoration: none;
    cursor: pointer;
    font-size: 14px;
    white-space: nowrap;
}

.delete-btn:hover {
    background: #b02a37;
}

.back {
    display: inline-block;
    margin-top: 20px;
    color: #218c5a;
    text-decoration: none;
    font-size: 14px;
}

@media(max-width: 1000px) {

    .form-row {
        flex-wrap: wrap;
    }

    .form-group {
        flex: 1 1 30%;
    }

}

@media(max-width: 600px) {

    .form-group {
        flex: 1 1 100%;
    }

    .button-group {
        width: 100%;
        flex-direction: column;
    }

    .submit-btn,
    .delete-btn {
        width: 100%;
        text-align: center;
    }

}

</style>

</head>

<body>

<div class="navbar">

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

</div>

<div class="main">

    <div class="form-container">

        <h2>Update Medicine</h2>

        <form action="<%= request.getContextPath() %>/updateMedicine"
              method="post">

            <input type="hidden"
                   name="medicine_id"
                   value="<%= medicineId %>">

            <div class="form-row">

                <div class="form-group">

                    <label>Medicine Name</label>

                    <input type="text"
                           name="medicine_name"
                           value="<%= medicineName %>"
                           required>

                </div>

                <div class="form-group">

                    <label>Category</label>

                    <select name="category" required>

                        <option value="Tablet"
                            <%= category.equals("Tablet") ? "selected" : "" %>>
                            Tablet
                        </option>

                        <option value="Capsule"
                            <%= category.equals("Capsule") ? "selected" : "" %>>
                            Capsule
                        </option>

                        <option value="Syrup"
                            <%= category.equals("Syrup") ? "selected" : "" %>>
                            Syrup
                        </option>

                        <option value="Injection"
                            <%= category.equals("Injection") ? "selected" : "" %>>
                            Injection
                        </option>

                        <option value="Cream"
                            <%= category.equals("Cream") ? "selected" : "" %>>
                            Cream
                        </option>

                        <option value="Drops"
                            <%= category.equals("Drops") ? "selected" : "" %>>
                            Drops
                        </option>

                        <option value="Other"
                            <%= category.equals("Other") ? "selected" : "" %>>
                            Other
                        </option>

                    </select>

                </div>

                <div class="form-group">

                    <label>Manufacturer</label>

                    <input type="text"
                           name="manufacturer"
                           value="<%= manufacturer %>">

                </div>

                <div class="form-group">

                    <label>Price</label>

                    <input type="number"
                           name="price"
                           value="<%= price %>"
                           step="0.01"
                           required>

                </div>

                <div class="form-group">

                    <label>Quantity</label>

                    <input type="number"
                           name="quantity"
                           value="<%= quantity %>"
                           required>

                </div>

                <div class="form-group">

                    <label>Expiry Date</label>

                    <input type="date"
                           name="expiry_date"
                           value="<%= expiryDate %>"
                           required>

                </div>

                <div class="button-group">

                    <button type="submit"
                            class="submit-btn">
                        Update Medicine
                    </button>

                    <a href="<%= request.getContextPath() %>/deleteMedicine?medicine_id=<%= medicineId %>"
                       class="delete-btn"
                       onclick="return confirm('Are you sure you want to delete this medicine?');">
                        Delete Medicine
                    </a>

                </div>

            </div>

        </form>

        <a href="updateMedicine.jsp" class="back">
            ← Back to Manage Stock
        </a>

    </div>

</div>

</body>

</html>