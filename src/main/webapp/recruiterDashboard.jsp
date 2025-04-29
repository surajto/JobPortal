<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session = request.getSession(false);
    Integer recruiterId = null;
    String companyName = null;
    String recruiterName = null;

    if (session != null && session.getAttribute("id") != null) {
        recruiterId = (Integer) session.getAttribute("id");
        companyName = (String) session.getAttribute("cName");
        recruiterName = (String) session.getAttribute("rName");
    } else {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recruiter Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
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
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--secondary-color);
            color: var(--text-dark);
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .dashboard-nav {
            background-color: var(--nav-bg);
            color: var(--text-light);
            padding: 15px 20px;
            box-shadow: var(--box-shadow);
            display:flex;
            justify-content:space-between;
        }

        .dashboard-nav-left {
            font-weight: 600;
            font-size: 1.5rem;
        }

        .dashboard-nav-right {
            display: flex;
            gap: 20px;
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

        .dashboard-body {
            flex-grow: 1;
            padding: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 30px;
        }

        .welcome-section {
            background-color: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 40px;
            text-align: center;
            box-shadow: var(--card-shadow);
            width: 80%;
            max-width: 700px;
        }

        .welcome-section h2 {
            color: var(--primary-color);
            margin-bottom: 15px;
            font-size: 2.2rem;
        }

        .welcome-section p {
            color: var(--text-dark);
            font-size: 1rem;
            margin-bottom: 25px;
        }

        .quick-actions {
            display: flex;
            gap: 20px;
            width: 90%;
            max-width: 960px;
            justify-content: center;
        }

        .quick-action-card {
            background-color: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 25px;
            text-align: center;
            box-shadow: var(--card-shadow);
            flex: 1;
            min-width: 200px;
        }

        .quick-action-card h3 {
            color: var(--primary-color);
            margin-bottom: 10px;
            font-size: 1.2rem;
        }

        .quick-action-card p {
            color: var(--text-dark);
            font-size: 0.9rem;
        }

        /* Placeholder for icons - you'll need to add your icon library or image tags */
        .icon-placeholder {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <nav class="dashboard-nav">
        <span class="dashboard-nav-left">Job Portal</span>
        <div class="dashboard-nav-right">
            <a href="RecruiterPostJob.jsp">Post a Job</a>
            <a href="RecruiterJobPosting.jsp">My Job Postings</a>
            <a href="MyProfileRecruiter.jsp?r_id=<%=recruiterId %>">Profile</a>
            <a href="logOut.jsp">Logout</a>
        </div>
    </nav>

    <div class="dashboard-body">
        <div class="welcome-section">
            <h2>Welcome, <%= recruiterName %>!</h2>
            <p>Manage your job postings, view applications, and find the best talent for your company.</p>
            </div>

        <div class="quick-actions">
            <a href="RecruiterPostJob.jsp" class="quick-action-card" style="text-decoration: none; color: inherit;">
                <div class="icon-placeholder">📝</div> <h3>Post a New Job</h3>
                <p>Create and publish job openings to attract potential candidates.</p>
            </a>
            <a href="RecruiterJobPosting.jsp" class="quick-action-card" style="text-decoration: none; color: inherit;">
                <div class="icon-placeholder">💼</div> <h3>My Job Postings</h3>
                <p>View and manage the jobs you have posted.</p>
            </a>
        </div>
    </div>
</body>
</html>