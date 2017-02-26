<%@ page import="java.sql.ResultSet"%>
<%@ page import="edu.rit.se.crowdupworkanalytics.DBProcess"%>
<%
	String username = request.getParameter("username");
	DBProcess dbProc = new DBProcess();
	try {
		int ret = dbProc.loginUser(username);
		if (ret == 0) {
			ret = dbProc.registerUser(username);
			dbProc.addLog(ret,"RegistrationAttempt");
		}
		if (ret == 0) {
			response.sendRedirect("../index.jsp");
		} else {
			ResultSet rs = dbProc.getUser(Integer.toString(ret));
			rs.next();
			session.setAttribute("userid", ret);
			session.setAttribute("state", rs.getInt("state"));
			session.setAttribute("completion", rs.getInt("completion"));
			session.setAttribute("auth", true);
			session.setAttribute("bid",rs.getInt("bid"));
			session.setAttribute("tid",rs.getInt("tid"));
			dbProc.addLog(ret,"Login");
			response.sendRedirect("../dashboard.jsp");
		}
	} finally {
		dbProc.disConnect();
	}
%>