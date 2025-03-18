<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>
<style>
    body {
        font-family: 'Roboto', sans-serif;
        margin: 0;
        padding: 0;
        background: linear-gradient(to right, #ff7e5f, #feb47b);
        color: #333;
    }
    .sidebar {
        height: 100vh;
        width: 250px;
        position: fixed;
        top: 0;
        left: 0;
        background-color: #2c3e50;
        color: #ecf0f1;
        transition: width 0.3s;
    }
    .sidebar a {
        padding: 20px;
        text-decoration: none;
        font-size: 18px;
        color: #ecf0f1;
        display: block;
        transition: background-color 0.3s, padding-left 0.3s;
    }
    .sidebar a:hover {
        background-color: #34495e;
        padding-left: 30px;
    }
    .sidebar .submenu a {
        padding-left: 40px;
        font-size: 16px;
    }
    .sidebar .submenu a:hover {
        background-color: #1abc9c;
    }
    .content {
        margin-left: 250px;
        padding: 20px;
        transition: margin-left 0.3s;
    }
    .navbar {
        background-color: #2980b9;
        color: white;
        padding: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-radius: 0 0 10px 10px;
    }
    .navbar .logout {
        text-decoration: none;
        color: white;
        background-color: #e74c3c;
        padding: 10px 15px;
        border-radius: 5px;
        transition: background-color 0.3s;
    }
    .navbar .logout:hover {
        background-color: #c0392b;
    }
    .hidden {
        display: none;
    }
    .section {
        background-color: #ecf0f1;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }
    .section h2 {
        margin-top: 0;
    }
    iframe {
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
</style>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.sidebar a').forEach(function(anchor) {
            anchor.addEventListener('click', function(event) {
                const sectionId = event.target.getAttribute('data-section');
                showSection(sectionId);
            });
        });
    });

    function showSection(section) {
        document.querySelectorAll('.section').forEach(function (element) {
            element.classList.add('hidden');
        });
        if (section) {
            document.getElementById(section).classList.remove('hidden');
        }
    }
</script>
</head>
<body>
    <div class="sidebar">
    	<a href="javascript:void(0)" data-section="userHome">Home</a>
   	    <a href="javascript:void(0)" data-section="meterNumber">Add Meter Details</a>
        <a href="javascript:void(0)" data-section="billingHistory">Billing History</a>
        <a href="javascript:void(0)" data-section="payBill">Pay Bill</a>
        <a href="javascript:void(0)" data-section="support">Support</a>
        <a href="javascript:void(0)" data-section="accountInfo">Account Information</a>
        
      
    </div>

    <div class="content">
        <div class="navbar">
            <h1>User Dashboard</h1>
            <div>
                <span>Welcome, <%= username %></span>
                <a href="logout" class="logout">Logout</a>
            </div>
        </div>
		<div id="userHome" class="section">
            
            <iframe src="userhome.jsp" style="border: none; width: 100%; height: 800px;"></iframe>
        </div>
        <div id="meterNumber" class="section hidden">
            <h2>Add Meter Details</h2>
            <iframe src="addMeter.jsp" style="border: none; width: 100%; height: 600px;"></iframe>
        </div>
        <div id="billingHistory" class="section hidden">
            <h2>Billing History</h2>
             <iframe src="myBills.jsp" style="border: none; width: 100%; height: 600px;"></iframe>
        </div>
        <div id="payBill" class="section hidden">
            <h2>Payment</h2>
            <iframe src="payBill.jsp" style="border: none; width: 100%; height: 600px;"></iframe>
        </div>
        <div id="support" class="section hidden">
            <h2>Support</h2>
            <iframe src="support.jsp" style="border: none; width: 100%; height: 600px;"></iframe>
        </div>
        
        <div id="accountInfo" class="section hidden">
            <h2>Account Information</h2>
            <iframe src="myAccount.jsp" style="border: none; width: 100%; height: 600px;"></iframe>
        </div>
       
    </div>
</body>
</html>
