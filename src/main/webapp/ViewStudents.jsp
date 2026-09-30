<%@ page import="java.sql.*, com.net.util.DBConnection" %>
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

    Connection conn = DBConnection.getConnection();
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT rollno, name FROM student");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>View Students</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
  <div class="max-w-2xl mx-auto mt-10 bg-white p-6 rounded shadow">
    <h2 class="text-2xl font-bold mb-4 text-center text-blue-600">Students List</h2>
    
    <table class="w-full border border-gray-300">
      <thead class="bg-blue-100">
        <tr>
          <th class="p-2 border">Roll No</th>
          <th class="p-2 border">Name</th>
          <th class="p-2 border">Action</th>
        </tr>
      </thead>
      <tbody>
      <%
        while (rs.next()) {
      %>
        <tr>
          <td class="p-2 border"><%= rs.getLong("rollno") %></td>
          <td class="p-2 border"><%= rs.getString("name") %></td>
          <td class="p-2 border text-center space-x-2">
            <form action="UpdateStudent.jsp" method="get" class="inline">
              <input type="hidden" name="rollno" value="<%= rs.getLong("rollno") %>">
              <button type="submit" class="bg-blue-600 text-white px-3 py-1 rounded hover:bg-blue-700">
                Update
              </button>
            </form>
            <form action="DeleteStudent.jsp" method="get" class="inline">
              <input type="hidden" name="rollno" value="<%= rs.getLong("rollno") %>">
              <button type="submit" class="bg-red-600 text-white px-3 py-1 rounded hover:bg-red-700">
                Delete
              </button>
            </form>
          </td>
        </tr>
      <%
        }
        conn.close();
      %>
      </tbody>
    </table>

    <div class="mt-4 text-center">
      <a href="AdminDashboard.jsp" class="text-blue-500 underline">Back to Dashboard</a>
    </div>
  </div>
</body>
</html>
