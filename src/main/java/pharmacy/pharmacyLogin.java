
package pharmacy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/pharmacyLogin")
public class pharmacyLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection c = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/medicinefinder",
                    "root",
                    "Password"
            );

            PreparedStatement ps = c.prepareStatement(
                    "SELECT * FROM pharmacy WHERE email = ? AND password = ?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session = req.getSession();

                session.setAttribute("pharmacy_id",
                        rs.getInt("pharmacy_id"));

                session.setAttribute("owner_name",
                        rs.getString("owner_name"));

                session.setAttribute("pharmacy_name",
                        rs.getString("pharmacy_name"));

                session.setAttribute("email",
                        rs.getString("email"));

                resp.sendRedirect(
                        req.getContextPath() + "/pharmacyHome.jsp"
                );

            } else {

                resp.sendRedirect(
                        req.getContextPath()
                        + "/index.jsp?message=Login%20Failed"
                );
            }

            rs.close();
            ps.close();
            c.close();

        } catch (Exception e) {

            e.printStackTrace();

            resp.sendRedirect(
                    req.getContextPath()
                    + "/index.jsp?message=Login%20Failed"
            );
        }
    }
}

