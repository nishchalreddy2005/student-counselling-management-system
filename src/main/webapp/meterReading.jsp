<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Meter Reading Prices</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        .update-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 5px 10px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<h2>Meter Reading Prices</h2>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>State</th>
            <th>Max Unit</th>
            <th>Unit Price</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            String jdbcURL = "jdbc:mysql://localhost:3306/electricity_billing";
            String jdbcUsername = "root";
            String jdbcPassword = "Monkey2016@";

            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                String sql = "SELECT id, state, max_units, rate FROM state_rates";
                statement = connection.prepareStatement(sql);
                resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String state = resultSet.getString("state");
                    double maxUnits = resultSet.getDouble("max_units");
                    double rate = resultSet.getDouble("rate");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= state %></td>
            <td><%= maxUnits %></td>
            <td><%= rate %></td>
            <td>
                <a class="update-button" href="updateMeterReading.jsp?id=<%= id %>&state=<%= state %>&maxUnits=<%= maxUnits %>&rate=<%= rate %>">Update</a>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
                if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
                if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
            }
        %>
    </tbody>
</table>

</body>
</html>
