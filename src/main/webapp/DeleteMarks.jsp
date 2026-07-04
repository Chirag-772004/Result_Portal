<%@ page import="com.net.util.DBConnection,java.sql.*, com.net.DAO.MarksDAO, com.net.bean.MarksBean" %>
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

    String message = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String rollnoStr = request.getParameter("rollno");
        String subjectcode = request.getParameter("subjectcode");

        if (rollnoStr != null && subjectcode != null) {
            try {
                long rollno = Long.parseLong(rollnoStr);
                Connection conn = DBConnection.getConnection();
                MarksDAO marksDAO = new MarksDAO(conn);
                MarksBean mb = new MarksBean();
                mb.setRollno(rollno);
                mb.setSubjectcode(subjectcode);

                boolean success = marksDAO.deleteMarks(mb);
                if (success) {
                    message = "Marks deleted successfully!";
                } else {
                    message = "No matching record found to delete.";
                }

            } catch (Exception e) {
                message = "Error: " + e.getMessage();
            }
        } else {
            message = "Please fill all fields.";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Delete Marks</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

  <div class="max-w-md mx-auto mt-10 bg-white p-6 rounded shadow">
    <h2 class="text-2xl font-bold mb-4 text-center text-blue-600">Delete Marks</h2>

    <form method="post" class="space-y-4">

      <div>
        <label class="block font-semibold">Student Roll No</label>
        <input type="text" name="rollno" required
               class="w-full border border-gray-300 rounded p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
      </div>

      <div>
        <label class="block font-semibold">Subject Code</label>
        <input type="text" name="subjectcode" required
               class="w-full border border-gray-300 rounded p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
      </div>

      <button type="submit" class="w-full bg-red-600 text-white font-bold p-2 rounded hover:bg-red-700">
        Delete Marks
      </button>

    </form>

    <% if (message != null) { %>
      <p class="mt-4 text-center font-semibold <%= message.startsWith("Error") || message.startsWith("No") ? "text-red-500" : "text-green-600" %>">
        <%= message %>
      </p>
    <% } %>

    <div class="mt-4 text-center">
      <a href="AdminDashboard.jsp" class="text-blue-500 underline">Back to Dashboard</a>
    </div>
  </div>

</body>
</html>
