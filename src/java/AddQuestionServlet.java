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

@WebServlet("/AddQuestionServlet")
public class AddQuestionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String subject = request.getParameter("subject");
        String question = request.getParameter("question");
        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");
        String correctAnswer = request.getParameter("correctAnswer");

        Connection con = null;
        PreparedStatement idPs = null;
        PreparedStatement ps = null;
        ResultSet idRs = null;

        try {

            con = DBConnection.getConnection();

            // Get next Question ID
            String idSql = "SELECT NVL(MAX(QUESTION_ID), 0) + 1 FROM QUESTIONS";

            idPs = con.prepareStatement(idSql);
            idRs = idPs.executeQuery();

            int questionId = 1;

            if (idRs.next()) {
                questionId = idRs.getInt(1);
            }

            // Insert question
            String sql = "INSERT INTO QUESTIONS "
                    + "(QUESTION_ID, SUBJECT, QUESTION, OPTION_A, OPTION_B, "
                    + "OPTION_C, OPTION_D, CORRECT_ANSWER) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            ps = con.prepareStatement(sql);

            ps.setInt(1, questionId);
            ps.setString(2, subject);
            ps.setString(3, question);
            ps.setString(4, optionA);
            ps.setString(5, optionB);
            ps.setString(6, optionC);
            ps.setString(7, optionD);
            ps.setString(8, correctAnswer);

            ps.executeUpdate();

            response.sendRedirect("adminDashboard.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error while adding question: " + e.getMessage()
            );

        } finally {

            try {
                if (idRs != null) {
                    idRs.close();
                }

                if (idPs != null) {
                    idPs.close();
                }

                if (ps != null) {
                    ps.close();
                }

                if (con != null) {
                    con.close();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}