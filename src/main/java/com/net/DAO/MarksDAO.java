package com.net.DAO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.net.bean.MarksBean;

public class MarksDAO {

    private Connection conn;

    public MarksDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean addOrUpdate(MarksBean marks) throws SQLException {
        String sql = "REPLACE INTO marks (rollno, subjectcode, marks) VALUES (?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, marks.getRollno());
        ps.setString(2, marks.getSubjectcode());
        ps.setInt(3, marks.getMarks());
        return ps.executeUpdate() > 0;
    }

    public boolean deleteMarks(MarksBean marks) throws SQLException {
        String sql = "DELETE FROM marks WHERE rollno=? AND subjectcode=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, marks.getRollno());
        ps.setString(2, marks.getSubjectcode());
        return ps.executeUpdate() > 0;
    }

    public List<MarksBean> getMarksByRollNo(long rollno) throws SQLException {
        List<MarksBean> list = new ArrayList<>();
        String sql = "SELECT * FROM marks WHERE rollno = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, rollno);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            MarksBean m = new MarksBean();
            m.setRollno(rs.getLong("rollno"));
            m.setSubjectcode(rs.getString("subjectcode"));
            m.setMarks(rs.getInt("marks"));
            list.add(m);
        }
        return list;
    }
}
