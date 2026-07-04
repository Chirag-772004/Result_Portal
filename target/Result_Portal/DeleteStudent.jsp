<%@ page import="java.sql.*" %>
<%@ page import="com.net.util.DBConnection" %>
<%@ page import="com.net.DAO.StudentDAO" %>
<%@ page import="com.net.bean.StudentBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String msg = null;
    StudentBean student = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Perform delete
        try {
            long rollno = Long.parseLong(request.getParameter("rollno"));
            Connection conn = DBConnection.getConnection();
            StudentDAO dao = new StudentDAO(conn);
            student = dao.getStudent(rollno);
            if (student != null) {
                boolean success = dao.deleteStudent(student);
                msg = success ? "Student record deleted successfully." : "Failed to delete student record.";
            } else {
                msg = "No student found with roll number: " + rollno;
            }
            conn.close();
        } catch (Exception e) {
            msg = "Error: " + e.getMessage();
        }
    } else if (request.getParameter("rollno") != null) {
        // Fetch student for confirmation display
        try {
            long rollno = Long.parseLong(request.getParameter("rollno"));
            Connection conn = DBConnection.getConnection();
            StudentDAO dao = new StudentDAO(conn);
            student = dao.getStudent(rollno);
            conn.close();
            if (student == null) {
                msg = "No student found with roll number: " + rollno;
            }
        } catch (Exception e) {
            msg = "Error: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Delete Student</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex justify-center items-center min-h-screen">

  <div class="bg-white p-6 rounded-lg shadow-md w-full max-w-md">
    <h2 class="text-xl font-bold text-center text-red-700 mb-4">Delete Student</h2>

    <% if (msg != null) { %>
      <p class="<%= msg.startsWith("Student record deleted") ? "text-green-600" : "text-red-500" %> font-semibold mb-4 text-center">
        <%= msg %>
      </p>
    <% } %>

    <% if (student == null && !"POST".equalsIgnoreCase(request.getMethod())) { %>
      <!-- Ask for roll number -->
      <form method="get" class="space-y-4">
        <div>
          <label class="block text-sm font-medium text-gray-700">Enter Roll No</label>
          <input type="text" name="rollno" required
                 class="w-full border border-gray-300 rounded-md p-2 focus:ring-red-500 focus:border-red-500"
                 placeholder="Roll No">
        </div>
        <button type="submit"
                class="w-full bg-red-600 text-white p-2 rounded-md hover:bg-red-700 font-semibold">
          Fetch Student
        </button>
      </form>

    <% } else if (student != null && !"POST".equalsIgnoreCase(request.getMethod())) { %>
      <!-- Confirm delete -->
      <div class="mb-4 text-sm text-gray-700">
        <p><strong>Name:</strong> <%= student.getName() %></p>
        <p><strong>Father's Name:</strong> <%= student.getFathername() %></p>
        <p><strong>Mother's Name:</strong> <%= student.getMothername() %></p>
        <p><strong>Semester:</strong> <%= student.getSemester() %></p>
        <p><strong>Year:</strong> <%= student.getYear() %></p>
      </div>
      <form method="post">
        <input type="hidden" name="rollno" value="<%= student.getRollno() %>">
        <button type="submit"
                class="w-full bg-red-600 text-white p-2 rounded-md hover:bg-red-700 font-semibold">
          Confirm Delete
        </button>
      </form>
    <% } %>

  </div>

</body>
</html>
