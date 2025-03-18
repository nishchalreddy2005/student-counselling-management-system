package com.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/addMeterServlet")
public class AddMeterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String meterNumber = request.getParameter("meterNumber");
        int userId = getUserIdFromUsername(username);

        String message = null; // Variable to hold success or error message

        if (userId == -1) {
            message = "User not found. Please try again.";
            request.setAttribute("message", message);
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");

            // Insert meter details
            String sql = "INSERT INTO Meter (meter_number, user_id) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, meterNumber);
            pstmt.setInt(2, userId);
            int result = pstmt.executeUpdate();

            if (result > 0) {
                message = "Meter added successfully!";
            } else {
                message = "Failed to add meter. Please try again.";
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            message = "An error occurred. Please try again.";
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Set the message as a request attribute
        request.setAttribute("message", message);
        // Forward the request back to the form page
        request.getRequestDispatcher("addMeter.jsp").forward(request, response);
    }

    private int getUserIdFromUsername(String username) {
        int userId = -1;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");

            // Query to get user ID based on username
            String sql = "SELECT user_id FROM users WHERE username = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("user_id");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return userId;
    }
}
