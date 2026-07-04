package com.net.DAO;

import java.sql.*;
import com.net.bean.SubjectBean;

public class SubjectDAO {
    private Connection conn;

    public SubjectDAO(Connection conn) {
        this.conn = conn;
    }

    public SubjectBean getSubject(String subjectCode) throws SQLException {
        String sql = "SELECT * FROM subject WHERE subjectcode = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, subjectCode);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            SubjectBean subject = new SubjectBean();
            subject.setSubjectcode(rs.getString("subjectcode"));
            subject.setSubjectname(rs.getString("subjectname"));
            return subject;
        }
        return null;
    }

    public ResultSet getAllSubjects() throws SQLException {
        String sql = "SELECT * FROM subject";
        PreparedStatement ps = conn.prepareStatement(sql);
        return ps.executeQuery();
    }
}
