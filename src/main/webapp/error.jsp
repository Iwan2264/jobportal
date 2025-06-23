<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - DodoJobs</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .error-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            text-align: center;
        }
        .error-code {
            font-size: 72px;
            color: #e74c3c;
            margin-bottom: 20px;
        }
        .error-message {
            font-size: 24px;
            color: #333;
            margin-bottom: 30px;
        }
        .error-details {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
            text-align: left;
        }
        .home-link {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 24px;
            background: #6e48aa;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s;
        }
        .home-link:hover {
            background: #9d50bb;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <header>
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="DodoJobs Logo" class="logo">
            <div>
                <h1>DodoJobs</h1>
                <p class="tagline">Simple. Swift. Dodo.</p>
            </div>
        </div>
    </header>

    <main class="error-container">
        <div class="error-code">
            <c:choose>
                <c:when test="${not empty requestScope['jakarta.servlet.error.status_code']}">
                    ${requestScope['jakarta.servlet.error.status_code']}
                </c:when>
                <c:otherwise>500</c:otherwise>
            </c:choose>
        </div>
        
        <div class="error-message">
            <c:choose>
                <c:when test="${not empty requestScope['jakarta.servlet.error.message']}">
                    ${requestScope['jakarta.servlet.error.message']}
                </c:when>
                <c:when test="${not empty exception}">
                    ${exception.message}
                </c:when>
                <c:otherwise>
                    Oops! Something went wrong.
                </c:otherwise>
            </c:choose>
        </div>
        
        <c:if test="${not empty exception}">
            <div class="error-details">
                <h3>Technical Details:</h3>
                <pre>${exception.stackTrace}</pre>
            </div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/index.jsp" class="home-link">Return to Home</a>
    </main>
</body>
</html>