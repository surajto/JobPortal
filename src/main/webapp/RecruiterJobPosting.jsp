<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Postings</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1a237e; /* Dark Blue (Material Design Indigo 900) */
            --nav-bg: #283593; /* Slightly lighter dark blue */
            --nav-link-hover: #3f51b5; /* Even lighter dark blue */
            --bg-light: #f4f6f8;
            --text-dark: #212121;
            --text-light: #fff;
            --border-radius: 8px;
            --box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            --font-family: 'Poppins', sans-serif;
        }

        body {
            font-family: var(--font-family);
            margin: 0;
            background-color: var(--bg-light);
            color: var(--text-dark);
            line-height: 1.6;
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

        /* Add a bit more visual separation for the active page if needed */
        /*.dashboard-nav-right a.active {
            background-color: var(--primary-color);
        }*/

        h1 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 25px;
        }

        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: var(--box-shadow);
            border-radius: var(--border-radius);
            overflow: hidden; /* For rounded corners on table */
        }

        th, td {
            padding: 12px 18px;
            border-bottom: 1px solid #eee;
            text-align: left;
        }

        th {
            background-color: var(--primary-color);
            color: var(--text-light);
            font-weight: 500;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #e8f0fe;
        }

        td button {
            background-color: #2ecc71; /* Emerald Green */
            color: var(--text-light);
            border: none;
            padding: 8px 15px;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
        }

        td button:hover {
            background-color: #27ae60;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
        }

        .message {
            color: #e74c3c; /* Red */
            text-align: center;
            margin-top: 15px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <%
    HttpSession currentSession = request.getSession(false);
    Integer currentRecruiterId = null;

    if (currentSession != null && currentSession.getAttribute("id") != null) {
        currentRecruiterId = (Integer) currentSession.getAttribute("id");
    } else {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/alumni_portal";
        String dbUser = "root";
        String dbPassword = "suraj12345";
        connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        String sql = "SELECT job_id, job_title, job_description, job_location, job_type, salary_range, required_experience, post_date, last_date_to_apply FROM jobs WHERE recruiter_id = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, currentRecruiterId);
        resultSet = preparedStatement.executeQuery();
    %>
    <nav class="dashboard-nav">
        <span class="dashboard-nav-left">Job Portal</span>
        <div class="dashboard-nav-right">
        	<a href="recruiterDashboard.jsp">Back to Home</a>
            <a href="RecruiterPostJob.jsp">Post a Job</a>
            <a href="RecruiterJobPosting.jsp" style="background-color: var(--primary-color);">My Job Postings</a>
            <a href="MyProfileRecruiter.jsp?r_id=<%=currentRecruiterId%>">Profile</a>
            <a href="logOut.jsp">Logout</a>
        </div>
    </nav>
    <h1>My Job Postings</h1>
    <table>
        <thead>
            <tr>
                <th>Job ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Location</th>
                <th>Posted Date</th>
                <th>Applicants</th>
            </tr>
        </thead>
        <tbody>
            <%
            while (resultSet.next()) {
                int jobId = resultSet.getInt("job_id");
                String title = resultSet.getString("job_title");
                String description = resultSet.getString("job_description");
                String location = resultSet.getString("job_location");
                java.sql.Date postedDate = resultSet.getDate("post_date");
            %>
            <tr>
                <td><%= jobId %></td>
                <td><%= title %></td>
                <td><%= description %></td>
                <td><%= location %></td>
                <td><%= postedDate %></td>
                <td>
                 <a href="RecruiterViewApplicants.jsp?jobPost_id=<%= jobId %>">View Applicants</a>
                </td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
    <%
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p class='message'>Database Error: " + e.getMessage() + "</p>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p class='message'>Error: Could not load database driver.</p>");
    } finally {
        try { if (resultSet != null) resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (preparedStatement != null) preparedStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (connection != null) connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
    %>
</body>
</html>