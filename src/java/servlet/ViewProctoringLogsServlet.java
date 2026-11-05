
package servlet;

import db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewProctoringLogsServlet")
public class ViewProctoringLogsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> logs = new ArrayList<>();

        String sql = "SELECT LOG_ID, STUDENT_ID, EXAM_ID, "
                + "EVENT_TYPE, EVENT_DETAILS, EVENT_TIME "
                + "FROM PROCTORING_LOG ORDER BY LOG_ID DESC";

        try {
            Connection con = DBConnection.getConnection();

            if (con == null || con.isClosed()) {
                throw new Exception("Database connection unavailable.");
            }

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Map<String, Object> log = new HashMap<>();
                    log.put("logId", rs.getObject("LOG_ID"));
                    log.put("studentId", rs.getObject("STUDENT_ID"));
                    log.put("examId", rs.getObject("EXAM_ID"));
                    log.put("eventType", rs.getString("EVENT_TYPE"));
                    log.put("details", rs.getString("EVENT_DETAILS"));
                    log.put("eventTime", rs.getTimestamp("EVENT_TIME"));
                    logs.add(log);
                }
            }

            request.setAttribute("logs", logs);
            request.getRequestDispatcher(
                    "/adminProctoringLogs.jsp"
            ).forward(request, response);

        } catch (Exception e) {
            getServletContext().log("Error loading proctoring logs", e);
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load proctoring logs. Check server logs."
            );
        }
    }
}
