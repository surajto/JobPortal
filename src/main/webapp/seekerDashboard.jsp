<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Seeker Dashboard | Job Portal</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Inter', sans-serif;
        background: linear-gradient(to right, #e3f2fd, #bbdefb);
        color: #0d47a1;
    }

    nav {
        background: #0d47a1;
        color: white;
        padding: 1.2rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }

    nav h1 {
        font-size: 1.8rem;
        font-weight: 700;
        letter-spacing: 1px;
    }

    .right_nav a, .right_nav button {
        color: white;
        text-decoration: none;
        margin-left: 24px;
        font-weight: 500;
        background: none;
        border: none;
        cursor: pointer;
        font-size: 16px;
        transition: all 0.3s ease;
    }

    .right_nav a:hover, .right_nav button:hover {
        color: #ffeb3b;
        transform: scale(1.05);
    }

    .right_nav {
        display: flex;
        align-items: center;
    }

    #main-content {
        padding: 60px 20px;
        max-width: 1200px;
        margin: 0 auto;
    }

    .welcome-section {
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(8px);
        border-radius: 20px;
        padding: 50px 40px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        text-align: center;
        animation: fadeIn 0.8s ease-in-out;
    }

    .welcome-text h2 {
        font-size: 2.5rem;
        color: #0d47a1;
        margin-bottom: 20px;
    }

    .welcome-text p {
        font-size: 1.1rem;
        color: #333;
        margin-bottom: 30px;
        max-width: 750px;
        margin-left: auto;
        margin-right: auto;
    }

    .welcome-image img {
        width: 150px;
        margin-bottom: 30px;
        transition: transform 0.3s ease;
    }

    .welcome-image img:hover {
        transform: scale(1.1);
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .features {
        margin-top: 50px;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 25px;
    }

    .feature-card {
        background: white;
        padding: 30px;
        border-radius: 16px;
        text-align: center;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border-left: 5px solid #1565c0;
    }

    .feature-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
    }

    .feature-card h3 {
        color: #1565c0;
        margin-bottom: 15px;
        font-size: 1.3rem;
    }

    .feature-card p {
        color: #444;
        font-size: 0.95rem;
        line-height: 1.5;
    }

</style>
<script>
    function LoadContent(url) {
        fetch(url)
        .then(res => res.text())
        .then(data => {
            document.getElementById("main-content").innerHTML = data;
        });
    }
</script>
</head>
<body>
<%
    session = request.getSession(false);
    if (session != null && session.getAttribute("userId") != null) {
        int id = (Integer) session.getAttribute("userId");
        String name = (String) session.getAttribute("userName");
        String username = (String) session.getAttribute("userUsername");
        String email = (String) session.getAttribute("userEmail");
        String phone = (String) session.getAttribute("userPhone");
        String dob = (String) session.getAttribute("userDOB");
        String password = (String) session.getAttribute("userPassword");
    } else {
        response.sendRedirect("login.jsp");
        return;
    }

    String status = request.getParameter("hogya");
    if ("success".equals(status)) {
%>
    <script>alert("✅ Thanks for applying for the job!");</script>
<% } else if ("already_applied".equals(status)) { %>
    <script>alert("✅ You already applied for this job!");</script>
<% } %>
<%
    String error = request.getParameter("error");
    if ("true".equals(error)) {
%>
    <script>alert("❌ Error submitting application.");</script>
<% }

    String dbError = request.getParameter("dbError");
    if ("true".equals(dbError)) {
%>
    <script>alert("❌ Issue with DB! Contact support!");</script>
<% } %>

<nav>
    <div class="left_nav">
        <h1>Job Portal</h1>
    </div>
    <div class="right_nav">
        <a href="#" onclick="LoadContent('jobListing.jsp')">🔍 Jobs</a>
        <a href="#" onclick="LoadContent('MyApplicationSeeker.jsp')">📄 Applications</a>
        <a href="#" onclick="LoadContent('MyProfileSeeker.jsp')">👤 Profile</a>
        <form action="logOut.jsp" style="display:inline;"><button>🚪 Log Out</button></form>
    </div>
</nav>

<div id="main-content">
    <section class="welcome-section">
        <div class="welcome-image">
            <img src="https://cdn-icons-png.flaticon.com/512/3135/3135755.png" alt="Job Seeker">
        </div>
        <div class="welcome-text">
            <h2>👋 Welcome, Seeker!</h2>
            <p>Discover thousands of job opportunities curated just for you. Apply, track, and stay ahead in your career journey.</p>
        </div>

        <div class="features">
            <div class="feature-card">
                <h3>🚀 Explore Jobs</h3>
                <p>Browse personalized job recommendations and trending roles in your field.</p>
            </div>
            <div class="feature-card">
                <h3>📄 My Applications</h3>
                <p>Manage all your job applications in one place with real-time status updates.</p>
            </div>
            <div class="feature-card">
                <h3>👤 Profile Settings</h3>
                <p>Update your resume, contact details, and preferences to attract top recruiters.</p>
            </div>
        </div>
    </section>
</div>
</body>
</html>
