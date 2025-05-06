<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - DodoJobs</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <div class="logo-container">
            <img src="images/logo.png" alt="DodoJobs Logo" class="logo">
            <div>
                <h1>DodoJobs</h1>
                <p class="tagline">Simple. Swift. Dodo.</p>
            </div>
        </div>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <div class="form-container">
            <h1>Create Your Account</h1>

            <% if (request.getAttribute("errors") != null) { %>
                <div class="error-messages">
                    <% for (String error : (List<String>) request.getAttribute("errors")) { %>
                        <p><%= error %></p>
                    <% } %>
                </div>
            <% } else if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="register" method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                    <small>Must contain at least 8 characters with uppercase, lowercase, and number</small>
                </div>

                <div class="form-group">
                    <label for="userType">I'm looking for</label>
                    <select id="userType" name="userType" required>
                        <option value="" disabled selected>Select account type</option>
                        <option value="job_seeker">Job Opportunities</option>
                        <option value="employer">To Hire Talent</option>
                    </select>
                </div>

                <button type="submit" class="btn">Join DodoJobs</button>
            </form>

            <p class="login-link">Already have an account? <a href="login.jsp">Sign in</a></p>
        </div>
    </main>
</body>
</html>
