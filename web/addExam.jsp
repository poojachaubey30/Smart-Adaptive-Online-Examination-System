<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="model.Subject"%>

<%
    SubjectDAO dao = new SubjectDAO();
    ArrayList<Subject> subjectList = dao.getAllSubjects();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Exam</title>
    <link rel="stylesheet" href="addExam.css">
</head>

<body>

<div class="container">

    <h2>Add New Exam</h2>

    <form action="AddExamServlet" method="post">

        <label>Subject</label>

        <select name="subjectId" required>

            <option value="">-- Select Subject --</option>

            <%
                for(Subject s : subjectList){
            %>

            <option value="<%=s.getSubjectId()%>">
                <%=s.getSubjectName()%>
            </option>

            <%
                }
            %>

        </select>

        <label>Exam Name</label>
        <input type="text" name="examName" required>

        <label>Total Questions</label>
        <input type="number" name="totalQuestions" required>

        <label>Total Marks</label>
        <input type="number" name="totalMarks" required>

        <label>Duration (Minutes)</label>
        <input type="number" name="durationMinutes" required>

        <label>Passing Marks</label>
        <input type="number" name="passingMarks" required>

        <label>Negative Marking</label>
        <input type="number" step="0.25" name="negativeMarking" value="0">

        <br><br>

        <input type="submit" value="Add Exam">

    </form>

</div>

</body>
</html>