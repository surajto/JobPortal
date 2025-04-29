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

@WebServlet("/delOpAdmin")
public class delOpAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
        String action = request.getParameter("action");
        
        String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
        String dbUser = "root";
        String dbPass = "suraj12345";
        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            
            if(action.equals("delUsers")) {
            	String deleteQuery = "DELETE FROM users WHERE user_id = ?";
            	PreparedStatement preparedStatement = conn.prepareStatement(deleteQuery);
            	preparedStatement.setInt(1, Integer.parseInt(id));
            	int rowsAffected = preparedStatement.executeUpdate();
            	if(rowsAffected > 0) {
            		response.sendRedirect("ManageUsersAdmin.jsp?success=1");
            	}
            	else {
            		response.sendRedirect("ManageUsersAdmin.jsp?error=1");
            	}
            }
            else if(action.equals("delRecruiter")) {
            	String deleteQuery = "DELETE FROM recruiter WHERE recruiter_id = ?";
            	PreparedStatement preparedStatement = conn.prepareStatement(deleteQuery);
            	preparedStatement.setInt(1, Integer.parseInt(id));
            	int rowsAffected = preparedStatement.executeUpdate();
            	if(rowsAffected > 0) {
            		response.sendRedirect("ManageRecruiterAdmin.jsp?success=1");
            	}
            	else {
            		response.sendRedirect("ManageRecruiterAdmin.jsp?error=1");
            	}
            }
            else {
            	String deleteQuery = "DELETE FROM jobs WHERE job_id = ?";
            	PreparedStatement preparedStatement = conn.prepareStatement(deleteQuery);
            	preparedStatement.setInt(1, Integer.parseInt(id));
            	int rowsAffected = preparedStatement.executeUpdate();
            	if(rowsAffected > 0) {
            		response.sendRedirect("ManageJobsAdmin.jsp?success=1");
            	}
            	else {
            		response.sendRedirect("ManageJobsAdmin.jsp?error=1");
            	}
            }
      

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=1");
        }
	}
}
