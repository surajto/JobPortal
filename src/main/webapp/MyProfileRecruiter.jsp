<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recruiter Profile</title>
    <style>
    :root {
            --primary-color: #1e3a8a; /* A deep blue */
            --secondary-color: #f0f4f8; /* Very light gray/blue */
            --text-dark: #333;
            --text-light: #fff;
            --border-radius: 12px;
            --nav-bg: var(--primary-color);
            --nav-link-hover: #2e5cb8; /* Slightly lighter blue */
            --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            --card-bg: #fff;
            --card-shadow: 0 2px 6px rgba(0, 0, 0, 0.06);
        }
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px 40px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
		.dashboard-nav {
            background-color: var(--nav-bg);
            color: var(--text-light);
            padding: 15px 20px;
            box-shadow: var(--box-shadow);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .dashboard-nav-left {
            font-weight: 600;
            font-size: 1.5rem;
        }

        .dashboard-nav-right {
            display: flex;
            gap: 15px; /* Slightly reduced gap */
            align-items: center;
        }

        .dashboard-nav-right a {
            color: var(--text-light);
            text-decoration: none;
            font-weight: 500;
            font-size: 1rem;
            padding: 8px 12px;
            border-radius: var(--border-radius);
            transition: background-color 0.3s ease;
        }

        .dashboard-nav-right a:hover {
            background-color: var(--nav-link-hover);
        }
        .profile-container {
            max-width: 700px;
            margin: 40px auto;
            background: white;
            border-radius: 12px;
            padding: 30px 40px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        }

        .profile-container h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .profile-info {
            margin-bottom: 14px;
        }

        .profile-info strong {
            color: #34495e;
            width: 150px;
            display: inline-block;
        }

        .edit-button {
            display: inline-block;
            margin-top: 30px;
            background-color: #2980b9;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
        }

        .edit-button:hover {
            background-color: #1f6392;
        }

        .success {
            color: green;
            font-weight: bold;
        }

        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

<%
    String r_id = request.getParameter("r_id");
    String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
    String dbUser = "root";
    String dbPass = "suraj12345";

    String companyName = "";
    String recruiterName = "";
    String email = "";
    String phone = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        String sql = "SELECT * FROM recruiter WHERE recruiter_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, r_id);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            companyName = rs.getString("company_name");
            recruiterName = rs.getString("recruiter_name");
            email = rs.getString("email");
            phone = rs.getString("phone_number");
        }

        conn.close();
    } catch (Exception e) {
        out.println("<p class='error'>Database connection error: " + e.getMessage() + "</p>");
    }
%>
 <nav class="dashboard-nav">
        <span class="dashboard-nav-left">Job Portal</span>
        <div class="dashboard-nav-right">
        <a href="recruiterDashboard.jsp">Back to Home</a>
            <a href="RecruiterPostJob.jsp">Post a Job</a>
            <a href="RecruiterJobPosting.jsp">My Job Postings</a>
            <a href="MyProfileRecruiter.jsp?r_id=<%= r_id%>">Profile</a>
            <a href="logOut.jsp">Logout</a>
        </div>
    </nav>
<header>
    <h1>Welcome, <%= recruiterName %>!</h1>
</header>

<div class="profile-container">
    <% 
        String msg = (String) session.getAttribute("msg");
        if (msg != null) {
    %>
        <p class="<%= msg.contains("success") ? "success" : "error" %>"><%= msg %></p>
    <%
            session.removeAttribute("msg");
        }
    %>

    <h2>Your Profile Details</h2>
    <div class="profile-info"><strong>Recruiter ID:</strong> <%= r_id %></div>
    <div class="profile-info"><strong>Recruiter Name:</strong> <%= recruiterName %></div>
    <div class="profile-info"><strong>Company:</strong> <%= companyName %></div>
    <div class="profile-info"><strong>Email:</strong> <%= email %></div>
    <div class="profile-info"><strong>Phone:</strong> <%= phone %></div>
    <a class="edit-button" href="editProfileRecruiter.jsp?r_id=<%=r_id%>">Edit Profile</a>
</div>

</body>
</html>
