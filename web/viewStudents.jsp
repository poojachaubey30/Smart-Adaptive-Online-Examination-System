<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="db.DBConnection"%>

<!DOCTYPE html>
<html>
<head>
    <title>View Students</title>

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
            overflow-x: auto;
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

    <h2>View Students</h2>

    <table>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {

        con = DBConnection.getConnection();

        String sql = "SELECT * FROM STUDENT";

        ps = con.prepareStatement(sql);

        rs = ps.executeQuery();

        ResultSetMetaData metaData = rs.getMetaData();

        int columnCount = metaData.getColumnCount();
%>

        <tr>

<%
        for (int i = 1; i <= columnCount; i++) {
%>

            <th>
                <%= metaData.getColumnName(i) %>
            </th>

<%
        }
%>

        </tr>

<%
        boolean found = false;

        while (rs.next()) {

            found = true;
%>

        <tr>

<%
            for (int i = 1; i <= columnCount; i++) {
%>

            <td>
                <%= rs.getString(i) %>
            </td>

<%
            }
%>

        </tr>

<%
        }

        if (!found) {
%>

        <tr>
            <td colspan="<%= columnCount %>">
                No students registered.
            </td>
        </tr>

<%
        }

    } catch (Exception e) {
%>

        <tr>
            <td colspan="10">
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

    <a href="adminDashboard.jsp" class="back">
        Back to Dashboard
    </a>

</div>

</body>
</html>