package com.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/signUp")
public class SignUpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String state = request.getParameter("state");
        String fullName = request.getParameter("full_name");
        String phoneNumber = request.getParameter("phone_number");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");

            // Check if username already exists
            String checkUserQuery = "SELECT * FROM users WHERE username = ?";
            PreparedStatement checkUserStmt = conn.prepareStatement(checkUserQuery);
            checkUserStmt.setString(1, username);
            ResultSet userResult = checkUserStmt.executeQuery();
            if (userResult.next()) {
                request.setAttribute("errorMessage", "Username already exists. Please choose a different username.");
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
                return;
            }

            // Check if email already exists
            String checkEmailQuery = "SELECT * FROM users WHERE email = ?";
            PreparedStatement checkEmailStmt = conn.prepareStatement(checkEmailQuery);
            checkEmailStmt.setString(1, email);
            ResultSet emailResult = checkEmailStmt.executeQuery();
            if (emailResult.next()) {
                request.setAttribute("errorMessage", "Email already exists. Please use a different email address.");
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
                return;
            }

            // Check if phone number already exists
            String checkPhoneQuery = "SELECT * FROM users WHERE phone_number = ?";
            PreparedStatement checkPhoneStmt = conn.prepareStatement(checkPhoneQuery);
            checkPhoneStmt.setString(1, phoneNumber);
            ResultSet phoneResult = checkPhoneStmt.executeQuery();
            if (phoneResult.next()) {
                request.setAttribute("errorMessage", "Phone number already exists. Please use a different phone number.");
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
                return;
            }

            // If all checks pass, insert the new user
            String query = "INSERT INTO users (username, password, email, state, full_name, phone_number) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setString(4, state);
            ps.setString(5, fullName);
            ps.setString(6, phoneNumber);

            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("errorMessage", "Sign up failed, please try again.");
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again later.");
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
        }
    }
}
