<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Listings</title>
    <style>
        /* Modern Job Listing UI (Inspired by LinkedIn and similar platforms) */
        :root {
            --primary-color: #0a66c2; /* LinkedIn Blue */
            --secondary-color: #6c757d;
            --light-bg: #f4f6f8;
            --dark-text: #2e3338;
            --light-text: #666;
            --border-color: #dce0e6;
            --box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            --font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            font-family: var(--font-family);
            background-color: var(--light-bg);
            color: var(--dark-text);
            margin: 0;
            padding:0;
            box-sizing: border-box;
            overflow-x: hidden;
        }

        .job-listings-container {
            max-width: 1200px;
            margin: 20px auto;
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 30px;
        }

        /* Filter Section */
		.filter {
		    background-color: #fff;
		    border: 1px solid var(--border-color);
		    border-radius: 8px;
		    padding: 20px;
		    box-shadow: var(--box-shadow);
		    position: sticky;
		    top: 60px; /* Adjust this value to the height of your main header */
		    height: fit-content;
		}

        .filter h2 {
            font-size: 1.25rem;
            color: var(--dark-text);
            margin-bottom: 15px;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 10px;
        }

        .filter label {
            display: block;
            margin-bottom: 8px;
            color: var(--light-text);
            font-size: 0.9rem;
            font-weight: bold;
        }

        .filter select {
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

        .filter button[type="submit"] {
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

        .filter button[type="submit"]:hover {
            background-color: #004d8f;
        }

        /* Job Listings Section */
        .post {
            display: grid;
            gap: 20px;
        }

        .post_data {
            background-color: #fff;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 20px;
            box-shadow: var(--box-shadow);
            transition: transform 0.15s ease-in-out;
        }

        .post_data:hover {
            transform: translateY(-3px);
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
        }

        .job-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .job-header h3 {
            font-size: 1.25rem;
            color: var(--dark-text);
            margin: 0;
            font-weight: bold;
        }

        .job-header span.company {
            font-size: 0.9rem;
            color: var(--primary-color);
            font-weight: bold;
        }

        .job-details p {
            font-size: 0.95rem;
            color: var(--light-text);
            line-height: 1.6;
            margin-bottom: 8px;
        }

        .job-details strong {
            font-weight: bold;
            color: var(--dark-text);
        }

        .job-skills {
            margin-top: 10px;
        }

        .job-skills span {
            display: inline-block;
            background-color: #e1f3ff;
            color: var(--primary-color);
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.85rem;
            margin-right: 5px;
            margin-bottom: 5px;
        }

        .job-actions {
            margin-top: 15px;
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .job-actions a {
            display: inline-block;
            background-color: var(--primary-color);
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: background-color 0.2s ease-in-out;
        }

        .job-actions a:hover {
            background-color: #004d8f;
        }

        .job-actions button {
            background: none;
            border: 1px solid var(--secondary-color);
            color: var(--secondary-color);
            padding: 8px 12px;
            border-radius: 5px;
            font-size: 0.9rem;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
        }

        .job-actions button:hover {
            background-color: var(--secondary-color);
            color: white;
        }

        /* Responsive Layout */
        @media (max-width: 992px) {
            .job-listings-container {
                grid-template-columns: 1fr;
            }

            .filter {
                position: static;
                margin-bottom: 20px;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="job-listings-container">
        <div class="filter">
            <h2>Filter Jobs</h2>
            <form action="FilterSeeker.jsp" method="get">
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
                <button type="submit">Apply Filters</button>
            </form>
        </div>

        <div class="post" id="post">
            <%
                session = request.getSession(false);
                if (session == null || session.getAttribute("userId") == null) {
                    response.sendRedirect("logOut.jsp");
                    return;
                }

                int userId = (Integer) session.getAttribute("userId");
                String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
                String dbUser = "root";
                String dbPass = "suraj12345";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

                    String query = "SELECT * FROM jobs WHERE last_date_to_apply >= CURDATE() ORDER BY post_date DESC;";
                    Statement stm1 = conn.createStatement();
                    ResultSet rs1 = stm1.executeQuery(query);

                    while (rs1.next()) {
                        int job_id = rs1.getInt("job_id");
                        String r_id = rs1.getString("recruiter_id");
                        String title = rs1.getString("job_title");
                        String description = rs1.getString("job_description");
                        String location = rs1.getString("job_location");
                        String type = rs1.getString("job_type");
                        String salary = rs1.getString("salary_range");
                        String experience = rs1.getString("required_experience");
                        String post_date = rs1.getString("post_date");
                        String last_date = rs1.getString("last_date_to_apply");

                        String companyName = "", recruiterName = "", email = "";

                        Connection conn2 = DriverManager.getConnection(dbURL, dbUser, dbPass);
                        PreparedStatement pstm = conn2.prepareStatement("SELECT company_name FROM recruiter WHERE recruiter_id = ?");
                        pstm.setString(1, r_id);
                        ResultSet rs2 = pstm.executeQuery();

                        PreparedStatement pstm1 = conn.prepareStatement("SELECT skill FROM job_skills WHERE job_id = ?");
                        pstm1.setInt(1, job_id);
                        ResultSet rs3 = pstm1.executeQuery();

                        if (rs2.next()) {
                            companyName = rs2.getString("company_name");
                        }

                        StringBuilder skillList = new StringBuilder();
                        while (rs3.next()) {
                            skillList.append("<span>").append(rs3.getString("skill")).append("</span>");
                        }

                        rs2.close();
                        pstm.close();
                        rs3.close();
                        pstm1.close();
                        conn2.close();
            %>
            <div class="post_data">
                <div class="job-header">
                    <h3><%= title %></h3>
                    <span class="company"><%= companyName %></span>
                </div>
                <div class="job-details">
                    <p><strong>Location:</strong> <%= location %></p>
                    <p><strong>Type:</strong> <%= type %></p>
                    <p><strong>Salary:</strong> <%= salary %></p>
                    <p><strong>Experience:</strong> <%= experience %></p>
                    <p><%= description.length() > 150 ? description.substring(0, 150) + "..." : description %></p>
                </div>
                <div class="job-skills">
                    <strong>Skills:</strong> <%= skillList.toString() %>
                </div>
                <div class="job-actions">
                    <a href="ApplyJobPanel.jsp?post_id=<%= job_id %>&recruiter_id=<%= r_id %>">Apply Now</a>
                </div>
                <p style="font-size: 0.8rem; color: var(--light-text); margin-top: 10px;">Posted on: <%= post_date %>, Apply by: <%= last_date %></p>
            </div>
            <%
                    }

                    rs1.close();
                    stm1.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>
</body>
</html>