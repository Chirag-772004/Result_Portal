<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Set session timeout: 5 minutes (300 seconds)
    session.setMaxInactiveInterval(300);

    String studentUser = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("userRole");
    String studentName = (String) session.getAttribute("studentName");  // you must set this at login

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
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <meta http-equiv="refresh" content="300;URL=Login.jsp">
</head>
<body class="bg-gray-100">

  <!-- Navbar -->
  <nav class="bg-blue-600 text-white p-4 flex justify-between items-center">
    <span class="font-bold text-xl">Result Portal - Student Dashboard</span>
    <div class="space-x-4">
      <a href="ViewStudentDetails.jsp" class="hover:underline">View Details</a>
      <a href="Login.jsp" class="hover:underline">Logout</a>
    </div>
    
  </nav>

  <!-- Greeting -->
  <div class="p-6 text-center">
    <h2 class="text-2xl font-bold text-gray-700">
      Welcome, <%= studentName != null ? studentName : studentUser %>!
    </h2>
    <p class="text-sm text-gray-500 mt-1">You will be automatically logged out after 5 minutes of inactivity.</p>
  </div>

  <!-- Center content -->
  <div class="flex items-center justify-center min-h-[60vh]">
    <a href="ViewResult.jsp" class="bg-green-600 text-white text-lg font-bold px-6 py-3 rounded hover:bg-green-700">
      View Result
    </a>
  </div>

</body>
</html>
