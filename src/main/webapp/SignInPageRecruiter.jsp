<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up - Job Portal (Recruiter)</title>
    <style>
    	/* General Page Setup */
body {
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #f0f2f5;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

/* Container for Signup */
.signup-container {
    background-color: #ffffff;
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    width: 400px;
    max-width: 90%;
}

.signup-container h2 {
    margin-bottom: 10px;
    text-align: center;
    color: #333;
}

.signup-container p {
    text-align: center;
    font-size: 14px;
    color: #555;
}

.signup-container form {
    margin-top: 20px;
}

/* Form Groups */
.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 6px;
    font-weight: bold;
    color: #444;
}

.form-group input[type="text"],
.form-group input[type="email"],
.form-group input[type="password"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    outline: none;
    transition: border 0.3s;
}

.form-group input:focus {
    border-color: #4CAF50;
}

/* Terms Section */
.terms {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    font-size: 13px;
    color: #444;
}

.terms input {
    margin-right: 8px;
}

/* Button Styling */
button {
    width: 100%;
    background-color: #4CAF50;
    color: white;
    padding: 12px;
    font-size: 16px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #45a049;
}

/* Extra Links */
.signup-container a {
    color: #4CAF50;
    text-decoration: none;
    font-weight: 500;
}

.signup-container a:hover {
    text-decoration: underline;
}
    	
    </style>
    <script>
        function validateForm() {
            let companyName = document.forms["signupForm"]["company_name"].value;
            let recruiterName = document.forms["signupForm"]["recruiter_name"].value;
            let email = document.forms["signupForm"]["email"].value;
            let phone = document.forms["signupForm"]["phone_number"].value;
            let password = document.forms["signupForm"]["password"].value;
            let confirmPassword = document.forms["signupForm"]["confirm_password"].value;

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
            if (password !== confirmPassword) {
                alert("Passwords do not match!");
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
        <h2>Join as a Recruiter</h2>
        <p>Create your recruiter account and start hiring talent.</p>

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

        <form action="RegisterRecruiterServlet" method="post" name="signupForm" onsubmit="return validateForm();">
            <div class="form-group">
                <label>Company Name</label>
                <input type="text" name="company_name" required>
            </div>

            <div class="form-group">
                <label>Recruiter Name</label>
                <input type="text" name="recruiter_name" required>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone_number" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirm_password" required>
            </div>

            <div class="terms">
                <input type="checkbox" name="terms" required>
                <label>I agree to the <a href="#">Terms and Conditions</a></label>
            </div>

            <button type="submit">Sign Up</button>

            <p>Already have an account? <a href="loginPage.jsp">Login</a></p>
            <p><a href="start.jsp">Back to Home</a></p>
        </form>
    </div>
</body>
</html>
