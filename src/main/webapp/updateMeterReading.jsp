<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Meter Reading Price</title>
    <style>
        form {
            max-width: 400px;
            margin: auto;
        }
        div {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<h2>Update Meter Reading Price</h2>

<%
    String jdbcURL = "jdbc:mysql://localhost:3306/electricity_billing";
    String jdbcUsername = "root";
    String jdbcPassword = "Monkey2016@";

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Handle form submission
        int id = Integer.parseInt(request.getParameter("id"));
        String state = request.getParameter("state");
        double maxUnits = Double.parseDouble(request.getParameter("maxUnits"));
        double rate = Double.parseDouble(request.getParameter("rate"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "UPDATE state_rates SET state = ?, max_units = ?, rate = ? WHERE id = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, state);
            statement.setDouble(2, maxUnits);
            statement.setDouble(3, rate);
            statement.setInt(4, id);

            int rowsUpdated = statement.executeUpdate();

            if (rowsUpdated > 0) {
                message = "Update successful!";
            } else {
                message = "Error updating record.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred: " + e.getMessage();
        } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    } else {
        // Display form with existing data
        int id = Integer.parseInt(request.getParameter("id"));
        String state = "";
        double maxUnits = 0;
        double rate = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "SELECT state, max_units, rate FROM state_rates WHERE id = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                state = resultSet.getString("state");
                maxUnits = resultSet.getDouble("max_units");
                rate = resultSet.getDouble("rate");
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred: " + e.getMessage();
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
%>

<form action="updateMeterReading.jsp" method="post">
    <div>
        <label for="id">ID</label>
        <input type="text" id="id" name="id" value="<%= id %>" readonly>
    </div>
    <div>
        <label for="state">State</label>
        <input type="text" id="state" name="state" value="<%= state %>">
    </div>
    <div>
        <label for="maxUnits">Max Units</label>
        <input type="number" id="maxUnits" name="maxUnits" value="<%= maxUnits %>">
    </div>
    <div>
        <label for="rate">Unit Price</label>
        <input type="number" step="0.01" id="rate" name="rate" value="<%= rate %>">
    </div>
    <div>
        <input type="submit" value="Update">
    </div>
</form>

<%
    }
%>

<p><%= message %></p>
<a href="meterReading.jsp">Back to Meter Reading Prices</a>

</body>
</html>
