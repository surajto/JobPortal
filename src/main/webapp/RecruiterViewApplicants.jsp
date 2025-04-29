<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Applicants for Job ID: <%= request.getParameter("jobPost_id") %></title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2962ff;
            --bg-light: #f7f9fc;
            --text-dark: #37474f;
            --box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            --font-family: 'Poppins', sans-serif;
            --border-radius: 6px;
            --border-color: #ced4da;
        }

        body {
            font-family: var(--font-family);
            margin: 20px;
            background-color: var(--bg-light);
            color: var(--text-dark);
            line-height: 1.6;
        }

        h1 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 25px;
        }

        .applicant-container {
            display: flex; /* Arrange applicant cards in a row */
            flex-wrap: wrap; /* Allow cards to wrap to the next line if needed */
            gap: 20px; /* Space between applicant cards */
        }

        .applicant-card {
            background-color: #fff;
            box-shadow: var(--box-shadow);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 0; /* Remove default bottom margin */
            border: 1px solid var(--border-color);
            width: calc(33% - 20px); /* Display approximately 3 cards per line with spacing */
            box-sizing: border-box; /* Include padding and border in the width */
        }

        /* Adjust width for smaller screens if needed */
        @media (max-width: 900px) {
            .applicant-card {
                width: calc(50% - 20px); /* Display 2 cards per line */
            }
        }

        @media (max-width: 600px) {
            .applicant-card {
                width: 100%; /* Display 1 card per line */
            }
        }

        .applicant-card p {
            margin-bottom: 10px;
        }

        .applicant-card strong {
            font-weight: 600;
            color: var(--primary-color);
        }

        .error-message {
            color: #f44336;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Applicants for Job ID: <%= request.getParameter("jobPost_id") %></h1>

    <%
    String jobIdStr = request.getParameter("jobPost_id");
    int jobId = 0;
    if (jobIdStr != null && !jobIdStr.isEmpty()) {
        try {
            jobId = Integer.parseInt(jobIdStr);
        } catch (NumberFormatException e) {
            out.println("<p class='error-message'>Invalid Job ID.</p>");
            return;
        }
    } else {
        out.println("<p class='error-message'>Job ID not provided.</p>");
        return;
    }

    Connection connection = null;
    PreparedStatement pstmtApplicants = null;
    ResultSet rsApplicants = null;
    PreparedStatement pstmtUser = null;
    ResultSet rsUser = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/alumni_portal";
        String dbUser = "root";
        String dbPassword = "suraj12345";
        connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        String sqlApplicants = "SELECT user_id, resume FROM job_applications WHERE job_id = ?";
        pstmtApplicants = connection.prepareStatement(sqlApplicants);
        pstmtApplicants.setInt(1, jobId);
        rsApplicants = pstmtApplicants.executeQuery();

        if (!rsApplicants.isBeforeFirst()) {
            out.println("<p class='error-message'>No applicants found for Job ID: " + jobId + "</p>");
        } else {
            out.println("<div class='applicant-container'>"); // Start the container
            while (rsApplicants.next()) {
                int userId = rsApplicants.getInt("user_id");
                String resume = rsApplicants.getString("resume");
                
				
                String userSql = "SELECT name, email, phone_number FROM users WHERE user_id = ?";
                pstmtUser = connection.prepareStatement(userSql);
                pstmtUser.setInt(1, userId);
                rsUser = pstmtUser.executeQuery();

                if (rsUser.next()) {
                    String name = rsUser.getString("name");
                    String email = rsUser.getString("email");
                    String phone = rsUser.getString("phone_number");
                    %>
                    <div class="applicant-card">
                        <p><strong>Name:</strong> <%= name %></p>
                        <p><strong>Email:</strong> <%= email %></p>
                        <p><strong>Phone:</strong> <%= phone %></p>
                        <p><strong>Resume:</strong> <a href="<%= resume %>" target="_blank">View Resume</a></p>
                        <form action="AcceptRejectServlet" method="post">
    						<input type="hidden" name="job_id" value="<%= jobId %>">
    						<input type="hidden" name="user_id" value="<%= userId %>">
    						<button type="submit" name="action" value="Accepted" style="background-color:#28a745; color:white; border:none; padding:8px 12px; margin-right:10px; border-radius:4px;">Select</button>
    						<button type="submit" name="action" value="Rejected" style="background-color:#dc3545; color:white; border:none; padding:8px 12px; border-radius:4px;">Reject</button>
						</form>
                    </div>
                    <%
                } else {
                    out.println("<p class='error-message'>Error: User details not found for User ID: " + userId + "</p>");
                }
            }
            out.println("</div>"); // End the container
        }

    } catch (ClassNotFoundException e) {
        out.println("<p class='error-message'>Database driver not found.</p>");
        e.printStackTrace();
    } catch (SQLException e) {
        out.println("<p class='error-message'>Database error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        try { if (rsUser != null) rsUser.close(); } catch (SQLException e) {}
        try { if (pstmtUser != null) pstmtUser.close(); } catch (SQLException e) {}
        try { if (rsApplicants != null) rsApplicants.close(); } catch (SQLException e) {}
        try { if (pstmtApplicants != null) pstmtApplicants.close(); } catch (SQLException e) {}
        try { if (connection != null) connection.close(); } catch (SQLException e) {}
    }
    %>
</body>
</html>