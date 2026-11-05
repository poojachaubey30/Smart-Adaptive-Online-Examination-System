package servlet;

import db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Question;
import dao.QuestionDAO;
import java.util.List;

@WebServlet("/SubmitExamServlet")
public class SubmitExamServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // Get Exam ID
            int examId = Integer.parseInt(
                    request.getParameter("examId")
            );

            // Get questions of this exam
            QuestionDAO questionDAO = new QuestionDAO();

            List<Question> questionList =
                    questionDAO.getQuestionsByExam(examId);

            int totalMarks = questionList.size();
            int obtainedMarks = 0;

            // Check every answer
            for (Question question : questionList) {

                String answer =
                        request.getParameter(
                                "answer_" + question.getQuestionId()
                        );

                if (answer != null &&
                        answer.equalsIgnoreCase(
                                question.getCorrectAnswer())) {

                    obtainedMarks++;
                }
            }

            // Result status
            String resultStatus;

            if (obtainedMarks >= (totalMarks * 0.4)) {
                resultStatus = "PASS";
            } else {
                resultStatus = "FAIL";
            }

            // Get logged-in student
            HttpSession session = request.getSession();

            Object studentObj =
                    session.getAttribute("student");

            int studentId = 1;

            /*
             * Temporary student ID.
             * We will connect this with the logged-in
             * student's actual ID next.
             */

            if (studentObj != null) {

                try {

                    model.Student student =
                            (model.Student) studentObj;

                    studentId = student.getStudentId();

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            // Insert result into RESULT table
            Connection con = null;
            PreparedStatement ps = null;

            try {

                con = DBConnection.getConnection();

                String sql =
                        "INSERT INTO RESULT "
                        + "(RESULT_ID, STUDENT_ID, EXAM_ID, "
                        + "TOTAL_MARKS, OBTAINED_MARKS, RESULT_STATUS) "
                        + "VALUES "
                        + "(NVL((SELECT MAX(RESULT_ID) FROM RESULT),0)+1, "
                        + "?, ?, ?, ?, ?)";

                ps = con.prepareStatement(sql);

                ps.setInt(1, studentId);
                ps.setInt(2, examId);
                ps.setInt(3, totalMarks);
                ps.setInt(4, obtainedMarks);
                ps.setString(5, resultStatus);

                ps.executeUpdate();

            } finally {

                if (ps != null) {
                    ps.close();
                }

                if (con != null) {
                    con.close();
                }
            }

            // Send result to result page
            response.sendRedirect(
                    "result.jsp?examId=" + examId
                    + "&marks=" + obtainedMarks
                    + "&total=" + totalMarks
                    + "&status=" + resultStatus
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error while submitting exam: "
                    + e.getMessage()
            );
        }
    }
}