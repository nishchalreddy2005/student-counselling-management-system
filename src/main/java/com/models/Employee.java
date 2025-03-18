package com.models;
public class Employee {
    private int employeeId;
    private String username;
    private String email;
    private String state;

    public Employee(int employeeId, String username, String email, String state) {
        this.employeeId = employeeId;
        this.username = username;
        this.email = email;
        this.state = state;
    }

    // Getters and Setters
    public int getEmployeeId() { return employeeId; }
    public void setEmployeeId(int employeeId) { this.employeeId = employeeId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }
}
