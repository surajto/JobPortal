<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Applications</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #0a66c2; /* LinkedIn Blue */
            --success-color: #2e7d32;
            --warning-color: #ed6c02;
            --error-color: #d32f2f;
            --text-primary: #212121;
            --text-secondary: #757575;
            --bg-light: #f5f5f5;
            --border-color: #e0e0e0;
            --box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
            --border-radius: 8px;
            --font-family: 'Inter', sans-serif;
        }

        main.my-applications-main {
            max-width: 960px;
            margin: 20px auto;
            padding: 30px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        main.my-applications-main h1 {
            text-align: center;
            color: var(--primary-color);
            font-size: 2.5rem;
            margin-bottom: 30px;
            font-weight: 600;
        }

        main.my-applications-main .application-card {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: var(--box-shadow);
            transition: transform 0.2s ease-in-out;
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 15px;
            align-items: center;
        }

        main.my-applications-main .application-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        main.my-applications-main .app-details p {
            margin: 8px 0;
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        main.my-applications-main .app-details strong {
            color: var(--text-primary);
            font-weight: 500;
        }

        main.my-applications-main .status-badge {
            font-weight: 500;
            padding: 8px 12px;
            border-radius: 12px;
            font-size: 0.8rem;
            color: white;
            text-align: center;
            white-space: nowrap;
        }

        main.my-applications-main .status-badge.pending {
            background-color: var(--warning-color);
        }

        main.my-applications-main .status-badge.accepted {
            background-color: var(--success-color);
        }

        main.my-applications-main .status-badge.rejected {
            background-color: var(--error-color);
        }

        main.my-applications-main .resume-link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease-in-out;
            display: inline-block;
            margin-top: 10px;
        }

        main.my-applications-main .resume-link:hover {
            text-decoration: underline;
            color: #004d8f;
        }

        main.my-applications-main .no-applications {
            text-align: center;
            color: var(--text-secondary);
            font-size: 1rem;
            margin-top: 50px;
        }

        @media (max-width: 768px) {
            main.my-applications-main {
                padding: 20px;
            }

            main.my-applications-main h1 {
                font-size: 2rem;
                margin-bottom: 20px;
            }

            main.my-applications-main .application-card {
                grid-template-columns: 1fr;
                align-items: flex-start;
            }

            main.my-applications-main .status-badge {
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>

<main class="my-applications-main">
    <h1>My Applications</h1>
    <%
        session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("logOut.jsp");
            return;
        }

        int userId = (Integer)session.getAttribute("userId");

        String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
        String dbUser = "root";
        String dbPass = "suraj12345";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String query = "SELECT ja.*, j.job_title, j.job_location, r.company_name, r.recruiter_name " +
                           "FROM job_applications ja " +
                           "JOIN jobs j ON ja.job_id = j.job_id " +
                           "JOIN recruiter r ON ja.recruiter_id = r.recruiter_id " +
                           "WHERE ja.user_id = ? ORDER BY ja.application_date DESC";

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            boolean hasApplications = false;
            while (rs.next()) {
                hasApplications = true;
                String status = rs.getString("application_status").toLowerCase();
                String statusClass = "pending";
                if (status.contains("accept")) statusClass = "accepted";
                else if (status.contains("reject")) statusClass = "rejected";
    %>
    <div class="application-card">
        <div class="app-details">
            <p><strong>Job Title:</strong> <%= rs.getString("job_title") %></p>
            <p><strong>Company:</strong> <%= rs.getString("company_name") %></p>
            <p><strong>Recruiter:</strong> <%= rs.getString("recruiter_name") %></p>
            <p><strong>Location:</strong> <%= rs.getString("job_location") %></p>
            <p><strong>Applied On:</strong> <%= rs.getString("application_date") %></p>
            <a href="<%= rs.getString("resume") %>" target="_blank" class="resume-link">View Resume</a>
        </div>
        <span class="status-badge <%= statusClass %>"><%= rs.getString("application_status") %></span>
    </div>
    <%
            }

            if (!hasApplications) {
    %>
        <div class="no-applications">You have not applied to any jobs yet.</div>
    <%
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %>
</main>

</body>
</html>