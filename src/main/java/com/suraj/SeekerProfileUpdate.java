package com.suraj;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;

@WebServlet("/SeekerProfileUpdate")
public class SeekerProfileUpdate extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pst = null;

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int userId = (Integer) session.getAttribute("userId");

            String name = request.getParameter("name1");
            String username = request.getParameter("username1");
            String email = request.getParameter("email1");
            String phone = request.getParameter("phone1");
            String dob = request.getParameter("dob1");

            // Use existing session values if fields are left blank
            if (name == null || name.trim().isEmpty()) name = (String) session.getAttribute("userName");
            if (username == null || username.trim().isEmpty()) username = (String) session.getAttribute("userUsername");
            if (email == null || email.trim().isEmpty()) email = (String) session.getAttribute("userEmail");
            if (phone == null || phone.trim().isEmpty()) phone = (String) session.getAttribute("userPhone");
            if (dob == null || dob.trim().isEmpty()) dob = (String) session.getAttribute("userDOB");

            // DB connection
            String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
            String dbUser = "root";
            String dbPass = "suraj12345";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            pst = conn.prepareStatement(
                "UPDATE users SET name = ?, username = ?, email = ?, phone_number = ?, date_of_birth = ? WHERE user_id = ?"
            );
            pst.setString(1, name);
            pst.setString(2, username);
            pst.setString(3, email);
            pst.setString(4, phone);
            pst.setString(5, dob);
            pst.setInt(6, userId);

            int rows = pst.executeUpdate();

            if (rows > 0) {
                // Update session attributes as well
                session.setAttribute("userName", name);
                session.setAttribute("userUsername", username);
                session.setAttribute("userEmail", email);
                session.setAttribute("userPhone", phone);
                session.setAttribute("userDOB", dob);
                session.setAttribute("msg", "Profile updated successfully.");
            } else {
                session.setAttribute("msg", "Failed to update profile.");
            }

            response.sendRedirect("seekerDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
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
