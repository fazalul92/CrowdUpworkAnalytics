<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="edu.rit.se.crowdupworkanalytics.DBProcess" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <%@ include file="head.jsp" %>
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
		<%@ include file="menu.jsp" %>
		
		<%
		  DBProcess dbProc = new DBProcess();
			ResultSet rs2 = dbProc.getAllTestCases(session.getAttribute("userid").toString());
		%>
		
        <!-- page content -->
        
		
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Testcase Review</h3>
              </div>

            </div>
            <div class="clearfix"></div>
            <form class="form-horizontal form-label-left" method="post" id="presurvey" action="exec/task.jsp">
            	<% while(rs2.next()) { %>
	            <div class="row">
	              <div class="col-md-12 col-sm-12 col-xs-12">
	                <div class="x_panel">
	                  <div class="x_title">
	                    <h2>Testcase Questions <small>Step 1</small></h2>
	                    <div class="clearfix"></div>
	                  </div>
	                  <div class="x_content">
	                    <br />
	                    <table>
	                    	<thead>
	                    		<th>Requirement</th>
	                    		<th><%= dbProc.getRequirementDescription(rs2.getString("rid")) %>
	                    	</thead>
	                    	<tbody>
	                    		<tr>
	                    			<td>Stimuli</td>
	                    			<td> <%= rs2.getString("stimuli") %> </td>
	                    		</tr>
	                    		<tr>
	                    			<td>Context</td>
	                    			<td> <%= rs2.getString("context") %> </td>
	                    		</tr>
	                    		<tr>
	                    			<td>Behavior</td>
	                    			<td> <%= rs2.getString("behavior") %> </td>
	                    		</tr>
	                    	</tbody>
	                    </table>
	                     <table class="table" style="border:0px;">
	                      <tbody>
	                        <% 
	            			
	                        ResultSet rs1 = dbProc.getQuestions("reviewer_questions");
	                        while(rs1.next()) { 
	                        
	                        %>
		                        <tr>
		                        <% if (rs1.getString("question_type").equals("text")) { %>
		                          <th scope="row"><label class="" for="<%= rs2.getInt("id") %>-<%= rs1.getInt("id") %>"><%= rs1.getString("description") %> <span class="required"><% if(rs1.getInt("required")==1){ out.println("*"); } %></span></label></th>
		                          <td><input type="text" id="<%= rs2.getInt("id") %>-<%= rs1.getInt("id") %>" name="<%= rs2.getInt("id") %>-<%= rs1.getInt("id") %>" <% if(rs1.getInt("required")==1){ out.println("required"); } %> class="form-control" placeholder="<%= rs1.getString("answer_choices") %>"></td>
		                    	<% } else if (rs1.getString("question_type").equals("multiple_choice")) { 
		                    		String answers = rs1.getString("answer_choices");
		                    		String[] choices = answers.split("\\|");
		                    	%>
		                          <th scope="row"><label class="" for="<%= rs2.getInt("id") %>-<%= rs1.getInt("id") %>"><%= rs1.getString("description") %> <span class="required"><% if(rs1.getInt("required")==1){ out.println("*"); } %></span></label></th>
		                          <td><select <% if(rs1.getInt("required")==1){ out.println("required"); } %> name="<%= rs2.getInt("id") %>-<%= rs1.getInt("id") %>" class="form-control">
		                          		<option value=""></option>
				                        <% for (int i = 0; i < choices.length; i++) { %>
				                        
				                        <option value="<%= choices[i] %>"><%= choices[i] %></option>
		                    	
		                    			<% } %>
		                    	</select></td>
		                    	<% } else if (rs1.getString("question_type").equals("multiple_choice_radio")) { 
		                    		String answers = rs1.getString("answer_choices");
		                    		String[] choices = answers.split("\\|");
		                    	%>
		                          <th scope="row"><label class="" for="<%= rs2.getInt("id") %>-<%= rs1.getInt("id") %>"><%= rs1.getString("description") %> <span class="required"><% if(rs1.getInt("required")==1){ out.println("*"); } %></span></label></th>
		                          <td>
				                        <% for (int i = 0; i < choices.length; i++) { %>
				                        <div style="width: 20%; float: left;">
				                        <input type="radio" name="<%= rs2.getInt("id") %>-<%= rs1.getInt("id") %>" value="<%= choices[i] %>" <% if(rs1.getInt("required")==1){ out.println("required"); } %> > <%= choices[i] %>
		                    			</div>
		                    			<% } %>
		                    	</td>
		                    	<% } %>
		                        </tr>
		                    <% } %>
	                       
	                      </tbody>
	                    </table> 
	                    
	                    
	                    
	                  </div>
	                </div>
	              </div>
	            </div>
	            <% } %>
               <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                     <button class="btn btn-primary">Cancel</button>
                     <button id="subm" class="btn btn-success">Submit</button>
               </div>
	            
            </form>
            
              </div>
            </div>
          </div>
        </div>
        
        <!-- /page content -->

        
	<%@ include file="scripts.jsp" %>
  </body>
</html>
<% dbProc.disConnect(); %>