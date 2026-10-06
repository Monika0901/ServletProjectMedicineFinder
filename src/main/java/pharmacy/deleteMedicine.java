package pharmacy;

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

@WebServlet("/deleteMedicine")
public class deleteMedicine extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Integer pharmacyId = (Integer) session.getAttribute("pharmacy_id");

        if (pharmacyId == null) {
            resp.sendRedirect(req.getContextPath() + "/pharmacyLogin.jsp");
            return;
        }

        String medicineIdValue = req.getParameter("medicine_id");

        try {

            int medicineId = Integer.parseInt(medicineIdValue);

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection c = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/medicinefinder",
                    "root",
                    "Password"
            );

            PreparedStatement ps = c.prepareStatement(
                    "DELETE FROM medicine " +
                    "WHERE medicine_id = ? AND pharmacy_id = ?"
            );

            ps.setInt(1, medicineId);
            ps.setInt(2, pharmacyId);

            int check = ps.executeUpdate();

            ps.close();
            c.close();

            if (check > 0) {

                resp.sendRedirect(
                        req.getContextPath()
                        + "/updateMedicine.jsp?message=Medicine%20Deleted%20Successfully"
                );

            } else {

                resp.sendRedirect(
                        req.getContextPath()
                        + "/updateMedicine.jsp?message=Medicine%20Delete%20Failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            resp.sendRedirect(
                    req.getContextPath()
                    + "/updateMedicine.jsp?message=Medicine%20Delete%20Failed"
            );
        }
    }
}
