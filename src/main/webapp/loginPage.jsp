<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login | Job Portal</title>
    <link rel="icon" href="assets/favicon.jpeg" type="image/jpeg">
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            animation: fadeIn 0.8s ease-in-out;
        }

        .login-container {
            background-color: #fff;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            animation: slideIn 0.8s ease-in-out;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #1e3c72;
        }

        label {
            font-weight: 600;
            margin-top: 15px;
            display: block;
            margin-bottom: 6px;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-bottom: 12px;
            transition: border-color 0.3s;
        }

        input:focus,
        select:focus {
            border-color: #2a5298;
            outline: none;
        }

        .forgot-password {
            text-align: right;
            font-size: 0.9em;
            margin-top: -8px;
            margin-bottom: 16px;
        }

        .forgot-password a {
            color: #2a5298;
            text-decoration: none;
        }

        .login-btn {
            width: 100%;
            padding: 12px;
            background-color: #2a5298;
            color: #fff;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .login-btn:hover {
            background-color: #1e3c72;
        }

        .signup-text {
            text-align: center;
            margin-top: 20px;
            font-size: 0.95em;
        }

        .signup-text a {
            color: #2a5298;
            font-weight: 600;
            text-decoration: none;
        }

        .alert {
            font-size: 0.9em;
            background-color: #ffe6e6;
            color: red;
            border-left: 4px solid red;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 10px;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 30px 20px;
            }
        }
    </style>
    <script>
        function openSignUpPage() {
            const role = document.getElementById("role").value;
            if (role === "seeker") {
                window.location.href = "SignInPageSeeker.jsp";
            } else if (role === "recruiter") {
                window.location.href = "SignInPageRecruiter.jsp";
            } else {
                alert("⚠️ Admin! You can't register!");
            }
        }
    </script>
</head>
<body>
    <div class="login-container">
        <h2>Login to Your Account</h2>
        <%
            String notFound = request.getParameter("notfound");
            String error = request.getParameter("error");
            String roleError = request.getParameter("roleError");
            if ("1".equals(notFound)) {
        %>
            <div class="alert">✅ Invalid Credentials – check them or register!</div>
        <%
            }
            if ("1".equals(error)) {
        %>
            <div class="alert">⚠️ An unexpected error occurred. Please try again.</div>
        <%
            }
            if ("1".equals(roleError)) {
        %>
            <div class="alert">⚠️ Please choose a role!</div>
        <%
            }
        %>

        <form action="LoginCredentialCheckServlet" method="post">
            <label for="email">Email or Username</label>
            <input type="text" id="email" name="email" placeholder="Enter your email or username" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>

            <label for="role">Select Your Role</label>
            <select id="role" name="role" required>
                <option value="">-- Select a role --</option>
                <option value="seeker">Job Seeker</option>
                <option value="recruiter">Recruiter</option>
                <option value="admin">Admin</option>
            </select>

            <div class="forgot-password">
                <a href="#">Forgot Password?</a>
            </div>

            <button type="submit" class="login-btn">Login</button>

            <div class="signup-text">
                Not a member? 
                <a href="#" onclick="openSignUpPage()">Sign Up</a>
            </div>
        </form>
    </div>
</body>
</html>
