<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.jobportal.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"job_seeker".equals(user.getUserType())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Complete Your Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <h2>Complete Your Profile</h2>
    <form action="${pageContext.request.contextPath}/store-profile" method="post" enctype="multipart/form-data">
        <label>Full Name:</label>
        <input type="text" name="fullName" required><br>

        <label>Email:</label>
        <input type="email" name="email" required><br>

        <label>Age:</label>
        <input type="number" name="age" required><br>

        <label>Phone:</label>
        <input type="text" name="phone" required><br>

        <label>Location:</label>
        <input type="text" name="location" required><br>

        <label>Skills:</label>
        <input type="text" name="skills" required><br>

        <label>Experience (Years):</label>
        <input type="number" name="experienceYears" required><br>

        <label>Education:</label>
        <input type="text" name="education" required><br>

        <label>University:</label>
        <input type="text" name="university" required><br>

        <label>Bio:</label>
        <textarea name="bio" rows="4" required></textarea><br>

        <label>Upload Resume:</label>
        <input type="file" name="resume"><br>

        <label>Upload Profile Picture:</label>
        <input type="file" name="profilePicture"><br><br>

        <input type="submit" value="Save Profile">
    </form>
</body>
</html>
