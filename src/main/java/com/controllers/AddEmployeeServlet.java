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

@WebServlet("/addEmployee")
public class AddEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String state = request.getParameter("state");
        String password = request.getParameter("password"); // Get the default password

        String jdbcURL = "jdbc:mysql://localhost:3306/electricity_billing";
        String jdbcUsername = "root";
        String jdbcPassword = "Monkey2016@"; // Update with your DB password

        String message = null; // Variable to hold success or error message

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            String sql = "INSERT INTO employee (username, email, state, password) VALUES (?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, username);
                statement.setString(2, email);
                statement.setString(3, state);
                statement.setString(4, password); // Insert the default password
                int result = statement.executeUpdate();
                
                if (result > 0) {
                    message = "Employee added successfully!";
                } else {
                    message = "Failed to add employee. Please try again.";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred. Please try again.";
        }

        // Set the message as a request attribute
        request.setAttribute("message", message);
        // Forward the request back to the same JSP page
        request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
    }
}
