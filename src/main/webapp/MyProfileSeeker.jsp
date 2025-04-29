<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px 40px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .profile-container {
            max-width: 700px;
            margin: 40px auto;
            background: white;
            border-radius: 12px;
            padding: 30px 40px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        }

        .profile-container h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .profile-info {
            margin-bottom: 14px;
        }

        .profile-info strong {
            color: #34495e;
            width: 150px;
            display: inline-block;
        }

        .edit-button {
            display: inline-block;
            margin-top: 30px;
            background-color: #2980b9;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
        }

        .edit-button:hover {
            background-color: #1f6392;
        }
    </style>
</head>
<body>

<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("logOut.jsp");
        return;
    }

    int id = (Integer) session.getAttribute("userId");
    String name = (String) session.getAttribute("userName");
    String username = (String) session.getAttribute("userUsername");
    String email = (String) session.getAttribute("userEmail");
    String phone = (String) session.getAttribute("userPhone");
    String dob = (String) session.getAttribute("userDOB");
    String msg = (String) session.getAttribute("msg");
%>

<header>
    <h1>Welcome, <%= name %>!</h1>
</header>

<div class="profile-container">
<% 
    if (msg != null) {
%>
        <p class="<%= msg.contains("success") ? "success" : "error" %>"><%= msg %></p>
<%
        session.removeAttribute("msg"); // clear message after showing
    }
%>
    <h2>Your Profile Details</h2>

    <div class="profile-info"><strong>User ID:</strong> <%= id %></div>
    <div class="profile-info"><strong>Full Name:</strong> <%= name %></div>
    <div class="profile-info"><strong>Username:</strong> <%= username %></div>
    <div class="profile-info"><strong>Email:</strong> <%= email %></div>
    <div class="profile-info"><strong>Phone:</strong> <%= phone %></div>
    <div class="profile-info"><strong>Date of Birth:</strong> <%= dob %></div>

    <a class="edit-button" href="editProfile.jsp">Edit Profile</a>
</div>

</body>
</html>
