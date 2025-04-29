package com.suraj;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet("/postJobServlet")
public class postJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/alumni_portal";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "suraj12345";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jobTitle = request.getParameter("job_title");
        String jobDescription = request.getParameter("job_description");
        String jobLocation = request.getParameter("job_location");
        String jobType = request.getParameter("job_type");
        String salaryRange = request.getParameter("salary_range");
        String requiredExperience = request.getParameter("required_experience");
        String lastDateToApply = request.getParameter("last_date_to_apply");
        String skillsInput = request.getParameter("skills");

        Connection conn = null;
        PreparedStatement pstmtJob = null;
        PreparedStatement pstmtSkill = null;
        ResultSet generatedKeys = null;
        boolean hasError = false;
        String errorMessage = "";

        // Validation checks (same as before)
        if (jobTitle == null || jobTitle.trim().isEmpty()) {
            hasError = true;
            errorMessage += "Job Title cannot be empty.<br>";
        }
        if (jobDescription == null || jobDescription.trim().isEmpty()) {
            hasError = true;
            errorMessage += "Job Description cannot be empty.<br>";
        }
        if (jobLocation == null || jobLocation.trim().isEmpty()) {
            hasError = true;
            errorMessage += "Job Location cannot be empty.<br>";
        }
        if (jobType == null || jobType.trim().isEmpty() || jobType.equals("Select Job Type")) {
            hasError = true;
            errorMessage += "Please select a Job Type.<br>";
        }
        if (salaryRange == null || salaryRange.trim().isEmpty() || salaryRange.equals("Select Salary Range")) {
            hasError = true;
            errorMessage += "Please select a Salary Range.<br>";
        }
        if (requiredExperience == null || requiredExperience.trim().isEmpty() || requiredExperience.equals("Select Required Experience")) {
            hasError = true;
            errorMessage += "Please select the Required Experience.<br>";
        }
        if (lastDateToApply == null || lastDateToApply.trim().isEmpty()) {
            hasError = true;
            errorMessage += "Last Date to Apply cannot be empty.<br>";
        }

        if (hasError) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("RecruiterPostJob.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

            // Start transaction (optional, but good for atomicity)
            conn.setAutoCommit(false);

            // Insert job details and get the generated job_id
            String sqlJob = "INSERT INTO jobs (recruiter_id, job_title, job_description, job_location, job_type, salary_range, required_experience, last_date_to_apply, post_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";
            pstmtJob = conn.prepareStatement(sqlJob, Statement.RETURN_GENERATED_KEYS); // To get the auto-incremented ID

            HttpSession session = request.getSession(false);
            Integer recruiterId = null;
            if (session != null && session.getAttribute("id") != null) {
                recruiterId = (Integer) session.getAttribute("id");
            } else {
                request.setAttribute("errorMessage", "You are not logged in. Please log in to post a job.");
                request.getRequestDispatcher("RecruiterPostJob.jsp").forward(request, response);
                return;
            }

            pstmtJob.setInt(1, recruiterId);
            pstmtJob.setString(2, jobTitle);
            pstmtJob.setString(3, jobDescription);
            pstmtJob.setString(4, jobLocation);
            pstmtJob.setString(5, jobType);
            pstmtJob.setString(6, salaryRange);
            pstmtJob.setString(7, requiredExperience);
            pstmtJob.setString(8, lastDateToApply);

            int jobRowsAffected = pstmtJob.executeUpdate();

            if (jobRowsAffected > 0) {
                generatedKeys = pstmtJob.getGeneratedKeys();
                int jobId = 0;
                if (generatedKeys.next()) {
                    jobId = generatedKeys.getInt(1);

                    // Process and store skills
                    if (skillsInput != null && !skillsInput.trim().isEmpty()) {
                        String[] skillsArray = skillsInput.split(",");
                        String sqlSkill = "INSERT INTO job_skills (job_id, skill) VALUES (?, ?)";
                        pstmtSkill = conn.prepareStatement(sqlSkill);

                        for (String skill : skillsArray) {
                            String trimmedSkill = skill.trim();
                            if (!trimmedSkill.isEmpty()) {
                                pstmtSkill.setInt(1, jobId);
                                pstmtSkill.setString(2, trimmedSkill);
                                pstmtSkill.executeUpdate();
                            }
                        }
                    }

                    // Commit transaction
                    conn.commit();
                    response.sendRedirect("recruiterDashboard.jsp");
                } else {
                    conn.rollback();
                    request.setAttribute("errorMessage", "Error getting job ID.");
                    request.getRequestDispatcher("RecruiterPostJob.jsp").forward(request, response);
                }
            } else {
                conn.rollback();
                request.setAttribute("errorMessage", "Error posting the job. Please try again.");
                request.getRequestDispatcher("RecruiterPostJob.jsp").forward(request, response);
            }

        } catch (ClassNotFoundException e) {
            if (conn != null)
				try {
					conn.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database driver not found.");
            request.getRequestDispatcher("RecruiterPostJob.jsp").forward(request, response);
        } catch (SQLException e) {
            if (conn != null)
				try {
					conn.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error connecting to the database or executing the query: " + e.getMessage());
            request.getRequestDispatcher("RecruiterPostJob.jsp").forward(request, response);
        } finally {
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (pstmtJob != null) pstmtJob.close();
                if (pstmtSkill != null) pstmtSkill.close();
                if (conn != null) conn.setAutoCommit(true); // Reset auto-commit
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}