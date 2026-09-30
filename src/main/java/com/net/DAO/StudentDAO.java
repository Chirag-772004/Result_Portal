package com.net.DAO;
import java.sql.*;
import java.util.*;

import com.net.bean.StudentBean;
public class StudentDAO {

	private Connection conn;
	public StudentDAO(Connection conn) {
		this.conn=conn;
	}
	
	public StudentBean getStudent(long rollno) throws SQLException {
	    String sql = "SELECT * FROM student WHERE rollno=?";
	    PreparedStatement ps = conn.prepareStatement(sql);
	    ps.setLong(1, rollno);
	    ResultSet rs = ps.executeQuery();

	    if (rs.next()) {
	        StudentBean student = new StudentBean();
	        student.setRollno(rs.getLong("rollno"));
	        student.setName(rs.getString("name"));
	        student.setFathername(rs.getString("fathername"));
	        student.setMothername(rs.getString("mothername"));
	        student.setDob(rs.getDate("dob"));
	        student.setSemester(rs.getInt("semester"));
	        student.setYear(rs.getInt("year"));
	        student.setCourse(rs.getString("course"));
	        return student;
	    } else {
	        return null;
	    }
	}

	
	public boolean addStudent(StudentBean student) throws SQLException {
	    String sql = "INSERT INTO student VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	    PreparedStatement ps = conn.prepareStatement(sql);
	    ps.setLong(1, student.getRollno());
	    ps.setString(2, student.getName());
	    ps.setString(3, student.getFathername());
	    ps.setString(4, student.getMothername());
	    ps.setDate(5, student.getDob());
	    ps.setInt(6, student.getSemester());
	    ps.setInt(7, student.getYear());
	    ps.setString(8, student.getCourse()); // ✅ ADD THIS LINE
	    return ps.executeUpdate() > 0;
	}

	
	public boolean updateStudent(StudentBean student) throws SQLException {
	    String sql = "UPDATE student SET name=?, fathername=?, mothername=?, dob=?, semester=?, year=?, course=? WHERE rollno=?";
	    PreparedStatement ps = conn.prepareStatement(sql);
	    ps.setString(1, student.getName());
	    ps.setString(2, student.getFathername());
	    ps.setString(3, student.getMothername());
	    ps.setDate(4, student.getDob());
	    ps.setInt(5, student.getSemester());
	    ps.setInt(6, student.getYear());
	    ps.setString(7, student.getCourse());
	    ps.setLong(8, student.getRollno());
	    return ps.executeUpdate() > 0;
	}
	
	public boolean deleteStudent(StudentBean student) throws SQLException{
		String sql="Delete from student where rollno=?";
		PreparedStatement ps=conn.prepareStatement(sql);
		ps.setLong(1, student.getRollno());
		return ps.executeUpdate()>0;
	}
}