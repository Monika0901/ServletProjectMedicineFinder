
package Admin;

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

@WebServlet("/adminUsers")
public class adminUsers extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession(false);

        // Check admin login
        if (session == null ||
            session.getAttribute("admin_id") == null) {

            resp.sendRedirect(
                    "adminLogin.jsp"
            );

            return;
        }

        try {

            Class.forName(
                    "com.mysql.cj.jdbc.Driver"
            );

            Connection c =
                    DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/medicinefinder",
                            "root",
                            "Password"
                    );

            String sql =
                    "SELECT user_id, full_name, age, " +
                    "email, mobile, address, city, " +
                    "pincode, created_at " +
                    "FROM users " +
                    "ORDER BY user_id DESC";

            PreparedStatement ps =
                    c.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            req.setAttribute(
                    "userResult",
                    rs
            );

            // Forward to JSP
            req.getRequestDispatcher(
                    "adminUsers.jsp"
            ).forward(req, resp);

        } catch (Exception e) {

            e.printStackTrace();

            resp.getWriter().println(
                    "Unable to load users: "
                    + e.getMessage()
            );
        }
    }
}

