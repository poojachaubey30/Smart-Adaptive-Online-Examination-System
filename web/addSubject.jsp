<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Subject</title>
</head>
<body>

<h2>Add Subject</h2>

<form action="AddSubjectServlet" method="post">

    <label>Subject Name</label><br><br>

    <input type="text" name="subjectName" required>

    <br><br>

    <input type="submit" value="Add Subject">

</form>

</body>
</html>