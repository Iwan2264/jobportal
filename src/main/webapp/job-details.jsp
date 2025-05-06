<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jobportal.dao.JobDAO, com.jobportal.model.Job" %>
<%
    String jobIdParam = request.getParameter("id");
    Job job = null;

    if (jobIdParam != null) {
        try {
            int jobId = Integer.parseInt(jobIdParam);
            job = new JobDAO().getJobById(jobId);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?msg=Invalid Job ID");
            return;
        }
    }

    if (job == null) {
        response.sendRedirect("error.jsp?msg=Job not found");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= job.getTitle() %> - Job Details | DodoJobs</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        .job-details-container {
            max-width: 900px;
            margin: 3rem auto;
            padding: 2rem;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .job-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .company-logo-large {
            width: 100px;
            height: 100px;
            object-fit: contain;
            border-radius: 10px;
            margin-bottom: 1rem;
        }

        .job-title {
            font-size: 2rem;
            margin: 0.5rem 0;
        }

        .company-name {
            font-size: 1.3rem;
            color: #666;
        }

        .job-meta {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 1.5rem;
            margin: 2rem 0;
            font-size: 1rem;
            color: #444;
        }

        .job-category {
            background: #e1f5fe;
            padding: 0.4rem 1rem;
            border-radius: 20px;
            color: #0277bd;
            font-weight: bold;
        }

        .job-description {
            margin-bottom: 2.5rem;
        }

        .job-description h3 {
            color: #333;
            margin-bottom: 1rem;
        }

        .job-description p {
            line-height: 1.6;
        }

        .apply-form {
            text-align: center;
        }

        .btn-apply {
            background: #6e48aa;
            color: #fff;
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn-apply:hover {
            background: #593a8b;
        }
    </style>
</head>
<body>

    <%-- Optional: Include header and nav using JSP include --%>
    <%-- <%@ include file="header.jsp" %> --%>

    <main class="job-details-container">
        <div class="job-header">
            <% if (job.getLogoPath() != null && !job.getLogoPath().isEmpty()) { %>
                <img src="<%= request.getContextPath() + "/uploads/" + job.getLogoPath() %>" alt="Company Logo" class="company-logo-large">
            <% } %>
            <h1 class="job-title"><%= job.getTitle() %></h1>
            <h2 class="company-name"><%= job.getCompanyName() %></h2>
        </div>

        <div class="job-meta">
            <span><strong>Location:</strong> <%= job.getLocation() %></span>
            <span><strong>Salary:</strong> <%= job.getSalary() %></span>
            <span><strong>Type:</strong> <%= job.getJobType() %></span>
            <span class="job-category"><%= job.getCategory() %></span>
        </div>

        <div class="job-description">
            <h3>Job Description</h3>
            <p><%= job.getDescription() %></p>
        </div>

        <form action="<%= request.getContextPath() %>/ApplyJobServlet" method="post" class="apply-form">
            <input type="hidden" name="jobId" value="<%= job.getJobId() %>">
            <button type="submit" class="btn-apply">
                <i class="fas fa-paper-plane"></i> 1-Click Apply
            </button>
        </form>
    </main>
</body>
</html>
