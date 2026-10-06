<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    Integer totalUsers = (Integer) request.getAttribute("totalUsers");
    Integer totalPharmacies = (Integer) request.getAttribute("totalPharmacies");
    Integer totalMedicines = (Integer) request.getAttribute("totalMedicines");
    Integer totalRequests = (Integer) request.getAttribute("totalRequests");

    Integer acceptedRequests = (Integer) request.getAttribute("acceptedRequests");
    Integer pendingRequests = (Integer) request.getAttribute("pendingRequests");
    Integer rejectedRequests = (Integer) request.getAttribute("rejectedRequests");

    if (totalUsers == null) totalUsers = 0;
    if (totalPharmacies == null) totalPharmacies = 0;
    if (totalMedicines == null) totalMedicines = 0;
    if (totalRequests == null) totalRequests = 0;

    if (acceptedRequests == null) acceptedRequests = 0;
    if (pendingRequests == null) pendingRequests = 0;
    if (rejectedRequests == null) rejectedRequests = 0;

    java.util.List<String> chartDays =
        (java.util.List<String>) request.getAttribute("chartDays");

    java.util.List<Integer> chartValues =
        (java.util.List<Integer>) request.getAttribute("chartValues");

    java.util.List<String> medicineNames =
        (java.util.List<String>) request.getAttribute("medicineNames");

    java.util.List<Integer> medicineRequestCounts =
        (java.util.List<Integer>) request.getAttribute("medicineRequestCounts");

    java.util.List<String> pharmacyNames =
        (java.util.List<String>) request.getAttribute("pharmacyNames");

    java.util.List<Integer> pharmacyMedicineCounts =
        (java.util.List<Integer>) request.getAttribute("pharmacyMedicineCounts");

    if (chartDays == null)
        chartDays = new java.util.ArrayList<>();

    if (chartValues == null)
        chartValues = new java.util.ArrayList<>();

    if (medicineNames == null)
        medicineNames = new java.util.ArrayList<>();

    if (medicineRequestCounts == null)
        medicineRequestCounts = new java.util.ArrayList<>();

    if (pharmacyNames == null)
        pharmacyNames = new java.util.ArrayList<>();

    if (pharmacyMedicineCounts == null)
        pharmacyMedicineCounts = new java.util.ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>MedicineFinder - Reports</title>

<style>

/* =========================
   GLOBAL
========================= */

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: Arial, Helvetica, sans-serif;
    background: #f5f8f6;
    color: #183328;
}

/* =========================
   TOP HEADER
========================= */

.header {
    width: 100%;
    height: 72px;
    background: white;
    border-bottom: 1px solid #e4ebe7;

    display: flex;
    align-items: center;
    justify-content: space-between;

    padding: 0 45px;

    position: sticky;
    top: 0;
    z-index: 100;
}

.logo {
    display: flex;
    align-items: center;
    gap: 12px;
}

.logo-icon {
    width: 42px;
    height: 42px;

    border-radius: 12px;

    background: #218c5a;

    color: white;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 21px;
    font-weight: bold;
}

.logo-text {
    font-size: 21px;
    font-weight: bold;
    color: #173c29;
}

.logo-text span {
    color: #218c5a;
}

.header-right {
    display: flex;
    align-items: center;
    gap: 25px;
}

.date-box {
    color: #6d7973;
    font-size: 14px;
}

.admin-box {
    display: flex;
    align-items: center;
    gap: 10px;
}

.admin-avatar {
    width: 38px;
    height: 38px;

    border-radius: 50%;

    background: #dff3e8;

    color: #218c5a;

    display: flex;
    align-items: center;
    justify-content: center;

    font-weight: bold;
}

/* =========================
   NAVIGATION
========================= */

.navbar {
    background: white;

    border-bottom: 1px solid #e6ece8;

    padding: 12px 45px;

    display: flex;
    gap: 10px;

    overflow-x: auto;
}

.navbar a {
    text-decoration: none;

    padding: 9px 17px;

    border-radius: 8px;

    color: #65736b;

    font-size: 14px;

    white-space: nowrap;

    transition: 0.2s;
}

