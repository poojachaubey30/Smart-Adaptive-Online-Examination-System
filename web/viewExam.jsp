<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="db.DBConnection"%>

<!DOCTYPE html>
<html>
<head>
    <title>View Exams</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 30px;
        }

        .container {
            width: 95%;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .back {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .back:hover {
            background-color: #0056b3;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>View Exams</h2>

    <table>

        <tr>
            <th>Exam ID</th>
            <th>Subject ID</th>
            <th>Exam Name</th>
            <th>Total Questions</th>
            <th>Total Marks</th>
            <th>Duration (Minutes)</th>
            <th>Passing Marks</th>
            <th>Negative Marking</th>
        </tr>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {

        con = DBConnection.getConnection();

        String sql = "SELECT * FROM EXAM";

        ps = con.prepareStatement(sql);

        rs = ps.executeQuery();

        boolean found = false;

        while (rs.next()) {

            found = true;
%>

        <tr>

            <td><%= rs.getInt("EXAM_ID") %></td>

            <td><%= rs.getInt("SUBJECT_ID") %></td>

            <td><%= rs.getString("EXAM_NAME") %></td>

            <td><%= rs.getInt("TOTAL_QUESTIONS") %></td>

            <td><%= rs.getInt("TOTAL_MARKS") %></td>

            <td><%= rs.getInt("DURATION_MINUTES") %></td>

            <td><%= rs.getInt("PASSING_MARKS") %></td>

            <td><%= rs.getInt("NEGATIVE_MARKING") %></td>

        </tr>

<%
        }

        if (!found) {
%>

        <tr>
            <td colspan="8">No exams available.</td>
        </tr>

<%
        }

    } catch (Exception e) {
%>

        <tr>
            <td colspan="8">
                Error: <%= e.getMessage() %>
            </td>
        </tr>

<%
        e.printStackTrace();

    } finally {

        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

    </table>

    <a href="adminDashboard.jsp" class="back">Back to Dashboard</a>

</div>

</body>
</html>