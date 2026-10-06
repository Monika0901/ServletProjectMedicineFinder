package com.tka;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/userHome")
public class userHome extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/userLogin.jsp");
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/userHome.jsp");
    }
}