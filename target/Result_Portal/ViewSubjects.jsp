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

    // Example: Get current semester (you can set this at login or dashboard)
    String semesterParam = request.getParameter("semester");
    int semester = semesterParam != null ? Integer.parseInt(semesterParam) : 4;

    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT subjectcode, subjectname FROM subject");
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>View Subjects</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
  <div class="max-w-xl mx-auto mt-10 bg-white p-6 rounded shadow">
    <h2 class="text-2xl font-bold mb-4 text-center text-blue-600">Subjects for Semester <%= semester %></h2>

    <table class="w-full border border-gray-300">
      <thead class="bg-blue-100">
        <tr>
          <th class="p-2 border">Subject Code</th>
          <th class="p-2 border">Subject Name</th>
        </tr>
      </thead>
      <tbody>
      <%
        boolean hasSubjects = false;
        while (rs.next()) {
          hasSubjects = true;
      %>
        <tr>
          <td class="p-2 border"><%= rs.getString("subjectcode") %></td>
          <td class="p-2 border"><%= rs.getString("subjectname") %></td>
        </tr>
      <%
        }
        if (!hasSubjects) {
      %>
        <tr>
          <td colspan="2" class="p-2 border text-center text-red-500">No subjects found for this semester.</td>
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
