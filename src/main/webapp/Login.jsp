<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Result Portal Login</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">

  <div class="bg-white shadow-lg rounded-lg p-6 w-full max-w-sm">
    <h2 class="text-center text-2xl font-bold text-gray-700 mb-4">Result Portal Login</h2>

    <form action="loginCheck.jsp" method="post" class="space-y-4">
      
      <div>
        <label class="block text-gray-600 mb-1">Roll No</label>
        <input type="text" name="userid" required
               class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
               placeholder="Student Roll No">
      </div>

      <div>
        <label class="block text-gray-600 mb-1">DOB</label>
        <input type="password" name="password" required
               class="w-full border border-gray-300 rounded-md p-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
               placeholder="DOB (YYYY-MM-DD)">
      </div>

      <button type="submit"
              class="w-full bg-blue-600 text-white p-2 rounded-md hover:bg-blue-700">
        Login
      </button>

      
      <%
        String error = request.getParameter("error");
        if (error != null) {
      %>
        <p class="text-center text-red-500 text-sm mt-2"><%= error %></p>
      <%
        }
      %>

    </form>

    <p class="text-center text-xs text-gray-500 mt-4">
      Students: Roll No + DOB (YYYY-MM-DD).
    </p>
  </div>

</body>
</html>
