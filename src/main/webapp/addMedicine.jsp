
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
if (session.getAttribute("pharmacy_id") == null) {
    response.sendRedirect("pharmacyLogin.jsp");
    return;
}

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

<title>Add Medicine - MedicineFinder</title>

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
    gap: 28px;
}

.nav-links a {
    text-decoration: none;
    color: #444;
    font-size: 15px;
}

.nav-links a:hover {
    color: #218c5a;
}

/* Main */

.main {
    min-height: calc(100vh - 70px);
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 50px 20px;
}

/* Form */

.form-container {
    width: 100%;
    max-width: 650px;
    background: white;
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 8px 30px rgba(0,0,0,0.08);
}

.form-container h1 {
    text-align: center;
    color: #183d29;
    margin-bottom: 10px;
}

.form-container p {
    text-align: center;
    color: #777;
    margin-bottom: 30px;
}

.form-row {
    display: flex;
    gap: 20px;
}

.form-group {
    flex: 1;
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #444;
    font-size: 14px;
    font-weight: bold;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 12px;
    border: 1px solid #d5ddd8;
    border-radius: 7px;
    font-size: 14px;
    outline: none;
}

.form-group input:focus,
.form-group select:focus {
    border-color: #218c5a;
}

.submit-btn {
    width: 100%;
    padding: 14px;
    background: #218c5a;
    border: none;
    color: white;
    font-size: 16px;
    font-weight: bold;
    border-radius: 7px;
    cursor: pointer;
    margin-top: 10px;
}

.submit-btn:hover {
    background: #176b44;
}

.back-link {
    display: block;
    text-align: center;
    margin-top: 20px;
    color: #218c5a;
    text-decoration: none;
    font-size: 14px;
}

.back-link:hover {
    text-decoration: underline;
}

@media (max-width: 600px) {

    .navbar {
        padding: 0 5%;
    }

    .nav-links {
        gap: 12px;
    }

    .nav-links a {
        font-size: 12px;
    }

    .form-container {
        padding: 25px;
    }

    .form-row {
        flex-direction: column;
        gap: 0;
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

        <a href="pharmacyHome.jsp">
            Home
        </a>

        <a href="addMedicine.jsp">
            Add Medicine
        </a>

        <a href="updateMedicine.jsp">
            Manage Stock
        </a>

        <a href="pharmacyHome.jsp">
            Profile
        </a>

        <a href="logout">
            Logout
        </a>

    </div>

</nav>


<div class="main">

    <div class="form-container">

        <h1>
            Add Medicine
        </h1>

        <p>
            Add medicine details and availability to your pharmacy.
        </p>


        <form action="${pageContext.request.contextPath}/addMedicine"
              method="post">


            <div class="form-group">

                <label>
                    Medicine Name
                </label>

                <input type="text"
                       name="medicine_name"
                       placeholder="Enter medicine name"
                       required>

            </div>


            <div class="form-row">

                <div class="form-group">

                    <label>
                        Category
                    </label>

                    <select name="category" required>

                        <option value="">
                            Select Category
                        </option>

                        <option value="Tablet">
                            Tablet
                        </option>

                        <option value="Capsule">
                            Capsule
                        </option>

                        <option value="Syrup">
                            Syrup
                        </option>

                        <option value="Injection">
                            Injection
                        </option>

                        <option value="Cream">
                            Cream
                        </option>

                        <option value="Drops">
                            Drops
                        </option>

                        <option value="Other">
                            Other
                        </option>

                    </select>

                </div>


                <div class="form-group">

                    <label>
                        Manufacturer
                    </label>

                    <input type="text"
                           name="manufacturer"
                           placeholder="Enter manufacturer"
                           required>

                </div>

            </div>


            <div class="form-row">

                <div class="form-group">

                    <label>
                        Price
                    </label>

                    <input type="number"
                           name="price"
                           step="0.01"
                           min="0"
                           placeholder="Enter price"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Quantity
                    </label>

                    <input type="number"
                           name="quantity"
                           min="0"
                           placeholder="Enter quantity"
                           required>

                </div>

            </div>


            <div class="form-group">

                <label>
                    Expiry Date
                </label>

                <input type="date"
                       name="expiry_date"
                       required>

            </div>


            <button type="submit" class="submit-btn">
                Add Medicine
            </button>

        </form>


        <a href="pharmacyHome.jsp" class="back-link">
            ← Back to Pharmacy Home
        </a>

    </div>

</div>


</body>

</html>

