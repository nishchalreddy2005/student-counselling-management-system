package com.controllers;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.models.Employee;

@WebServlet("/viewEmployees")
public class ViewEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Employee> employees = new ArrayList<>();
        String jdbcURL = "jdbc:mysql://localhost:3306/electricity_billing";
        String jdbcUsername = "root";
        String jdbcPassword = "Monkey2016@"; // Update with your DB password

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery("SELECT employee_id, username, email, state FROM employee")) {

            while (resultSet.next()) {
                int employeeId = resultSet.getInt("employee_id");
                String username = resultSet.getString("username");
                String email = resultSet.getString("email");
                String state = resultSet.getString("state");

                Employee employee = new Employee(employeeId, username, email, state);
                employees.add(employee);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("employees", employees);
        request.getRequestDispatcher("viewEmployee.jsp").forward(request, response);
    }
}
