<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Job Postings - Admin Panel</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #673ab7; /* Deep Purple */
            --bg-light: #f4f6f8;
            --text-dark: #333;
            --text-light: #eee;
            --border-radius: 8px;
            --box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease-in-out;
            --font-family: 'Poppins', sans-serif;
            --nav-bg: #455a64; /* Blue Grey */
            --nav-link-hover: #673ab7;
            --table-header-bg: #455a64;
            --table-row-even: #e0e0e0;
            --action-btn-edit: #2e7d32; /* Green */
            --action-btn-delete: #d32f2f; /* Red */
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

        .user-table {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid var(--border-color);
        }

        .user-table th, .user-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        .user-table th {
            background-color: var(--table-header-bg);
            color: var(--text-light);
            font-weight: 500;
            font-size: 1rem;
        }

        .user-table tbody tr:nth-child(even) {
            background-color: var(--table-row-even);
        }

        .user-table tbody tr:hover {
            background-color: #f9f9f9;
        }

        .action-btn {
            padding: 8px 12px;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 500;
            color: white;
            text-decoration: none;
            transition: background-color 0.3s ease;
            margin-right: 8px;
            font-size: 0.9rem;
            cursor: pointer;
        }

        .action-btn.edit {
            background-color: var(--action-btn-edit);
        }

        .action-btn.edit:hover {
            background-color: #1b5e20;
        }

        .action-btn.delete {
            background-color: var(--action-btn-delete);
        }

        .action-btn.delete:hover {
            background-color: #b71c1c;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>

<div class="nav">
    <a href="adminDashboard.jsp">Home</a>
    <a href="ManageUsersAdmin.jsp">Manage Users</a>
    <a href="ManageRecruiterAdmin.jsp">Manage Recruiters</a>
    <a href="ManageJobsAdmin.jsp" class="active">Manage Jobs</a>
    <a href="ManageApplicationsAdmin.jsp">Manage Applications</a>
    <a href="logOut.jsp">Logout</a>
</div>

<h1>Recruiter Job Postings</h1>

<div class="table-container">
    <table class="user-table">
        <thead>
            <tr>
                <th>Job ID</th>
                <th>Recruiter Name</th>
                <th>Recruiter Email</th>
                <th>Job Title</th>
                <th>Job Location</th>
                <th>Job Type</th>
                <th>Salary</th>
                <th>Experience Required</th>
                <th>Post Date</th>
                <th>Actions</th>
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

                    String sql = "SELECT j.job_id, j.recruiter_id, r.recruiter_name, r.email, j.job_title, j.job_location, j.job_type, j.salary_range, j.required_experience, j.post_date FROM jobs j JOIN recruiter r ON j.recruiter_id = r.recruiter_id";
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();

                    while(rs.next()) {
                        int jobId = rs.getInt("job_id");
                        String recruiterName = rs.getString("recruiter_name");
                        String recruiterEmail = rs.getString("email");
                        String jobTitle = rs.getString("job_title");
                        String jobLocation = rs.getString("job_location");
                        String jobType = rs.getString("job_type");
                        String salary = rs.getString("salary_range");
                        String experience = rs.getString("required_experience");
                        String postDate = rs.getString("post_date");
            %>
            <tr>
                <td><%= jobId %></td>
                <td><%= recruiterName %></td>
                <td><%= recruiterEmail %></td>
                <td><%= jobTitle %></td>
                <td><%= jobLocation %></td>
                <td><%= jobType %></td>
                <td><%= salary %></td>
                <td><%= experience %></td>
                <td><%= postDate %></td>
                <td>
                   <form action="delOpAdmin" method="post" style="display: inline;">
    					<input type="hidden" name="id" value="<%=jobId%>">
    					<input type="hidden" name="action" value="delJobs">
    					<button type="submit" class="action-btn delete">Delete</button>
				   </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='10'>Error: " + e.getMessage() + "</td></tr>");
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