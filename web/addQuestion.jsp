<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Question</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 500px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        textarea {
            height: 80px;
            resize: none;
        }

        .options {
            margin-top: 10px;
        }

        .options input {
            width: 100%;
            margin-bottom: 10px;
        }

        .btn {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            background-color: #007bff;
            color: white;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .back {
            display: block;
            text-align: center;
            margin-top: 15px;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Add Question</h2>

    <form action="AddQuestionServlet" method="post">

        <label>Subject</label>
        <select name="subject" required>
            <option value="">-- Select Subject --</option>
            <option value="HTML">HTML</option>
            <option value="Java">Java</option>
            <option value="SQL">SQL</option>
        </select>

        <label>Question</label>
        <textarea name="question" placeholder="Enter your question" required></textarea>

        <label>Option A</label>
        <input type="text" name="optionA" required>

        <label>Option B</label>
        <input type="text" name="optionB" required>

        <label>Option C</label>
        <input type="text" name="optionC" required>

        <label>Option D</label>
        <input type="text" name="optionD" required>

        <label>Correct Answer</label>
        <select name="correctAnswer" required>
            <option value="">-- Select Correct Answer --</option>
            <option value="A">Option A</option>
            <option value="B">Option B</option>
            <option value="C">Option C</option>
            <option value="D">Option D</option>
        </select>

        <input type="submit" value="Add Question" class="btn">

    </form>

    <a href="adminDashboard.jsp" class="back">Back to Dashboard</a>

</div>

</body>
</html>