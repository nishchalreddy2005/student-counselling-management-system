<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Bills</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f4f4f9;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
        font-size: 18px;
        text-align: left;
    }
    th, td {
        padding: 12px;
        border: 1px solid #ddd;
    }
    th {
        background-color: #007bff;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .navbar {
        background-color: #007bff;
        color: white;
        padding: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .navbar .logout {
        text-decoration: none;
        color: white;
        background-color: #d9534f;
        padding: 10px 15px;
        border-radius: 5px;
    }
    .navbar .logout:hover {
        background-color: #c9302c;
    }
</style>
</head>
<body>
    

    <h2>List of Bills</h2>

    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");

            String sql = "SELECT reading_id, meter_number, units_consumed, reading_date, payment_status, state, amount FROM metereading";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            if (rs.next()) {
    %>
                <table>
                    <thead>
                        <tr>
                            <th>Reading ID</th>
                            <th>Meter Number</th>
                            <th>Units Consumed</th>
                            <th>Reading Date</th>
                            <th>Payment Status</th>
                            <th>Meter State</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody>
    <%
                do {
    %>
                    <tr>
                        <td><%= rs.getInt("reading_id") %></td>
                        <td><%= rs.getString("meter_number") %></td>
                        <td><%= rs.getInt("units_consumed") %></td>
                        <td><%= rs.getDate("reading_date") %></td>
                        <td><%= rs.getString("payment_status") %></td>
                        <td><%= rs.getString("state") %></td>
                        <td><%= rs.getString("amount") %></td>
                    </tr>
    <%
                } while (rs.next());
    %>
                    </tbody>
                </table>
    <%
            } else {
    %>
                <p>No bills found.</p>
    <%
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
    %>
            <p>An error occurred while retrieving bills: <%= e.getMessage() %></p>
    <%
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
