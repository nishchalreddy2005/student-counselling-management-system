<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, javax.servlet.http.HttpSession" %>
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

    String message = "";
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (newPassword != null && confirmPassword != null && newPassword.equals(confirmPassword)) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");

                // Verify the current password
                String verifySql = "SELECT password FROM employee WHERE username = ?";
                pstmt = conn.prepareStatement(verifySql);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String storedPassword = rs.getString("password");

                    if (currentPassword.equals(storedPassword)) {
                        // Update the password
                        String updateSql = "UPDATE employee SET password = ? WHERE username = ?";
                        pstmt = conn.prepareStatement(updateSql);
                        pstmt.setString(1, newPassword);
                        pstmt.setString(2, username);
                        int rowsUpdated = pstmt.executeUpdate();

                        if (rowsUpdated > 0) {
                            message = "Password updated successfully.";
                        } else {
                            message = "Error updating password.";
                        }
                    } else {
                        message = "Current password is incorrect.";
                    }
                } else {
                    message = "User not found.";
                }
            } catch (Exception e) {
                e.printStackTrace();
                message = "An error occurred: " + e.getMessage();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } else {
            message = "New passwords do not match.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f9;
    }
    .container {
        max-width: 600px;
        margin: 50px auto;
        padding: 20px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        color: #007bff;
        margin-bottom: 20px;
    }
    label {
        display: block;
        margin: 10px 0 5px;
    }
    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    input[type="submit"] {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #0056b3;
    }
    .message {
    margin: 20px 0;
    font-size: 16px;
    padding: 10px;
    border-radius: 4px;
}

.error {
    color: #d9534f; /* Red color for error messages */
    background-color: #f8d7da; /* Light red background */
    border: 1px solid #f5c6cb; /* Red border */
}

.success {
    color: #28a745; /* Green color for success messages */
    background-color: #d4edda; /* Light green background */
    border: 1px solid #c3e6cb; /* Green border */
}
    
</style>
</head>
<body>
    <div class="container">
        <h2>Change Password</h2>
        <form method="post">
            <label for="currentPassword">Current Password</label>
            <input type="password" id="currentPassword" name="currentPassword" required>
            
            <label for="newPassword">New Password</label>
            <input type="password" id="newPassword" name="newPassword" required>
            
            <label for="confirmPassword">Confirm New Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            
            <input type="submit" value="Change Password">
        </form>
        <%-- Check if there's a message to display --%>
<% if (message != null && !message.isEmpty()) { %>
    <div class="message <% if (message.contains("successfully")) { %>success<% } else { %>error<% } %>">
        <%= message %>
    </div>
<% } %>
        
    </div>
</body>
</html>
