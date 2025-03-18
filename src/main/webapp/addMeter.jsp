<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
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

    // Retrieve message from request scope
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Meter</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f9;
    }
    .container {
        max-width: 800px;
        margin: 20px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        margin-top: 0;
    }
    .form-group {
        margin-bottom: 15px;
    }
    .form-group label {
        display: block;
        margin-bottom: 5px;
    }
    .form-group input, .form-group select {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    .form-group input[type="submit"] {
        background-color: #007bff;
        color: white;
        border: none;
        cursor: pointer;
        padding: 10px 15px;
        font-size: 16px;
    }
    .form-group input[type="submit"]:hover {
        background-color: #0056b3;
    }
    .navbar {
        background-color: #007bff;
        color: white;
        padding: 15px;
        text-align: center;
    }
    .message {
        padding: 10px;
        margin-bottom: 20px;
        border-radius: 5px;
        color: #fff;
    }
    .message.success {
        background-color: #28a745;
    }
    .message.error {
        background-color: #dc3545;
    }
</style>
</head>
<body>
    
    <div class="container">
        <!-- Display message if any -->
        <% if (message != null) { %>
            <div class="message <%= message.contains("success") ? "success" : "error" %>">
                <%= message %>
            </div>
        <% } %>
        
        <form action="addMeterServlet" method="post" onsubmit="return validateForm()">
    <div class="form-group">
        <label for="meterNumber">Meter Number</label>
        <input type="text" id="meterNumber" name="meterNumber" pattern="\d{8}" title="Meter number must be exactly 8 digits" required>
        <div id="error-message" class="error" style="display:none;color:#dc3545;">Meter number must be exactly 8 digits.</div>
    </div>
    <div class="form-group">
        <input type="submit" value="Add Meter">
    </div>
</form>

<script>
    function validateForm() {
        var meterNumber = document.getElementById('meterNumber').value;
        if (meterNumber.length !== 8 || isNaN(meterNumber)) {
            document.getElementById('error-message').style.display = 'block';
            return false;
        }
        return true;
    }
</script>
        
    </div>
</body>
</html>
