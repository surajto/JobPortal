<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard - Job Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #e74c3c;
            --accent-color: #f39c12;
            --text-dark: #333;
            --text-light: #eee;
            --bg-light: #f4f6f8;
            --bg-dark: #2c3e50;
            --border-radius: 8px;
            --box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease-in-out;
            --font-family: 'Poppins', sans-serif;
        }

        body {
            font-family: var(--font-family);
            background-color: var(--bg-light);
            color: var(--text-dark);
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .header {
            background-color: var(--primary-color);
            color: var(--text-light);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align:center;
        }

        .header h1 {
            font-size: 2.5rem;
        }

        .nav {
            background-color: var(--bg-dark);
            padding: 15px 30px;
            display: flex;
            justify-content: center;
            gap: 25px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .nav a {
            color: var(--text-light);
            text-decoration: none;
            font-weight: 500;
            font-size: 1rem;
            padding: 10px 15px;
            border-radius: var(--border-radius);
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .nav a:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: var(--accent-color);
        }

        .dashboard-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            padding: 30px;
            margin: 20px auto;
            max-width: 1200px;
        }

        .card {
            background-color: white;
            color: var(--text-dark);
            border-radius: var(--border-radius);
            padding: 30px;
            box-shadow: var(--box-shadow);
            font-size: 1.2rem;
            text-align: center;
            transition: transform var(--transition), box-shadow var(--transition);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }

        .card svg {
            font-size: 3rem;
            margin-bottom: 15px;
            color: var(--primary-color);
        }

        .card strong {
            font-size: 1.5rem;
            margin-top: 10px;
            color: var(--accent-color);
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Admin Dashboard</h1>
</div>

<div class="nav">
    <a href="ManageUsersAdmin.jsp">Manage Users</a>
    <a href="ManageRecruiterAdmin.jsp">Manage Recruiters</a>
    <a href="ManageJobsAdmin.jsp">Manage Jobs</a>
    <a href="ManageApplicationsAdmin.jsp">Manage Applications</a>
    <a href="logOut.jsp">Logout</a>
</div>

<div class="dashboard-container">
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        int totalUsers = 0, totalJobs = 0, totalApplications = 0, totalRecruiter = 0, totalSelected = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_portal", "root", "suraj12345");
            stmt = conn.createStatement();

            rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
            if (rs.next()) totalUsers = rs.getInt(1);

            rs = stmt.executeQuery("SELECT COUNT(*) FROM recruiter");
            if (rs.next()) totalRecruiter = rs.getInt(1);

            rs = stmt.executeQuery("SELECT COUNT(*) FROM jobs");
            if (rs.next()) totalJobs = rs.getInt(1);

            rs = stmt.executeQuery("SELECT COUNT(*) FROM job_applications");
            if (rs.next()) totalApplications = rs.getInt(1);

            rs = stmt.executeQuery("SELECT COUNT(*) FROM job_applications WHERE application_status LIKE '%Accept%'");
            if (rs.next()) totalSelected = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>

    <div class="card">
        <i class="fas fa-users"></i>
        Total Seekers
        <strong><%= totalUsers %></strong>
    </div>
    <div class="card">
        <i class="fas fa-building"></i>
        Total Recruiters
        <strong><%= totalRecruiter %></strong>
    </div>
    <div class="card">
        <i class="fas fa-briefcase"></i>
        Total Jobs Posted
        <strong><%= totalJobs %></strong>
    </div>
    <div class="card">
        <i class="fas fa-file-alt"></i>
        Total Applications
        <strong><%= totalApplications %></strong>
    </div>
    <div class="card">
        <i class="fas fa-check-circle" style="color: var(--success-color);"></i>
        Selected Applications
        <strong><%= totalSelected %></strong>
    </div>
</div>

</body>
</html>