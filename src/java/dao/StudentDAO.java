package dao;

import db.DBConnection;
import model.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StudentDAO {

    // Registration Method
    public boolean registerStudent(Student student) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO STUDENT(STUDENT_ID, NAME, GENDER, EMAIL, MOBILE, COURSE, PASSWORD, STATUS) VALUES (STUDENT_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, 'ACTIVE')";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, student.getName());
            ps.setString(2, student.getGender());
            ps.setString(3, student.getEmail());
            ps.setString(4, student.getMobile());
            ps.setString(5, student.getCourse());
            ps.setString(6, student.getPassword());

            int i = ps.executeUpdate();

            if (i > 0) {
                status = true;
            }

            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Login Method
    public Student loginStudent(String email, String password) {

        Student student = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM STUDENT WHERE EMAIL=? AND PASSWORD=? AND STATUS='ACTIVE'";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                student = new Student();

                student.setStudentId(rs.getInt("STUDENT_ID"));
                student.setName(rs.getString("NAME"));
                student.setGender(rs.getString("GENDER"));
                student.setEmail(rs.getString("EMAIL"));
                student.setMobile(rs.getString("MOBILE"));
                student.setCourse(rs.getString("COURSE"));
                student.setPassword(rs.getString("PASSWORD"));

            }

            rs.close();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return student;
    }

}