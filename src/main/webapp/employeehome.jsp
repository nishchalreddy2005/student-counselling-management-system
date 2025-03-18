<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Home - Electricity Billing System</title>
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
            <h2>Welcome to the Employee Portal</h2>
            <p>Manage billing, account information, and unit prices with ease.</p>
        </div>
        <div class="cards">
            <div class="card">
                <h3>Add Bills</h3>
                <p>Add new billing information for customers.</p>
            </div>
            <div class="card">
                <h3>View Bills</h3>
                <p>View and manage existing bills.</p>
            </div>
            <div class="card">
                <h3>Update Account Information</h3>
                <p>Keep customer account details up-to-date.</p>
            </div>
            <div class="card">
                <h3>Unit Price List</h3>
                <p>Manage and view the list of unit prices for different states.</p>
            </div>
        </div>
    </div>
    
</body>
</html>
