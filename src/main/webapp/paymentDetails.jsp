<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String meterNumber = request.getParameter("meter_number");
    String unitsConsumed = request.getParameter("units_consumed");
    String readingDate = request.getParameter("reading_date");
    String paymentStatus = request.getParameter("payment_status");
    String state = request.getParameter("state");
    String amount = request.getParameter("amount");
    String readingId = request.getParameter("reading_id"); // Added reading_id
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Details</title>
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
    .container {
        padding: 20px;
        margin: 0 auto;
        max-width: 600px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .details {
        margin-bottom: 20px;
    }
    .details p {
        margin: 5px 0;
    }
    .pay-button {
        background-color: #007bff;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .pay-button:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
    <div class="container">
        <h2>Payment Details</h2>
        <div class="details">
            <p><strong>Meter Number:</strong> <%= meterNumber %></p>
            <p><strong>Units Consumed:</strong> <%= unitsConsumed %></p>
            <p><strong>Reading Date:</strong> <%= readingDate %></p>
            <p><strong>Payment Status:</strong> <%= paymentStatus %></p>
            <p><strong>Meter State:</strong> <%= state %></p>
            <p><strong>Amount:</strong> <%= amount %></p>
        </div>
        <form action="processPayment.jsp" method="post">
            <input type="hidden" name="meter_number" value="<%= meterNumber %>">
            <input type="hidden" name="units_consumed" value="<%= unitsConsumed %>">
            <input type="hidden" name="reading_date" value="<%= readingDate %>">
            <input type="hidden" name="payment_status" value="<%= paymentStatus %>">
            <input type="hidden" name="state" value="<%= state %>">
            <input type="hidden" name="amount" value="<%= amount %>">
            <input type="hidden" name="reading_id" value="<%= readingId %>"> <!-- Added hidden field for reading_id -->
            <button type="submit" class="pay-button">Confirm Payment</button>
        </form>
    </div>
</body>
</html>
