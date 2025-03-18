<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bill</title>
</head>
<body>
    <h2>Bill Details</h2>
    <% 
        int userId = (int) session.getAttribute("user_id");
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");
            String sql = "SELECT * FROM bills WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
    %>
    <table border="1">
        <tr>
            <th>Billing Date</th>
            <th>Units Consumed</th>
            <th>Amount Due</th>
        </tr>
        <tr>
            <td><%= rs.getDate("billing_date") %></td>
            <td><%= rs.getInt("units_consumed") %></td>
            <td><%= rs.getBigDecimal("amount_due") %></td>
        </tr>
    </table>
    <% 
            } else {
                out.println("No bill found for the user.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    %>
</body>
</html>
