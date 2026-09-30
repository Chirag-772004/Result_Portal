<%@ page import="java.sql.*" %>
<%@ page import="com.net.util.DBConnection" %>
<%@ page import="com.net.DAO.StudentDAO" %>
<%@ page import="com.net.bean.StudentBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Session validation
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("userRole");
    if (user == null || role == null || !"admin".equals(role)) {
%>
    <div class="flex items-center justify-center min-h-screen bg-gray-100">
        <div class="bg-white p-6 rounded shadow text-center">
            <p class="text-red-500 font-bold">Session expired or unauthorized</p>
            <a href="Login.jsp" class="text-blue-500 underline">Go to Login</a>
        </div>
    </div>
<%
        return;
    }

    // Get form data
    long rollno = Long.parseLong(request.getParameter("rollno"));
    String name = request.getParameter("name");
    String fathername = request.getParameter("fathername");
    String mothername = request.getParameter("mothername");
    String dobStr = request.getParameter("dob");
    int semester = Integer.parseInt(request.getParameter("semester"));
    int year = Integer.parseInt(request.getParameter("year"));
    String course = request.getParameter("course");

    java.sql.Date dob = java.sql.Date.valueOf(dobStr);

    // Insert using DAO
    boolean success = false;
    try {
        Connection conn = DBConnection.getConnection();
        StudentDAO dao = new StudentDAO(conn);
        StudentBean student = new StudentBean();
        student.setRollno(rollno);
        student.setName(name);
        student.setFathername(fathername);
        student.setMothername(mothername);
        student.setDob(dob);
        student.setSemester(semester);
        student.setYear(year);
        student.setCourse(course);

        success = dao.addStudent(student);

        conn.close();
    } catch(Exception e) {
        out.println("<p class='text-red-500 text-center'>Error: " + e.getMessage() + "</p>");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Student Result</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex justify-center items-center min-h-screen">

  <div class="bg-white p-6 rounded shadow text-center">
    <% if (success) { %>
      <p class="text-green-600 font-bold">Student added successfully!</p>
    <% } else { %>
      <p class="text-red-600 font-bold">Failed to add student.</p>
    <% } %>
    <a href="AdminDashboard.jsp" class="text-blue-500 underline mt-3 inline-block">Back to Dashboard</a>
  </div>

</body>
</html>
