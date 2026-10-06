
package com.tka;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/medicineRequest")
public class medicineRequest extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Object userIdObject =
                session.getAttribute("user_id");

        if (userIdObject == null) {

            resp.sendRedirect("userLogin.jsp");

            return;
        }

        int userId =
                (Integer) userIdObject;

        String userName =
                req.getParameter("user_name");

        int age =
                Integer.parseInt(
                        req.getParameter("age")
                );

        String medicineName =
                req.getParameter("medicine_name");

        int quantity =
                Integer.parseInt(
                        req.getParameter("quantity")
                );

        String address =
                req.getParameter("address");

        String phone =
                req.getParameter("phone");


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
                    "INSERT INTO medicine_request " +
                    "(user_id, user_name, age, medicine_name, " +
                    "quantity, address, phone, request_status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";


            PreparedStatement ps =
                    c.prepareStatement(
                            sql,
                            Statement.RETURN_GENERATED_KEYS
                    );


            ps.setInt(1, userId);

            ps.setString(2, userName);

            ps.setInt(3, age);

            ps.setString(4, medicineName);

            ps.setInt(5, quantity);

            ps.setString(6, address);

            ps.setString(7, phone);

            ps.setString(8, "Pending");


            ps.executeUpdate();


            ResultSet rs =
                    ps.getGeneratedKeys();

            int requestId = 0;

            if (rs.next()) {

                requestId =
                        rs.getInt(1);
            }


            rs.close();

            ps.close();

            c.close();


            if (requestId > 0) {

                resp.sendRedirect(
                        "request.jsp?request_id="
                        + requestId
                );

            } else {

                resp.getWriter().println(
                        "Request saved, but Request ID was not generated."
                );
            }


        } catch (Exception e) {

            e.printStackTrace();

            resp.getWriter().println(
                    "Request failed: "
                    + e.getMessage()
            );
        }
    }
}

