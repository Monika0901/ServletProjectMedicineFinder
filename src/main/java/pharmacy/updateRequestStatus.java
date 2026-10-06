
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

@WebServlet("/updateRequestStatus")
public class updateRequestStatus extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Object pharmacyIdObject =
                session.getAttribute("pharmacy_id");

        if (pharmacyIdObject == null) {

            resp.sendRedirect("pharmacyLogin.jsp");

            return;
        }

        String requestIdParameter =
                req.getParameter("request_id");

        String status =
                req.getParameter("status");

        if (requestIdParameter == null ||
            status == null) {

            resp.sendRedirect("pharmacyRequests.jsp");

            return;
        }

        int requestId =
                Integer.parseInt(requestIdParameter);

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
                    "UPDATE medicine_request " +
                    "SET request_status = ? " +
                    "WHERE request_id = ?";

            PreparedStatement ps =
                    c.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, requestId);

            int rows =
                    ps.executeUpdate();

            ps.close();
            c.close();

            if (rows > 0) {

                resp.sendRedirect(
                        "pharmacyRequests.jsp"
                );

            } else {

                resp.getWriter().println(
                        "Request not found"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            resp.getWriter().println(
                    "Status update failed: "
                    + e.getMessage()
            );
        }
    }
}

