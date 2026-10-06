
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

@WebServlet("/addMedicine")
public class addMedicine extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Integer pharmacyId = (Integer) session.getAttribute("pharmacy_id");

        if (pharmacyId == null) {
            resp.sendRedirect(req.getContextPath() + "/pharmacyLogin.jsp");
            return;
        }

        String medicineName = req.getParameter("medicine_name");
        String category = req.getParameter("category");
        String manufacturer = req.getParameter("manufacturer");
        double price = Double.parseDouble(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String expiryDate = req.getParameter("expiry_date");

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection c = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/medicinefinder",
                    "root",
                    "Password"
            );

            PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO medicine " +
                    "(pharmacy_id, medicine_name, category, manufacturer, price, quantity, expiry_date) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)"
            );

            ps.setInt(1, pharmacyId);
            ps.setString(2, medicineName);
            ps.setString(3, category);
            ps.setString(4, manufacturer);
            ps.setDouble(5, price);
            ps.setInt(6, quantity);
            ps.setString(7, expiryDate);

            int check = ps.executeUpdate();

            if (check > 0) {
                resp.sendRedirect(
                    req.getContextPath() +
                    "/addMedicine.jsp?message=Medicine%20Added%20Successfully"
                );
            } else {
                resp.sendRedirect(
                    req.getContextPath() +
                    "/addMedicine.jsp?message=Medicine%20Not%20Added"
                );
            }

            ps.close();
            c.close();

        } catch (Exception e) {

            e.printStackTrace();

            resp.sendRedirect(
                req.getContextPath() +
                "/addMedicine.jsp?message=Medicine%20Not%20Added"
            );
        }
    }
}

