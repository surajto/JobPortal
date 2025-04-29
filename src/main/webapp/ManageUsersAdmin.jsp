<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Admin Panel</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3498db;
            --bg-light: #f4f6f8;
            --text-dark: #333;
            --text-light: #eee;
            --border-radius: 8px;
            --box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease-in-out;
            --font-family: 'Poppins', sans-serif;
            --nav-bg: #2c3e50;
            --nav-link-hover: #3498db;
            --table-header-bg: #3498db;
            --table-row-even: #ecf0f1;
            --action-btn-edit: #27ae60;
            --action-btn-delete: #e74c3c;
        }

        body {
            font-family: var(--font-family);
            margin: 0;
            padding: 0;
            background-color: var(--bg-light);
            color: var(--text-dark);
            line-height: 1.6;
        }

        .nav {
            background-color: var(--nav-bg);
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 15px 0;
            width: 100%;
            position:fixed;
            top:0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .nav a {
            color: var(--text-light);
            text-decoration: none;
            font-weight: 500;
            font-size: 1rem;
            padding: 10px 15px;
            border-radius: var(--border-radius);
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .nav a:hover {
            background-color: rgba(255, 255, 255, 0.15);
            color: var(--nav-link-hover);
        }

        .table-container {
            overflow-x: auto;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 20px;
            margin: 20px auto;
            background-color: #fff;
            max-width: 1200px;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid var(--border-color);
        }

        .user-table th, .user-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        .user-table th {
            background-color: var(--table-header-bg);
            color: var(--text-light);
            font-weight: 500;
            font-size: 1rem;
        }

        .user-table tbody tr:nth-child(even) {
            background-color: var(--table-row-even);
        }

        .user-table tbody tr:hover {
            background-color: #f9f9f9;
        }

        .action-btn {
            padding: 8px 12px;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 500;
            color: white;
            text-decoration: none;
            transition: background-color 0.3s ease;
            margin-right: 8px;
            font-size: 0.9rem;
            cursor: pointer;
        }

        .action-btn.edit {
            background-color: var(--action-btn-edit);
        }

        .action-btn.edit:hover {
            background-color: #1e8449;
        }

        .action-btn.delete {
            background-color: var(--action-btn-delete);
        }

        .action-btn.delete:hover {
            background-color: #c0392b;
        }

        h1 {
            color: var(--primary-color);
            text-align: center;
            margin-top: 100px;
            margin-bottom: 20px;
            font-size: 2rem;
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="nav">
    <a href="adminDashboard.jsp">Home</a>
    <a href="ManageUsersAdmin.jsp" class="active">Manage Users</a>
    <a href="ManageRecruiterAdmin.jsp">Manage Recruiters</a>
    <a href="ManageJobsAdmin.jsp">Manage Jobs</a>
    <a href="ManageApplicationsAdmin.jsp">Manage Applications</a>
    <a href="logOut.jsp">Logout</a>
</div>

<h1>User Management</h1>

<div class="table-container">
    <table class="user-table">
        <thead>
        <tr>
            <th>User ID</th>
            <th>Name</th>
            <th>Username</th>
            <th>Email</th>
            <th>Phone</th>
            <th>DOB</th>
            <th>Gender</th>
            <th>Registration Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            try (
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_portal", "root", "suraj12345");
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users");
                ResultSet rs = stmt.executeQuery()
            ) {
                Class.forName("com.mysql.cj.jdbc.Driver");

                while(rs.next()) {
                    int user_id = rs.getInt("user_id");
                    String name = rs.getString("name");
                    String username = rs.getString("username");
                    String email = rs.getString("email");
                    String phone_number = rs.getString("phone_number");
                    String date_of_birth = rs.getString("date_of_birth");
                    String gender = rs.getString("gender");
                    String acc_registration_date = rs.getString("created_at");
        %>
        <tr>
            <td><%= user_id %></td>
            <td><%= name %></td>
            <td><%= username %></td>
            <td><%= email %></td>
            <td><%= phone_number %></td>
            <td><%= date_of_birth %></td>
            <td><%= gender %></td>
            <td><%= acc_registration_date %></td>
            <td>
              <form action="delOpAdmin" method="post" style="display: inline;">
    			<input type="hidden" name="id" value="<%=user_id%>">
    			<input type="hidden" name="action" value="delUsers">
    			<button type="submit" class="action-btn delete">Delete</button>
			  </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='9'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>