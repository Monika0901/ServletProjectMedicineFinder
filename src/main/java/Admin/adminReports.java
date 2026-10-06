package Admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminReports")
public class adminReports extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String URL =
            "jdbc:mysql://localhost:3306/medicinefinder";

    private static final String USER = "root";

    private static final String PASSWORD = "Password";

    @Override
    protected void doGet(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        // ==============================
        // ADMIN LOGIN CHECK
        // ==============================

        HttpSession session = req.getSession(false);

        if (session == null ||
            session.getAttribute("admin_id") == null) {

            resp.sendRedirect("adminLogin.jsp");
            return;
        }

        // ==============================
        // DATABASE CONNECTION
        // ==============================

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection c = DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );

            // ==============================
            // 1. TOTAL USERS
            // ==============================

            int totalUsers = 0;

            String sqlUsers =
                    "SELECT COUNT(*) FROM users";

            PreparedStatement psUsers =
                    c.prepareStatement(sqlUsers);

            ResultSet rsUsers =
                    psUsers.executeQuery();

            if (rsUsers.next()) {
                totalUsers = rsUsers.getInt(1);
            }

            rsUsers.close();
            psUsers.close();


            // ==============================
            // 2. TOTAL PHARMACIES
            // ==============================

            int totalPharmacies = 0;

            String sqlPharmacies =
                    "SELECT COUNT(*) FROM pharmacy";

            PreparedStatement psPharmacies =
                    c.prepareStatement(sqlPharmacies);

            ResultSet rsPharmacies =
                    psPharmacies.executeQuery();

            if (rsPharmacies.next()) {
                totalPharmacies = rsPharmacies.getInt(1);
            }

            rsPharmacies.close();
            psPharmacies.close();


            // ==============================
            // 3. TOTAL MEDICINES
            // ==============================

            int totalMedicines = 0;

            String sqlMedicines =
                    "SELECT COUNT(*) FROM medicine";

            PreparedStatement psMedicines =
                    c.prepareStatement(sqlMedicines);

            ResultSet rsMedicines =
                    psMedicines.executeQuery();

            if (rsMedicines.next()) {
                totalMedicines = rsMedicines.getInt(1);
            }

            rsMedicines.close();
            psMedicines.close();


            // ==============================
            // 4. TOTAL REQUESTS
            // ==============================

            int totalRequests = 0;

            String sqlRequests =
                    "SELECT COUNT(*) FROM medicine_request";

            PreparedStatement psRequests =
                    c.prepareStatement(sqlRequests);

            ResultSet rsRequests =
                    psRequests.executeQuery();

            if (rsRequests.next()) {
                totalRequests = rsRequests.getInt(1);
            }

            rsRequests.close();
            psRequests.close();


            // ==============================
            // 5. ACCEPTED REQUESTS
            // ==============================

            int acceptedRequests = 0;

            String sqlAccepted =
                    "SELECT COUNT(*) FROM medicine_request " +
                    "WHERE request_status = 'Accepted'";

            PreparedStatement psAccepted =
                    c.prepareStatement(sqlAccepted);

            ResultSet rsAccepted =
                    psAccepted.executeQuery();

            if (rsAccepted.next()) {
                acceptedRequests = rsAccepted.getInt(1);
            }

            rsAccepted.close();
            psAccepted.close();


            // ==============================
            // 6. PENDING REQUESTS
            // ==============================

            int pendingRequests = 0;

            String sqlPending =
                    "SELECT COUNT(*) FROM medicine_request " +
                    "WHERE request_status = 'Pending'";

            PreparedStatement psPending =
                    c.prepareStatement(sqlPending);

            ResultSet rsPending =
                    psPending.executeQuery();

            if (rsPending.next()) {
                pendingRequests = rsPending.getInt(1);
            }

            rsPending.close();
            psPending.close();


            // ==============================
            // 7. REJECTED REQUESTS
            // ==============================

            int rejectedRequests = 0;

            String sqlRejected =
                    "SELECT COUNT(*) FROM medicine_request " +
                    "WHERE request_status = 'Rejected'";

            PreparedStatement psRejected =
                    c.prepareStatement(sqlRejected);

            ResultSet rsRejected =
                    psRejected.executeQuery();

            if (rsRejected.next()) {
                rejectedRequests = rsRejected.getInt(1);
            }

            rsRejected.close();
            psRejected.close();


            // ==============================
            // 8. LAST 7 DAYS REQUEST ACTIVITY
            // ==============================

            Map<LocalDate, Integer> dailyRequests =
                    new HashMap<>();

            LocalDate today = LocalDate.now();

            // Create last 7 days with default 0
            for (int i = 6; i >= 0; i--) {

                LocalDate date =
                        today.minusDays(i);

                dailyRequests.put(date, 0);
            }


            
            String sqlDaily =
                    "SELECT DATE(requested_at) AS request_date, " +
                    "COUNT(*) AS total " +
                    "FROM medicine_request " +
                    "WHERE requested_at >= CURDATE() - INTERVAL 6 DAY " +
                    "GROUP BY DATE(requested_at) " +
                    "ORDER BY request_date";

            PreparedStatement psDaily =
                    c.prepareStatement(sqlDaily);

            ResultSet rsDaily =
                    psDaily.executeQuery();

            while (rsDaily.next()) {

                java.sql.Date sqlDate =
                        rsDaily.getDate("request_date");

                if (sqlDate != null) {

                    LocalDate date =
                            sqlDate.toLocalDate();

                    int total =
                            rsDaily.getInt("total");

                    dailyRequests.put(date, total);
                }
            }

            rsDaily.close();
            psDaily.close();


            // ==============================
            // CHART DATA
            // ==============================

            List<String> chartDays =
                    new ArrayList<>();

            List<Integer> chartValues =
                    new ArrayList<>();

            DateTimeFormatter formatter =
                    DateTimeFormatter.ofPattern("EEE");

            for (int i = 6; i >= 0; i--) {

                LocalDate date =
                        today.minusDays(i);

                chartDays.add(
                        date.format(formatter)
                );

                chartValues.add(
                        dailyRequests.getOrDefault(date, 0)
                );
            }


            // ==============================
            // 9. MOST REQUESTED MEDICINES
            // ==============================

            List<String> medicineNames =
                    new ArrayList<>();

            List<Integer> medicineRequestCounts =
                    new ArrayList<>();

            String sqlMostRequested =
                    "SELECT medicine_name, COUNT(*) AS total_requests " +
                    "FROM medicine_request " +
                    "GROUP BY medicine_name " +
                    "ORDER BY total_requests DESC " +
                    "LIMIT 5";

            PreparedStatement psMostRequested =
                    c.prepareStatement(sqlMostRequested);

            ResultSet rsMostRequested =
                    psMostRequested.executeQuery();

            while (rsMostRequested.next()) {

                medicineNames.add(
                        rsMostRequested.getString("medicine_name")
                );

                medicineRequestCounts.add(
                        rsMostRequested.getInt("total_requests")
                );
            }

            rsMostRequested.close();
            psMostRequested.close();


            // ==============================
            // 10. TOP PHARMACIES
            // ==============================

            List<String> pharmacyNames =
                    new ArrayList<>();

            List<Integer> pharmacyMedicineCounts =
                    new ArrayList<>();

            String sqlTopPharmacies =
                    "SELECT p.pharmacy_name, " +
                    "COUNT(m.medicine_id) AS medicine_count " +
                    "FROM pharmacy p " +
                    "LEFT JOIN medicine m " +
                    "ON p.pharmacy_id = m.pharmacy_id " +
                    "GROUP BY p.pharmacy_id, p.pharmacy_name " +
                    "ORDER BY medicine_count DESC " +
                    "LIMIT 5";

            PreparedStatement psTopPharmacies =
                    c.prepareStatement(sqlTopPharmacies);

            ResultSet rsTopPharmacies =
                    psTopPharmacies.executeQuery();

            while (rsTopPharmacies.next()) {

                pharmacyNames.add(
                        rsTopPharmacies.getString("pharmacy_name")
                );

                pharmacyMedicineCounts.add(
                        rsTopPharmacies.getInt("medicine_count")
                );
            }

            rsTopPharmacies.close();
            psTopPharmacies.close();


            // ==============================
            // DEBUG OUTPUT
            // ==============================

            System.out.println(
                    "========== MEDICINE FINDER REPORT =========="
            );

            System.out.println(
                    "Total Users       = " + totalUsers
            );

            System.out.println(
                    "Total Pharmacies  = " + totalPharmacies
            );

            System.out.println(
                    "Total Medicines   = " + totalMedicines
            );

            System.out.println(
                    "Total Requests    = " + totalRequests
            );

            System.out.println(
                    "Accepted Requests = " + acceptedRequests
            );

            System.out.println(
                    "Pending Requests  = " + pendingRequests
            );

            System.out.println(
                    "Rejected Requests = " + rejectedRequests
            );

            System.out.println(
                    "Chart Days        = " + chartDays
            );

            System.out.println(
                    "Chart Values      = " + chartValues
            );

            System.out.println(
                    "Medicines         = " + medicineNames
            );

            System.out.println(
                    "Pharmacies        = " + pharmacyNames
            );

            System.out.println(
                    "============================================"
            );


            // ==============================
            // SEND DATA TO JSP
            // ==============================

            req.setAttribute(
                    "totalUsers",
                    totalUsers
            );

            req.setAttribute(
                    "totalPharmacies",
                    totalPharmacies
            );

            req.setAttribute(
                    "totalMedicines",
                    totalMedicines
            );

            req.setAttribute(
                    "totalRequests",
                    totalRequests
            );

            req.setAttribute(
                    "acceptedRequests",
                    acceptedRequests
            );

            req.setAttribute(
                    "pendingRequests",
                    pendingRequests
            );

            req.setAttribute(
                    "rejectedRequests",
                    rejectedRequests
            );

            req.setAttribute(
                    "chartDays",
                    chartDays
            );

            req.setAttribute(
                    "chartValues",
                    chartValues
            );

            req.setAttribute(
                    "medicineNames",
                    medicineNames
            );

            req.setAttribute(
                    "medicineRequestCounts",
                    medicineRequestCounts
            );

            req.setAttribute(
                    "pharmacyNames",
                    pharmacyNames
            );

            req.setAttribute(
                    "pharmacyMedicineCounts",
                    pharmacyMedicineCounts
            );


            // ==============================
            // OPEN REPORT PAGE
            // ==============================

            req.getRequestDispatcher(
                    "/adminReports.jsp"
            ).forward(req, resp);


            // ==============================
            // CLOSE CONNECTION
            // ==============================

            c.close();

        } catch (Exception e) {

            e.printStackTrace();

            resp.setContentType("text/html");

            resp.getWriter().println(
                    "<h2>Reports Error</h2>"
            );

            resp.getWriter().println(
                    "<p>" + e.getMessage() + "</p>"
            );
        }
    }
}