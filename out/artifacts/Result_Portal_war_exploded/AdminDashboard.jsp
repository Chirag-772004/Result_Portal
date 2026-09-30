<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.setMaxInactiveInterval(300);
    String adminUser = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("userRole");

    if (adminUser == null || role == null || !"admin".equals(role)) {
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
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

  <!-- Navbar -->
  <nav class="bg-blue-600 text-white p-4 flex justify-between items-center">
    <span class="font-bold text-xl">Result Portal - Admin Dashboard</span>
    <div class="space-x-4">
      <a href="AddStudent.jsp" class="hover:underline">Add Student</a>
      <a href="UpdateStudent.jsp" class="hover:underline">Update Student</a>
      <a href="DeleteStudent.jsp" class="hover:underline">Delete Student</a>
      <a href="MarksForm.jsp" class="hover:underline">Add Marks</a>
      <a href="MarksForm.jsp" class="hover:underline">Update Marks</a>
      <a href="DeleteMarks.jsp" class="hover:underline">Delete Marks</a>
      <a href="ViewStudents.jsp" class="hover:underline">View Students</a>
      <a href="ViewSubjects.jsp" class="hover:underline">View Subjects</a>
    </div>
  </nav>

  <div class="p-6">
    <h2 class="text-2xl font-bold text-gray-700">Welcome, <%= adminUser %>!</h2>
    <p class="text-gray-600 mt-2">Use the navigation bar to manage students, marks, and view subjects.</p>
  </div>

</body>
</html>
