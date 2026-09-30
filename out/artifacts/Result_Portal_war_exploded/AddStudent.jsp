<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.setMaxInactiveInterval(600);
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
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Student</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

  <div class="flex justify-center items-center min-h-screen">
    <form action="AddStudentProcess.jsp" method="post" class="bg-white p-6 rounded-lg shadow-md w-full max-w-md">
      <h2 class="text-xl font-bold text-center mb-4 text-blue-700">Add Student</h2>

      <div class="mb-3">
        <label class="block text-sm font-medium text-gray-700">Roll No</label>
        <input type="text" name="rollno" placeholder="Roll No" required
               class="mt-1 w-full border border-gray-300 rounded-md p-2 focus:ring-blue-500 focus:border-blue-500">
      </div>

      <div class="mb-3">
        <label class="block text-sm font-medium text-gray-700">Name</label>
        <input type="text" name="name" required
               class="mt-1 w-full border border-gray-300 rounded-md p-2 focus:ring-blue-500 focus:border-blue-500">
      </div>

      <div class="mb-3">
        <label class="block text-sm font-medium text-gray-700">Father's Name</label>
        <input type="text" name="fathername" required
               class="mt-1 w-full border border-gray-300 rounded-md p-2 focus:ring-blue-500 focus:border-blue-500">
      </div>

      <div class="mb-3">
        <label class="block text-sm font-medium text-gray-700">Mother's Name</label>
        <input type="text" name="mothername" required
               class="mt-1 w-full border border-gray-300 rounded-md p-2 focus:ring-blue-500 focus:border-blue-500">
      </div>

      <div class="mb-3">
        <label class="block text-sm font-medium text-gray-700">DOB</label>
        <input type="date" name="dob" required
               class="mt-1 w-full border border-gray-300 rounded-md p-2 focus:ring-blue-500 focus:border-blue-500">
      </div>

      <div class="mb-3">
        <label class="block text-sm font-medium text-gray-700">Semester</label>
        <input type="number" name="semester" min="1" max="8" required
               class="mt-1 w-full border border-gray-300 rounded-md p-2 focus:ring-blue-500 focus:border-blue-500">
      </div>

      <div class="mb-3">
        <label class="block text-sm font-medium text-gray-700">Year</label>
        <input type="number" name="year" required
               class="mt-1 w-full border border-gray-300 rounded-md p-2 focus:ring-blue-500 focus:border-blue-500">
      </div>

      <div class="mb-4">
        <label class="block text-sm font-medium text-gray-700">Course</label>
        <input type="text" name="course" value="Bachelor Of Technology" readonly
               class="mt-1 w-full bg-gray-100 border border-gray-300 rounded-md p-2">
      </div>

      <button type="submit" 
              class="w-full bg-blue-600 text-white p-2 rounded-md hover:bg-blue-700 font-semibold">
        Add Student
      </button>
    </form>
  </div>

</body>
</html>
