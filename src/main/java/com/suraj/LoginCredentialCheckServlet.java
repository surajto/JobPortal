package com.suraj;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.*;

@WebServlet("/LoginCredentialCheckServlet")
public class LoginCredentialCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // User credentials
        String emailOrUsername = request.getParameter("email").trim();
        String pass = request.getParameter("password").trim();
        String role = request.getParameter("role").trim();

        System.out.println("Role: " + role);
        System.out.println("Email/Username: " + emailOrUsername);
        System.out.println("Password: " + pass);
        
        // Database credentials
        String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
        String dbUser = "root";
        String dbPass = "suraj12345";
        
        	if (role == null || role.isEmpty()) {
        	    response.sendRedirect("loginPage.jsp?roleError=1"); 
        	    return;
        	}
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String query = "";
            if ("seeker".equals(role)) {
                query = "SELECT * FROM users WHERE ((email = ? or username = ?) AND password = ?)";
            } else if ("recruiter".equals(role)){
                query = "SELECT * FROM recruiter WHERE ((email = ? or recruiter_name = ?) AND password = ?)";
            } else {
                query = "SELECT * FROM admin WHERE ((admin_email = ? or admin_name = ?) AND password = ?)";
            }
            
            System.out.println("Final SQL Query: " + query);

            ps = conn.prepareStatement(query);
            ps.setString(1, emailOrUsername);
            ps.setString(2, emailOrUsername);
            ps.setString(3, pass);
            rs = ps.executeQuery();

            if (rs.next()) {
                if ("seeker".equals(role)) {
                	int id = rs.getInt("user_id");
                	String name = rs.getString("name");
                	String username = rs.getString("username");
                	String email = rs.getString("email");
                	String phone_number = rs.getString("phone_number");
                	String dob = rs.getString("date_of_birth");
                	String password = rs.getString("password");

                	HttpSession session = request.getSession();
                	session.setAttribute("userId", id);
                	session.setAttribute("userName", name);
                	session.setAttribute("userUsername", username);
                	session.setAttribute("userEmail", email);
                	session.setAttribute("userPhone", phone_number);
                	session.setAttribute("userDOB", dob);
                	session.setAttribute("userPassword", password);
                	response.sendRedirect("seekerDashboard.jsp");
                	
                } else if ("recruiter".equals(role)) {
                	int id = rs.getInt("recruiter_id");
                	String cName = rs.getString("company_name");
                	String rName = rs.getString("recruiter_name");
                	String email = rs.getString("email");
                	String phone_number = rs.getString("phone_number");
                	String password = rs.getString("password");

                	HttpSession session = request.getSession();
                	session.setAttribute("id", id);
                	session.setAttribute("cName", cName);
                	session.setAttribute("rName", rName);
                	session.setAttribute("email", email);
                	session.setAttribute("phone", phone_number);
                	session.setAttribute("password", password);
                    response.sendRedirect("recruiterDashboard.jsp");
                } else {
                    response.sendRedirect("adminDashboard.jsp");
                }
            } else {
                response.sendRedirect("loginPage.jsp?notfound=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("loginPage.jsp?error=1");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
