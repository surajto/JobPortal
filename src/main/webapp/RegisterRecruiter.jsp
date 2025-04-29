<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>

<% 
	String companyName = request.getParameter("company_name");
	String recruiterName = request.getParameter("recruiter_name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone_number");
	String pass = request.getParameter("password");
	
	String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
    String dbUser = "root";
    String dbPass = "suraj12345";
    
    try{
    	Class.forName("com.mysql.cj.jdbc.Driver");
    	Connection con = DriverManager.getConnection(dbURL,dbUser,dbPass);
    	String query = "INSERT into recruiter (company_name, recruiter_name, email, phone_number, password) values (?,?,?,?,?)";
    	PreparedStatement pstm = con.prepareStatement(query);
    	pstm.setString(1,companyName);
    	pstm.setString(2,recruiterName);
    	pstm.setString(3,email);
    	pstm.setString(4,phone);
    	pstm.setString(5,pass);
    	
        int rows = pstm.executeUpdate();
        con.close();

        if (rows > 0) {
%>
        <script>
            alert("Signup Successful! Redirecting to Login Page...");
            window.location.href = "loginPage.jsp";
        </script>
<%
        } else {
%>
        <script>
            alert("Registration failed. Please try again.");
            window.location.href = "SignInPageRecruiter.jsp";
        </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace(); // Print error to the console for debugging
%>
        <script>
            alert("An unexpected error occurred. Please try again later.");
            window.location.href = "SignInPageRecruiter.jsp";
        </script>
<%
    }
%>