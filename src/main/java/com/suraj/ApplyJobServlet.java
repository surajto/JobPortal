package com.suraj;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.*;

@WebServlet("/ApplyJobServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 5,            // 5 MB
        maxRequestSize = 1024 * 1024 * 10)        // 10 MB
public class ApplyJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIRECTORY = "resumes";

    // Extract file name
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] elements = contentDisposition.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int postId = Integer.parseInt(request.getParameter("post_id"));
        int recruiterId = Integer.parseInt(request.getParameter("recruiter_id"));
        int seekerId = Integer.parseInt(request.getParameter("seeker_id"));

        Part filePart = request.getPart("resume");
        String fileName = getFileName(filePart);

        // Unique file name: seekerId_resume.ext
        String storedFileName = seekerId + "_" + fileName;

        // Physical upload path inside your project: webapp/resumes/
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Create folder if not exist
        }

        // Full physical path to save file
        String fullFilePath = uploadPath + File.separator + storedFileName;

        // Relative path to store in database
        String relativePath = UPLOAD_DIRECTORY + "/" + storedFileName;

        String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
        String dbUser = "root";
        String dbPass = "suraj12345";

        try (
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            PreparedStatement checkStmt = conn.prepareStatement(
                "SELECT user_id FROM job_applications WHERE user_id = ? AND job_id = ?");
            PreparedStatement insertStmt = conn.prepareStatement(
                "INSERT INTO job_applications (user_id, job_id, recruiter_id, resume, application_date) VALUES (?, ?, ?, ?, NOW())")
        ) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Check if already applied
            checkStmt.setInt(1, seekerId);
            checkStmt.setInt(2, postId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                request.setAttribute("errorMessage", "You have already submitted an application for this job.");
                request.getRequestDispatcher("ApplyJobPanel.jsp?post_id=" + postId + "&recruiter_id=" + recruiterId)
                        .forward(request, response);
                return;
            }

            // Save the resume to disk
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, Paths.get(fullFilePath), StandardCopyOption.REPLACE_EXISTING);
            } catch (IOException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error uploading resume. Please try again.");
                request.getRequestDispatcher("ApplyJobPanel.jsp?post_id=" + postId + "&recruiter_id=" + recruiterId)
                        .forward(request, response);
                return;
            }

            // Save data in DB
            insertStmt.setInt(1, seekerId);
            insertStmt.setInt(2, postId);
            insertStmt.setInt(3, recruiterId);
            insertStmt.setString(4, relativePath);

            int rowsInserted = insertStmt.executeUpdate();
            if (rowsInserted > 0) {
                request.setAttribute("successMessage", "Application submitted successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to submit application. Please try again.");
                Files.deleteIfExists(Paths.get(fullFilePath)); 
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database driver not found.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }

        // Forward to job application panel
        request.getRequestDispatcher("ApplyJobPanel.jsp?post_id=" + postId + "&recruiter_id=" + recruiterId)
                .forward(request, response);
    }
}
