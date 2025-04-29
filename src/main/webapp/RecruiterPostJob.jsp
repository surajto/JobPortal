<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post a New Job</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1a237e; /* Blue Accent */
            --bg-light: #f7f9fc; /* Very Light Gray */
            --text-dark: #37474f; /* Dark Gray */
            --text-light: #fff;
            --border-radius: 6px;
            --box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            --font-family: 'Poppins', sans-serif;
            --input-border: #ced4da; /* Light Gray Border */
            --input-focus: #1e88e5; /* Lighter Blue Focus */
            --nav-bg: var(--primary-color);
            --nav-link-hover: #1947b2;
        }

        body {
            font-family: var(--font-family);
            margin: 0;
            background-color: var(--bg-light);
            color: var(--text-dark);
            line-height: 1.6;
            display: flex;
            flex-direction: column; /* Stack navigation and content */
            align-items: center; /* Center content horizontally */
            min-height: 100vh;
            padding-top: 60px; /* Space for fixed navigation */
            box-sizing: border-box;
        }

        .dashboard-nav {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: var(--nav-bg);
            color: var(--text-light);
            padding: 15px 20px;
            box-shadow: var(--box-shadow);
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 100; /* Ensure it stays on top */
        }

        .dashboard-nav-left {
            font-weight: 600;
            font-size: 1.5rem;
        }

        .dashboard-nav-right {
            display: flex;
            gap: 15px;
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

        .container {
            max-width: 700px;
            padding: 30px;
            background-color: #fff;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            width: 90%;
            margin-top: 20px; /* Space below fixed navigation */
            box-sizing: border-box;
        }

        h2 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 25px;
            font-size: 2rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-dark);
            font-size: 0.9rem;
        }

        input[type="text"],
        textarea,
        select,
        input[type="date"] {
            width: calc(100% - 16px);
            padding: 10px;
            border: 1px solid var(--input-border);
            border-radius: var(--border-radius);
            box-sizing: border-box;
            font-size: 1rem;
            transition: border-color 0.2s ease;
        }

        input[type="text"]:focus,
        textarea:focus,
        select:focus,
        input[type="date"]:focus {
            border-color: var(--input-focus);
            outline: none;
            box-shadow: 0 0 5px rgba(30, 136, 229, 0.5); /* Focus glow */
        }

        textarea {
            rows: 5;
        }

        select {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%232962ff" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position: right 8px top 50%;
            background-size: 16px;
            padding-right: 30px; /* Space for the arrow */
        }

        button {
            background-color: var(--primary-color);
            color: var(--text-light);
            padding: 12px 20px;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.2s ease, box-shadow 0.2s ease;
            box-shadow: 0 2px 5px rgba(41, 98, 255, 0.3);
        }

        button:hover {
            background-color: #1e4db2;
            box-shadow: 0 3px 7px rgba(41, 98, 255, 0.4);
        }

        .error-message {
            color: #f44336;
            margin-top: 10px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <nav class="dashboard-nav">
        <span class="dashboard-nav-left">Job Portal</span>
        <div class="dashboard-nav-right">
        	<a href="recruiterDashboard.jsp">Back to Home</a>
            <a href="RecruiterPostJob.jsp">Post a Job</a>
            <a href="RecruiterJobPosting.jsp">My Job Postings</a>
            <a href="profile">Profile</a>
            <a href="logOut.jsp">Logout</a>
        </div>
    </nav>
    <div class="container">
        <h2>Post a New Job</h2>
        <form action="postJobServlet" method="post">
            <div class="form-group">
                <label for="job_title">Job Title:</label>
                <input type="text" id="job_title" name="job_title" required>
            </div>

            <div class="form-group">
                <label for="job_description">Job Description:</label>
                <textarea id="job_description" name="job_description" required></textarea>
            </div>

            <div class="form-group">
                <label for="job_location">Job Location:</label>
                <input type="text" id="job_location" name="job_location" required>
            </div>

            <div class="form-group">
                <label for="job_type">Job Type:</label>
                <select id="job_type" name="job_type">
                    <option value="">Select Job Type</option>
                    <option value="full-time">Full-Time</option>
                    <option value="part-time">Part-Time</option>
                    <option value="contract">Contract</option>
                    <option value="internship">Internship</option>
                </select>
            </div>

            <div class="form-group">
                <label for="salary_range">Salary Range:</label>
                <select id="salary_range" name="salary_range">
                    <option value="">Select Salary Range</option>
                    <option value="3-5 LPA">3-5 LPA</option>
                    <option value="5-7 LPA">5-7 LPA</option>
                    <option value="7-10 LPA">7-10 LPA</option>
                    <option value="10-13 LPA">10-13 LPA</option>
                    <option value="13-18 LPA">13-18 LPA</option>
                    <option value="18-25 LPA">18-25 LPA</option>
                    <option value="25-50 LPA">25-50 LPA</option>
                </select>
            </div>

            <div class="form-group">
                <label for="required_experience">Required Experience:</label>
                <select id="required_experience" name="required_experience">
                    <option value="">Select Required Experience</option>
                    <option value="0 years">0 year</option>
                    <option value="1 years">1 year</option>
                    <option value="2 years">2 years</option>
                    <option value="3 years">3 years</option>
                    <option value="5 years">5 years</option>
                    <option value="8 years">8 years</option>
                    <option value="10 years">10+ years</option>
                </select>
            </div>
            <div class="form-group">
                <label for="skills">Required Skills (comma-separated):</label>
                <input type="text" id="skills" name="skills" placeholder="e.g., Java, Spring, SQL, REST APIs">
            </div>
            <div class="form-group">
                <label for="last_date_to_apply">Last Date to Apply:</label>
                <input type="date" id="last_date_to_apply" name="last_date_to_apply">
            </div>

            <button type="submit">Post Job</button>
        </form>

        <%-- Optional: Display error messages here --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p class="error-message"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
    </div>
</body>
</html>