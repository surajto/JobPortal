<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
<style>
	body {
		margin: 0;
		padding: 0;
		font-family: Arial, sans-serif;
		background: #f2f2f2;
	}
	.info {
		width: 400px;
		margin: 50px auto;
		padding: 30px;
		background: white;
		border-radius: 10px;
		box-shadow: 0 0 10px rgba(0,0,0,0.1);
	}
	form {
		display: flex;
		flex-direction: column;
	}
	label {
		margin-top: 10px;
		font-weight: bold;
	}
	input {
		padding: 8px;
		margin-top: 5px;
		border-radius: 5px;
		border: 1px solid #ccc;
	}
	button {
		margin-top: 20px;
		padding: 10px;
		background: #4CAF50;
		color: white;
		border: none;
		border-radius: 5px;
		cursor: pointer;
	}
	button:hover {
		background: #45a049;
	}
</style>

<script>
	
</script>
</head>
<body>
<%
    int id = (Integer) session.getAttribute("userId");
    String name = (String) session.getAttribute("userName");
    String username = (String) session.getAttribute("userUsername");
    String email = (String) session.getAttribute("userEmail");
    String phone = (String) session.getAttribute("userPhone");
    String dob = (String) session.getAttribute("userDOB");
%>
<div class="info">
	<h2>Edit Profile</h2>
	<form action="SeekerProfileUpdate" method="post">
		<label>Full Name: </label>
		<input type="text" value="<%=name %>" name="name1" required>

		<label>Username: </label>
		<input type="text" value="<%=username %>" name="username1" required>

		<label>Email: </label>
		<input type="email" value="<%=email %>" name="email1" required>

		<label>Phone Number: </label>
		<input type="text" value="<%=phone %>" name="phone1" required>

		<label>Date of Birth: </label>
		<input type="date" value="<%=dob %>" name="dob1" required>
		
		<button type="submit">Change</button>
	</form>
</div>
</body>
</html>
