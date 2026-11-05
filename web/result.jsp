<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="db.DBConnection"%>
<%@page import="model.Student"%>

<%
    Student student = (Student) session.getAttribute("student");

    int studentId = 1;

    if (student != null) {
        studentId = student.getStudentId();
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>My Results</title>

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
        }

        .header h1 {
            font-size: 28px;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 40px auto;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: #0284c7;
            font-size: 15px;
        }

        .result-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th {
            background: #0284c7;
            color: white;
            padding: 14px;
            text-align: center;
        }

        td {
            padding: 14px;
            text-align: center;
            border-bottom: 1px solid #e2e8f0;
            color: #475569;
        }

        tr:hover {
            background: #f8fafc;
        }

        .pass {
            color: #166534;
            background: #dcfce7;
            padding: 6px 14px;
            border-radius: 15px;
            font-weight: bold;
        }

        .fail {
            color: #991b1b;
            background: #fee2e2;
            padding: 6px 14px;
            border-radius: 15px;
            font-weight: bold;
        }

        .no-result {
            text-align: center;
            padding: 40px;
            color: #64748b;
        }

    </style>

</head>

<body>

<div class="header">
    <h1>My Results</h1>
</div>

<div class="container">

    <a href="studentDashboard.jsp" class="back-btn">
        ← Back to Dashboard
    </a>

    <div class="result-card">

        <h2>Examination Results</h2>

        <table>

            <tr>
                <th>Result ID</th>
                <th>Exam ID</th>
                <th>Total Marks</th>
                <th>Obtained Marks</th>
                <th>Status</th>
            </tr>

<%
    try {

        con = DBConnection.getConnection();

        String sql =
                "SELECT RESULT_ID, EXAM_ID, TOTAL_MARKS, "
                + "OBTAINED_MARKS, RESULT_STATUS "
                + "FROM RESULT "
                + "WHERE STUDENT_ID = ? "
                + "ORDER BY RESULT_ID DESC";

        ps = con.prepareStatement(sql);

        ps.setInt(1, studentId);

        rs = ps.executeQuery();

        boolean found = false;

        while (rs.next()) {

            found = true;

            String status = rs.getString("RESULT_STATUS");
%>

            <tr>

                <td>
                    <%= rs.getInt("RESULT_ID") %>
                </td>

                <td>
                    <%= rs.getInt("EXAM_ID") %>
                </td>

                <td>
                    <%= rs.getInt("TOTAL_MARKS") %>
                </td>

                <td>
                    <%= rs.getInt("OBTAINED_MARKS") %>
                </td>

                <td>

<%
            if ("PASS".equalsIgnoreCase(status)) {
%>

                    <span class="pass">
                        PASS
                    </span>

<%
            } else {
%>

                    <span class="fail">
                        FAIL
                    </span>

<%
            }
%>

                </td>

            </tr>

<%
        }

        if (!found) {
%>

            <tr>
                <td colspan="5" class="no-result">
                    No examination results available.
                </td>
            </tr>

<%
        }

    } catch (Exception e) {

        e.printStackTrace();
%>

            <tr>
                <td colspan="5" class="no-result">
                    Error while loading results.
                </td>
            </tr>

<%
    } finally {

        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();

            // Do NOT close con here because DBConnection
            // is currently using a shared connection.

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

        </table>

    </div>

</div>

</body>

</html>