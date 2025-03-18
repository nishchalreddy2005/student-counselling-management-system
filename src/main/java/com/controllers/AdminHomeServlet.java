package com.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/adminhome")
public class AdminHomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jdbcURL = "jdbc:mysql://localhost:3306/electricity_billing";
        String dbUser = "root";
        String dbPassword = "Monkey2016@";

        try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
            String employeeCountQuery = "SELECT COUNT(employee_id) FROM employee";
            String userCountQuery = "SELECT COUNT(user_id) FROM users";
            String billCountQuery = "SELECT COUNT(reading_id) FROM metereading";

            int employeeCount = getCount(connection, employeeCountQuery);
            int userCount = getCount(connection, userCountQuery);
            int billCount = getCount(connection, billCountQuery);

            request.setAttribute("employeeCount", employeeCount);
            request.setAttribute("userCount", userCount);
            request.setAttribute("billCount", billCount);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/adminhome.jsp").forward(request, response);
    }

    private int getCount(Connection connection, String query) throws Exception {
        try (PreparedStatement statement = connection.prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        }
        return 0;
    }
}
