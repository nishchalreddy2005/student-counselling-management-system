<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<%
    String readingId = request.getParameter("reading_id");
    String meterNumber = request.getParameter("meter_number");
    String unitsConsumed = request.getParameter("units_consumed");
    String readingDate = request.getParameter("reading_date");
    String paymentStatus = request.getParameter("payment_status");
    String state = request.getParameter("state");
    String amount = request.getParameter("amount");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the database connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");

        // SQL query to update payment status using reading_id
        String updateSql = "UPDATE metereading SET payment_status = 'Paid' WHERE reading_id = ?";
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setInt(1, Integer.parseInt(readingId));
        pstmt.executeUpdate();

        // Redirect to a confirmation page or back to the bills page
        response.sendRedirect("payBill.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        // Handle error and possibly redirect to an error page
        response.sendRedirect("error.jsp");
    } finally {
        // Close resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
