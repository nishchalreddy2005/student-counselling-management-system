package com.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddBillServlet")
public class AddBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String meterNumber = request.getParameter("meter_number");
        int unitsConsumed = Integer.parseInt(request.getParameter("units_consumed"));
        String readingDate = request.getParameter("reading_date");
        String state = request.getParameter("state");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Connection conn = null;
        PreparedStatement stmt = null;
        String message = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");

            String sql = "INSERT INTO metereading (meter_number, units_consumed, reading_date, state, amount) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, meterNumber);
            stmt.setInt(2, unitsConsumed);
            stmt.setDate(3, java.sql.Date.valueOf(readingDate));
            stmt.setString(4, state);
            stmt.setDouble(5, amount);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                message = "Bill added successfully!";
            } else {
                message = "Failed to add bill!";
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            message = "An error occurred: " + e.getMessage();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("message", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("addBill.jsp");
        dispatcher.forward(request, response);
    }
}
