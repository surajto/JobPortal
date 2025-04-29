<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Listings</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* Modern Job Listing UI (Adaptable for inclusion) */
        :root {
            --primary-color: #0a66c2; /* LinkedIn Blue (example) */
            --secondary-color: #6c757d;
            --light-bg: #f4f6f8;
            --dark-text: #2e3338;
            --light-text: #666;
            --border-color: #dce0e6;
            --box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            --font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .job-listings-wrapper {
            display: flex;
            gap: 20px;
            padding: 20px;
            background-color: var(--light-bg);
        }

        .filter-section {
            width: 250px; /* Fixed width for the filter */
            background-color: #fff;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 20px;
            box-shadow: var(--box-shadow);
            position: sticky;
            top: 20px; /* Adjust based on your main header height + spacing */
            height: fit-content;
        }

        .filter-section h2 {
            font-size: 1.25rem;
            color: var(--dark-text);
            margin-bottom: 15px;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 10px;
            text-align: center;
        }

        .filter-section label {
            display: block;
            margin-bottom: 8px;
            color: var(--light-text);
            font-size: 0.9rem;
            font-weight: bold;
        }

        .filter-section select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            font-size: 1rem;
            color: var(--dark-text);
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%23666" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position-x: 95%;
            background-position-y: 50%;
        }

        .filter-section button[type="submit"] {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            width: 100%;
            transition: background-color 0.2s ease-in-out;
        }

        .filter-section button[type="submit"]:hover {
            background-color: #004d8f;
        }

        .job-listings {
            flex: 1;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .job-card {
            background-color: #fff;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 20px;
            box-shadow: var(--box-shadow);
            transition: transform 0.15s ease-in-out;
        }

        .job-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
        }

        .job-card h3 {
            font-size: 1.25rem;
            color: var(--dark-text);
            margin-bottom: 8px;
            font-weight: bold;
        }

        .job-card p {
            font-size: 0.95rem;
            color: var(--light-text);
            line-height: 1.6;
            margin-bottom: 5px;
        }

        .job-card strong {
            font-weight: bold;
            color: var(--dark-text);
        }

        .job-card .job-actions {
            margin-top: 15px;
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .job-card .job-actions a {
            display: inline-block;
            background-color: var(--primary-color);
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: background-color 0.2s ease-in-out;
        }

        .job-card .job-actions a:hover {
            background-color: #004d8f;
        }

        .navigation-buttons {
            padding: 20px;
            text-align: left; /* Adjust as needed */
        }

        .navigation-buttons a {
            display: inline-block;
            background-color: var(--secondary-color);
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.9rem;
            margin-right: 10px;
            transition: background-color 0.2s ease-in-out;
        }

        .navigation-buttons a:hover {
            background-color: #545b62;
        }
    </style>
</head>
<body>

<div class="navigation-buttons">
    <a href="seekerDashboard.jsp">Back to Home</a>
</div>

<div class="job-listings-wrapper">
    <div class="filter-section">
        <h2>Filter Jobs</h2>
        <form method="get">
            <label for="city">City</label>
            <select id="city" name="city">
                <option value="">-- Any City --</option>
                <option value="Mumbai">Mumbai</option>
                <option value="Delhi">Delhi</option>
                <option value="Bangalore">Bangalore</option>
                <option value="Chennai">Chennai</option>
                <option value="Hyderabad">Hyderabad</option>
                <option value="Ahmedabad">Ahmedabad</option>
                <option value="Kolkata">Kolkata</option>
                <option value="Pune">Pune</option>
            </select>
            <button type="submit">Filter Jobs</button>
        </form>
    </div>

    <div class="job-listings">
        <%
            String city = request.getParameter("city");
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_portal", "root", "suraj12345");

                String query = "SELECT * FROM jobs WHERE last_date_to_apply >= CURDATE()";
                if (city != null && !city.isEmpty()){
                    query += " AND job_location=?";
                }

                pst = conn.prepareStatement(query);
                if (city != null && !city.isEmpty()) {
                    pst.setString(1, city);
                }

                rs = pst.executeQuery();
                while (rs.next()) {
                    int job_id = rs.getInt("job_id");
                    int r_id = rs.getInt("recruiter_id");
                    String title = rs.getString("job_title");
                    String description = rs.getString("job_description");
                    String location = rs.getString("job_location");
                    String type = rs.getString("job_type");
                    String salaryRange = rs.getString("salary_range");
                    String experience = rs.getString("required_experience");
                    String post_date = rs.getString("post_date");
                    String last_date = rs.getString("last_date_to_apply");
        %>
        <div class="job-card">
            <h3><%= title %></h3>
            <p><strong>Description:</strong> <%= description %></p>
            <p><strong>Location:</strong> <%= location %></p>
            <p><strong>Type:</strong> <%= type %></p>
            <p><strong>Salary:</strong> <%= salaryRange %></p>
            <p><strong>Experience:</strong> <%= experience %></p>
            <p><strong>Posted on:</strong> <%= post_date %></p>
            <p><strong>Apply by:</strong> <%= last_date %></p>
            <div class="job-actions">
                <a href="ApplyJobPanel.jsp?post_id=<%= job_id %>&recruiter_id=<%= r_id %>">Apply</a>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
</div>

</body>
</html>