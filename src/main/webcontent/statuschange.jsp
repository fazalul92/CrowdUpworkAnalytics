<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="head.jsp"%>
<style>
h2 {
	font-size: 24px
}

h3 {
	font-size: 18px
}
</style>
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<%@ include file="menu.jsp"%>
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Instructions</h3>
						</div>

					</div>
					<!--  Start Panel -->
					<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="x_panel">
							<div class="x_content">
								<h2>Task Completed</h2>

								<p>
									You are highly encouraged to work on another task. Would you like to proceed? If you choose not to, you will be redirected to the completion page and cannot return to this task.
								</p>
								
            					<form class="form-horizontal form-label-left" method="post" id="statuschange" action="exec/statuschange.jsp">
									<input type="radio" name="choice" value="complete"> Get completion code
									<input type="radio" name="choice" value="return"> Get another task
									<button type="submit" value="Submit Choice"></button>
								</form>
								

							</div>
						</div>
					</div>
					<!-- End Panel -->

				</div>
			</div>
			<!-- /page content -->


			<%@ include file="scripts.jsp"%>
</body>
</html>