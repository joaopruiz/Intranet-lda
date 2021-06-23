<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>Insert title here</title>
<link rel="stylesheet" href="style.css" type="text/css" media="screen" />
</head>
<body>
<div id="layout_wrapper">
	<div id="layout_edgetop"></div>

		<div id="layout_container">

			<!--<div id="navigation">

				<div id="tabs">
			
					<ul>
								
					</ul>

					<div class="clearer"></div>

				</div>

			</div>-->



		<div class="spacer h5"></div>
			<div id="site_title">

			<h1 class="left"><%String msg ="olá mundo"; out.print(msg); %></h1>
</div>
</div>
</div>
</body>
</html>