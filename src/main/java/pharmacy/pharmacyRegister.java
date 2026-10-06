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

@WebServlet("/pharmacyRegister")
public class pharmacyRegister extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String ownerName = req.getParameter("owner_name");
        String pharmacyName = req.getParameter("pharmacy_name");
        String email = req.getParameter("email");
        String mobile = req.getParameter("mobile");
        String password = req.getParameter("password");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        String pincode = req.getParameter("pincode");

        double latitude = Double.parseDouble(req.getParameter("latitude"));
        double longitude = Double.parseDouble(req.getParameter("longitude"));

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection c = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/medicinefinder",
                    "root",
                    "Password"
            );

            PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO pharmacy " +
                    "(owner_name, pharmacy_name, email, mobile, password, address, city, pincode, latitude, longitude) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            );

            ps.setString(1, ownerName);
            ps.setString(2, pharmacyName);
            ps.setString(3, email);
            ps.setString(4, mobile);
            ps.setString(5, password);
            ps.setString(6, address);
            ps.setString(7, city);
            ps.setString(8, pincode);
            ps.setDouble(9, latitude);
            ps.setDouble(10, longitude);

            int check = ps.executeUpdate();

            if (check > 0) {

                resp.sendRedirect(
                        req.getContextPath()
                        + "/pharmacyLogin.jsp?message=Registration%20Successful"
                );

            } else {

                resp.sendRedirect(
                        req.getContextPath()
                        + "/index.jsp?message=Registration%20Failed"
                );
            }

            ps.close();
            c.close();

        } catch (Exception e) {

            e.printStackTrace();

            resp.sendRedirect(
                    req.getContextPath()
                    + "/index.jsp?message=Registration%20Failed"
            );
        }
    }
}