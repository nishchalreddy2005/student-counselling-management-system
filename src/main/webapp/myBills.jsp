<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.PreparedStatement" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession currentSession = request.getSession(false);
    String username = null;
    if (currentSession != null) {
        username = (String) currentSession.getAttribute("username");
    }
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSet meterRs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");

        // Get user_id from the username
        String userSql = "SELECT user_id FROM users WHERE username = ?";
        pstmt = conn.prepareStatement(userSql);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            int userId = rs.getInt("user_id");

            // Get all meter_numbers for this user
            String meterSql = "SELECT meter_number FROM meter WHERE user_id = ?";
            pstmt = conn.prepareStatement(meterSql);
            pstmt.setInt(1, userId);
            meterRs = pstmt.executeQuery();

            // Display bill details
            if (meterRs.next()) {
    %>
                <h2>My Bills</h2>
                <table>
                    <thead>
                        <tr>
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
                    String meterNumber = meterRs.getString("meter_number");

                    // Get bill details for each meter_number
                    String billSql = "SELECT meter_number, units_consumed, reading_date, payment_status, state, amount FROM metereading WHERE meter_number = ?";
                    pstmt = conn.prepareStatement(billSql);
                    pstmt.setString(1, meterNumber);
                    ResultSet billRs = pstmt.executeQuery();

                    while (billRs.next()) {
    %>
                        <tr>
                            <td><%= billRs.getString("meter_number") %></td>
                            <td><%= billRs.getInt("units_consumed") %></td>
                            <td><%= billRs.getDate("reading_date") %></td>
                            <td><%= billRs.getString("payment_status") %></td>
                            <td><%= billRs.getString("state") %></td>
                            <td><%= billRs.getString("amount") %></td>
                        </tr>
    <%
                    }
                    billRs.close();
                } while (meterRs.next());
    %>
                    </tbody>
                </table>
    <%
            } else {
    %>
                <p>No meter details found.</p>
    <%
            }
        } else {
    %>
            <p>No user information found.</p>
    <%
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    %>
        <p>An error occurred while retrieving bill details: <%= e.getMessage() %></p>
    <%
    } finally {
        try {
            if (rs != null) rs.close();
            if (meterRs != null) meterRs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Bills</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f9;
    }
    h2 {
        color: #007bff;
        margin: 20px 0;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
        font-size: 16px;
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
        background-color: #f9f9f9;
    }
    tr:hover {
        background-color: #f1f1f1;
    }
    .container {
        padding: 20px;
        margin: 0 auto;
        max-width: 1200px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
</style>
</head>
<body>
    <div class="container">
        <!-- Content goes here -->
    </div>
</body>
</html>
