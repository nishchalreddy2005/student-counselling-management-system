<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('https://wallpapercave.com/wp/wp1837599.jpg') no-repeat center center fixed; 
            background-size: cover;
            margin: 0;
            padding: 0;
            color: white; /* Ensure text is readable */
        }
        .navbar {
            background: linear-gradient(135deg, #007bff, #0044ff); /* Gradient from blue to darker blue */
            color: white;
            overflow: hidden;
            position: fixed;
            top: 0;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            border-radius: 5px;
            z-index: 1000; /* Ensure navbar stays on top */
        }
        .navbar h3 {
            margin: 0;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: bold;
        }
        .navbar a:hover {
            text-decoration: underline;
        }
        .container {
            margin-top: 80px; /* Adjust based on navbar height */
            text-align: center;
            background: linear-gradient(135deg, #1e3c72, #2a5298); /* Dark stormy sky colors */
            background-image:
                linear-gradient(135deg, #1e3c72, #2a5298),
                repeating-linear-gradient(45deg, transparent, transparent 10px, #ffd700 10px, #ffd700 12px); /* Yellow sparks */
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            width: 400px;
            margin: 80px auto; /* Center the container */
            color: white;
        }
        form {
            background: linear-gradient(135deg, #232526, #414345); /* Colors resembling a thunderstorm */
            background-image:
                linear-gradient(135deg, #232526, #414345),
                repeating-linear-gradient(45deg, transparent, transparent 10px, #ffd700 10px, #ffd700 12px); /* Yellow sparks */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
            width: 300px;
            margin: 0 auto;
        }
        form:hover {
            transform: scale(1.05);
        }
        input[type="text"], input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        select {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            background: #232526; /* Matching the form background */
            color: white; /* White text color */
        }
        option {
            background: #232526; /* Matching the form background */
            color: white; /* White text color */
        }
        input[type="submit"] {
            background: linear-gradient(135deg, #007bff, #0044ff);
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background: linear-gradient(135deg, #0066cc, #0033cc);
        }
        .signup-link {
            margin-top: 20px;
            display: block;
            color: #007bff;
            text-decoration: none;
        }
        .signup-link:hover {
            text-decoration: underline;
        }

        /* Message styles */
        .message {
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 5px;
            font-weight: bold;
        }
        .message.success {
            background-color: #d4edda; /* Light green background */
            color: #155724; /* Dark green text */
        }
        .message.error {
            background-color: #f8d7da; /* Light red background */
            color: #721c24; /* Dark red text */
        }
        .message.warning {
            background-color: #fff3cd; /* Light yellow background */
            color: #856404; /* Dark yellow text */
        }

        /* Modal styles */
        .modal {
            display: none; /* Hidden by default */
            position: fixed;
            z-index: 1001; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            color: black;
            border-radius: 10px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h3>Electricity Billing System</h3>
        <div>
            <a href="#" id="aboutUsBtn">About Us</a>
            <a href="#" id="contactUsBtn">Contact Us</a>
        </div>
    </div>

    <!-- About Us Modal -->
    <div id="aboutUsModal" class="modal">
        <div class="modal-content">
            <span class="close" id="aboutUsClose">&times;</span>
            <h2>About Us</h2>
            <p>We are dedicated to providing the best electricity billing system. Our system ensures accuracy, efficiency, and ease of use for all our customers.</p>
<p>Our electricity billing system is designed with the latest technology to streamline the billing process and provide a seamless experience for users. Whether you are a residential customer or a business, our platform caters to your specific needs with precision and reliability.</p>
<p>Key features of our system include:</p>
<ul>
    <li><strong>Accurate Billing:</strong> Our system calculates your electricity usage accurately, ensuring you only pay for what you use.</li>
    <li><strong>Efficient Management:</strong> Manage your account effortlessly with our user-friendly interface, which allows you to view your billing history, make payments, and update your account details with ease.</li>
    <li><strong>Automated Processes:</strong> Enjoy the benefits of automated meter readings and billing calculations, reducing human errors and saving time.</li>
    <li><strong>Secure Transactions:</strong> We prioritize your security, employing advanced encryption and security measures to protect your personal and payment information.</li>
    <li><strong>24/7 Support:</strong> Our dedicated support team is available around the clock to assist you with any queries or issues you may encounter.</li>
</ul>
<p>We continually update our system with new features and enhancements based on user feedback, ensuring that we provide the most advanced and efficient billing solution available. Join us and experience the convenience and reliability of our top-notch electricity billing system.</p>
<p>For more information or to get started, please contact our support team or visit our website. We look forward to serving you!</p>
        </div>
    </div>

    <!-- Contact Us Modal -->
    <div id="contactUsModal" class="modal">
        <div class="modal-content">
            <span class="close" id="contactUsClose">&times;</span>
            <h2>Contact Us</h2>
            <p>If you have any questions or need assistance, please contact us at <a href="mailto:eletricity@ebs.com">eletricity@ebs.com</a>.</p>
        </div>
    </div>

    <div class="container">
        <h2>Login</h2>
        <div class="message">
            <% 
                String message = (String) request.getAttribute("message");
                if (message != null) {
                    String messageClass = message.contains("Invalid") ? "error" : "success";
            %>
                <p class="<%= messageClass %>"><%= message %></p>
            <% } %>
        </div>
        <form action="login" method="post">
            <label for="role">Role:</label>
            <select id="role" name="role" required>
                <option value="users">User</option>
                <option value="admin">Admin</option>
                <option value="employee">Employee</option>
            </select><br><br>
            Username: <input type="text" name="username" required><br>
            Password: <input type="password" name="password" required><br>
            <input type="submit" value="Login">
        </form>
        <a href="signUp.jsp" class="signup-link">Don't have an account? Sign up here</a>
    </div>

    <script>
        // JavaScript for modal handling
        var aboutUsBtn = document.getElementById("aboutUsBtn");
        var contactUsBtn = document.getElementById("contactUsBtn");
        var aboutUsModal = document.getElementById("aboutUsModal");
        var contactUsModal = document.getElementById("contactUsModal");
        var aboutUsClose = document.getElementById("aboutUsClose");
        var contactUsClose = document.getElementById("contactUsClose");

        aboutUsBtn.onclick = function() {
            aboutUsModal.style.display = "block";
        }

        contactUsBtn.onclick = function() {
            contactUsModal.style.display = "block";
        }

        aboutUsClose.onclick = function() {
            aboutUsModal.style.display = "none";
        }

        contactUsClose.onclick = function() {
            contactUsModal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == aboutUsModal) {
                aboutUsModal.style.display = "none";
            }
            if (event.target == contactUsModal) {
                contactUsModal.style.display = "none";
            }
        }
    </script>
</body>
</html>
