<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    Statement stmt = null;
    int employeeCount = 0;
    int userCount = 0;
    int billCount = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");
        stmt = conn.createStatement();

        ResultSet rs = stmt.executeQuery("SELECT COUNT(employee_id) FROM employee");
        if (rs.next()) {
            employeeCount = rs.getInt(1);
        }

        rs = stmt.executeQuery("SELECT COUNT(user_id) FROM users");
        if (rs.next()) {
            userCount = rs.getInt(1);
        }

        rs = stmt.executeQuery("SELECT COUNT(reading_id) FROM metereading");
        if (rs.next()) {
            billCount = rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Home - Electricity Billing System</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #2b5876, #4e4376);
            color: #fff;
        }
        .content {
            padding-top: 50px;
            text-align: center;
            max-width: 1200px;
            margin: 0 auto;
        }
        .hero-section {
            margin: 50px 0;
        }
        .hero-section h2 {
            font-size: 48px;
            margin-bottom: 20px;
        }
        .hero-section p {
            font-size: 20px;
            line-height: 1.5;
        }
        .cards {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }
        .card {
            background: #fff;
            color: #333;
            width: 300px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s;
            margin: 20px 0;
        }
        .card:hover {
            transform: translateY(-10px);
        }
        .card h3 {
            margin-top: 0;
            font-size: 24px;
            margin-bottom: 10px;
        }
        .card p {
            font-size: 16px;
            line-height: 1.5;
        }
        .card img {
            width: 100%;
            border-radius: 10px;
            margin-bottom: 10px;
        }
        .footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 20px;
            position: fixed;
            width: 100%;
            bottom: 0;
        }
    </style>
</head>
<body>
    <div class="content">
        <div class="hero-section">
            <h2>Welcome to the Admin Portal</h2>
            <p>Monitor and manage employees, users, and bills efficiently.</p>
        </div>
        <div class="cards">
            <div class="card">
                <img src="https://banner2.cleanpng.com/20190916/sbf/transparent-clip-art-cartoon-employment-job-white-collar-worke-5d7fff3e926a54.0139605215686695025997.jpg" alt="Total Employees">
                <h3>Total Employees</h3>
                <p><%= employeeCount %></p>
            </div>
            <div class="card">
                <img src="https://www.shutterstock.com/image-vector/young-smiling-man-adam-avatar-600nw-2107967969.jpg" alt="Total Users">
                <h3>Total Users</h3>
                <p><%= userCount %></p>
            </div>
            <div class="card">
                <img src="https://i.pinimg.com/564x/a2/6f/62/a26f62b0d95c23dab9af716fae01db9e.jpg" alt="Total Bills">
                <h3>Total Bills</h3>
                <p><%= billCount %></p>
            </div>
            <div class="card">
                <img src="https://www.itpedia.nl/wp-content/uploads/2023/03/crud.png" alt="Employee CRUD Operations">
                <h3>Employee CRUD Operations</h3>
                <p>Manage employee details, add new employees, update information, and delete employees.</p>
            </div>
        </div>
    </div>
    
</body>
</html>
