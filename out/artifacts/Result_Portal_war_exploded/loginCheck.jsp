<%@ page import="java.sql.*, com.net.util.DBConnection, com.net.DAO.AdminDAO, com.net.DAO.StudentDAO, com.net.bean.AdminBean, com.net.bean.StudentBean" %>
<%
    String userid = request.getParameter("userid");
    String password = request.getParameter("password");

    Connection conn = null;
    try {
        conn = DBConnection.getConnection();

        boolean isAdmin = false;
        boolean isStudent = false;

        // First check admin
        AdminDAO adminDAO = new AdminDAO(conn);
        AdminBean admin = new AdminBean();
        admin.setUsername(userid);
        admin.setPassword(password);

        if (adminDAO.checkLogin(admin)) {
            isAdmin = true;
        } else {
            // Check student
            StudentDAO studentDAO = new StudentDAO(conn);
            StudentBean student = studentDAO.getStudent(Long.parseLong(userid));

            if (student != null && student.getDob().toString().equals(password)) {
                isStudent = true;
                session.setAttribute("studentName", student.getName());
            }
        }

        if (isAdmin) {
            session.setAttribute("userRole", "admin");
            session.setAttribute("user", userid);
            response.sendRedirect("AdminDashboard.jsp");
        } else if (isStudent) {
            session.setAttribute("userRole", "student");
            session.setAttribute("user", userid);
            response.sendRedirect("StudentDashboard.jsp");
        } else {
            %>
            <jsp:forward page="Login.jsp">
                <jsp:param name="error" value="Invalid username/roll no or password/DOB." />
            </jsp:forward>
            <%
        }

    } catch (Exception e) {
        e.printStackTrace();
        %>
        <jsp:forward page="Login.jsp">
            <jsp:param name="error" value="Error occurred during login. Please try again." />
        </jsp:forward>
        <%
    } finally {
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>
