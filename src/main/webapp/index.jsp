<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DodoJobs - Your Career Partner</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        header {
            background: linear-gradient(135deg, #6e48aa 0%, #9d50bb 100%);
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .logo-container {
            display: flex;
            align-items: center;
        }
        .logo {
            height: 50px;
            margin-right: 15px;
        }
        .tagline {
            font-style: italic;
            font-size: 0.9rem;
            color: #f8f8f8;
        }
        nav ul {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
        }
        nav ul li a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        nav ul li a:hover {
            background-color: rgba(255,255,255,0.2);
            border-radius: 4px;
        }
        .hero {
            background: url('images/hero-bg.jpg') center/cover;
            height: 60vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            position: relative;
        }
        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 800px;
            padding: 0 20px;
        }
        .hero h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
        }
        .btn {
            background-color: #ff6b6b;
            color: white;
            padding: 12px 30px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .btn:hover {
            background-color: #ff5252;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        footer {
            background-color: #2c3e50;
            color: white;
            text-align: center;
            padding: 1.5rem;
            margin-top: 2rem;
        }
    </style>
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
                <li><a href="jobs.jsp">Browse Jobs</a></li>
                <li><a href="employers.jsp">For Employers</a></li>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="register.jsp">Register</a></li>
            </ul>
        </nav>
    </header>
    
    <main>
        <section class="hero">
            <div class="hero-content">
                <h1>Find Your Perfect Career Match</h1>
                <p>Join thousands of professionals who found their dream jobs through DodoJobs</p>
                <a href="register.jsp" class="btn">Get Started Now</a>
            </div>
        </section>
        
        <section style="padding: 3rem 2rem; text-align: center;">
            <h2>Why Choose DodoJobs?</h2>
            <div style="display: flex; justify-content: center; gap: 2rem; margin-top: 2rem;">
                <div style="flex: 1; max-width: 300px;">
                    <h3>Simple</h3>
                    <p>Easy-to-use interface that gets you results in minutes</p>
                </div>
                <div style="flex: 1; max-width: 300px;">
                    <h3>Swift</h3>
                    <p>Lightning-fast job matching with our smart algorithms</p>
                </div>
                <div style="flex: 1; max-width: 300px;">
                    <h3>Dodo</h3>
                    <p>Unique approach that makes job hunting effortless</p>
                </div>
            </div>
        </section>
    </main>
    
    <footer>
        <p>&copy; 2023 DodoJobs. All rights reserved. | Simple. Swift. Dodo.</p>
    </footer>
</body>
</html>