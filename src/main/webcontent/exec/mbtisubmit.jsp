<%@ page import="java.util.Enumeration"%>
<%@ page import="edu.rit.se.crowdupworkanalytics.DBProcess"%>
<%
  /* String uid = session.getAttribute("userid").toString();
  Enumeration<String> en = request.getParameterNames();
  DBProcess dbProc = new DBProcess();
  int ret = 0;
  while (en.hasMoreElements()) {
    String parameterName = (String) en.nextElement();
    String parameterValue = request.getParameter(parameterName);
    if(parameterName.contains("generic")){
    	ret += dbProc.genericResponseData(uid, parameterName, parameterValue);	
    } else {
    	ret += dbProc.mbtiResponseData(uid, parameterName, parameterValue);
    }
  }
  if (ret > 0) {
  	String[] StateInfo = dbProc.updateState(uid,session.getAttribute("state").toString());
	session.setAttribute("state", StateInfo[0]);
    dbProc.disConnect();
    response.sendRedirect("../"+StateInfo[1]);
  } else {
	dbProc.disConnect();
    response.sendRedirect("../discpersona.jsp");
  } */
%>