package com.suraj;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/RegisterRecruiterServlet")
public class RegisterRecruiterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L; // this is used to save us from class exception suppose if we change our class (add/remove fields) then old object might not work so to handle that we use this id(Serilaization and deserialization) 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String companyName = request.getParameter("company_name");
		String recruiterName = request.getParameter("recruiter_name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone_number");
		String pass = request.getParameter("password");
		
		String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
	    String dbUser = "root";
	    String dbPass = "suraj12345";
	    
	    Connection con = null;
        PreparedStatement pstm = null;
	    
	    try{
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	    	con = DriverManager.getConnection(dbURL,dbUser,dbPass);
	    	
	    	String search_query = "SELECT * FROM recruiter WHERE email = ? or phone_number = ?";
	    	PreparedStatement stmt = con.prepareStatement(search_query);
	    	stmt.setString(1, email);
	    	stmt.setString(2, phone);
	    	ResultSet rs = stmt.executeQuery();  // Correct method for SELECT queries

	    	if(rs.next()) {
	    		response.sendRedirect("SignInPageRecruiter.jsp?search=1");
	    		return;
	    	}
	    	else {
	    		rs.close();
	    		stmt.close();
	    	}
	    	String query = "INSERT into recruiter (company_name, recruiter_name, email, phone_number, password) values (?,?,?,?,?)";
	    	pstm = con.prepareStatement(query);
	    	pstm.setString(1,companyName);
	    	pstm.setString(2,recruiterName);
	    	pstm.setString(3,email);
	    	pstm.setString(4,phone);
	    	pstm.setString(5,pass);
	    	
            int rows = pstm.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("SignInPageRecruiter.jsp?success=1"); // Redirect to login page
            } else {
                response.sendRedirect("SignInPageRecruiter.jsp?error=1"); // Redirect back to registration page
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SignInPageRecruiter.jsp?error=2"); // Redirect with error code
        } finally {
            try {
            	if (pstm != null) pstm.close();
            	if (con != null) con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}