.navbar a:hover {
    background: #edf8f2;
    color: #218c5a;
}

.navbar .active {
    background: #e1f3e9;
    color: #218c5a;
    font-weight: bold;
}

/* =========================
   MAIN
========================= */

.main {
    max-width: 1450px;

    margin: auto;

    padding: 35px 45px 60px;
}

/* =========================
   HERO
========================= */

.hero {
    background: linear-gradient(
        120deg,
        #dff4e8,
        #f4fbf7
    );

    border: 1px solid #d8ebdf;

    border-radius: 20px;

    padding: 30px 34px;

    display: flex;

    align-items: center;

    justify-content: space-between;

    margin-bottom: 28px;
}

.hero h1 {
    font-size: 29px;
    color: #173c29;
    margin-bottom: 8px;
}

.hero p {
    color: #68766e;
    font-size: 14px;
}

.hero-badge {
    background: white;

    padding: 13px 18px;

    border-radius: 12px;

    border: 1px solid #d9e8df;

    color: #218c5a;

    font-size: 14px;

    font-weight: bold;
}

/* =========================
   STAT CARDS
========================= */

.stats {
    display: grid;

    grid-template-columns:
        repeat(4, 1fr);

    gap: 20px;

    margin-bottom: 28px;
}

.stat-card {
    background: white;

    border: 1px solid #e2eae5;

    border-radius: 17px;

    padding: 23px;

    position: relative;

    overflow: hidden;

    transition: 0.25s;
}

.stat-card:hover {
    transform: translateY(-4px);

    box-shadow:
        0 10px 25px
        rgba(31, 94, 63, 0.08);
}

.stat-top {
    display: flex;

    justify-content: space-between;

    align-items: center;
}

.stat-title {
    font-size: 14px;

    color: #748078;

    font-weight: 600;
}

.stat-icon {
    width: 43px;
    height: 43px;

    border-radius: 12px;

    background: #e4f5eb;

    color: #218c5a;

    display: flex;

    align-items: center;
    justify-content: center;

    font-size: 20px;
}

.stat-value {
    font-size: 32px;

    font-weight: bold;

    color: #183c2b;

    margin-top: 16px;
}

.stat-footer {
    font-size: 12px;

    color: #8a948f;

    margin-top: 7px;
}

/* =========================
   SECTION
========================= */

.section {
    background: white;

    border: 1px solid #e2eae5;

    border-radius: 17px;

    padding: 25px;

    margin-bottom: 25px;
}

.section-header {
    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 22px;
}

.section-title {
    font-size: 19px;

    color: #193c2c;

    font-weight: bold;
}

.section-subtitle {
    font-size: 12px;

    color: #8a958f;

    margin-top: 5px;
}

/* =========================
   CHART
========================= */

.chart-area {
    height: 270px;

    display: flex;

    align-items: flex-end;

    gap: 18px;

    padding: 20px 10px 0;
}

.bar-wrapper {
    flex: 1;

    height: 100%;

    display: flex;

    flex-direction: column;

    justify-content: flex-end;

    align-items: center;

    gap: 8px;
}

.bar-value {
    font-size: 12px;

    color: #557064;

    font-weight: bold;
}

.bar {
    width: 65%;

    min-height: 4px;

    background: linear-gradient(
        to top,
        #218c5a,
        #65c28d
    );

    border-radius:
        8px 8px 3px 3px;

    transition: 0.3s;
}

.bar:hover {
    opacity: 0.75;
}

.bar-day {
    font-size: 12px;

    color: #77837d;
}

/* =========================
   TWO COLUMN
========================= */

.two-column {
    display: grid;

    grid-template-columns:
        1fr 1fr;

    gap: 25px;

    margin-bottom: 25px;
}

/* =========================
   STATUS
========================= */

.status-item {
    margin-bottom: 20px;
}

.status-label {
    display: flex;

    justify-content: space-between;

    margin-bottom: 8px;

    font-size: 13px;
}

