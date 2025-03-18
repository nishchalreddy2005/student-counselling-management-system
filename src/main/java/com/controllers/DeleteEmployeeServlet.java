package com.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteEmployee")
public class DeleteEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeId = request.getParameter("employee_id");

        String jdbcURL = "jdbc:mysql://localhost:3306/electricity_billing";
        String jdbcUsername = "root";
        String jdbcPassword = "Monkey2016@"; // Update with your DB password

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            String sql = "DELETE FROM employee WHERE employee_id = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, employeeId);
            int result = statement.executeUpdate();

            if (result > 0) {
                response.sendRedirect("deleteEmployee.jsp?success=true");
            } else {
                response.sendRedirect("deleteEmployee.jsp?success=false&message=Employee ID does not exist.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("deleteEmployee.jsp?success=false&message=An error occurred. Please try again.");
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
