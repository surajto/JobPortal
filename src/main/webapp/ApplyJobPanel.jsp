<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Apply for Job</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f2f2f2;
            padding: 30px;
        }
        .apply-container {
            background-color: #fff;
            max-width: 700px;
            margin: auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            margin-top: 0;
            color: #333;
        }
        .section {
            margin-bottom: 20px;
        }
        .section label {
            font-weight: bold;
        }
        .section p {
            margin: 5px 0;
        }
        input[type="file"] {
            margin-top: 10px;
        }
        .buttons {
            display: flex;
            justify-content: space-between;
        }
        .buttons input, .buttons a {
            padding: 10px 20px;
            font-size: 16px;
            text-decoration: none;
            border: none;
            border-radius: 5px;
        }
        .submit-btn {
            background-color: #28a745;
            color: white;
            cursor: pointer;
        }
        .back-btn {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>
<%
    int post_id = Integer.parseInt(request.getParameter("post_id"));
    int recruiter_id = Integer.parseInt(request.getParameter("recruiter_id"));
    int seeker_id = (Integer) session.getAttribute("userId");

    // Seeker Details
    String name = (String) session.getAttribute("userName");
    String email = (String) session.getAttribute("userEmail");

    // DB Connection for recruiter and job info
    String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
    String dbUser = "root";
    String dbPass = "suraj12345";

    String jobTitle = "", jobLocation = "", jobType = "", salary = "", recruiterName = "", company = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Job Details
        PreparedStatement jobStmt = conn.prepareStatement("SELECT * FROM jobs WHERE job_id = ?");
        jobStmt.setInt(1, post_id);
        ResultSet jobRs = jobStmt.executeQuery();
        if (jobRs.next()) {
            jobTitle = jobRs.getString("job_title");
            jobLocation = jobRs.getString("job_location");
            jobType = jobRs.getString("job_type");
            salary = jobRs.getString("salary_range");
        }

        // Recruiter Details
        PreparedStatement recruiterStmt = conn.prepareStatement("SELECT * FROM recruiter WHERE recruiter_id = ?");
        recruiterStmt.setInt(1, recruiter_id);
        ResultSet recRs = recruiterStmt.executeQuery();
        if (recRs.next()) {
            recruiterName = recRs.getString("recruiter_name");
            company = recRs.getString("company_name");
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<div class="apply-container">
    <h2>Apply for <%= jobTitle %></h2>
	<% 
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
    if (errorMessage != null) {
%>
    <div style="color: red; margin-bottom: 15px; font-weight: bold;">
        <%= errorMessage %>
    </div>
<% 
    } else if (successMessage != null) {
%>
    <div style="color: green; margin-bottom: 15px; font-weight: bold;">
        <%= successMessage %>
    </div>
<% 
    } 
%>
    <div class="section">
        <label>📌 Job Details:</label>
        <p><strong>Title:</strong> <%= jobTitle %></p>
        <p><strong>Location:</strong> <%= jobLocation %></p>
        <p><strong>Type:</strong> <%= jobType %></p>
        <p><strong>Salary:</strong> ₹<%= salary %></p>
    </div>

    <div class="section">
        <label>🧑 Recruiter:</label>
        <p><strong>Name:</strong> <%= recruiterName %></p>
        <p><strong>Company:</strong> <%= company %></p>
    </div>

    <div class="section">
        <label>👤 Your Details:</label>
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Email:</strong> <%= email %></p>
    </div>

    <form action="ApplyJobServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="post_id" value="<%= post_id %>">
        <input type="hidden" name="recruiter_id" value="<%= recruiter_id %>">
        <input type="hidden" name="seeker_id" value="<%= seeker_id %>">
        <div class="section">
            <label>📄 Upload Resume:</label><br>
            <input type="file" name="resume" accept=".pdf" required>
        </div>
        <div class="buttons">
            <input type="submit" value="Submit Application" class="submit-btn">
        </div>
    </form>
</div>
</body>
</html>
