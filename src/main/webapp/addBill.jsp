<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Bill</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
        }
        h2 {
            color: #2c3e50;
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            color: #fff;
        }
        .success {
            background-color: #2ecc71;
        }
        .error {
            background-color: #e74c3c;
        }
        form {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 10px;
        }
        input[type="text"], input[type="number"], input[type="date"], select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        let stateRates = {};

        function fetchRates() {
            $.ajax({
                url: 'FetchStateRatesServlet',
                method: 'GET',
                success: function(response) {
                    response.forEach(function(rate) {
                        if (!stateRates[rate.state]) {
                            stateRates[rate.state] = [];
                        }
                        stateRates[rate.state].push({ max: rate.max_units, rate: rate.rate });
                    });
                },
                error: function(error) {
                    console.error("Error fetching rates:", error);
                }
            });
        }

        function calculateAmount() {
            const state = document.getElementById("state").value;
            const units = parseInt(document.getElementById("units_consumed").value, 10);
            if (state && !isNaN(units)) {
                const rates = stateRates[state];
                let amount = 0;
                for (const range of rates) {
                    if (units <= range.max) {
                        amount = range.rate * units;
                        break;
                    }
                }
                document.getElementById("amount").value = amount.toFixed(2);
            }
        }

        $(document).ready(function() {
            fetchRates();
        });
    </script>
</head>
<body>
    <h2>Add Bill</h2>

    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
            String messageClass = message.contains("successfully") ? "success" : "error";
    %>
        <div class="message <%= messageClass %>"><%= message %></div>
    <%
        }
    %>

    <form action="AddBillServlet" method="post">
        <label for="meter_number">Meter Number:</label>
        <input type="text" id="meter_number" name="meter_number" pattern="\d{8}" title="Meter number must be exactly 8 digits" required>

        <label for="units_consumed">Units Consumed:</label>
        <input type="number" id="units_consumed" name="units_consumed" required oninput="calculateAmount()">

        <label for="reading_date">Reading Date:</label>
        <input type="date" id="reading_date" name="reading_date" required>

        <label for="state">State:</label>
        <select id="state" name="state" required onchange="calculateAmount()">
            <option value="">Select State</option>
            <%
                String[] states = { "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal" };
                for (String state : states) {
                    out.println("<option value=\"" + state + "\">" + state + "</option>");
                }
            %>
        </select>

        <label for="amount">Amount:</label>
        <input type="text" id="amount" name="amount" readonly>

        <input type="submit" value="Add Bill">
    </form>
</body>
</html>
