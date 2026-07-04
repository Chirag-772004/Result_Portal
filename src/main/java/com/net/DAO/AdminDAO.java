package com.net.DAO;

import java.sql.*;
import com.net.bean.AdminBean;

public class AdminDAO {
    private Connection conn;

    public AdminDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean checkLogin(AdminBean admin) throws SQLException {
        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, admin.getUsername());
        ps.setString(2, admin.getPassword());
        ResultSet rs = ps.executeQuery();
        return rs.next();
    }
}
