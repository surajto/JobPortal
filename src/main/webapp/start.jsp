<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Job Portal</title>
    <link rel="icon" type="image/jpeg" href="images/favicon.jpeg">
    <link rel="stylesheet" href="css/start.css">
    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f4f8;
            color: #1f2937;
        }

        a {
            text-decoration: none;
        }

        /* Navigation Bar */
        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 60px;
            background: linear-gradient(90deg, #3b82f6, #2563eb);
            color: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        nav h1 {
            font-size: 30px;
            font-weight: bold;
        }

        .nav-links a {
            color: white;
            margin-left: 20px;
            padding: 10px 20px;
            border: 2px solid white;
            border-radius: 8px;
            transition: 0.3s;
            font-weight: 500;
        }

        .nav-links a:hover {
            background-color: white;
            color: #2563eb;
        }

        /* Main Section */
        main {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 80px 100px;
            background-image: url('https://www.transparenttextures.com/patterns/white-wall.png');
            animation: fadeIn 1s ease-in;
        }

        .content {
            max-width: 50%;
        }

        .content h2 {
            font-size: 52px;
            color: #1d4ed8;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .content p {
            font-size: 18px;
            line-height: 1.6;
            margin-bottom: 15px;
            color: #374151;
        }

        .quote {
            font-style: italic;
            color: #6b7280;
            margin-bottom: 30px;
        }

        .cta-btn {
            background: linear-gradient(to right, #2563eb, #1d4ed8);
            color: white;
            padding: 14px 32px;
            font-size: 18px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            display: inline-block;
        }

        .cta-btn:hover {
            background: #1e40af;
            transform: translateY(-4px);
        }

        .main_img img {
            width: 480px;
            border-radius: 15px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
            animation: slideIn 1s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(60px); }
            to { opacity: 1; transform: translateX(0); }
        }

        /* Footer */
        footer {
            position:absolute;
            bottom:0;
            width:100vw;
            background-color: #1e3a8a;
            padding-top:5px;
            padding-bottom:5px;
            color: white;
            text-align: center;
            font-size: 18px;
        }

        /* Responsive Design */
        @media (max-width: 900px) {
            main {
                flex-direction: column;
                padding: 50px 20px;
                text-align: center;
            }

            .content, .main_img {
                max-width: 100%;
            }

            .main_img img {
                width: 90%;
                margin-top: 30px;
            }

            nav {
                flex-direction: column;
                gap: 15px;
            }

            .nav-links a {
                margin: 0 10px;
            }
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav>
        <div class="left">
            <h1>Job Portal</h1>
        </div>
        <div class="right nav-links">
            <a href="loginPage.jsp">Login</a>
        </div>
    </nav>

    <!-- Main Hero Section -->
    <main>
        <div class="content">
            <h2>Find Your Dream Job Today!</h2>
            <p>Explore thousands of job listings from top companies. Sign up now and take the next step in your career.</p>
            <p class="quote">"Opportunities don't happen, you create them." – Chris Grosser</p>
            <a href="loginPage.jsp" class="cta-btn">Get Started</a>
        </div>

        <div class="main_img">
            <img src="images/main.png" alt="Job Portal Image">
        </div>
    </main>

    <!-- Footer -->
    <footer>
    &copy; 2025 Job Portal. All rights reserved. <br>
    Built with ❤️ by Team: Suraj, Tanu, Shubham, Siddarth & Harsh
</footer>


</body>
</html>
