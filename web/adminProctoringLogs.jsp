
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>

<%!
    public String safe(Object value) {
        if (value == null) {
            return "-";
        }

        return value.toString()
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>

<%
    List<Map<String, Object>> logs =
        (List<Map<String, Object>>) request.getAttribute("logs");

    if (logs == null) {
        response.sendRedirect(
            request.getContextPath() + "/ViewProctoringLogsServlet");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AI Proctoring Logs</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f1f5fb;
            margin: 0;
            padding: 25px;
            color: #172554;
        }

        .container {
            max-width: 1200px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
        }

        h2 {
            color: #123778;
        }

        .btn {
            display: inline-block;
            background: #123778;
            color: white;
            padding: 10px 16px;
            text-decoration: none;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #d5deed;
            padding: 12px;
            text-align: left;
            overflow-wrap: anywhere;
        }

        th {
            background: #123778;
            color: white;
        }

        tr:nth-child(even) {
            background: #f3f6fc;
        }

        .count {
            margin-bottom: 15px;
            font-weight: bold;
        }
    </style>
</head>

<body>
<div class="container">

    <h2>AI Proctoring - Monitoring Logs</h2>

    <a class="btn"
       href="<%= request.getContextPath() %>/ViewProctoringLogsServlet">
        Refresh Logs
    </a>

    <div class="count">
        Total Events: <%= logs.size() %>
    </div>

    <% if (logs.isEmpty()) { %>

        <p>Abhi koi proctoring event record nahi hua hai.</p>

    <% } else { %>

    <table>
        <tr>
            <th>Log ID</th>
            <th>Student ID</th>
            <th>Exam ID</th>
            <th>Event Type</th>
            <th>Details</th>
            <th>Date &amp; Time</th>
        </tr>

        <% for (Map<String, Object> log : logs) { %>
        <tr>
            <td><%= safe(log.get("logId")) %></td>
            <td><%= safe(log.get("studentId")) %></td>
            <td><%= safe(log.get("examId")) %></td>
            <td><%= safe(log.get("eventType")) %></td>
            <td><%= safe(log.get("details")) %></td>
            <td><%= safe(log.get("eventTime")) %></td>
        </tr>
        <% } %>

    </table>
    <% } %>

</div>
</body>
</html>
