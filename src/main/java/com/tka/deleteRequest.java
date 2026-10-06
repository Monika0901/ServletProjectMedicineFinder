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

@WebServlet("/deleteRequest")
public class deleteRequest extends HttpServlet {

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
                    "DELETE FROM medicine_request " +
                    "WHERE request_id = ? " +
                    "AND user_id = ?";


            PreparedStatement ps =
                    c.prepareStatement(sql);


            ps.setInt(1, requestId);

            ps.setInt(2, userId);


            ps.executeUpdate();


            ps.close();

            c.close();


            resp.sendRedirect(
                    "requestStatus.jsp"
            );


        } catch (Exception e) {

            e.printStackTrace();

            resp.getWriter().println(
                    "Delete failed: " +
                    e.getMessage()
            );
        }
    }
}