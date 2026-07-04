<%@ page import="java.sql.*, com.net.DAO.StudentDAO, com.net.bean.StudentBean, com.net.util.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Session validation
    session.setMaxInactiveInterval(300);
    String studentUser = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("userRole");

    if (studentUser == null || role == null || !"student".equals(role)) {
%>
    <div class="flex items-center justify-center min-h-screen bg-gray-100">
        <div class="bg-white p-6 rounded shadow text-center">
            <p class="text-red-500 font-bold">Session expired or unauthorized access</p>
            <a href="Login.jsp" class="text-blue-500 underline">Go to Login</a>
        </div>
    </div>
<%
        return;
    }

    // Fetch student details
    Connection conn = DBConnection.getConnection();
    StudentDAO dao = new StudentDAO(conn);
    StudentBean student = dao.getStudent(Long.parseLong(studentUser));
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>View Student Details</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

  <div class="max-w-md mx-auto mt-10 bg-white p-6 rounded shadow">
    <h2 class="text-2xl font-bold mb-4 text-center text-blue-600">Your Details</h2>

    <% if (student != null) { %>
    <div class="space-y-2">
      <p><span class="font-semibold">Name:</span> <%= student.getName() %></p>
      <p><span class="font-semibold">Roll No:</span> <%= student.getRollno() %></p>
      <p><span class="font-semibold">Father's Name:</span> <%= student.getFathername() %></p> 
      <p><span class="font-semibold">Mother's Name:</span> <%= student.getMothername() %></p>
      <p><span class="font-semibold">DOB:</span> <%= student.getDob() %></p>
      <p><span class="font-semibold">Semester:</span> <%= student.getSemester() %></p>
      <p><span class="font-semibold">Year:</span> <%= student.getYear() %></p>
      <p><span class="font-semibold">Course:</span> <%= student.getCourse() %></p>
    </div>
    <% } else { %>
      <p class="text-red-500 text-center">Unable to fetch your details.</p>
    <% } %>

    <div class="mt-4 text-center">
      <a href="StudentDashboard.jsp" class="text-blue-500 underline">Back to Dashboard</a>
    </div>
  </div>

</body>
</html>
