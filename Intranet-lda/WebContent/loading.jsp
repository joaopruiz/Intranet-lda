<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
 <HEAD>
 <noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
  <TITLE></TITLE>
<STYLE type=text/css>
 #divLoadCont{position:absolute; width:100%; height:100%; top:0; left:0; 

background-color:white; layer-background-color:white; font-family:arial,helvetica; 

z-index:100}
</STYLE>
<script type="text/javascript" language="JavaScript">
 function checkBrowser(){
  this.ver=navigator.appVersion
  this.dom=document.getElementById?1:0
  this.ie6=(this.ver.indexOf("MSIE 6")>-1 && this.dom)?1:0;
  this.ie5=(this.ver.indexOf("MSIE 5")>-1 && this.dom)?1:0;
  this.ie4=(document.all && !this.dom)?1:0;
  this.ns5=(this.dom && parseInt(this.ver) >= 5) ?1:0;
  this.ns4=(document.layers && !this.dom)?1:0;
  this.bw=(this.ie6 || this.ie5 || this.ie4 || this.ns4 || this.ns5)
  return this
 }
 bw=new checkBrowser()
 function hideIt(div){
  
   div="divLoadCont";
   obj=bw.dom?document.getElementById(div).style:bw.ie4?document.all[div].style:bw.ns4?
	document[div]:0; 
   obj.visibility='hidden';
  
 }
 onload=hideIt;
</script>
 </HEAD>
 <BODY TOPMARGIN="0" LEFTMARGIN="0"  background="img/Iceberg.jpg">
 <script>

	 document.write("<div id='divLoadCont'><table width='100%' height='100%' align='center' valign='middle'><tr><td width='100%' height='100%' align='center' valign='middle'><FONT FACE='Verdana' SIZE='2' COLOR='#000000'><B>Loading...</B></FONT></td></tr></table></div>");
 
 </script>
 <P><B>Loading Simples</B></P>
 <%String escala = Util.DataHojesemHORA(); 
						String e=(String) request.getParameter("theDate");
						if(e!=null){
							escala=e;
						}
						%>
						<div>
							<table class="search">
							<tr>
								<td>
								<%Util.Verificadiaescala(escala);%>
								</td>
							</tr>
							</table>
						</div>
						</form>
						<%=Util.imprimeEscalaAltera(escala)%>

</BODY>
</HTML>