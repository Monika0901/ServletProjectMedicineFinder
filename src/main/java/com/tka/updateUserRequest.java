package com.tka;

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

@WebServlet("/updateUserRequest")
public class updateUserRequest extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession();

        Object userIdObject =
                session.getAttribute("user_id");

        if (userIdObject == null) {

            resp.sendRedirect("userLogin.jsp");

            return;
        }

        int userId =
                (Integer) userIdObject;


        int requestId =
                Integer.parseInt(
                        req.getParameter("request_id")
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
                    "UPDATE medicine_request " +
                    "SET medicine_name = ?, " +
                    "quantity = ?, " +
                    "address = ?, " +
                    "phone = ? " +
                    "WHERE request_id = ? " +
                    "AND user_id = ?";


            PreparedStatement ps =
                    c.prepareStatement(sql);


            ps.setString(1, medicineName);

            ps.setInt(2, quantity);

            ps.setString(3, address);

            ps.setString(4, phone);

            ps.setInt(5, requestId);

            ps.setInt(6, userId);


            ps.executeUpdate();


            ps.close();

            c.close();


            resp.sendRedirect(
                    "requestStatus.jsp"
            );


        } catch (Exception e) {

            e.printStackTrace();

            resp.getWriter().println(
                    "Update failed: " +
                    e.getMessage()
            );
        }
    }
}