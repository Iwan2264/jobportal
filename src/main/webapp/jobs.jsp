<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.dao.JobDAO, com.jobportal.model.Job, java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    String searchQuery = request.getParameter("search");
    JobDAO jobDao = new JobDAO();
    List<Job> jobs;

    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        jobs = jobDao.searchJobs(searchQuery.trim());
    } else {
        jobs = jobDao.getAllJobs();
    }
    request.setAttribute("jobs", jobs);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Browse Jobs - DodoJobs</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        header {
            background: linear-gradient(135deg, #6e48aa 0%, #9d50bb 100%);
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo-container {
            display: flex;
            align-items: center;
        }
        .logo {
            height: 50px;
            margin-right: 15px;
        }
        nav ul {
            display: flex;
            list-style: none;
        }
        nav ul li a {
            color: white;
            padding: 0.5rem 1rem;
            text-decoration: none;
        }
        nav ul li a:hover {
            background: rgba(255,255,255,0.2);
            border-radius: 4px;
        }
        main {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .search-container {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }
        .search-container form {
            display: flex;
            gap: 10px;
        }
        .search-container input {
            flex: 1;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .search-container button {
            background: linear-gradient(135deg, #6e48aa, #9d50bb);
            color: white;
            border: none;
            padding: 0 1.5rem;
            border-radius: 4px;
            cursor: pointer;
        }
        .job-listings {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
        }
        .job-card {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .job-card:hover {
            transform: translateY(-5px);
        }
        .company-logo {
            width: 60px;
            height: 60px;
            object-fit: contain;
            margin-bottom: 1rem;
        }
        .btn {
            display: inline-block;
            margin-top: 1rem;
            padding: 8px 16px;
            background: linear-gradient(135deg, #6e48aa, #9d50bb);
            color: white;
            border-radius: 4px;
            text-decoration: none;
        }
        .no-jobs {
            text-align: center;
            background: white;
            padding: 2rem;
            border-radius: 8px;
            grid-column: 1 / -1;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="DodoJobs Logo" class="logo">
            <h1>DodoJobs</h1>
        </div>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="jobs.jsp">Browse Jobs</a></li>
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <h1>Find Your Next Opportunity</h1>

        <div class="search-container">
            <form method="get" action="jobs.jsp">
                <input type="text" name="search" placeholder="Search jobs..." 
                       value="${param.search != null ? param.search : ''}">
                <button type="submit">Search</button>
            </form>
        </div>

        <div class="job-listings">
            <c:choose>
                <c:when test="${empty jobs}">
                    <div class="no-jobs">
                        <h2>No jobs found</h2>
                        <p>Try adjusting your search or check back later.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="job" items="${jobs}">
                        <div class="job-card">
                            <img src="${pageContext.request.contextPath}/${job.logoPath}" 
                                 class="company-logo"
                                 alt="${job.companyName} Logo"
                                 onerror="this.src='${pageContext.request.contextPath}/images/default-company.png'">
                            <h2>${job.title}</h2>
                            <h3>${job.companyName}</h3>
                            <p><strong>Location:</strong> ${job.location}</p>
                            <p><strong>Salary:</strong> ${job.salary}</p>
                            <p>${job.description.length() > 150 ? job.description.substring(0, 150) + "..." : job.description}</p>
                            <a class="btn" href="job-details.jsp?id=${job.jobId}">View Details</a>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</body>
</html>
