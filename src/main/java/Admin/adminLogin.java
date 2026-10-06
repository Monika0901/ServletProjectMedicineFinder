
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

@WebServlet("/adminLogin")
public class adminLogin extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String email =
                req.getParameter("email");

        String password =
                req.getParameter("password");


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
                    "SELECT admin_id, admin_name, email " +
                    "FROM admin " +
                    "WHERE email = ? AND password = ?";


            PreparedStatement ps =
                    c.prepareStatement(sql);


            ps.setString(1, email);
            ps.setString(2, password);


            ResultSet rs =
                    ps.executeQuery();


            if (rs.next()) {

                HttpSession session =
                        req.getSession();

                session.setAttribute(
                        "admin_id",
                        rs.getInt("admin_id")
                );

                session.setAttribute(
                        "admin_name",
                        rs.getString("admin_name")
                );

                session.setAttribute(
                        "admin_email",
                        rs.getString("email")
                );


                rs.close();
                ps.close();
                c.close();


                resp.sendRedirect(
                        "adminHome.jsp"
                );

            } else {

                rs.close();
                ps.close();
                c.close();

                resp.getWriter().println(
                        "Invalid Admin Email or Password"
                );
            }


        } catch (Exception e) {

            e.printStackTrace();

            resp.getWriter().println(
                    "Login failed: " +
                    e.getMessage()
            );
        }
    }
}

