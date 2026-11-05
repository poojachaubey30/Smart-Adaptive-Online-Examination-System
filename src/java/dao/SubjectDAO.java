package dao;

import db.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Subject;

public class SubjectDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Add Subject
    public boolean addSubject(Subject subject) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql = "INSERT INTO SUBJECT(SUBJECT_ID, SUBJECT_NAME, STATUS) VALUES(SUBJECT_SEQ.NEXTVAL, ?, ?)";

            ps = con.prepareStatement(sql);

            ps.setString(1, subject.getSubjectName());
            ps.setString(2, subject.getStatus());

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Get All Active Subjects
    public ArrayList<Subject> getAllSubjects() {

        ArrayList<Subject> list = new ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM SUBJECT WHERE STATUS='ACTIVE' ORDER BY SUBJECT_NAME";

            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {

                Subject subject = new Subject();

                subject.setSubjectId(rs.getInt("SUBJECT_ID"));
                subject.setSubjectName(rs.getString("SUBJECT_NAME"));
                subject.setStatus(rs.getString("STATUS"));

                list.add(subject);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}