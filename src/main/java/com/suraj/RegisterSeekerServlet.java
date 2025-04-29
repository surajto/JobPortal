package com.suraj;

import jakarta.servlet.ServletException;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterSeekerServlet")
public class RegisterSeekerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone_num");
        String gender = request.getParameter("gender");
        String date_of_birth = request.getParameter("dob");

        // Database credentials
        String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
        String dbUser = "root";
        String dbPass = "suraj12345";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Load MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish Connection
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            
            String search_query = "SELECT * FROM users WHERE email = ? or phone_number = ?";
	    	PreparedStatement stmt = conn.prepareStatement(search_query);
	    	stmt.setString(1, email);
	    	stmt.setString(2, phone);
	    	ResultSet rs = stmt.executeQuery();

	    	if(rs.next()) {
	    		response.sendRedirect("SignInPageSeeker.jsp?search=1");
	    		return;
	    	}
	    	else {
	    		rs.close();
	    		stmt.close();
	    	}
            
            // Insert Query
            String query = "INSERT INTO users (name, username, email, phone_number, date_of_birth, password, gender) VALUES (?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(query);
            ps.setString(1, fullname);
            ps.setString(2, username);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, date_of_birth);
            ps.setString(6, password);
            ps.setString(7, gender);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("SignInPageSeeker.jsp?success=1"); // Redirect to login page
            } else {
                response.sendRedirect("SignInPageSeeker.jsp?error=1"); // Redirect back to registration page
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SignInPageSeeker.jsp?error=2"); // Redirect with error code
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
