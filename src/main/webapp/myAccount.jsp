<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.PreparedStatement, javax.servlet.http.HttpSession" %>
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Account</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f4f4f9;
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
    h2 {
        color: #007bff;
        margin-bottom: 20px;
    }
    .account-info {
        max-width: 600px;
        margin: 0 auto;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }
    .account-info table {
        width: 100%;
        border-collapse: collapse;
        font-size: 18px;
        text-align: left;
    }
    .account-info th, .account-info td {
        padding: 12px;
        border: 1px solid #ddd;
    }
    .account-info th {
        background-color: #007bff;
        color: white;
    }
    .account-info tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .account-info tr {
        display: flex;
        flex-direction: column;
        margin-bottom: 15px;
    }
    .account-info td {
        border: none;
        padding: 10px;
    }
    .account-info td::before {
        content: attr(data-label);
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
        color: #007bff;
    }
</style>
</head>
<body>
    
    <div class="account-info">
        <h2>My Information</h2>

        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");

                String sql = "SELECT user_id, username, email, state, full_name, phone_number FROM users WHERE username = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();

                if (rs.next()) {
        %>
            <table>
                <tbody>
                    <tr>
                        <td data-label="User ID"><%= rs.getInt("user_id") %></td>
                    </tr>
                    <tr>
                        <td data-label="Username"><%= rs.getString("username") %></td>
                    </tr>
                    <tr>
                        <td data-label="Email"><%= rs.getString("email") %></td>
                    </tr>
                    <tr>
                        <td data-label="State"><%= rs.getString("state") %></td>
                    </tr>
                    <tr>
                        <td data-label="Full Name"><%= rs.getString("full_name") %></td>
                    </tr>
                    <tr>
                        <td data-label="Phone Number"><%= rs.getString("phone_number") %></td>
                    </tr>
                </tbody>
            </table>
        <%
                } else {
        %>
            <p>No user information found.</p>
        <%
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
        %>
            <p>An error occurred while retrieving user information: <%= e.getMessage() %></p>
        <%
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
