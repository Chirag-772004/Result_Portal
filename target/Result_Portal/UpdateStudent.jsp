<%@ page import="java.sql.*" %>
<%@ page import="com.net.util.DBConnection" %>
<%@ page import="com.net.DAO.StudentDAO" %>
<%@ page import="com.net.bean.StudentBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String msg = null;
    StudentBean student = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Handle update submission
        try {
            long rollno = Long.parseLong(request.getParameter("rollno"));
            String name = request.getParameter("name");
            String fathername = request.getParameter("fathername");
            String mothername = request.getParameter("mothername");
            Date dob = Date.valueOf(request.getParameter("dob"));
            int semester = Integer.parseInt(request.getParameter("semester"));
            int year = Integer.parseInt(request.getParameter("year"));
            String course = request.getParameter("course");

            student = new StudentBean();
            student.setRollno(rollno);
            student.setName(name);
            student.setFathername(fathername);
            student.setMothername(mothername);
            student.setDob(dob);
            student.setSemester(semester);
            student.setYear(year);
            student.setCourse(course);

            Connection conn = DBConnection.getConnection();
            StudentDAO dao = new StudentDAO(conn);
            boolean success = dao.updateStudent(student);
            conn.close();

            if (success) {
                msg = "Student record updated successfully.";
            } else {
                msg = "Failed to update student record.";
            }

        } catch (Exception e) {
            msg = "Error: " + e.getMessage();
        }
    } else if (request.getParameter("rollno") != null) {
        // Fetch details for editing
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
  <title>Update Student</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex justify-center items-center min-h-screen">

  <div class="bg-white p-6 rounded-lg shadow-md w-full max-w-md">
    <h2 class="text-xl font-bold text-center text-blue-700 mb-4">Update Student</h2>

    <% if (msg != null) { %>
      <p class="<%= msg.startsWith("Student record updated") ? "text-green-600" : "text-red-500" %> font-semibold mb-4 text-center">
        <%= msg %>
      </p>
    <% } %>

    <% if (student == null && !"POST".equalsIgnoreCase(request.getMethod())) { %>
      <!-- Roll number input form -->
      <form method="get" class="space-y-4">
        <div>
          <label class="block text-sm font-medium text-gray-700">Enter Roll No</label>
          <input type="text" name="rollno" required
                 class="w-full border border-gray-300 rounded-md p-2 focus:ring-blue-500 focus:border-blue-500"
                 placeholder="Roll No">
        </div>
        <button type="submit"
                class="w-full bg-blue-600 text-white p-2 rounded-md hover:bg-blue-700 font-semibold">
          Fetch Details
        </button>
      </form>

    <% } else if (student != null) { %>
      <!-- Update form -->
      <form method="post" class="space-y-4">
        <input type="hidden" name="rollno" value="<%= student.getRollno() %>">

        <div>
          <label class="block text-sm font-medium text-gray-700">Name</label>
          <input type="text" name="name" value="<%= student.getName() %>" required
                 class="w-full border border-gray-300 rounded-md p-2">
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700">Father's Name</label>
          <input type="text" name="fathername" value="<%= student.getFathername() %>" required
                 class="w-full border border-gray-300 rounded-md p-2">
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700">Mother's Name</label>
          <input type="text" name="mothername" value="<%= student.getMothername() %>" required
                 class="w-full border border-gray-300 rounded-md p-2">
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700">Date of Birth</label>
          <input type="date" name="dob" value="<%= student.getDob() %>" required
                 class="w-full border border-gray-300 rounded-md p-2">
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700">Semester</label>
          <input type="number" name="semester" value="<%= student.getSemester() %>" required min="1"
                 class="w-full border border-gray-300 rounded-md p-2">
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700">Year</label>
          <input type="number" name="year" value="<%= student.getYear() %>" required
                 class="w-full border border-gray-300 rounded-md p-2">
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700">Course</label>
          <input type="text" name="course" value="<%= student.getCourse() %>" readonly
                 class="w-full border border-gray-300 rounded-md p-2 bg-gray-100">
        </div>

        <button type="submit"
                class="w-full bg-blue-600 text-white p-2 rounded-md hover:bg-blue-700 font-semibold">
          Update Student
        </button>
      </form>
    <% } %>
  </div>

</body>
</html>
