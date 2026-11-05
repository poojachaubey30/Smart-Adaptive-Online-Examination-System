<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Exam"%>

<%
    List<Exam> examList = (List<Exam>) request.getAttribute("examList");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Available Exams</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f4f6fb;
            min-height: 100vh;
        }

        .header {
            background: #1e293b;
            color: white;
            padding: 22px;
            text-align: center;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .header h1 {
            font-size: 27px;
        }

        .container {
            width: 85%;
            max-width: 1000px;
            margin: 40px auto;
        }

        .exam-card {
            background: white;
            padding: 28px;
            margin-bottom: 22px;
            border-radius: 14px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            transition: 0.3s;
        }

        .exam-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 7px 18px rgba(0,0,0,0.12);
        }

        .exam-card h2 {
            color: #1e293b;
            margin-bottom: 20px;
            font-size: 22px;
        }

        .exam-info {
            color: #475569;
            line-height: 2;
            margin-bottom: 20px;
            font-size: 15px;
        }

        .exam-info b {
            color: #1e293b;
        }

        .start-btn {
            display: inline-block;
            background: #0284c7;
            color: white;
            text-decoration: none;
            padding: 11px 25px;
            border-radius: 7px;
            font-size: 15px;
            border: none;
            cursor: pointer;
            transition: 0.3s;
        }

        .start-btn:hover {
            background: #0369a1;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 25px;
            text-decoration: none;
            color: #0284c7;
            font-size: 15px;
        }

        .back-btn:hover {
            text-decoration: underline;
        }

        .no-exam {
            background: white;
            padding: 40px;
            text-align: center;
            border-radius: 14px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
        }

        .no-exam h2 {
            color: #1e293b;
            margin-bottom: 10px;
        }

        .no-exam p {
            color: #64748b;
        }

    </style>

</head>

<body>


<div class="header">

    <h1>Available Examinations</h1>

</div>


<div class="container">

    <a href="studentDashboard.jsp" class="back-btn">
        ← Back to Dashboard
    </a>


<%
    if (examList != null && !examList.isEmpty()) {

        for (Exam exam : examList) {
%>


    <div class="exam-card">

        <h2>
            <%= exam.getExamName() %>
        </h2>


        <div class="exam-info">

            <b>Total Questions:</b>
            <%= exam.getTotalQuestions() %>

            <br>

            <b>Total Marks:</b>
            <%= exam.getTotalMarks() %>

            <br>

            <b>Duration:</b>
            <%= exam.getDurationMinutes() %> minutes

            <br>

            <b>Passing Marks:</b>
            <%= exam.getPassingMarks() %>

            <br>

            <b>Negative Marking:</b>
            <%= exam.getNegativeMarking() %>

        </div>


        <!-- Start Exam -->

        <a href="StartExamServlet?examId=<%= exam.getExamId() %>"
           class="start-btn">

            Start Exam

        </a>


    </div>


<%
        }

    } else {
%>


    <div class="no-exam">

        <h2>No Exam Available</h2>

        <p>
            Currently, no examination is available.
        </p>

    </div>


<%
    }
%>


</div>


</body>

</html>