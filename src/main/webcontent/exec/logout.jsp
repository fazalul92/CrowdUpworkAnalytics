<%@ page import="java.sql.ResultSet"%>
<%@ page import="edu.rit.se.crowdupworkanalytics.DBProcess"%>
<%
	session.removeAttribute( "userid" );
	session.removeAttribute( "state" );
	session.removeAttribute( "groupid" );
	session.removeAttribute( "auth" );
	session.invalidate();
	response.sendRedirect("../index.jsp");
%>