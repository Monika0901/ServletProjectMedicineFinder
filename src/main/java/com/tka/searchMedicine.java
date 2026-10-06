package com.tka;

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

@WebServlet("/searchMedicine")
public class searchMedicine extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/userLogin.jsp");
            return;
        }

        String medicineName = req.getParameter("medicine_name");

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection c = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/medicinefinder",
                    "root",
                    "Password"
            );

            PreparedStatement ps = c.prepareStatement(
                    "SELECT m.medicine_id, " +
                    "m.pharmacy_id, " +
                    "m.medicine_name, " +
                    "m.category, " +
                    "m.manufacturer, " +
                    "m.price, " +
                    "m.quantity, " +
                    "m.expiry_date, " +
                    "p.pharmacy_name, " +
                    "p.address, " +
                    "p.city, " +
                    "p.pincode, " +
                    "p.latitude, " +
                    "p.longitude " +
                    "FROM medicine m " +
                    "JOIN pharmacy p " +
                    "ON m.pharmacy_id = p.pharmacy_id " +
                    "WHERE m.medicine_name LIKE ? " +
                    "AND m.quantity > 0"
            );

            ps.setString(1, "%" + medicineName + "%");

            ResultSet rs = ps.executeQuery();

            req.setAttribute("medicineName", medicineName);
            req.setAttribute("resultSet", rs);

            req.getRequestDispatcher("/medicineResults.jsp")
               .forward(req, resp);

        } catch (Exception e) {

            e.printStackTrace();

            resp.sendRedirect(
                    req.getContextPath()
                    + "/searchMedicine.jsp?message=Search%20Failed"
            );
        }
    }
}