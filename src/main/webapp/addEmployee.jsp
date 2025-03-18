<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Employee</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f2f5;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    h2 {
        text-align: center;
        color: #333;
    }
    .container {
        width: 100%;
        max-width: 600px;
        margin: 20px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    form {
        display: flex;
        flex-direction: column;
    }
    label {
        margin-bottom: 5px;
        font-weight: bold;
    }
    input[type="text"], select {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-sizing: border-box;
        transition: border-color 0.3s;
    }
    input[type="text"]:focus, select:focus {
        border-color: #007bff;
        outline: none;
    }
    input[type="submit"] {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 15px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s, transform 0.2s;
    }
    input[type="submit"]:hover {
        background-color: #0056b3;
        transform: scale(1.02);
    }
    .message {
        text-align: center;
        margin-bottom: 20px;
        font-size: 1.2em;
        padding: 10px;
        border-radius: 5px;
    }
    .success {
        color: green;
        background-color: #e0f9e5;
        border: 1px solid green;
    }
    .error {
        color: red;
        background-color: #f9e0e0;
        border: 1px solid red;
    }
</style>
</head>
<body>
    <div class="container">
        <h2>Add New Employee</h2>
        <div class="message">
            <% 
                String message = (String) request.getAttribute("message");
                if (message != null) {
                    String messageClass = message.startsWith("Employee added") ? "success" : "error";
            %>
                <p class="<%= messageClass %>"><%= message %></p>
            <% } %>
        </div>
        <form action="addEmployee" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="email">Email:</label>
            <input type="text" id="email" name="email" required>

            <label for="state">State:</label>
            <select id="state" name="state" required>
                <option value="" disabled selected>Select State</option>
                <option value="Andhra Pradesh">Andhra Pradesh</option>
                <option value="Arunachal Pradesh">Arunachal Pradesh</option>
                <option value="Assam">Assam</option>
                <option value="Bihar">Bihar</option>
                <option value="Chhattisgarh">Chhattisgarh</option>
                <option value="Goa">Goa</option>
                <option value="Gujarat">Gujarat</option>
                <option value="Haryana">Haryana</option>
                <option value="Himachal Pradesh">Himachal Pradesh</option>
                <option value="Jharkhand">Jharkhand</option>
                <option value="Karnataka">Karnataka</option>
                <option value="Kerala">Kerala</option>
                <option value="Madhya Pradesh">Madhya Pradesh</option>
                <option value="Maharashtra">Maharashtra</option>
                <option value="Manipur">Manipur</option>
                <option value="Meghalaya">Meghalaya</option>
                <option value="Mizoram">Mizoram</option>
                <option value="Nagaland">Nagaland</option>
                <option value="Odisha">Odisha</option>
                <option value="Punjab">Punjab</option>
                <option value="Rajasthan">Rajasthan</option>
                <option value="Sikkim">Sikkim</option>
                <option value="Tamil Nadu">Tamil Nadu</option>
                <option value="Telangana">Telangana</option>
                <option value="Tripura">Tripura</option>
                <option value="Uttar Pradesh">Uttar Pradesh</option>
                <option value="Uttarakhand">Uttarakhand</option>
                <option value="West Bengal">West Bengal</option>
            </select>

            <!-- Hidden field for default password -->
            <input type="hidden" name="password" value="Power@123">

            <input type="submit" value="Add Employee">
        </form>
    </div>
</body>
</html>