.status-label span:first-child {
    color: #66736c;
}

.status-label span:last-child {
    font-weight: bold;

    color: #183c2b;
}

.progress {
    width: 100%;

    height: 9px;

    background: #edf1ee;

    border-radius: 10px;

    overflow: hidden;
}

.progress-fill {
    height: 100%;

    border-radius: 10px;
}

.accepted {
    background: #42a86e;
}

.pending {
    background: #e3b94e;
}

.rejected {
    background: #df6c6c;
}

/* =========================
   TABLE
========================= */

.data-table {
    width: 100%;

    border-collapse: collapse;
}

.data-table th {
    text-align: left;

    font-size: 12px;

    color: #7b8781;

    background: #f7faf8;

    padding: 13px;

    border-bottom: 1px solid #e5ebe7;
}

.data-table td {
    padding: 14px 13px;

    font-size: 13px;

    border-bottom: 1px solid #edf1ee;

    color: #42544b;
}

.data-table tr:last-child td {
    border-bottom: none;
}

.rank {
    width: 30px;
    height: 30px;

    border-radius: 8px;

    background: #e5f5eb;

    color: #218c5a;

    display: inline-flex;

    align-items: center;

    justify-content: center;

    font-weight: bold;
}

.count-badge {
    display: inline-block;

    padding: 6px 10px;

    border-radius: 7px;

    background: #edf8f2;

    color: #218c5a;

    font-weight: bold;

    font-size: 12px;
}

/* =========================
   INSIGHTS
========================= */

.insights {
    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 15px;
}

.insight {
    background: #f7faf8;

    border: 1px solid #e4ece7;

    border-radius: 13px;

    padding: 18px;
}

.insight-icon {
    font-size: 21px;

    margin-bottom: 10px;
}

.insight h4 {
    font-size: 14px;

    color: #244637;

    margin-bottom: 6px;
}

.insight p {
    font-size: 12px;

    color: #7b8781;

    line-height: 1.5;
}

/* =========================
   EMPTY
========================= */

.empty {
    text-align: center;

    color: #929c97;

    padding: 25px;

    font-size: 13px;
}

/* =========================
   RESPONSIVE
========================= */

@media(max-width: 1000px) {

    .stats {
        grid-template-columns:
            repeat(2, 1fr);
    }

    .two-column {
        grid-template-columns: 1fr;
    }

    .insights {
        grid-template-columns: 1fr;
    }

    .header {
        padding: 0 25px;
    }

    .navbar {
        padding: 12px 25px;
    }

    .main {
        padding: 30px 25px;
    }
}

@media(max-width: 600px) {

    .header {
        height: auto;

        padding: 15px 18px;

        align-items: flex-start;
    }

    .header-right {
        gap: 10px;
    }

    .date-box {
        display: none;
    }

    .stats {
        grid-template-columns: 1fr;
    }

    .hero {
        flex-direction: column;

        align-items: flex-start;

        gap: 18px;
    }

    .main {
        padding: 20px 15px;
    }

    .chart-area {
        gap: 7px;
    }

    .bar {
        width: 75%;
    }
}

</style>

</head>

<body>

<!-- =========================
     HEADER
========================= -->

<header class="header">

    <div class="logo">

        <div class="logo-icon">
            M
        </div>

        <div class="logo-text">
            Medicine<span>Finder</span>
        </div>

    </div>

    <div class="header-right">

        <div class="date-box">
            <%= new java.text.SimpleDateFormat("dd MMM yyyy")
                    .format(new java.util.Date()) %>
        </div>

        <div class="admin-box">

            <div class="admin-avatar">
                A
            </div>

            <span>Administrator</span>

        </div>

    </div>

</header>


<!-- =========================
     NAVBAR
========================= -->

<nav class="navbar">

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

    <a href="adminReports"
       class="active">
        Reports
    </a>

    <a href="adminProfile.jsp">
        Profile
    </a>

    <a href="adminLogout">
        Logout
    </a>

</nav>


<!-- =========================
     MAIN
