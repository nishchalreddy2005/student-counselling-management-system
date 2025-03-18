<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Home - Electricity Billing System</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #4e54c8, #8f94fb);
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
            <h2>Welcome to the Electricity Billing System</h2>
            <p>Your one-stop solution for managing your electricity bills seamlessly and efficiently.</p>
        </div>
        <div class="cards">
            <div class="card">
                <h3>View Billing History</h3>
                <p>Check your past bills and keep track of your electricity usage and payments.</p>
            </div>
            <div class="card">
                <h3>Make a Payment</h3>
                <p>Pay your electricity bills online quickly and securely with our easy payment options.</p>
            </div>
            <div class="card">
                <h3>Get Support</h3>
                <p>Need help? Contact our support team for any assistance with your account or billing.</p>
            </div>
            <div class="card">
                <h3>Update Account</h3>
                <p>Keep your account information up-to-date for a smoother billing experience.</p>
            </div>
        </div>
    </div>
    
</body>
</html>
