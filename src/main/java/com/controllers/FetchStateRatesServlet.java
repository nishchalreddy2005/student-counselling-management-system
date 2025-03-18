package com.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@WebServlet("/FetchStateRatesServlet")
public class FetchStateRatesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        JsonArray ratesArray = new JsonArray();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/electricity_billing", "root", "Monkey2016@");
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT state, max_units, rate FROM state_rates");
            while (rs.next()) {
                JsonObject rateObj = new JsonObject();
                rateObj.addProperty("state", rs.getString("state"));
                rateObj.addProperty("max_units", rs.getInt("max_units"));
                rateObj.addProperty("rate", rs.getDouble("rate"));
                ratesArray.add(rateObj);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        out.print(ratesArray.toString());
        out.flush();
    }
}
