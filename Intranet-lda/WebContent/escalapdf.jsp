<%@page import="metodos.*" %>
<%@page import="bean.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.lowagie.text.*"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.awt.Color"%>
<%@page import="com.lowagie.text.Document"%>
<%@page import="com.lowagie.text.DocumentException"%>
<%@page import="com.lowagie.text.Paragraph"%>
<%@page import="com.lowagie.text.pdf.PdfPCell"%>
<%@page import="com.lowagie.text.pdf.PdfPTable"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="com.lowagie.text.Image"%>
<%@page import="com.lowagie.text.Chunk"%>
<%@page import="com.lowagie.text.Phrase"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<html>
<head>
<noscript>
<meta http-equiv="Refresh" content="1;URL=semjava.jsp" />
</noscript>
<title>Insert title here</title>
</head>
<body>
<%String data = (String) request.getParameter("data");
String[][] vectorpla1 = Util.comboboxUSUARIOSArrayListUPPER();

Rectangle pageSize = new Rectangle(800, 300);
Document document = new Document();
ByteArrayOutputStream baos = new ByteArrayOutputStream();
PdfWriter.getInstance(document, baos);
document.open();
//aki preenche o pdf com os dados

ResultSet res = Util.retornaResultset(data);
Font  titulo = new Font(Font.TIMES_ROMAN, Font.BOLD, Font.UNDERLINE);
titulo.setSize(22);
Font  titulo1 = new Font(Font.TIMES_ROMAN, Font.BOLD, Font.NORMAL);
titulo1.setSize(22);
Font  texto = new Font(Font.TIMES_ROMAN, Font.DEFAULTSIZE, Font.NORMAL);
texto.setSize(7);
Font  textonegrito = new Font(Font.TIMES_ROMAN, Font.DEFAULTSIZE, Font.BOLD);
textonegrito.setSize(7);
Font  rodape = new Font(Font.TIMES_ROMAN, Font.DEFAULTSIZE, Font.BOLD);
rodape.setSize(8);
Font red = FontFactory.getFont(FontFactory.HELVETICA, Font.DEFAULTSIZE, Font.BOLD, new Color(0xFF, 0x00, 0x00));

	
	//Image imagem = Image.getInstance("C:/Arquivos de programas/Apache Software Foundation/Tomcat 6.0/webapps/ROOT/img/brasao_negro.jpg");
	//aki fica o path da imagem
	Image imagem = Image.getInstance("http://localhost:8082/Intranet-lda/img/brasao_negro.jpg");
	imagem.scalePercent(15);
	imagem.setAlignment(Element.ALIGN_CENTER);
	Paragraph pr = new Paragraph("MJ - DEPARTAMENTO DE POLÍCIA FEDERAL");
	pr.setAlignment(Element.ALIGN_CENTER);
	Paragraph pr1 = new Paragraph("SUPERINTENDÊNCIA REGIONAL NO PARANÁ");
	pr.setAlignment(Element.ALIGN_CENTER);
	Paragraph pr2 = new Paragraph("DELEGACIA DE POLÍCIA FEDERAL EM LONDRINA");
	pr.setAlignment(Element.ALIGN_CENTER);
	
	Chunk ck = new Chunk(imagem, 0, -5);

	PdfPTable tabelatt = new PdfPTable(2);
	PdfPTable tabelaint = new PdfPTable(1);
	PdfPCell celula1 = new PdfPCell(pr);
	celula1.setColspan(2);
	PdfPCell celula2 = new PdfPCell(pr1);
	celula2.setColspan(2);
	PdfPCell celula3 = new PdfPCell(pr2);
	celula3.setColspan(2);
	PdfPCell celula4 = new PdfPCell(imagem);
	PdfPCell celula5 = new PdfPCell(tabelaint);
	celula4.setHorizontalAlignment(Element.ALIGN_CENTER);
	celula3.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula2.setHorizontalAlignment(Element.ALIGN_LEFT);
	celula1.setHorizontalAlignment(Element.ALIGN_LEFT);
	
	celula1.setBorderColor(Color.WHITE);
	celula2.setBorderColor(Color.WHITE);
	celula3.setBorderColor(Color.WHITE);
	celula4.setBorderColor(Color.WHITE);
	celula5.setBorderColor(Color.WHITE);
	
	tabelatt.addCell(celula4);
	tabelaint.addCell(celula1);
	tabelaint.addCell(celula2);
	tabelaint.addCell(celula3);
	tabelatt.addCell(celula5);
	
	
	tabelatt.setWidthPercentage(100);
	float[] widths2 = {1f, 1f};
	widths2[0] = 40f;
	widths2[1] = 100f;
	
	tabelatt.setWidths(widths2);
	
	document.add(tabelatt);
	Phrase fase = new Phrase();
	fase.add(ck);
	//fase.add(tabelatt);
	
	
	Paragraph ptb=new Paragraph(fase);
	ptb.setAlignment(Element.ALIGN_CENTER);
	//document.add(ptb);

	document.add(new Paragraph(" "));
	document.add(new Paragraph(" "));
	Paragraph para = new Paragraph(new Chunk("ESCALA DE SERVIÇO", titulo));
	para.setAlignment(Element.ALIGN_CENTER);
	document.add(para);
	document.add(new Paragraph(" "));
	
	
	String dto=data.substring(3,5);
	//System.out.println("tnocdarp: "+dto);
	int diadomes=Integer.parseInt(dto);
	String mes=Util.retornaMes(diadomes);
	
	Paragraph para1 = new Paragraph(new Chunk(mes+" / "+data.substring(6,10), titulo1));
	para1.setAlignment(Element.ALIGN_CENTER);
	document.add(para1);
	document.add(new Paragraph(" "));
	
	
	//inicio da tabela
	float[] widths = {1f, 1f, 1f, 1f, 1f, 1f, 1f, 1f, 1f};
	PdfPTable table = new PdfPTable(9);
	
	PdfPCell cell1 = new PdfPCell(new Paragraph("SOBREAVISOS"));
	cell1.setColspan(9);
	cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
	table.addCell(cell1);
	
	PdfPCell celldatat = new PdfPCell(new Paragraph("DATA"));
	//celldatat.setColspan(8);
	//celldatat.setExtraParagraphSpace(30);
	table.addCell(celldatat);
	
	PdfPCell cellpl1 = new PdfPCell(new Paragraph("PLA1"));
	//cellpl1.setColspan(9);
	table.addCell(cellpl1);
	
	PdfPCell cellpl2 = new PdfPCell(new Paragraph("PLA2"));
	//cellpl1.setColspan(9);
	table.addCell(cellpl2);
	
	PdfPCell cellag1 = new PdfPCell(new Paragraph("APF1"));
	//cellpl1.setColspan(9);
	table.addCell(cellag1);
	
	PdfPCell cellag2 = new PdfPCell(new Paragraph("APF2"));
	//cellpl1.setColspan(9);
	table.addCell(cellag2);
	
	PdfPCell cellepf = new PdfPCell(new Paragraph("EPF"));
	//cellpl1.setColspan(9);
	table.addCell(cellepf);
	
	PdfPCell celldpf = new PdfPCell(new Paragraph("DPF"));
	//cellpl1.setColspan(9);
	table.addCell(celldpf);
	
	PdfPCell cellpap = new PdfPCell(new Paragraph("PPF"));
	//cellpl1.setColspan(9);
	table.addCell(cellpap);
	
	PdfPCell cellper = new PdfPCell(new Paragraph("PCF"));
	cellper.setColspan(9);
	table.addCell(cellper);
	
	//variáveis axiliares
	PdfPCell celldata;
	PdfPCell cellpl1t;
	PdfPCell cellpl2t;
	PdfPCell cellag1t;
	PdfPCell cellag2t;
	PdfPCell cellepft;
	PdfPCell celledpf; 
	PdfPCell cellepap;
	PdfPCell cellperito;
	
	//inicio do acesso da tabela
	
	if( res.next() ){
		do
		{ 
		//System.out.println("entrou");
		String datares=res.getString("data");
		String pl1=Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("plantonista1"), vectorpla1);
		String pl2=Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("plantonista2"), vectorpla1);
		String ag1=Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("agente1"), vectorpla1);
		String ag2=Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("agente2"), vectorpla1);
		String epf=Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("escrivao"), vectorpla1);
		String dpf=Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("delegado"), vectorpla1);
		String pap=Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("papiloscopista"), vectorpla1);
		String per=Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("perito"), vectorpla1);
		
		if(pl1.equals("&nbsp;")){
			pl1="";
		}
		if(pl2.equals("&nbsp;")){
			pl2="";
		}
		if(ag1.equals("&nbsp;")){
			ag1="";
		}
		if(ag2.equals("&nbsp;")){
			ag2="";
		}
		if(epf.equals("&nbsp;")){
			epf="";
		}
		if(dpf.equals("&nbsp;")){
			dpf="";
		}
		if(pap.equals("&nbsp;")){
			pap="";
		}
		if(per.equals("&nbsp;")){
			per="";
		}
		
		String auxdia=Util.retornaDiadaSemana(datares);
		if(auxdia.equals("DOM") || auxdia.equals("SAB")){
			celldata = new PdfPCell(new Paragraph(datares.substring(0,2)+" "+auxdia, textonegrito));
			
			celldata.setColspan(1);
			table.addCell(celldata);
			
			cellpl1t = new PdfPCell(new Paragraph(pl1, textonegrito));
			table.addCell(cellpl1t);
			
			cellpl2t = new PdfPCell(new Paragraph(pl2, textonegrito));
			table.addCell(cellpl2t);
			
			cellag1t = new PdfPCell(new Paragraph(ag1, textonegrito));
			table.addCell(cellag1t);
			
			cellag2t = new PdfPCell(new Paragraph(ag2, textonegrito));
			table.addCell(cellag2t);
			
			cellepft = new PdfPCell(new Paragraph(epf, textonegrito));
			table.addCell(cellepft);
			
			celledpf = new PdfPCell(new Paragraph(dpf, textonegrito));
			table.addCell(celledpf);
			
			cellepap = new PdfPCell(new Paragraph(pap, textonegrito));
			table.addCell(cellepap);
			
			cellperito = new PdfPCell(new Paragraph(per, textonegrito));
			cellperito.setColspan(9);
			table.addCell(cellperito);
		}else{
			celldata = new PdfPCell(new Paragraph(datares.substring(0,2)+" "+auxdia, texto));
			
			celldata.setColspan(1);
			table.addCell(celldata);
			
			cellpl1t = new PdfPCell(new Paragraph(pl1, texto));
			table.addCell(cellpl1t);
			
			cellpl2t = new PdfPCell(new Paragraph(pl2, texto));
			table.addCell(cellpl2t);
			
			cellag1t = new PdfPCell(new Paragraph(ag1, texto));
			table.addCell(cellag1t);
			
			cellag2t = new PdfPCell(new Paragraph(ag2, texto));
			table.addCell(cellag2t);
			
			cellepft = new PdfPCell(new Paragraph(epf, texto));
			table.addCell(cellepft);
			
			celledpf = new PdfPCell(new Paragraph(dpf, texto));
			table.addCell(celledpf);
			
			cellepap = new PdfPCell(new Paragraph(pap, texto));
			table.addCell(cellepap);
			
			cellperito = new PdfPCell(new Paragraph(per, texto));
			cellperito.setColspan(9);
			table.addCell(cellperito);
		}
	
		}while(res.next());
}	
	Paragraph p1 = new Paragraph("ATENÇÃO: 1-O servidor que não estiver gozando de folga regulamentar, deverá se apresentar em seu núcleo correspondente, para cumprir horário de trabalho.", texto);
	Paragraph p2 = new Paragraph("2-A escala de plantão tem jornada de 24h de serviço, com 72h de descanso.", texto);
	Paragraph p3 = new Paragraph("3-Os Plantões serão responsáveis pelo N. de Custódia, obedecendo a O.N. 001/02.", texto);
	Paragraph p4 = new Paragraph("4-Os agentes de sobreavisos auxiliarão o N. de custódia nos dias de visita a presos.", texto);
	Paragraph p5 = new Paragraph("5-Os escalados para o sobreaviso que saírem emn viagem, devem indicar o seu substituto.", texto);
	Paragraph p6 = new Paragraph("Obs: Qualquer alteração na escala deverá ocorrer com anuência do Chefe da DPF/LDA/PR.", texto);
	Paragraph p7 = new Paragraph("A Escala de Delegados inicia às 07:30 hs.", texto);
	
	
	
	//ps.setBorderColor(new Color(255, 0, 0));
	//ps.setColspan(9);
	//table.addCell(ps);
	PdfPCell cell3 = new PdfPCell(new Paragraph("cell test2"));
	//cell.setBackgroundColor(new Color(0xC0, 0xC0, 0xC0));
	cell3.setColspan(9);
	//table.addCell(cell3);
	widths[0] = 100f;
	widths[1] = 110f;
	widths[2] = 110f;
	widths[3] = 110f;
	widths[4] = 110f;
	widths[5] = 110f;
	widths[6] = 150f;
	widths[7] = 110f;
	widths[8] = 110f;
	
	table.setWidths(widths);
	table.setWidthPercentage(100); 
	document.add(table);

	document.add(p1);
	document.add(p2);
	document.add(p3);
	document.add(p4);
	document.add(p5);
	document.add(p6);
	document.add(p7);
	document.add(new Paragraph(" "));
	document.add(new Paragraph(" "));
	Paragraph rodape1 = new Paragraph("DPF EVARISTO KUCEKI", rodape);
	rodape1.setAlignment(Element.ALIGN_CENTER);
	Paragraph rodape2 = new Paragraph("Chefe da DPF/LDA/PR", rodape);
	rodape2.setAlignment(Element.ALIGN_CENTER);
	document.add(rodape1);
	document.add(rodape2);
	
document.setPageSize(PageSize.A4);
document.close();
response.setContentType("application/pdf");
response.setContentLength(baos.size());
ServletOutputStream jp = response.getOutputStream();
baos.writeTo(jp);
jp.flush(); %>
</body>
</html>