<%@ page import="com.net.DAO.MarksDAO,java.sql.Connection, com.net.bean.MarksBean, com.net.util.DBConnection" %>
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

    String mode = request.getParameter("mode"); // add or update
    String rollno = request.getParameter("rollno");
    String subjectcode = request.getParameter("subjectcode");
    String marksStr = request.getParameter("marks");

    boolean formSubmitted = "POST".equalsIgnoreCase(request.getMethod());
    boolean success = false;
    String message = "";

    // Pre-populate marks if in update mode and not yet submitted
    if (!formSubmitted && "update".equalsIgnoreCase(mode) && rollno != null && subjectcode != null) {
        try {
            Connection conn = DBConnection.getConnection();
            MarksDAO marksDAO = new MarksDAO(conn);
            MarksBean existingMarks = marksDAO.getMarks(Long.parseLong(rollno), subjectcode);
            if (existingMarks != null) {
                marksStr = String.valueOf(existingMarks.getMarks());
            }
            conn.close();
        } catch (Exception e) {
            message = "Error fetching existing marks: " + e.getMessage();
        }
    }

    if (formSubmitted) {
        try {
            long rno = Long.parseLong(rollno);
            String scode = subjectcode;
            int marks = Integer.parseInt(marksStr);

            Connection conn = DBConnection.getConnection();
            MarksDAO marksDAO = new MarksDAO(conn);

            MarksBean mb = new MarksBean();
            mb.setRollno(rno);
            mb.setSubjectcode(scode);
            mb.setMarks(marks);

            if ("update".equalsIgnoreCase(mode)) {
                success = marksDAO.addOrUpdate(mb);
                message = success ? "Marks updated successfully." : "Failed to update marks.";
            } else {
                success = marksDAO.addOrUpdate(mb);
                message = success ? "Marks added successfully." : "Failed to add marks.";
            }

            conn.close();
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title><%= mode != null && mode.equalsIgnoreCase("update") ? "Update Marks" : "Add Marks" %></title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

  <div class="max-w-md mx-auto mt-10 bg-white p-6 rounded shadow">
    <h2 class="text-2xl font-bold mb-4 text-center text-blue-600">
      <%= mode != null && mode.equalsIgnoreCase("update") ? "Update Marks" : "Add Marks" %>
    </h2>

    <% if (formSubmitted) { %>
        <p class="<%= success ? "text-green-600" : "text-red-600" %> text-center font-semibold mb-4"><%= message %></p>
        <div class="text-center">
            <a href="AdminDashboard.jsp" class="text-blue-500 underline">Back to Dashboard</a>
        </div>
    <% } else { %>
        <form method="post" class="space-y-4">
          <input type="hidden" name="mode" value="<%= mode != null ? mode : "add" %>">
          <div>
            <label class="block font-semibold">Student Roll No</label>
            <input type="text" name="rollno" required 
                   value="<%= rollno != null ? rollno : "" %>" 
                   <%= "update".equalsIgnoreCase(mode) ? "readonly" : "" %>
                   class="w-full border border-gray-300 rounded p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>

          <div>
            <label class="block font-semibold">Subject Code</label>
            <input type="text" name="subjectcode" required
                   value="<%= subjectcode != null ? subjectcode : "" %>"
                   <%= "update".equalsIgnoreCase(mode) ? "readonly" : "" %>
                   class="w-full border border-gray-300 rounded p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>

          <div>
            <label class="block font-semibold">Marks</label>
            <input type="number" name="marks" min="0" max="100" required
                   value="<%= marksStr != null ? marksStr : "" %>"
                   class="w-full border border-gray-300 rounded p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
          </div>

          <button type="submit" class="w-full bg-blue-600 text-white font-bold p-2 rounded hover:bg-blue-700">
            <%= mode != null && mode.equalsIgnoreCase("update") ? "Update Marks" : "Add Marks" %>
          </button>
        </form>
    <% } %>

  </div>

</body>
</html>
