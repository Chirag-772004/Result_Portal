<%@ page import="com.net.DAO.MarksDAO,java.sql.Connection, com.net.DAO.SubjectDAO, com.net.bean.MarksBean, com.net.bean.SubjectBean, com.net.util.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
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

    Connection conn = DBConnection.getConnection();
    MarksDAO marksDAO = new MarksDAO(conn);
    SubjectDAO subjectDAO = new SubjectDAO(conn);

    java.util.List<MarksBean> marksList = marksDAO.getMarksByRollNo(Long.parseLong(studentUser));
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Your Result</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

  <div class="max-w-2xl mx-auto mt-10 bg-white p-6 rounded shadow">
    <h2 class="text-2xl font-bold mb-4 text-center text-blue-600">Your Result</h2>

    <% if (marksList != null && !marksList.isEmpty()) { %>
    <table class="w-full border border-gray-300">
      <thead class="bg-blue-100">
        <tr>
          <th class="border border-gray-300 p-2">Subject Code</th>
          <th class="border border-gray-300 p-2">Subject Name</th>
          <th class="border border-gray-300 p-2">Marks</th>
        </tr>
      </thead>
      <tbody>
      <% 
        for (MarksBean mark : marksList) { 
            SubjectBean subject = subjectDAO.getSubject(mark.getSubjectcode());
      %>
        <tr>
          <td class="border border-gray-300 p-2"><%= mark.getSubjectcode() %></td>
          <td class="border border-gray-300 p-2"><%= subject != null ? subject.getSubjectname() : "N/A" %></td>
          <td class="border border-gray-300 p-2"><%= mark.getMarks() %></td>
        </tr>
      <% } %>
      </tbody>
    </table>
    <% } else { %>
      <p class="text-center text-red-500">No result found for your roll number.</p>
    <% } %>

    <div class="mt-4 text-center">
      <a href="StudentDashboard.jsp" class="text-blue-500 underline">Back to Dashboard</a>
    </div>
  </div>

</body>
</html>
