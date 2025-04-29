package com.suraj;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/AcceptRejectServlet")
public class AcceptRejectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int jobId = Integer.parseInt(request.getParameter("job_id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String action = request.getParameter("action");

        String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
        String dbUser = "root";
        String dbPass = "suraj12345";

        String status = action.equals("Accepted") ? "Accepted" : "Rejected";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "UPDATE job_applications SET application_status = ? WHERE job_id = ? AND user_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, jobId);
            pstmt.setInt(3, userId);

            int rowsUpdated = pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            if (rowsUpdated > 0) {
                System.out.println("Status updated successfully.");
            } else {
                System.out.println("Failed to update status.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("RecruiterViewApplicants.jsp?jobPost_id=" + jobId);
    }
}
