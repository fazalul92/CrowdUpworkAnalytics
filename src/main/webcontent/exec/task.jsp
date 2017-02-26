<%@ page import="java.util.Enumeration"%>
<%@ page import="edu.rit.se.crowdupworkanalytics.DBProcess"%>
<%	
	String uid = session.getAttribute("userid").toString();
	Enumeration<String> en = request.getParameterNames();
	DBProcess dbProc = new DBProcess();
	int ret = 0;
	while (en.hasMoreElements()) {
		String parameterName = en.nextElement().toString();
		System.out.println(parameterName);
	    String[] parameterNameComplete = parameterName.split("-");
	    String value = request.getParameter(parameterName);
	    ret += dbProc.submitReviewerResponse(uid, parameterNameComplete[0], parameterNameComplete[1], value);
	}
    if (ret > 0) {
      	String[] StateInfo = dbProc.updateState(uid,session.getAttribute("state").toString());
	    session.setAttribute("state", StateInfo[0]);
	    dbProc.disConnect();
        response.sendRedirect("../"+StateInfo[1]);
    } else {
    	dbProc.disConnect();
        response.sendRedirect("../task.jsp");
    }
%>