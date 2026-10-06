
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

@WebServlet("/deleteAdminUser")
public class deleteAdminUser extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        // Check admin login
        HttpSession session = req.getSession(false);

        if (session == null ||
            session.getAttribute("admin_id") == null) {

            resp.sendRedirect("adminLogin.jsp");
            return;
        }

        // Get user ID
        String userIdValue =
                req.getParameter("user_id");

        if (userIdValue == null ||
            userIdValue.trim().isEmpty()) {

            resp.sendRedirect("adminHome.jsp");
            return;
        }

        int userId =
                Integer.parseInt(userIdValue);

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

            // Delete user
            String sql =
                    "DELETE FROM users " +
                    "WHERE user_id = ?";

            PreparedStatement ps =
                    c.prepareStatement(sql);

            ps.setInt(1, userId);

            int rows =
                    ps.executeUpdate();

            ps.close();
            c.close();

            // User successfully deleted
            if (rows > 0) {

                resp.sendRedirect(
                        req.getContextPath()
                        + "/adminHome.jsp"
                );

            } else {

                // User ID was not found
                resp.sendRedirect(
                        req.getContextPath()
                        + "/adminUsers.jsp"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            resp.setContentType("text/html");

            resp.getWriter().println(
                    "<h2>User Delete Failed</h2>"
            );

            resp.getWriter().println(
                    "<p>" + e.getMessage() + "</p>"
            );

            resp.getWriter().println(
                    "<a href='adminUsers.jsp'>Back to Users</a>"
            );
        }
    }
}
