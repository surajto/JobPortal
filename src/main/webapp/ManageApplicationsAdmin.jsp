<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Applications</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #00bcd4; /* Teal */
            --bg-light: #f4f6f8;
            --text-dark: #333;
            --text-light: #eee;
            --border-radius: 8px;
            --box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease-in-out;
            --font-family: 'Poppins', sans-serif;
            --nav-bg: #455a64; /* Blue Grey */
            --nav-link-hover: #00bcd4;
            --table-header-bg: #455a64;
            --table-row-even: #e0e0e0;
        }

        body {
            font-family: var(--font-family);
            margin: 0;
            padding: 0;
            background-color: var(--bg-light);
            color: var(--text-dark);
            line-height: 1.6;
        }

        h1 {
            color: var(--primary-color);
            text-align: center;
            margin-top: 30px;
            margin-bottom: 20px;
            font-size: 2rem;
            font-weight: 600;
        }

        .nav {
            background-color: var(--nav-bg);
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 15px 0;
            width: 100%;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 1000;
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
            background-color: rgba(255, 255, 255, 0.15);
            color: var(--nav-link-hover);
        }

        .table-container {
            overflow-x: auto;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            max-width: 1200px;
        }

        .app-table {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid var(--border-color);
        }

        .app-table th, .app-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        .app-table th {
            background-color: var(--table-header-bg);
            color: var(--text-light);
            font-weight: 500;
            font-size: 1rem;
        }

        .app-table tbody tr:nth-child(even) {
            background-color: var(--table-row-even);
        }

        .app-table tbody tr:hover {
            background-color: #f9f9f9;
        }

        .resume-link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .resume-link:hover {
            text-decoration: underline;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="nav">
    <a href="adminDashboard.jsp">Home</a>
    <a href="ManageUsersAdmin.jsp">Manage Users</a>
    <a href="ManageRecruiterAdmin.jsp">Manage Recruiters</a>
    <a href="ManageJobsAdmin.jsp">Manage Jobs</a>
    <a href="ManageApplicationsAdmin.jsp" class="active">Manage Applications</a>
    <a href="logOut.jsp">Logout</a>
</div>

<h1>Application Management</h1>

<div class="table-container">
    <table class="app-table">
        <thead>
            <tr>
                <th>Seeker Name</th>
                <th>Seeker Email</th>
                <th>Recruiter Name</th>
                <th>Recruiter Email</th>
                <th>Job Title</th>
                <th>Application Date</th>
                <th>Status</th>
                <th>Resume</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_portal", "root", "suraj12345");

                    String sql = "SELECT a.application_date, a.application_status, a.resume, " +
                                 "u.name AS seeker_name, u.email AS seeker_email, " +
                                 "r.recruiter_name, r.email AS recruiter_email, " +
                                 "j.job_title " +
                                 "FROM job_applications a " +
                                 "JOIN users u ON a.user_id = u.user_id " +
                                 "JOIN recruiter r ON a.recruiter_id = r.recruiter_id " +
                                 "JOIN jobs j ON a.job_id = j.job_id";

                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();

                    while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("seeker_name") %></td>
                <td><%= rs.getString("seeker_email") %></td>
                <td><%= rs.getString("recruiter_name") %></td>
                <td><%= rs.getString("recruiter_email") %></td>
                <td><%= rs.getString("job_title") %></td>
                <td><%= rs.getTimestamp("application_date") %></td>
                <td><%= rs.getString("application_status") %></td>
                <td><a href="<%= rs.getString("resume") %>" class="resume-link" target="_blank">View Resume</a></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </tbody>
    </table>
</div>

</body>
</html>