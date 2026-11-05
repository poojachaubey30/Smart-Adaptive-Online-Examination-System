```jsp
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Student"%>

<%
    Student student = (Student) session.getAttribute("student");

    String studentName = "Pooja Chaubey";

    if (student != null) {
        studentName = student.getName();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>

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

        /* LOGOUT */
        .logout {
            position: absolute;
            bottom: 25px;
            width: 100%;
        }

        .logout a {
            display: block;
            color: #fecaca;
            text-decoration: none;
            padding: 15px 25px;
            font-size: 15px;
            transition: 0.3s;
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
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }

        .topbar h1 {
            color: #1e293b;
            font-size: 27px;
        }

        .topbar p {
            color: #64748b;
            margin-top: 8px;
            font-size: 15px;
        }

        /* DASHBOARD CARDS */
        .cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px;
        }

        .card {
            background: white;
            padding: 28px;
            border-radius: 14px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 7px 18px rgba(0,0,0,0.12);
        }

        .icon {
            width: 55px;
            height: 55px;
            border-radius: 12px;
            background: #e0f2fe;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            margin-bottom: 18px;
        }

        .card h3 {
            color: #1e293b;
            margin-bottom: 8px;
            font-size: 19px;
        }

        .card p {
            color: #64748b;
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            text-decoration: none;
            background: #0284c7;
            color: white;
            padding: 10px 18px;
            border-radius: 7px;
            font-size: 14px;
            transition: 0.3s;
        }

        .btn:hover {
            background: #0369a1;
        }

        /* RESPONSIVE DESIGN */
        @media (max-width: 1000px) {
            .cards {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 700px) {
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
                padding-bottom: 10px;
            }

            .logout {
                position: relative;
                bottom: auto;
            }

            .main {
                margin-left: 0;
                padding: 20px;
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

            <a href="studentDashboard.jsp">
                🏠 Dashboard
            </a>

            <a href="ExamListServlet">
                📝 Start Exam
            </a>

            <!-- FIXED PROFILE LINK -->
            <a href="student/profile.jsp">
                👤 My Profile
            </a>

            <a href="result.jsp">
                📊 My Results
            </a>

        </div>

        <div class="logout">
            <a href="LogoutServlet">
                🚪 Logout
            </a>
        </div>

    </div>

    <!-- MAIN CONTENT -->
    <div class="main">

        <div class="topbar">
            <h1>Student Dashboard</h1>

            <p>
                Welcome, <b><%= studentName %></b> 👋
            </p>
        </div>

        <div class="cards">

            <!-- START EXAM CARD -->
            <div class="card">

                <div class="icon">📝</div>

                <h3>Start Exam</h3>

                <p>
                    View available examinations and start your online test.
                </p>

                <a href="ExamListServlet" class="btn">
                    Start Exam
                </a>

            </div>

            <!-- MY PROFILE CARD -->
            <div class="card">

                <div class="icon">👤</div>

                <h3>My Profile</h3>

                <p>
                    View your personal and academic profile information.
                </p>

                <!-- FIXED PROFILE LINK -->
                <a href="student/profile.jsp" class="btn">
                    View Profile
                </a>

            </div>

            <!-- RESULTS CARD -->
            <div class="card">

                <div class="icon">📊</div>

                <h3>My Results</h3>

                <p>
                    Check your examination results, marks and performance.
                </p>

                <a href="result.jsp" class="btn">
                    View Results
                </a>

            </div>

        </div>

    </div>

</body>
</html>
```