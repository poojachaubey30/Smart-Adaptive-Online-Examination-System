package dao;

import db.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Question;

public class QuestionDAO {

    public List<Question> getQuestionsByExam(int examId) {

        List<Question> questionList = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            /*
             * QUESTIONS table has SUBJECT column
             * and EXAM table has SUBJECT_ID.
             *
             * SUBJECT_ID mapping:
             * 1 = Java
             * 2 = HTML
             * 3 = SQL
             */

            String sql =
                "SELECT q.* FROM QUESTIONS q " +
                "JOIN EXAM e ON UPPER(q.SUBJECT) = " +
                "CASE e.SUBJECT_ID " +
                "WHEN 1 THEN 'JAVA' " +
                "WHEN 2 THEN 'HTML' " +
                "WHEN 3 THEN 'SQL' " +
                "END " +
                "WHERE e.EXAM_ID = ?";

            ps = con.prepareStatement(sql);

            ps.setInt(1, examId);

            rs = ps.executeQuery();

            while (rs.next()) {

                Question question = new Question();

                question.setQuestionId(
                        rs.getInt("QUESTION_ID"));

                question.setSubject(
                        rs.getString("SUBJECT"));

                question.setQuestion(
                        rs.getString("QUESTION"));

                question.setOptionA(
                        rs.getString("OPTION_A"));

                question.setOptionB(
                        rs.getString("OPTION_B"));

                question.setOptionC(
                        rs.getString("OPTION_C"));

                question.setOptionD(
                        rs.getString("OPTION_D"));

                question.setCorrectAnswer(
                        rs.getString("CORRECT_ANSWER"));

                questionList.add(question);
            }

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            try {

                if (rs != null) {
                    rs.close();
                }

                if (ps != null) {
                    ps.close();
                }

                /*
                 * IMPORTANT:
                 * Do NOT close con here.
                 *
                 * DBConnection uses a shared static connection.
                 * Closing it here causes "Closed Connection"
                 * error when another DAO/Servlet uses it.
                 */

            } catch (Exception e) {

                e.printStackTrace();
            }
        }

        return questionList;
    }
}