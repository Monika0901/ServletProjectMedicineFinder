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

@WebServlet("/updateMedicine")
public class updateMedicine extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String medicineIdValue = req.getParameter("medicine_id");
        String medicineName = req.getParameter("medicine_name");
        String category = req.getParameter("category");
        String manufacturer = req.getParameter("manufacturer");
        String priceValue = req.getParameter("price");
        String quantityValue = req.getParameter("quantity");
        String expiryDate = req.getParameter("expiry_date");

        try {

            int medicineId = Integer.parseInt(medicineIdValue);
            double price = Double.parseDouble(priceValue);
            int quantity = Integer.parseInt(quantityValue);

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection c = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/medicinefinder",
                    "root",
                    "Password"
            );

            PreparedStatement ps = c.prepareStatement(
                    "UPDATE medicine SET " +
                    "medicine_name = ?, " +
                    "category = ?, " +
                    "manufacturer = ?, " +
                    "price = ?, " +
                    "quantity = ?, " +
                    "expiry_date = ? " +
                    "WHERE medicine_id = ?"
            );

            ps.setString(1, medicineName);
            ps.setString(2, category);
            ps.setString(3, manufacturer);
            ps.setDouble(4, price);
            ps.setInt(5, quantity);
            ps.setString(6, expiryDate);
            ps.setInt(7, medicineId);

            int check = ps.executeUpdate();

            ps.close();
            c.close();

            if (check > 0) {

                resp.sendRedirect(
                        req.getContextPath()
                        + "/updateMedicine.jsp?message=Medicine%20Updated%20Successfully"
                );

            } else {

                resp.sendRedirect(
                        req.getContextPath()
                        + "/updateMedicine.jsp?message=Medicine%20Update%20Failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            resp.sendRedirect(
                    req.getContextPath()
                    + "/updateMedicine.jsp?message=Medicine%20Update%20Failed"
            );
        }
    }
}