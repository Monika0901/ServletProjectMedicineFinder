
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

@WebServlet("/deleteAdminMedicine")
public class deleteAdminMedicine extends HttpServlet {

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


        // Get medicine ID
        String medicineIdValue =
                req.getParameter("medicine_id");


        if (medicineIdValue == null ||
            medicineIdValue.trim().isEmpty()) {

            resp.sendRedirect("adminHome.jsp");
            return;
        }


        int medicineId =
                Integer.parseInt(medicineIdValue);


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


            // Delete medicine
            String sql =
                    "DELETE FROM medicine " +
                    "WHERE medicine_id = ?";


            PreparedStatement ps =
                    c.prepareStatement(sql);


            ps.setInt(1, medicineId);


            int rows =
                    ps.executeUpdate();


            ps.close();

            c.close();


            // Medicine deleted
            if (rows > 0) {

                resp.sendRedirect(
                    req.getContextPath()
                    + "/adminHome.jsp"
                );

            }

            // Medicine not found
            else {

                resp.sendRedirect(
                    req.getContextPath()
                    + "/adminMedicines.jsp"
                );

            }


        }

        catch (Exception e) {

            e.printStackTrace();


            resp.setContentType("text/html");


            resp.getWriter().println(
                "<h2>Medicine Delete Failed</h2>"
            );


            resp.getWriter().println(
                "<p>" + e.getMessage() + "</p>"
            );


            resp.getWriter().println(
                "<a href='adminMedicines.jsp'>Back to Medicines</a>"
            );

        }

    }

}

