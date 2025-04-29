<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up | Job Portal</title>
    <link rel="icon" type="image/jpeg" href="assets/favicon.jpeg">
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
            animation: fadeIn 1s ease-in-out;
        }

        .signup-container {
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 500px;
            animation: slideIn 1s ease-in-out;
        }

        h2 {
            text-align: center;
            color: #1e3c72;
            margin-bottom: 10px;
        }

        p {
            text-align: center;
            color: #555;
            font-size: 0.95em;
        }

        form {
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="date"],
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            transition: 0.3s;
        }

        input:focus,
        select:focus {
            border-color: #2a5298;
            outline: none;
        }

        .terms {
            display: flex;
            align-items: center;
            font-size: 0.9em;
            margin-top: 10px;
            margin-bottom: 15px;
        }

        .terms input {
            margin-right: 8px;
        }

        .terms a {
            color: #2a5298;
            text-decoration: none;
        }

        button[type="submit"] {
            width: 100%;
            background: #2a5298;
            color: white;
            padding: 12px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button[type="submit"]:hover {
            background: #1e3c72;
        }

        .signup-container p a {
            color: #2a5298;
            text-decoration: none;
            font-weight: 600;
        }

        p[style*="color:red"],
        p[style*="color:green"] {
            font-size: 0.9em;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 15px;
            text-align: center;
        }

        p[style*="color:red"] {
            background: #ffe6e6;
            border-left: 4px solid red;
        }

        p[style*="color:green"] {
            background: #e6ffe6;
            border-left: 4px solid green;
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
            .signup-container {
                padding: 30px 20px;
            }
        }
    </style>

    <script>
        function validateForm() {
            let email = document.forms["signupForm"]["email"].value;
            let password = document.forms["signupForm"]["password"].value;
            let phone = document.forms["signupForm"]["phone_num"].value;

            let emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            let phoneRegex = /^[0-9]{10}$/;

            if (!emailRegex.test(email)) {
                alert("Invalid email format!");
                return false;
            }
            if (password.length < 6) {
                alert("Password must be at least 6 characters!");
                return false;
            }
            if (!phoneRegex.test(phone)) {
                alert("Phone number must be 10 digits!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="signup-container">
        <h2>Create Account</h2>
        <p>Start your journey with us!</p>

        <!-- Success & Error Messages -->
        <%
            String success = request.getParameter("success");
            String search = request.getParameter("search");
            String error = request.getParameter("error");
            if ("1".equals(search)) {
        %>
            <p style="color:green;">✅ Already exists! Please <a href="loginPage.jsp">login</a>.</p>
        <%
            } else {
                if ("1".equals(success)) {
        %>
            <p style="color:green;">✅ Sign-up successful! Please <a href="loginPage.jsp">login</a>.</p>
        <%
                } else if ("1".equals(error)) {
        %>
            <p style="color:red;">❌ Error: Registration failed. Try again.</p>
        <%
                } else if ("2".equals(error)) {
        %>
            <p style="color:red;">❌ Error: Database issue. Contact support.</p>
        <%
                }
            }
        %>

        <form action="RegisterSeekerServlet" method="post" name="signupForm" onsubmit="return validateForm();">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullname" required>
            </div>

            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone_num" required>
            </div>

            <div class="form-group">
                <label>Gender</label>
                <select name="gender" required>
                    <option value="">Select</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="form-group">
                <label>Date of Birth</label>
                <input type="date" name="dob" required>
            </div>

            <div class="terms">
                <input type="checkbox" name="terms" required>
                <label>I agree to the <a href="#">Terms and Conditions</a></label>
            </div>

            <button type="submit">Sign Up</button>

            <p>Already have an account? <a href="loginPage.jsp">Login</a></p>
            <p><a href="start.jsp">⬅ Back to Home</a></p>
        </form>
    </div>
</body>
</html>
