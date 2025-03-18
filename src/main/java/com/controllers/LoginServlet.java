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
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");

            String sql = null;
            String idColumn = null;
            
            // Determine SQL query and ID column based on role
            if ("admin".equals(role)) {
                sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
                idColumn = "admin_id";
            } else if ("employee".equals(role)) {
                sql = "SELECT * FROM employee WHERE username = ? AND password = ?";
                idColumn = "employee_id";
            } else {
                sql = "SELECT * FROM users WHERE username = ? AND password = ?";
                idColumn = "user_id";
            }

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession(true); // Create a new session if one does not exist
                
                // Set session attributes based on the role
                session.setAttribute(idColumn, rs.getInt(idColumn));
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                // Redirect based on role
                if ("admin".equals(role)) {
                    response.sendRedirect("admin.jsp");
                } else if ("employee".equals(role)) {
                    response.sendRedirect("employee.jsp");
                } else {
                    response.sendRedirect("user.jsp");
                }
            } else {
                // Set an error message attribute and forward back to login.jsp
                request.setAttribute("message", "Invalid username or password. Please try again.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Set an error message attribute and forward back to login.jsp
            request.setAttribute("message", "An error occurred while processing your request.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
