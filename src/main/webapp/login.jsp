<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - DodoJobs</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        h1 {
            color: #6e48aa;
            text-align: center;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .btn-login {
            width: 100%;
            background: linear-gradient(135deg, #6e48aa 0%, #9d50bb 100%);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(110, 72, 170, 0.3);
        }
        .register-link {
            text-align: center;
            margin-top: 20px;
        }
        .error-message {
            color: #e74c3c;
            background-color: #fdecea;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo-container" style="gap: 10px;">
            <img src="images/logo.png" alt="DodoJobs Logo" class="logo">
            <div>
                <h1>DodoJobs</h1>
                <p class="tagline">Simple. Swift. Dodo.</p>
            </div>
        </div>
    </header>

    <main class="login-container">
        <h1>Login to Your Account</h1>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                Invalid username or password. Please try again.
            </div>
        <% } %>
        
        <form action="login" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn-login">Login</button>
        </form>
        
        <div class="register-link">
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </main>
</body>
</html>