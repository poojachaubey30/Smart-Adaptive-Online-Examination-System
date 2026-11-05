package dao;

import db.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Admin;

public class AdminDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public Admin loginAdmin(String username, String password) {

        Admin admin = null;

        try {

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM ADMIN WHERE USERNAME=? AND PASSWORD=?";

            ps = con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {

                admin = new Admin();

                admin.setAdminId(rs.getInt("ADMIN_ID"));
                admin.setUsername(rs.getString("USERNAME"));
                admin.setPassword(rs.getString("PASSWORD"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return admin;
    }

}