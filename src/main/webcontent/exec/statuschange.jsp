<%@ page import="java.util.Enumeration"%>
<%@ page import="edu.rit.se.crowdupworkanalytics.DBProcess"%>
<%	
	String uid = session.getAttribute("userid").toString();
	String choice = request.getParameter("choice");
	DBProcess dbProc = new DBProcess();
	int ret = 0;
	int currentState = Integer.parseInt(session.getAttribute("state").toString());
	if(choice.equals("complete")){
      	String[] StateInfo = dbProc.updateState(uid,session.getAttribute("state").toString());
	    session.setAttribute("state", StateInfo[0]);
	    dbProc.disConnect();
        response.sendRedirect("../"+StateInfo[1]);
	} else {
      	String[] StateInfo = dbProc.goToPreviousState(uid,Integer.parseInt(session.getAttribute("state").toString()));
	    session.setAttribute("state", StateInfo[0]);
	    session.setAttribute("bid",0);
	    dbProc.disConnect();
        response.sendRedirect("../"+StateInfo[1]);
	}
   	dbProc.disConnect();
    response.sendRedirect("../task.jsp");
%>