
package Admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/deleteAdminPharmacy")
public class deleteAdminPharmacy extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        // Check admin login
        HttpSession session =
                req.getSession(false);

        if (session == null ||
            session.getAttribute("admin_id") == null) {

            resp.sendRedirect("adminLogin.jsp");
            return;
        }

        // Get pharmacy ID
        String pharmacyIdValue =
                req.getParameter("pharmacy_id");

        if (pharmacyIdValue == null ||
            pharmacyIdValue.trim().isEmpty()) {

            resp.sendRedirect("adminHome.jsp");
            return;
        }

        int pharmacyId =
                Integer.parseInt(pharmacyIdValue);

        try {

            // Load MySQL driver
            Class.forName(
                    "com.mysql.cj.jdbc.Driver"
            );

            // Database connection
            Connection c =
                    DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/medicinefinder",
                        "root",
                        "Password"
                    );

            // Delete pharmacy
            String sql =
                    "DELETE FROM pharmacy " +
                    "WHERE pharmacy_id = ?";

            PreparedStatement ps =
                    c.prepareStatement(sql);

            ps.setInt(1, pharmacyId);

            int rows =
                    ps.executeUpdate();

            ps.close();
            c.close();


            // Successfully deleted
            if (rows > 0) {

                resp.sendRedirect(
                    req.getContextPath()
                    + "/adminHome.jsp"
                );

            } else {

                // Pharmacy not found
                resp.sendRedirect(
                    req.getContextPath()
                    + "/adminPharmacies.jsp"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            resp.setContentType("text/html");

            resp.getWriter().println(
                "<h2>Pharmacy Delete Failed</h2>"
            );

            resp.getWriter().println(
                "<p>" + e.getMessage() + "</p>"
            );

            resp.getWriter().println(
                "<a href='adminPharmacies.jsp'>Back to Pharmacies</a>"
            );
        }
    }
}

