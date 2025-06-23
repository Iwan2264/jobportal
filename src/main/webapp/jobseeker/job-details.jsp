<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jobportal.model.Job" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="job" scope="request" type="com.jobportal.model.Job" />

<!DOCTYPE html>
<html>
<head>
    <title>Job Details</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 60%;
            margin: 40px auto;
            background-color: #fff;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        h1 {
            margin-bottom: 10px;
            color: #333;
        }
        .meta {
            color: #777;
            font-size: 14px;
            margin-bottom: 20px;
        }
        .description {
            line-height: 1.6;
            color: #444;
        }
        .back-link {
            margin-top: 30px;
            display: inline-block;
            color: #007bff;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .apply-btn {
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .apply-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h1><%= job.getTitle() %></h1>

    <div class="meta">
        <strong>Company:</strong> <%= job.getCompanyName() %> |
        <strong>Location:</strong> <%= job.getLocation() %> |
        <strong>Type:</strong> <%= job.getType() %> |
        <strong>Salary:</strong> ₹<%= job.getSalary() %>
    </div>

    <div class="description">
        <h3>Job Description:</h3>
        <p><%= job.getDescription() %></p>
    </div>

    <form action="<c:url value='/apply-job'/>" method="post">
        <input type="hidden" name="jobId" value="<%= job.getJobId() %>" />
        <button type="submit" class="apply-btn">Apply Now</button>
    </form>

    <a class="back-link" href="<c:url value='/jobseeker/dashboard.jsp'/>">&larr; Back to Dashboard</a>
</div>

</body>
</html>
