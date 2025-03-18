<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Employee</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f2f5;
        margin: 0;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    h2 {
        color: #333;
        margin-bottom: 20px;
    }
    .container {
        width: 100%;
        max-width: 1200px;
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    table, th, td {
        border: 1px solid #ddd;
    }
    th, td {
        padding: 12px;
        text-align: left;
    }
    th {
        background-color: #007bff;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    tr:hover {
        background-color: #e9f5ff;
    }
    .button {
        background-color: #d9534f;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        text-align: center;
        text-decoration: none;
    }
    .button:hover {
        background-color: #c9302c;
    }
    form {
        margin: 0;
    }
</style>
</head>
<body>
    <div class="container">
        <h2>Delete Employee</h2>
        <table>
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>State</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String jdbcURL = "jdbc:mysql://localhost:3306/electricity_billing";
                    String jdbcUsername = "root";
                    String jdbcPassword = "Monkey2016@"; // Update with your DB password
                    Connection connection = null;
                    PreparedStatement statement = null;
                    ResultSet resultSet = null;

                    try {
                        connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                        String sql = "SELECT employee_id, username, email, state FROM employee";
                        statement = connection.prepareStatement(sql);
                        resultSet = statement.executeQuery();

                        while (resultSet.next()) {
                            String employeeId = resultSet.getString("employee_id");
                            String username = resultSet.getString("username");
                            String email = resultSet.getString("email");
                            String state = resultSet.getString("state");
                %>
                <tr>
                    <td><%= employeeId %></td>
                    <td><%= username %></td>
                    <td><%= email %></td>
                    <td><%= state %></td>
                    <td>
                        <form action="deleteEmployee" method="post" style="display:inline;">
                            <input type="hidden" name="employee_id" value="<%= employeeId %>">
                            <input type="submit" class="button" value="Delete">
                        </form>
                    </td>
                </tr>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (resultSet != null) resultSet.close();
                            if (statement != null) statement.close();
                            if (connection != null) connection.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