========================= -->

<main class="main">


<!-- HERO -->

<section class="hero">

    <div>

        <h1>
            Reports & Analytics
        </h1>

        <p>
            Monitor MedicineFinder activity,
            requests and pharmacy inventory.
        </p>

    </div>

    <div class="hero-badge">
        ● Live Database Report
    </div>

</section>


<!-- =========================
     STATISTICS
========================= -->

<section class="stats">


    <div class="stat-card">

        <div class="stat-top">

            <div class="stat-title">
                Total Users
            </div>

            <div class="stat-icon">
                👤
            </div>

        </div>

        <div class="stat-value">
            <%= totalUsers %>
        </div>

        <div class="stat-footer">
            Registered users
        </div>

    </div>


    <div class="stat-card">

        <div class="stat-top">

            <div class="stat-title">
                Total Pharmacies
            </div>

            <div class="stat-icon">
                🏥
            </div>

        </div>

        <div class="stat-value">
            <%= totalPharmacies %>
        </div>

        <div class="stat-footer">
            Pharmacies available
        </div>

    </div>


    <div class="stat-card">

        <div class="stat-top">

            <div class="stat-title">
                Total Medicines
            </div>

            <div class="stat-icon">
                💊
            </div>

        </div>

        <div class="stat-value">
            <%= totalMedicines %>
        </div>

        <div class="stat-footer">
            Medicines listed
        </div>

    </div>


    <div class="stat-card">

        <div class="stat-top">

            <div class="stat-title">
                Total Requests
            </div>

            <div class="stat-icon">
                📋
            </div>

        </div>

        <div class="stat-value">
            <%= totalRequests %>
        </div>

        <div class="stat-footer">
            Medicine requests
        </div>

    </div>


</section>


<!-- =========================
     7 DAY ACTIVITY
========================= -->

<section class="section">

    <div class="section-header">

        <div>

            <div class="section-title">
                Medicine Request Activity
            </div>

            <div class="section-subtitle">
                Request activity for the last 7 days
            </div>

        </div>

        <div class="count-badge">
            Last 7 Days
        </div>

    </div>


    <div class="chart-area">

        <%
            int maxValue = 1;

            for(Integer value : chartValues) {

                if(value != null && value > maxValue) {
                    maxValue = value;
                }

            }

            for(int i = 0; i < chartDays.size(); i++) {

                int value = chartValues.get(i);

                int height = (value * 180) / maxValue;

                if(value > 0 && height < 8) {
                    height = 8;
                }
        %>

        <div class="bar-wrapper">

            <div class="bar-value">
                <%= value %>
            </div>

            <div class="bar"
                 style="height:<%= height %>px;">
            </div>

            <div class="bar-day">
                <%= chartDays.get(i) %>
            </div>

        </div>

        <%
            }
        %>

    </div>

</section>


<!-- =========================
     STATUS + INSIGHTS
========================= -->

<div class="two-column">


<!-- STATUS -->

<section class="section">

    <div class="section-header">

        <div>

            <div class="section-title">
                Request Status
            </div>

            <div class="section-subtitle">
                Current request distribution
            </div>

        </div>

    </div>


    <%
        int totalStatus =
            acceptedRequests +
            pendingRequests +
            rejectedRequests;

        int acceptedPercent = 0;
        int pendingPercent = 0;
        int rejectedPercent = 0;

        if(totalStatus > 0) {

            acceptedPercent =
                (acceptedRequests * 100) / totalStatus;

            pendingPercent =
                (pendingRequests * 100) / totalStatus;

            rejectedPercent =
                (rejectedRequests * 100) / totalStatus;
        }
    %>


    <div class="status-item">

        <div class="status-label">

            <span>Accepted</span>

            <span>
                <%= acceptedRequests %>
            </span>

        </div>

        <div class="progress">

            <div class="progress-fill accepted"
                 style="width:<%= acceptedPercent %>%;">
            </div>

        </div>

    </div>


    <div class="status-item">

        <div class="status-label">

            <span>Pending</span>

            <span>
                <%= pendingRequests %>
            </span>

        </div>

        <div class="progress">

            <div class="progress-fill pending"
                 style="width:<%= pendingPercent %>%;">
            </div>

        </div>

    </div>


    <div class="status-item">

        <div class="status-label">

            <span>Rejected</span>

            <span>
                <%= rejectedRequests %>
            </span>

        </div>

        <div class="progress">

            <div class="progress-fill rejected"
                 style="width:<%= rejectedPercent %>%;">
            </div>

        </div>

    </div>

