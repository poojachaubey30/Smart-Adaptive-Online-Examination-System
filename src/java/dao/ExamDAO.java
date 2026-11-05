package dao;

import db.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Exam;

public class ExamDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // ==========================================
    // ADD EXAM
    // ==========================================

    public boolean addExam(Exam exam) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql = "INSERT INTO EXAM "
                    + "(EXAM_ID, SUBJECT_ID, EXAM_NAME, TOTAL_QUESTIONS, "
                    + "TOTAL_MARKS, DURATION_MINUTES, PASSING_MARKS, NEGATIVE_MARKING) "
                    + "VALUES (EXAM_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";

            ps = con.prepareStatement(sql);

            ps.setInt(1, exam.getSubjectId());
            ps.setString(2, exam.getExamName());
            ps.setInt(3, exam.getTotalQuestions());
            ps.setInt(4, exam.getTotalMarks());
            ps.setInt(5, exam.getDurationMinutes());
            ps.setInt(6, exam.getPassingMarks());
            ps.setDouble(7, exam.getNegativeMarking());

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;
    }


    // ==========================================
    // GET ALL EXAMS
    // ==========================================

    public List<Exam> getAllExams() {

        List<Exam> examList = new ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM EXAM ORDER BY EXAM_ID";

            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {

                Exam exam = new Exam();

                exam.setExamId(
                        rs.getInt("EXAM_ID")
                );

                exam.setSubjectId(
                        rs.getInt("SUBJECT_ID")
                );

                exam.setExamName(
                        rs.getString("EXAM_NAME")
                );

                exam.setTotalQuestions(
                        rs.getInt("TOTAL_QUESTIONS")
                );

                exam.setTotalMarks(
                        rs.getInt("TOTAL_MARKS")
                );

                exam.setDurationMinutes(
                        rs.getInt("DURATION_MINUTES")
                );

                exam.setPassingMarks(
                        rs.getInt("PASSING_MARKS")
                );

                exam.setNegativeMarking(
                        rs.getDouble("NEGATIVE_MARKING")
                );

                examList.add(exam);
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return examList;
    }
}