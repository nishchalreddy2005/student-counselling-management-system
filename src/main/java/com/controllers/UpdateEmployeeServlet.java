package com.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateEmployee")
public class UpdateEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeId = request.getParameter("employee_id");
        String state = request.getParameter("state");

        String jdbcURL = "jdbc:mysql://localhost:3306/electricity_billing";
        String jdbcUsername = "root";
        String jdbcPassword = "Monkey2016@"; // Update with your DB password

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // Check if employee exists
            String checkSql = "SELECT COUNT(*) FROM employee WHERE employee_id = ?";
            statement = connection.prepareStatement(checkSql);
            statement.setString(1, employeeId);
            resultSet = statement.executeQuery();

            if (resultSet.next() && resultSet.getInt(1) > 0) {
                // Update employee state
                String updateSql = "UPDATE employee SET state = ? WHERE employee_id = ?";
                statement.close(); // Close the previous statement before creating a new one
                statement = connection.prepareStatement(updateSql);
                statement.setString(1, state);
                statement.setString(2, employeeId);
                int result = statement.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("updateEmployee.jsp?success=true");
                } else {
                    response.sendRedirect("updateEmployee.jsp?success=false");
                }
            } else {
                response.sendRedirect("updateEmployee.jsp?success=false&message=Employee ID does not exist.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("updateEmployee.jsp?success=false&message=An error occurred. Please try again.");
        } finally {
            // Close resources
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
