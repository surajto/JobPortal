<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    String r_id = request.getParameter("r_id");
    String dbURL = "jdbc:mysql://localhost:3306/alumni_portal";
    String dbUser = "root";
    String dbPass = "suraj12345";

    String companyName = "";
    String recruiterName = "";
    String email = "";
    String phone = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        String sql = "SELECT * FROM recruiter WHERE recruiter_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, r_id);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            companyName = rs.getString("company_name");
            recruiterName = rs.getString("recruiter_name");
            email = rs.getString("email");
            phone = rs.getString("phone_number");
        }

        conn.close();
    } catch (Exception e) {
        out.println("<p class='error'>Database connection error: " + e.getMessage() + "</p>");
    }
%>
<div class="info">
	<h2>Edit Profile</h2>
	<form action="RecruiterProfileUpdate" method="post">

		<label>Company Name: </label>
		<input type="text" value="<%=companyName %>" name="com_name" required>
		
		<label>Recruiter Name: </label>
		<input type="text" value="<%=recruiterName %>" name="name" required>

		<label>Email: </label>
		<input type="email" value="<%=email %>" name="email" required>

		<label>Phone Number: </label>
		<input type="text" value="<%=phone %>" name="phone" required>
		
		<button type="submit">Change</button>
	</form>
</div>
</body>
</html>