</section>


<!-- SMART INSIGHTS -->

<section class="section">

    <div class="section-header">

        <div>

            <div class="section-title">
                Smart Insights
            </div>

            <div class="section-subtitle">
                Quick overview of your system
            </div>

        </div>

    </div>


    <div class="insights">

        <div class="insight">

            <div class="insight-icon">
                👥
            </div>

            <h4>
                User Network
            </h4>

            <p>
                <%= totalUsers %>
                users are registered in
                MedicineFinder.
            </p>

        </div>


        <div class="insight">

            <div class="insight-icon">
                💊
            </div>

            <h4>
                Medicine Coverage
            </h4>

            <p>
                <%= totalMedicines %>
                medicines are currently
                available.
            </p>

        </div>


        <div class="insight">

            <div class="insight-icon">
                📋
            </div>

            <h4>
                Request Activity
            </h4>

            <p>
                <%= totalRequests %>
                medicine requests have
                been recorded.
            </p>

        </div>

    </div>

</section>

</div>


<!-- =========================
     MOST REQUESTED MEDICINES
========================= -->

<section class="section">

    <div class="section-header">

        <div>

            <div class="section-title">
                Most Requested Medicines
            </div>

            <div class="section-subtitle">
                Top medicines based on user requests
            </div>

        </div>

    </div>


    <%
        if(medicineNames.size() == 0) {
    %>

        <div class="empty">
            No medicine request data available.
        </div>

    <%
        } else {
    %>

    <table class="data-table">

        <thead>

            <tr>

                <th>
                    Rank
                </th>

                <th>
                    Medicine Name
                </th>

                <th>
                    Requests
                </th>

            </tr>

        </thead>

        <tbody>

        <%
            for(int i = 0;
                i < medicineNames.size();
                i++) {
        %>

            <tr>

                <td>

                    <span class="rank">
                        <%= i + 1 %>
                    </span>

                </td>

                <td>
                    <%= medicineNames.get(i) %>
                </td>

                <td>

                    <span class="count-badge">
                        <%= medicineRequestCounts.get(i) %>
                        requests
                    </span>

                </td>

            </tr>

        <%
            }
        %>

        </tbody>

    </table>

    <%
        }
    %>

</section>


<!-- =========================
     TOP PHARMACIES
========================= -->

<section class="section">

    <div class="section-header">

        <div>

            <div class="section-title">
                Top Pharmacies
            </div>

            <div class="section-subtitle">
                Pharmacies with the highest medicine inventory
            </div>

        </div>

    </div>


    <%
        if(pharmacyNames.size() == 0) {
    %>

        <div class="empty">
            No pharmacy data available.
        </div>

    <%
        } else {
    %>

    <table class="data-table">

        <thead>

            <tr>

                <th>
                    Rank
                </th>

                <th>
                    Pharmacy Name
                </th>

                <th>
                    Medicines
                </th>

            </tr>

        </thead>

        <tbody>

        <%
            for(int i = 0;
                i < pharmacyNames.size();
                i++) {
        %>

            <tr>

                <td>

                    <span class="rank">
                        <%= i + 1 %>
                    </span>

                </td>

                <td>
                    <%= pharmacyNames.get(i) %>
                </td>

                <td>

                    <span class="count-badge">
                        <%= pharmacyMedicineCounts.get(i) %>
                        medicines
                    </span>

                </td>

            </tr>

        <%
            }
        %>

        </tbody>

    </table>

    <%
        }
    %>

</section>


</main>

</body>
</html>