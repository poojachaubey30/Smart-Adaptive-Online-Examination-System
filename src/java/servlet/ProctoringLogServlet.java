package servlet;

import db.DBConnection;
import model.Student;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ProctoringLogServlet")
public class ProctoringLogServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        // Check student login session
        HttpSession session = request.getSession(false);

        if (session == null
                || !(session.getAttribute("student") instanceof Student)) {
            response.sendError(
                    HttpServletResponse.SC_UNAUTHORIZED,
                    "Please login first."
            );
            return;
        }

        Student student = (Student) session.getAttribute("student");
        int studentId = student.getStudentId();

        // Read exam and event details
        String examIdText = request.getParameter("examId");
        String eventType = request.getParameter("eventType");
        String eventDetails = request.getParameter("eventDetails");

        int examId;

        try {
            examId = Integer.parseInt(examIdText);

            if (examId <= 0) {
                throw new NumberFormatException();
            }

        } catch (Exception e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid exam ID."
            );
            return;
        }

        // Accept only supported event types
        if (eventType == null
                || !(eventType.equals("TAB_SWITCH")
                || eventType.equals("CAMERA_STARTED")
                || eventType.equals("CAMERA_STOPPED")
                || eventType.equals("CAMERA_PERMISSION_DENIED"))) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid event type."
            );
            return;
        }

        if (eventDetails == null) {
            eventDetails = "";
        }

        // Keep details within the database column limit
        if (eventDetails.length() > 200) {
            eventDetails = eventDetails.substring(0, 200);
        }

        String sql =
                "INSERT INTO PROCTORING_LOG "
                + "(LOG_ID, STUDENT_ID, EXAM_ID, EVENT_TYPE, EVENT_DETAILS) "
                + "VALUES (PROCTORING_LOG_SEQ.NEXTVAL, ?, ?, ?, ?)";

        try {
            Connection con = DBConnection.getConnection();

            if (con == null || con.isClosed()) {
                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Database connection unavailable."
                );
                return;
            }

            // Do not close the shared DBConnection connection here.
            // Close only the PreparedStatement.
            try (PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, studentId);
                ps.setInt(2, examId);
                ps.setString(3, eventType);
                ps.setString(4, eventDetails);

                ps.executeUpdate();
            }

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Proctoring event saved.");

        } catch (SQLException e) {
            getServletContext().log(
                    "Error saving proctoring event.", e
            );

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Could not save proctoring event."
            );
        }
    }
}