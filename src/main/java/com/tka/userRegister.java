
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

@WebServlet("/userRegister")
public class userRegister extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("full_name");
        int age = Integer.parseInt(req.getParameter("age"));
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String mobile = req.getParameter("mobile");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        String pincode = req.getParameter("pincode");

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection c = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/medicinefinder",
                    "root",
                    "Password"
            );

            PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO users " +
                    "(full_name, age, email, password, mobile, address, city, pincode) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
            );

            ps.setString(1, name);
            ps.setInt(2, age);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, mobile);
            ps.setString(6, address);
            ps.setString(7, city);
            ps.setString(8, pincode);

            int check = ps.executeUpdate();

            ps.close();
            c.close();

            if (check > 0) {

                resp.sendRedirect(
                        req.getContextPath()
                        + "/userLogin.jsp?message=Registration%20Successful"
                );

            } else {

                resp.sendRedirect(
                        req.getContextPath()
                        + "/index.jsp?message=Registration%20Failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            resp.sendRedirect(
                    req.getContextPath()
                    + "/index.jsp?message=Registration%20Failed"
            );
        }
    }
}

