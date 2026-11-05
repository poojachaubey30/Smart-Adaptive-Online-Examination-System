```jsp
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Student"%>
<%@page import="java.util.Objects"%>

<%
    Student student = (Student) session.getAttribute("student");

    String studentName = "Not available";
    String studentEmail = "Not available";
    String studentCourse = "Not available";
    String studentStatus = "Not available";

    if (student != null) {
        if (student.getName() != null) {
            studentName = student.getName();
        }

        if (student.getEmail() != null
                && !student.getEmail().trim().isEmpty()) {
            studentEmail = student.getEmail();
        }

        if (student.getCourse() != null
                && !student.getCourse().trim().isEmpty()) {
            studentCourse = student.getCourse();
        }

        // Status is not currently a field in Student.java.
        // Use ACTIVE only as a temporary display value.
        studentStatus = "ACTIVE";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>

    <style>
        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            margin: 0;
            background: #f4f6fb;
            min-height: 100vh;
        }

        .header {
            background: #1e293b;
            color: white;
            padding: 22px;
            text-align: center;
        }

        .header h1 {
            margin: 0;
        }

        .container {
            max-width: 650px;
            margin: 40px auto;
            padding: 20px;
        }

        .profile-card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
        }

        .profile-card h2 {
            color: #0284c7;
            text-align: center;
            margin-bottom: 25px;
        }

        .detail {
            padding: 15px 5px;
            border-bottom: 1px solid #e2e8f0;
            color: #334155;
            overflow-wrap: anywhere;
        }

        .label {
            font-weight: bold;
            display: inline-block;
            width: 130px;
        }

        .back-btn {
            display: block;
            width: fit-content;
            margin: 25px auto 0;
            padding: 12px 22px;
            background: #0284c7;
            color: white;
            text-decoration: none;
            border-radius: 7px;
        }

        .back-btn:hover {
            background: #0369a1;
        }

        @media (max-width: 500px) {
            .container {
                margin: 20px auto;
                padding: 15px;
            }

            .profile-card {
                padding: 20px;
            }

            .label {
                width: 110px;
            }
        }
    </style>
</head>

<body>

<div class="header">
    <h1>My Profile</h1>
</div>

<div class="container">
    <div class="profile-card">

        <h2>Student Details</h2>

        <div class="detail">
            <span class="label">Name:</span>
            <%= studentName %>
        </div>

        <div class="detail">
            <span class="label">Email:</span>
            <%= studentEmail %>
        </div>

        <div class="detail">
            <span class="label">Course:</span>
            <%= studentCourse %>
        </div>

        <div class="detail">
            <span class="label">Status:</span>
            <%= studentStatus %>
        </div>

        <a class="back-btn"
           href="<%=request.getContextPath()%>/studentDashboard.jsp">
            Back to Dashboard
        </a>

    </div>
</div>

</body>
</html>
```