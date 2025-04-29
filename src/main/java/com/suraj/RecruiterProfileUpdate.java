package com.suraj;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;

@WebServlet("/RecruiterProfileUpdate")
public class RecruiterProfileUpdate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        Connection conn = null;
        PreparedStatement pst = null;

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("id") == null) {
                response.sendRedirect("recruiterDashboard.jsp");
                return;
            }

            int recruiterId = (Integer) session.getAttribute("id");

            String companyName = request.getParameter("com_name");
            String recruiterName = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            // DB connection
            String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
            String dbUser = "root";
            String dbPass = "suraj12345";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "UPDATE recruiter SET company_name = ?, recruiter_name = ?, email = ?, phone_number = ? WHERE recruiter_id = ?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, companyName);
            pst.setString(2, recruiterName);
            pst.setString(3, email);
            pst.setString(4, phone);
            pst.setInt(5, recruiterId);

            int rowsUpdated = pst.executeUpdate();

            if (rowsUpdated > 0) {
                // Update session values
                session.setAttribute("companyName", companyName);
                session.setAttribute("recruiterName", recruiterName);
                session.setAttribute("email", email);
                session.setAttribute("phone", phone);
                session.setAttribute("msg", "Profile updated successfully.");
            } else {
                session.setAttribute("msg", "Failed to update profile.");
            }

            response.sendRedirect("recruiterDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "Something went wrong: " + e.getMessage());
            response.sendRedirect("recruiterDashboard.jsp");
        } finally {
            try {
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
