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
<title>Admin Dashboard</title>
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
    function showSection(section) {
        document.querySelectorAll('.section').forEach(function (element) {
            element.classList.add('hidden');
        });
        document.getElementById(section).classList.remove('hidden');
    }

    function toggleSubmenu(menuId) {
        document.querySelectorAll('.submenu').forEach(function (submenu) {
            if (submenu.id !== menuId) {
                submenu.classList.add('hidden');
            }
        });
        var submenu = document.getElementById(menuId);
        submenu.classList.toggle('hidden');
    }

    function handleMenuClick(section, submenuId) {
        showSection(section);
        toggleSubmenu(submenuId);
    }
</script>
</head>
<body>
    <div class="sidebar">
    <a href="javascript:void(0)" onclick="handleMenuClick('adminhome', '')">Home</a>
        <a href="javascript:void(0)" onclick="handleMenuClick('crudEmployee', 'employeeSubmenu')">CRUD Employee</a>
        <div id="employeeSubmenu" class="submenu hidden">
            <a href="javascript:void(0)" onclick="showSection('addEmployee')">Add Employee</a>
            <a href="javascript:void(0)" onclick="showSection('viewEmployee')">View Employee</a>
            <a href="javascript:void(0)" onclick="showSection('updateEmployee')">Update Employee</a>
            <a href="javascript:void(0)" onclick="showSection('deleteEmployee')">Delete Employee</a>
        </div>
        <a href="javascript:void(0)" onclick="handleMenuClick('allBills', '')">All Bills</a>
        <a href="javascript:void(0)" onclick="handleMenuClick('priceManagement', '')">Price Management</a>
    </div>

    <div class="content">
        <div class="navbar">
            <h1>Admin Dashboard</h1>
            <div>
                <span>Welcome, <%= username %></span>
                <a href="logout" class="logout">Logout</a>
            </div>
        </div>
		
		<div id="adminhome" class="section ">
            
            <iframe src="adminhome.jsp" style="border: none; width: 100%; height: 900px;"></iframe>
        </div>
        <div id="crudEmployee" class="section hidden">
            <h2>Employee Management</h2>
            <p>Manage employee records: create, read, update, and delete employee information.</p>
        </div>
        <div id="addEmployee" class="section hidden">
            <h2>Add Employee</h2>
            <p>Fill out the form below to add a new employee.</p>
            <iframe src="addEmployee.jsp" style="border: none; width: 100%; height: 500px;"></iframe>
        </div>
        <div id="viewEmployee" class="section hidden">
            <h2>View Employee</h2>
            <p>List and view details of employees.</p>
            <iframe src="viewEmployees" style="border: none; width: 100%; height: 600px;"></iframe>
        </div>
        <div id="updateEmployee" class="section hidden">
            <h2>Update Employee</h2>
            <iframe src="updateEmployee.jsp" style="border: none; width: 100%; height: 600px;"></iframe>
        </div>
        <div id="deleteEmployee" class="section hidden">
            <h2>Delete Employee</h2>
            <iframe src="deleteEmployee.jsp" style="border: none; width: 100%; height: 600px;"></iframe>
        </div>
        <div id="allBills" class="section hidden">
            <h2>All Bills</h2>
            <iframe src="viewBills.jsp" style="border: none; width: 100%; height: 500px;"></iframe>
        </div>
        <div id="priceManagement" class="section hidden">
            <h2>Units Prices</h2>
            <iframe src="meterReading.jsp" style="border: none; width: 100%; height: 500px;"></iframe>
        </div>
    </div>
</body>
</html>
