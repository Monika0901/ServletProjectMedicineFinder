
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

@WebServlet("/deleteAdminRequest")
public class deleteAdminRequest extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Check admin login
        if (session == null ||
            session.getAttribute("admin_id") == null) {

            resp.sendRedirect("adminLogin.jsp");
            return;
        }

        // Get request ID
        String requestIdValue = req.getParameter("request_id");

        if (requestIdValue == null ||
            requestIdValue.trim().isEmpty()) {

            resp.sendRedirect("adminRequests.jsp");
            return;
        }

        int requestId = Integer.parseInt(requestIdValue);

        try {

            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Database connection
            Connection c = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/medicinefinder",
                    "root",
                    "Password"
            );

            // Delete request
            String sql =
                    "DELETE FROM medicine_request " +
                    "WHERE request_id = ?";

            PreparedStatement ps = c.prepareStatement(sql);

            ps.setInt(1, requestId);

            int rows = ps.executeUpdate();

            ps.close();
            c.close();

            // After successful delete → Admin Home
            if (rows > 0) {

                resp.sendRedirect(
                        req.getContextPath() + "/adminHome.jsp"
                );

            } else {

                resp.sendRedirect(
                        req.getContextPath() + "/adminRequests.jsp"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            resp.setContentType("text/html");

            resp.getWriter().println(
                    "<h2>Request Delete Failed</h2>"
            );

            resp.getWriter().println(
                    "<p>" + e.getMessage() + "</p>"
            );

            resp.getWriter().println(
                    "<a href='adminRequests.jsp'>Back to Requests</a>"
            );
        }
    }
}

