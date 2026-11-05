<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Admin"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>

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

        /* SIDEBAR */

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 240px;
            height: 100vh;
            background: #1e293b;
            color: white;
            padding-top: 25px;
        }

        .logo {
            text-align: center;
            font-size: 23px;
            font-weight: bold;
            margin-bottom: 35px;
        }

        .logo span {
            color: #38bdf8;
        }

        .menu a {
            display: block;
            color: #cbd5e1;
            text-decoration: none;
            padding: 15px 25px;
            font-size: 15px;
            transition: 0.3s;
        }

        .menu a:hover {
            background: #334155;
            color: white;
            padding-left: 32px;
        }

        .logout {
            position: absolute;
            bottom: 25px;
            width: 100%;
        }

        .logout a {
            color: #fecaca;
        }

        .logout a:hover {
            background: #7f1d1d;
            color: white;
        }


        /* MAIN CONTENT */

        .main {
            margin-left: 240px;
            padding: 30px;
        }

        .topbar {
            background: white;
            padding: 20px 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }

        .topbar h1 {
            color: #1e293b;
            font-size: 26px;
        }

        .topbar p {
            color: #64748b;
            margin-top: 6px;
        }


        /* CARDS */

        .cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 7px 18px rgba(0,0,0,0.12);
        }

        .icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            background: #e0f2fe;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 18px;
        }

        .card h3 {
            color: #1e293b;
            margin-bottom: 8px;
        }

        .card p {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 18px;
        }

        .btn {
            display: inline-block;
            text-decoration: none;
            background: #0284c7;
            color: white;
            padding: 9px 18px;
            border-radius: 7px;
            font-size: 14px;
        }

        .btn:hover {
            background: #0369a1;
        }


        /* RESPONSIVE */

        @media (max-width: 900px) {

            .cards {
                grid-template-columns: repeat(2, 1fr);
            }

            .sidebar {
                width: 200px;
            }

            .main {
                margin-left: 200px;
            }
        }

        @media (max-width: 600px) {

            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
            }

            .logout {
                position: relative;
                bottom: auto;
            }

            .main {
                margin-left: 0;
            }

            .cards {
                grid-template-columns: 1fr;
            }
        }

    </style>

</head>

<body>


<!-- SIDEBAR -->

<div class="sidebar">

    <div class="logo">
        Online<span>Exam</span>
    </div>

    <div class="menu">

        <a href="adminDashboard.jsp">🏠 Dashboard</a>

        <a href="addExam.jsp">📝 Add Exam</a>

        <a href="viewExam.jsp">📋 View Exams</a>

        <a href="addQuestion.jsp">❓ Add Questions</a>

        <a href="viewStudents.jsp">👨‍🎓 View Students</a>

        <a href="viewResults.jsp">📊 View Results</a>

    </div>

    <div class="logout">

        <a href="AdminLogoutServlet">🚪 Logout</a>

    </div>

</div>



<!-- MAIN CONTENT -->

<div class="main">

    <div class="topbar">

        <h1>Admin Dashboard</h1>

        <p>Welcome, <b>admin</b> 👋</p>

    </div>


    <div class="cards">


        <!-- ADD EXAM -->

        <div class="card">

            <div class="icon">📝</div>

            <h3>Add Exam</h3>

            <p>Create a new examination with marks and duration.</p>

            <a href="addExam.jsp" class="btn">
                Add Exam
            </a>

        </div>



        <!-- VIEW EXAM -->

        <div class="card">

            <div class="icon">📋</div>

            <h3>View Exams</h3>

            <p>View all examinations created by the admin.</p>

            <a href="viewExam.jsp" class="btn">
                View Exams
            </a>

        </div>



        <!-- ADD QUESTIONS -->

        <div class="card">

            <div class="icon">❓</div>

            <h3>Add Questions</h3>

            <p>Add multiple-choice questions for examinations.</p>

            <a href="addQuestion.jsp" class="btn">
                Add Questions
            </a>

        </div>



        <!-- VIEW STUDENTS -->

        <div class="card">

            <div class="icon">👨‍🎓</div>

            <h3>View Students</h3>

            <p>View registered students and their information.</p>

            <a href="viewStudents.jsp" class="btn">
                View Students
            </a>

        </div>



        <!-- VIEW RESULTS -->

        <div class="card">

            <div class="icon">📊</div>

            <h3>View Results</h3>

            <p>Check examination results and student performance.</p>

            <a href="viewResults.jsp" class="btn">
                View Results
            </a>

        </div>


    </div>

</div>


</body>
</html>