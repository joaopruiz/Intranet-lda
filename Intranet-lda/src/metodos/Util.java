package metodos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.postgresql.util.PSQLException;

import bean.*;
import conexao.Conexao;

public class Util {
	public static String imprimeTitulo(){
		String a ="DELEGACIA DE POLÍCIA FEDERAL - LONDRINA/PR";
			return a;
	}
	static public boolean VerificaCPF (String strCpf )
	   {
	      int     d1, d2;
	      int     digito1, digito2, resto;
	      int     digitoCPF;
	      String  nDigResult;

	      d1 = d2 = 0;
	      digito1 = digito2 = resto = 0;

	      for (int nCount = 1; nCount < strCpf.length() -1; nCount++)
	      {
	         digitoCPF = Integer.valueOf (strCpf.substring(nCount -1, nCount)).intValue();

	         //multiplique a ultima casa por 2 a seguinte por 3 a seguinte por 4 e assim por diante.
	         d1 = d1 + ( 11 - nCount ) * digitoCPF;

	         //para o segundo digito repita o procedimento incluindo o primeiro digito calculado no passo anterior.
	         d2 = d2 + ( 12 - nCount ) * digitoCPF;
	      };

	      //Primeiro resto da divisão por 11.
	      resto = (d1 % 11);

	      //Se o resultado for 0 ou 1 o digito é 0 caso contrário o digito é 11 menos o resultado anterior.
	      if (resto < 2)
	         digito1 = 0;
	      else
	         digito1 = 11 - resto;

	      d2 += 2 * digito1;

	      //Segundo resto da divisão por 11.
	      resto = (d2 % 11);

	      //Se o resultado for 0 ou 1 o digito é 0 caso contrário o digito é 11 menos o resultado anterior.
	      if (resto < 2)
	         digito2 = 0;
	      else
	         digito2 = 11 - resto;

	      //Digito verificador do CPF que está sendo validado.
	      String nDigVerific = strCpf.substring (strCpf.length()-2, strCpf.length());

	      //Concatenando o primeiro resto com o segundo.
	      nDigResult = String.valueOf(digito1) + String.valueOf(digito2);

	      //comparar o digito verificador do cpf com o primeiro resto + o segundo resto.
	      return nDigVerific.equals(nDigResult);
	   }
	
	static public boolean VerificaCPFBanco(String CPF) throws Exception{
		String sql;
		sql = "Select cpf from tbusuarios where cpf like '"+CPF+"';";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		bd.desconectar();
		if ( res.next() ) {
			return true;
		}else{
			return false;
		}
			
	}
	static public boolean VerificaMatriculaBanco(String CPF) throws Exception{
		String sql;
		sql = "Select matricula from tbusuarios where matricula="+CPF+";";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		bd.desconectar();
		if ( res.next() ) {
			return true;
		}else{
			return false;
		}	
	}
	public static String retornaBomDia(){
		String a ="";
		String data=Util.DataHojePM();
		a=data.substring(11,13);
		//System.out.println(data);
		//System.out.println(a);
		int i = Integer.parseInt(a);
		//System.out.println(i);
		if(i>=1 && i<=5){
			a="Boa Madrugada!";
		}else{
			if(i>=6 && i<=11){
				a="Bom Dia!";
			}else{
				if(i>=12 && i<=18){
					a="Boa Tarde!";
				}else{
					a="Boa Noite!";
				}
			}
		}
		return a;
	}
	public static boolean verificaDataAdmissao(String data){
		//aki começa o código pra impedir a troca de users para os dias do passado
		Boolean flag=false;
		String dataatual=Util.DataHojesemHORA();
		//System.out.println("data atual: "+dataatual);
		//System.out.println("data para o teste: "+data);
		int a=Integer.parseInt(dataatual.substring(0,2));
		int b=Integer.parseInt(dataatual.substring(3,5));
		int c=Integer.parseInt(dataatual.substring(6,10));
		int a1=Integer.parseInt(data.substring(0,2));
		int b1=Integer.parseInt(data.substring(3,5));
		int c1=Integer.parseInt(data.substring(6,10));
		if(c1<c){
			flag=true;
		}else{
			if(c1==c){
				if(b1<b){
					flag=true;
				}else{
					if(b1==b){
						if(a1<a){
							flag=true;
						}
					}
				}
			}
			
		}
		//System.out.println(flag);
		return flag;
		//fim do código pra impedir a mudança na escala do passado		
	}
	public static boolean verificaExpiracao(String data13){
		String data=Util.DataHojesemHORA();
		//System.out.println("Data de hoje: "+data);
		//System.out.println("Data q expira: "+data13);
		int a=Integer.parseInt(data.substring(0,2));
		int b=Integer.parseInt(data.substring(3,5));
		int c=Integer.parseInt(data.substring(6,10));
		int a1=Integer.parseInt(data13.substring(0,2));
		int b1=Integer.parseInt(data13.substring(3,5));
		int c1=Integer.parseInt(data13.substring(6,10));
		Boolean flag=true;
		if(c1<c){
			flag=false;		
		}else{
			if(b1<b){
				flag=false;
			}else{
				if(b1==b){
					if(a1<a){
						flag=false;
					}
				}
				
			}
		}
		//System.out.println(flag);
		return flag;
	}
	public static int retornaUltimoDiaMes(String data){
		//String data = "16/02/2009";
	 Calendar cal = Calendar.getInstance();     
	  int dia = Integer.parseInt(data.substring(0,2));  
	  int mes = Integer.parseInt(data.substring(3,5)); 
	  int ano = Integer.parseInt(data.substring(6,10)); 
	//  System.out.println(dia+" / "+mes+" / "+ano);          
	  cal.set (ano, mes - 1, dia); // note que você precisa subtrair 1 do mês !!!!  
	
	  int j = cal.getActualMaximum(Calendar.DAY_OF_MONTH); 
		return j;
	}
	public static String retornaDiadaSemana(String data){
		String diasemana="";
		 Calendar cal = Calendar.getInstance();     
		  int dia = Integer.parseInt(data.substring(0,2));  
		  int mes = Integer.parseInt(data.substring(3,5)); 
		  int ano = Integer.parseInt(data.substring(6,10)); 
		//  System.out.println(dia+" / "+mes+" / "+ano);          
		  cal.set (ano, mes - 1, dia); // note que você precisa subtrair 1 do mês !!!!  
		  int i = cal.get(Calendar.DAY_OF_WEEK); 
	
		  switch(i){
			
	      case 1:
	    	  diasemana="DOM";
	        break;
	      case 2:
	    	  diasemana="SEG";
	        break;
	      case 3:
	    	  diasemana="TER";
	        break;
	      case 4:
	    	  diasemana="QUA";
	        break;
	      case 5:
	    	  diasemana="QUI";
	        break;
	      case 6:
	    	  diasemana="SEX";
	        break;
	      case 7:
	    	  diasemana="SAB";
	        break;
		  }
		return diasemana;
	}
	public static String retornaMes(int diadomes){
		
		String mes="";
		switch(diadomes){
		
	      case 1:
	         mes="JANEIRO";
	        break;
	      case 2:
	          mes="FEVEREIRO";
	         break;
	      case 3:
	          mes="MARÇO";
	         break;
	      case 4:
	          mes="ABRIL";
	         break;
	      case 5:
	          mes="MAIO";
	         break;
	      case 6:
	          mes="JUNHO";
	         break;
	      case 7:
	          mes="JULHO";
	         break;
	      case 8:
	          mes="AGOSTO";
	         break;
	      case 9:
	          mes="SETEMBRO";
	         break;
	      case 10:
	          mes="OUTUBRO";
	         break;
	      case 11:
	          mes="NOVEMBRO";
	         break;
	      case 12:
	          mes="DEZEMBRO";
	         break;
		}
		return mes;
	}
	public static String imprimeNotícia(int id) throws Exception
	{
		String sql;
		String resHTML = "";
		String titulo="";
		String descricao="";
		
		sql = "select *  from tbnoticias where id="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
			do{
				titulo =  res.getString("titulo");
				descricao = res.getString("descricao");
				
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += "		<center><h1>"+ titulo +"</h1></center>";
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += 		"<P ALIGN='JUSTIFY'>"+descricao+"</p>" ;
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += 		"&nbsp;";
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += 		"<center>Notícia postada em: "+ res.getString("data")+"</center>";
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += 		"<center>Notícia postada por: "+ Util.retornaNome(res.getInt("usuario"))+"</center>";
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += 		"<center><a href='javascript:retornar();'>Voltar...</a></center>";
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "</table>";
				resHTML += "</div>"; 
			}
			while( res.next() );
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há notícias...</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String retornaMenu(int id) throws Exception
	{
		String sql;
		String resHTML = "";
		
		sql = "select *  from menu where id="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			resHTML=res.getString("conteudo");
		}
		return resHTML;
	}
	public static String retornaLayout(String descricao) throws Exception
	{
		String sql;
		String resHTML = "";
		sql = "select *  from tblayout where descricao='"+descricao+"';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			resHTML=res.getString("conteudo");
		}
		return resHTML;
	}
	public static ArrayList<BeanConteudo> retornaConteudoArrayList() throws Exception
	{
		String sql;
		sql = "select *  from tbconteudo order by id;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		ArrayList<BeanConteudo> lotacoes = new ArrayList<BeanConteudo>();
		while(res.next()){
			BeanConteudo conteudo = new BeanConteudo();
			conteudo.setId(res.getInt("id"));
			conteudo.setDescricao(res.getString("descricao"));
			conteudo.setConteudo(res.getString("conteudo"));
			lotacoes.add(conteudo);
		}
		return lotacoes;
	}
	public static BeanConteudo retornaConteudoid(int id) throws Exception
	{
		String sql;
		BeanConteudo conteudo = new BeanConteudo();
		sql = "select *  from tbconteudo where id="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		while(res.next()){
			conteudo.setId(res.getInt("id"));
			conteudo.setDescricao(res.getString("descricao"));
			conteudo.setConteudo(res.getString("conteudo"));
		}
		return conteudo;
	}
	public static ArrayList<BeanLayout> retornaLayoutArrayList() throws Exception
	{
		String sql;
		sql = "select upper(descricao), id, conteudo   from tblayout order by id;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		ArrayList<BeanLayout> layouts = new ArrayList<BeanLayout>();
		while(res.next()){
			BeanLayout layout = new BeanLayout();
			layout.setId(res.getInt("id"));
			layout.setDescricao(res.getString("upper"));
			layout.setConteudo(res.getString("conteudo"));
			layouts.add(layout);
		}
		return layouts;
	}
	public static String imprimePostos() throws Exception
	{
		String sql;
		String resHTML = "";
		sql = "select *  from tbpostos;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
			do{
				resHTML += "<TR>";
				resHTML += "	<TD><B>";
				resHTML += res.getString("nome");
				resHTML += "	</B></TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD><B>";
				resHTML += "Endereço: </B>"+res.getString("endereco");
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD><B>";
				resHTML += "Bairro: </B>"+res.getString("bairro");
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD><B>";
				resHTML += "Cidade: </B>"+res.getString("cidade");
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD><B>";
				resHTML += "Estado: </B>"+res.getString("estado");
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD><B>";
				resHTML += "Telefone: </B>"+res.getString("tel");
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD><B>";
				resHTML += "Especialidade: </B>"+res.getString("esp");
				resHTML += "	</TD>";
				resHTML += "</TR>";
				
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += "&nbsp;&nbsp;&nbsp;";
				resHTML += "	</TD>";
				resHTML += "</TR>";
			}
			while( res.next() );
		}else{
		
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há Postos no BD...</b></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String imprimeNotícias() throws Exception
	{
		String sql;
		String resHTML = "";
		String titulo="";
		String descricao="";
		int id = 0;
		
		sql = "select *  from tbnoticias order by id desc limit 2;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);	
		if ( res.next() ) {
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			do{
				if(Util.verificaExpiracao(res.getString("expira"))==true){
					titulo =  res.getString("titulo");
					String note =res.getString("descricao");
					if(note.length()<210){
						descricao=note;
					}else{
						descricao = (res.getString("descricao").substring(0,210));					
					}
					id=res.getInt("id");
					
					resHTML += "<td width='50%' height='50%'>";
					resHTML += "<div>";
					resHTML += "<table class='search'>";
					resHTML += "<TR>";
					resHTML += "	<TD>";
					resHTML += "		<center><a href='noticias.jsp?note="+id+"'><h1>"+ titulo +"</h1></a></center>";
					resHTML += "	</TD>";
					resHTML += "</TR>";
					resHTML += "<TR>";
					resHTML += "	<TD>";
					resHTML += 		"<center>"+descricao+"...</center>" ;
					resHTML += "	</TD>";
					resHTML += "</TR>";
					resHTML += "</table>";
					resHTML += "</div>"; 
					resHTML += "<div>";
					resHTML += "<table class='search'>";
					resHTML += "<TR>";
					resHTML += "	<TD>";
					resHTML += "		&nbsp;";
					resHTML += "	</TR>";
					resHTML += "</TD>";
					resHTML += "</table>";
					resHTML += "</div>"; 
					resHTML += "<div>";
					resHTML += "<table class='search'>";
					resHTML += "<TR>";
					resHTML += "	<TD>";
					resHTML += "		&nbsp;";
					resHTML += "	</TR>";
					resHTML += "</TD>";
					resHTML += "</table>";
					resHTML += "</div>"; 
					resHTML += "</td>";
				}
			}
			while( res.next() );
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há notícias...</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
		public static String imprimeNotíciasPaginaIndex() throws Exception
		{
			String sql;
			String resHTML = "";
			String titulo="";
			String descricao="";
			String id = "";
			
			sql = "select *  from tbnoticias order by id desc;";
			Conexao bd = new Conexao();
			bd.conectarAccess();
			bd.prepareStmt();
			ResultSet res = bd.executeQuery(sql);
			//modificando para arraylist
			ArrayList<BeanNoticia> noticias = new ArrayList<BeanNoticia>();
			while(res.next()){
				BeanNoticia noticia = new BeanNoticia();
				/*private int nome=0;
				private String titulo="";
				private String descricao="";
				private String data="";
				private String id="";*/
				
				noticia.setNome(res.getInt("usuario"));
				noticia.setTitulo(res.getString("titulo"));
				noticia.setDescricao(res.getString("descricao"));
				noticia.setData(res.getString("data"));
				noticia.setId(Integer.toString(res.getInt("id")));
				noticia.setExpira(res.getString("expira"));
				noticias.add(noticia);
			}
			ArrayList<BeanNoticia> noticias2 = new ArrayList<BeanNoticia>();
			for(int i=0;i<noticias.size();i++){
				BeanNoticia n1 = (BeanNoticia)noticias.get(i);
				if(Util.verificaExpiracao(n1.getExpira())==true){
					noticias2.add(n1);
				}
			}
			int aux=0;
			for(int i=0;i<2;i++){
				//System.out.println("i: "+i);
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<TR>";
				for(int j=i;j<(i+2);j++){
					BeanNoticia b1 = (BeanNoticia)noticias2.get(aux);
					//System.out.println("j: "+j);
						titulo =  b1.getTitulo();
						String note = b1.getDescricao();
						if(note.length()<210){
							descricao=note;
						}else{
							descricao = (b1.getDescricao().substring(0,210));					
						}
						id=b1.getId();
						
						resHTML += "<td width='50%' height='50%'>";
						resHTML += "<div>";
						resHTML += "<table class='search'>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += "		<center><a href='noticias.jsp?note="+id+"'><h1>"+ titulo +"</h1></a></center>";
						resHTML += "	</TD>";
						resHTML += "</TR>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += 		"<center>"+descricao+"...</center>" ;
						resHTML += "	</TD>";
						resHTML += "</TR>";
						resHTML += "</table>";
						resHTML += "</div>"; 
						resHTML += "<div>";
						resHTML += "<table class='search'>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += "		&nbsp;";
						resHTML += "	</TR>";
						resHTML += "</TD>";
						resHTML += "</table>";
						resHTML += "</div>"; 
						resHTML += "<div>";
						resHTML += "<table class='search'>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += "		&nbsp;";
						resHTML += "	</TR>";
						resHTML += "</TD>";
						resHTML += "</table>";
						resHTML += "</div>"; 
						resHTML += "</td>";
						aux++;
				}
				resHTML += "</TR>";
				resHTML += "</table>";
				resHTML += "</div>";
				
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += "		&nbsp;";
				resHTML += "	</TR>";
				resHTML += "</TD>";
				resHTML += "</table>";
				resHTML += "</div>";
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += "		&nbsp;";
				resHTML += "	</TR>";
				resHTML += "</TD>";
				resHTML += "</table>";
				resHTML += "</div>"; 
				
			aux++;
			}
			for(int i=5;i<noticias2.size();i++){
				BeanNoticia b1 = (BeanNoticia)noticias2.get(i);
				titulo =  b1.getTitulo();
				String note = b1.getDescricao();
				if(note.length()<210){
					descricao=note;
				}else{
					descricao = (b1.getDescricao().substring(0,210));					
				}
				id=b1.getId();
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += "		<center><a href='noticias.jsp?note="+id+"'><h1>"+ titulo +"</h1></a></center>";
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += 		"<center>"+descricao+"...</center>" ;
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += 		"<td>&nbsp;</td>";
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "</table>";
				resHTML += "</div>"; 
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += "		&nbsp;";
				resHTML += "	</TR>";
				resHTML += "</TD>";
				resHTML += "</table>";
				resHTML += "</div>"; 
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += "		&nbsp;";
				resHTML += "	</TR>";
				resHTML += "</TD>";
				resHTML += "</table>";
				resHTML += "</div>"; 
			}
			return resHTML;
		}

	public static String imprimeNotícias2() throws Exception
	{
		String sql;
		String resHTML = "";
		String titulo="";
		String descricao="";
		int id = 0;
		
		sql = "select *  from tbnoticias order by id desc limit 4;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		int n =0;
		if ( res.next() ) {
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			do{
				if(Util.verificaExpiracao(res.getString("expira"))==true){
					if(n>=2){
						titulo =  res.getString("titulo");
						String note =res.getString("descricao");
						if(note.length()<210){
							descricao=note;
						}else{
							descricao = (res.getString("descricao").substring(0,210));					
						}
						id=res.getInt("id");
						
						resHTML += "<td width='50%'>";
						resHTML += "<div>";
						resHTML += "<table class='search'>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += "		<center><a href='noticias.jsp?note="+id+"'><h1>"+ titulo +"</h1></a></center>";
						resHTML += "	</TD>";
						resHTML += "</TR>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += 		"<center>"+descricao+"...</center>" ;
						resHTML += "	</TD>";
						resHTML += "</TR>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += 		"<td>&nbsp;</td>";
						resHTML += "	</TD>";
						resHTML += "</TR>";
						resHTML += "</table>";
						resHTML += "</div>"; 
						resHTML += "<div>";
						resHTML += "<table class='search'>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += "		&nbsp;";
						resHTML += "	</TR>";
						resHTML += "</TD>";
						resHTML += "</table>";
						resHTML += "</div>"; 
						resHTML += "<div>";
						resHTML += "<table class='search'>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += "		&nbsp;";
						resHTML += "	</TR>";
						resHTML += "</TD>";
						resHTML += "</table>";
						resHTML += "</div>"; 
						resHTML += "</td>";
					}
				}
				
				n++;
			}
			while( res.next() );
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há notícias...</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String imprimeNotícias3() throws Exception
	{
		String sql;
		String resHTML = "";
		String titulo="";
		String descricao="";
		int id = 0;
		
		sql = "select *  from tbnoticias order by id desc limit 10;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		int n =0;
		if ( res.next() ) {
			//resHTML += "<div>";
			//resHTML += "<table class='search'>";
			//resHTML += "<TR>";
			do{
				if(Util.verificaExpiracao(res.getString("expira"))==true){
					if(n>=4){
						titulo =  res.getString("titulo");
						String note =res.getString("descricao");
						if(note.length()<210){
							descricao=note;
						}else{
							descricao = (res.getString("descricao").substring(0,210));					
						}
						id=res.getInt("id");
						
						//resHTML += "<td>";
						resHTML += "<div>";
						resHTML += "<table class='search'>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += "		<center><a href='noticias.jsp?note="+id+"'><h1>"+ titulo +"</h1></a></center>";
						resHTML += "	</TD>";
						resHTML += "</TR>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += 		"<center>"+descricao+"...</center>" ;
						resHTML += "	</TD>";
						resHTML += "</TR>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += 		"<td>&nbsp;</td>";
						resHTML += "	</TD>";
						resHTML += "</TR>";
						resHTML += "</table>";
						resHTML += "</div>"; 
						resHTML += "<div>";
						resHTML += "<table class='search'>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += "		&nbsp;";
						resHTML += "	</TR>";
						resHTML += "</TD>";
						resHTML += "</table>";
						resHTML += "</div>"; 
						resHTML += "<div>";
						resHTML += "<table class='search'>";
						resHTML += "<TR>";
						resHTML += "	<TD>";
						resHTML += "		&nbsp;";
						resHTML += "	</TR>";
						resHTML += "</TD>";
						resHTML += "</table>";
						resHTML += "</div>"; 
						//resHTML += "</td>";
					}
				}
				
			
				
				n++;
			}
			while( res.next() );
			//resHTML += "</TR>";
			//resHTML += "</table>";
			//resHTML += "</div>"; 
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há notícias...</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String imprimeNotíciasView() throws Exception
	{
		String sql;
		String resHTML = "";
		String titulo="";
		String descricao="";
		int id = 0;
		
		sql = "select *  from tbnoticias order by id desc;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			//resHTML += "<div>";
			//resHTML += "<table class='search'>";
			//resHTML += "<TR>";
			do{
				//if(Util.verificaExpiracao(res.getString("expira"))==true){
					titulo =  res.getString("titulo");
					String note =res.getString("descricao");
					if(note.length()<210){
						descricao=note;
					}else{
						descricao = (res.getString("descricao").substring(0,210));					
					}
					id=res.getInt("id");
					
					//resHTML += "<td>";
					resHTML += "<div>";
					resHTML += "<table class='search'>";
					resHTML += "<TR>";
					resHTML += "	<TD width='20%' height='20%'>";
					resHTML += 		res.getString("data") ;
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "		<center><h1><a href='noticias.jsp?note="+id+"'>"+ titulo +"</a></h1></center>" ;
					resHTML += "	</TD>";
					resHTML += "</TR>";
					resHTML += "</table>";
					resHTML += "</div>"; 
					resHTML += "<div>";
					resHTML += "<table class='search'>";
					resHTML += "<TR>";
					resHTML += "	<TD>";
					resHTML += "		&nbsp;";
					resHTML += "	</TR>";
					resHTML += "</TD>";
					resHTML += "</table>";
					resHTML += "</div>"; 
					resHTML += "<div>";
					resHTML += "<table class='search'>";
					resHTML += "<TR>";
					resHTML += "	<TD>";
					resHTML += "		&nbsp;";
					resHTML += "	</TR>";
					resHTML += "</TD>";
					resHTML += "</table>";
					resHTML += "</div>"; 
					//resHTML += "</td>";
				//}
				
			}
			while( res.next() );
			//resHTML += "</TR>";
			//resHTML += "</table>";
			//resHTML += "</div>"; 
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há notícias...</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	
	public static String imprimeLeitura(int no) throws Exception
	{
		String sql;
		String resHTML = "";
		String titulo="";
		String descricao="";
		int id = 0;
		
		//sql = "select *  from tbnoticias where id!="+no+" order by id desc limit 5;";
		sql = "select *  from tbnoticias where id!="+no+" order by id desc;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
			do{
				titulo =  res.getString("titulo");
				String note =res.getString("descricao");
				if(note.length()<210){
					descricao=note;
				}else{
					descricao = (res.getString("descricao").substring(0,210));					
				}
				id=res.getInt("id");
				
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<TR>";
				resHTML += "	<TD width='20%' height='0%'>";
				resHTML += 		res.getString("data") ;
				resHTML += "	</TD>";
				resHTML += "	<TD>";
				resHTML += "		<center><h1><a href='noticias.jsp?note="+id+"'>"+ titulo +"</a></h1></center>" ;
				resHTML += "	</TD>";
				resHTML += "</TR>";
				resHTML += "</table>";
				resHTML += "</div>"; 
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += "		&nbsp;";
				resHTML += "	</TR>";
				resHTML += "</TD>";
				resHTML += "</table>";
				resHTML += "</div>"; 
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<TR>";
				resHTML += "	<TD>";
				resHTML += "		&nbsp;";
				resHTML += "	</TR>";
				resHTML += "</TD>";
				resHTML += "</table>";
				resHTML += "</div>"; 
			}
			while( res.next() );
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há notícias...</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String imprimeEscala(String data) throws Exception
	{
		String[][] vectorpla1 = Util.comboboxUSUARIOSArrayListUPPER();
		
		String sql;
		String resHTML = "";
		//System.out.println(subdata);
		String subdata=data.substring(3,5);
		sql = "SELECT * from tbescala where SUBSTRING (data FROM 4 FOR 2)='"+subdata+"' order by data;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		
		if ( res.next() ) {
			resHTML += "<div>";
			resHTML += "<table border='1' bordercolor='black'  cellspacing='0' align='center'>";
			resHTML += "<TR>";
			resHTML += "<TD>";
			resHTML += "<b>DATA</b>";
			resHTML += "</TD>";
			resHTML += "<TD>";
			resHTML += "<b>PLA 1</b>";
			resHTML += "</TD>";
			resHTML += "<TD>";
			resHTML += "<b>PLA 2</b>";
			resHTML += "</TD>";
			resHTML += "<TD>";
			resHTML += "<b>APF 1</b>";
			resHTML += "</TD>";
			resHTML += "<TD>";
			resHTML += "<b>APF 2</b>";
			resHTML += "</TD>";
			resHTML += "<TD>";
			resHTML += "<b>EPF</b>";
			resHTML += "</TD>";
			resHTML += "<TD>";
			resHTML += "<b>DPF</b>";
			resHTML += "</TD>";
			resHTML += "<TD>";
			resHTML += "<b>PPF<b/>";
			resHTML += "</TD>";
			resHTML += "<TD>";
			resHTML += "<b>PCF</b>";
			resHTML += "</TD>";
			resHTML += "</TR>";
			do{
			String data13=res.getString("data");
			String auxdia=Util.retornaDiadaSemana(data13);
			if(auxdia.equals("DOM") || auxdia.equals("SAB")){
				resHTML += "<TR>";
				resHTML += "<TD>";
				resHTML += "<b>"+(data13).substring(0,2)+" "+auxdia;
				resHTML += "</b></TD>";
				resHTML += "<TD><b>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("plantonista1"), vectorpla1);
				resHTML += "</b></TD>";
				resHTML += "<TD><b>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("plantonista2"), vectorpla1);
				resHTML += "</b></TD>";
				resHTML += "<TD><b>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("agente1"), vectorpla1);
				resHTML += "</b></TD>";
				resHTML += "<TD><b>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("agente2"), vectorpla1);
				resHTML += "</b></TD>";
				resHTML += "<TD><b>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("escrivao"), vectorpla1);
				resHTML += "</b></TD>";
				resHTML += "<TD><b>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("delegado"), vectorpla1);
				resHTML += "</b></TD>";
				resHTML += "<TD><b>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("papiloscopista"), vectorpla1);
				resHTML += "</b></TD>";
				resHTML += "<TD><b>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("perito"), vectorpla1);
				resHTML += "</b></TD>";
				resHTML += "</TR>";
				
				//resHTML +="<tr>";
				//resHTML +="<td>";
				//resHTML +="&nbsp;&nbsp;&nbsp;";
				//resHTML +="</td>";
				//resHTML +="</tr>";
			}else{
				resHTML += "<TR>";
				resHTML += "<TD>";
				resHTML += ""+(data13).substring(0,2)+" "+auxdia;
				resHTML += "</TD>";
				resHTML += "<TD>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("plantonista1"), vectorpla1);
				resHTML += "</TD>";
				resHTML += "<TD>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("plantonista2"), vectorpla1);
				resHTML += "</TD>";
				resHTML += "<TD>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("agente1"), vectorpla1);
				resHTML += "</TD>";
				resHTML += "<TD>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("agente2"), vectorpla1);
				resHTML += "</TD>";
				resHTML += "<TD>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("escrivao"), vectorpla1);
				resHTML += "</TD>";
				resHTML += "<TD>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("delegado"), vectorpla1);
				resHTML += "</TD>";
				resHTML += "<TD>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("papiloscopista"), vectorpla1);
				resHTML += "</TD>";
				resHTML += "<TD>";
				resHTML += Util.comboboxUSUARIOSidVectorMostraNome(res.getInt("perito"), vectorpla1);
				resHTML += "</TD>";
				resHTML += "</TR>";
				
				//resHTML +="<tr>";
				//resHTML +="<td>";
				//resHTML +="&nbsp;&nbsp;&nbsp;";
				//resHTML +="</td>";
				//resHTML +="</tr>";
			}
			}
			
			while( res.next() );
			resHTML += "</table>";
			resHTML += "</div>"; 
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há escalas gravadas...</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		//System.out.println(resHTML);
		return resHTML;
	}
	public static String imprimeEscalaPagina(String data, String nome) throws Exception
	{
		String sql;
		String resHTML = "";
		int id = Util.retornaID(nome);
		String subdata=data.substring(3,5);
		
		sql = "SELECT * from tbescala where   (plantonista1 = "+id+" or plantonista2 = "+id+" or agente1 = "+id+" or agente2 =  "+id+" or escrivao = "+id+" or delegado = "+id+" or papiloscopista = "+id+" or perito = "+id+") and  SUBSTRING (data FROM 4 FOR 2)='"+subdata+"' order by data;";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		
		if ( res.next() ) {
			
			do{
			resHTML += "<tr>";
			resHTML += "<td>";
			resHTML += res.getString("data").substring(0,2)+" - <b>"+Util.retornaDiadaSemana(res.getString("data")+"</b>");
			resHTML += "</td>";
			resHTML += "</tr>";
			
			}while( res.next() );
			
		}else{
			//resHTML += "<div>";
			//resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Voçê não está de serviço este mês...</b></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			//resHTML += "</table>";
			//resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static void Verificadiaescala(String data) throws Exception{
		//mudança do codigo, mudança da interface
		
		String sql;
		Conexao bd = new Conexao();
		String auxiliar=data;
		//String aux2 = auxiliar.substring(2,10);
		
		int udia = Util.retornaUltimoDiaMes(auxiliar);
		for(int i=1;i<=udia;i++){
			//System.out.println(data);
			//System.out.println("contagem= "+i);
			String data1 = "";
			if(i>=1 && i<=9){
				data1 ="0"+i+data.substring(2,10);
			}else{
				data1 =i+data.substring(2,10);
			}
			sql = "SELECT * from tbescala where data like '"+data1+"';";
			//System.out.println(sql+"select verificador");
			bd.conectarAccess();
			bd.prepareStmt();
			ResultSet res = bd.executeQuery(sql);
			if (res.next()){
				//System.out.println("resultset cheio");
			}else{
				//System.out.println("resultset vazio");
				try {
					sql="insert into tbescala (data) values ('"+data1+"');";
					//System.out.println(sql+" select de inserção");
					bd.executeUpdate(sql);
					bd.desconectar();
				} catch (Exception e) {
					bd.desconectar();
				
				}
			}
		}
	}
	public static String imprimeEscalaAltera(String data) throws Exception
	{
		String[][] vectorpla1 = Util.comboboxUSUARIOSArrayList();
		String[][] vectorapf1 = Util.comboboxAGENTESArrayList();
		String[][] vectoraepf1 = Util.comboboxESCRIVAESArrayList();
		String[][] vectorppf1 = Util.comboboxPAPILOSCOPISTASArrayList();
		String[][] vectordpf1 = Util.comboboxDELEGADOSArrayList();
		String[][] vectorapcf1 = Util.comboboxPERITOSArrayList();
		
		
		String sql;
		String resHTML = "";
		String subdata=data.substring(3,10);
		sql = "SELECT * from tbescala where SUBSTRING (data FROM 4 FOR 7) like '"+subdata+"' order by data;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ) {
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "<b>DIA&nbsp;</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>PLA1</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>PLA2</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>APF1</b></b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>APF2</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>EPF</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>PPF</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>DPF</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>PCF</b>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "<form name='formulario_escala' method='POST' action='gravacaoescala.jsp'>";
			int aux=0;
			do{
				aux++;
				resHTML += "<TR>";
				String data13=res.getString("data");
				String auxdia=Util.retornaDiadaSemana(data13);
				if(auxdia.equals("DOM") || auxdia.equals("SAB")){
					resHTML += "	<TD>";
					resHTML += "<input type='hidden' name='data_"+aux+"' value='"+data13+"'><input type='hidden' name='theDate' value='"+data13+"'><b>"+(data13).substring(0,2)+" "+auxdia+"</b>";
					resHTML += "	</TD>";
				}else{
					resHTML += "	<TD>";
					resHTML += "<input type='hidden' name='data_"+aux+"' value='"+data13+"'><input type='hidden' name='theDate' value='"+data13+"'>"+(data13).substring(0,2)+" "+auxdia;
					resHTML += "	</TD>";
				}
	
			/*aki começa o código pra impedir a troca de users para os dias do passado
				data=Util.DataHojesemHORA();
				int a=Integer.parseInt(data.substring(0,2));
				int b=Integer.parseInt(data.substring(3,5));
				int c=Integer.parseInt(data.substring(6,10));
				int a1=Integer.parseInt(data13.substring(0,2));
				int b1=Integer.parseInt(data13.substring(3,5));
				int c1=Integer.parseInt(data13.substring(6,10));
				Boolean flag=true;
				if(c1<c){
					flag=false;		
				}else{
					if(b1<b){
						flag=false;
					}else{
						if(b1==b){
							if(a1<a){
								flag=false;
							}							
						}
					}
				}*/
				//fim do código pra impedir a mudança na escala do passado
					resHTML += "	<TD>";
					resHTML += "<select  name='plantonista1_"+aux+"'>"+Util.comboboxUSUARIOSidVector((res.getInt("plantonista1")), vectorpla1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='plantonista2_"+aux+"'>"+Util.comboboxUSUARIOSidVector((res.getInt("plantonista2")), vectorpla1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='agente1_"+aux+"'>"+Util.comboboxUSUARIOSidVector((res.getInt("agente1")), vectorapf1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='agente2_"+aux+"'>"+Util.comboboxUSUARIOSidVector((res.getInt("agente2")), vectorapf1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='escrivao_"+aux+"'>"+Util.comboboxUSUARIOSidVector((res.getInt("escrivao")), vectoraepf1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='papiloscopista_"+aux+"'>"+Util.comboboxUSUARIOSidVector((res.getInt("papiloscopista")), vectorppf1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='delegado_"+aux+"'>"+Util.comboboxUSUARIOSidVector((res.getInt("delegado")), vectordpf1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='perito_"+aux+"'>"+Util.comboboxUSUARIOSidVector((res.getInt("perito")), vectorapcf1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "</TR>";
			}
			while( res.next() );
			
			resHTML +="<tr>";
			resHTML +="<td>";
			resHTML +="&nbsp;&nbsp;&nbsp;";
			resHTML +="</td>";
			resHTML +="</tr>";
			resHTML +="<tr>";
			resHTML +="<td>";
			resHTML +="</td>";
			resHTML +="<td>";
			resHTML +="</td>";
			resHTML +="<td>";
			resHTML +="</td>";
			resHTML +="<td>";
			resHTML +="</td>";
			resHTML +="<td>";
			resHTML +="<center><b><input type='submit' value='SALVAR' name='salvar'></b></center>";
			resHTML +="</td>";
			resHTML +="</tr>";
			resHTML += "</form>";
			resHTML += "</table>";
			resHTML += "</div>";
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há escalas gravadas...</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String imprimeEscalaAltera2(String data) throws Exception
	{
		String[][] vectorpla1 = Util.comboboxUSUARIOSArrayList();
		String[][] vectorapf1 = Util.comboboxAGENTESArrayList();
		String[][] vectoraepf1 = Util.comboboxESCRIVAESArrayList();
		String[][] vectorppf1 = Util.comboboxPAPILOSCOPISTASArrayList();
		String[][] vectordpf1 = Util.comboboxDELEGADOSArrayList();
		String[][] vectorapcf1 = Util.comboboxPERITOSArrayList();
		
		
		String sql;
		String resHTML = "";
		String subdata=data.substring(3,10);
		sql = "SELECT * from tbescala where SUBSTRING (data FROM 4 FOR 7) like '"+subdata+"' order by data;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ) {
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "<b>DIA&nbsp;</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>PLA1</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>PLA2</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>APF1</b></b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>APF2</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>EPF</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>PPF</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>DPF</b>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "<b>PCF</b>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "<form name='formulario_escala' method='POST' action='gravacaoescala.jsp'>";
			int aux=0;
			do{
				aux++;
				resHTML += "<TR>";
				String data13=res.getString("data");
				String auxdia=Util.retornaDiadaSemana(data13);
				if(auxdia.equals("DOM") || auxdia.equals("SAB")){
					resHTML += "	<TD>";
					resHTML += "<input type='hidden' name='data' value='"+data13+"'><input type='hidden' name='theDate' value='"+data13+"'><b>"+(data13).substring(0,2)+" "+auxdia+"</b>";
					resHTML += "	</TD>";
				}else{
					resHTML += "	<TD>";
					resHTML += "<input type='hidden' name='data' value='"+data13+"'><input type='hidden' name='theDate' value='"+data13+"'>"+(data13).substring(0,2)+" "+auxdia;
					resHTML += "	</TD>";
				}
	
			/*aki começa o código pra impedir a troca de users para os dias do passado
				data=Util.DataHojesemHORA();
				int a=Integer.parseInt(data.substring(0,2));
				int b=Integer.parseInt(data.substring(3,5));
				int c=Integer.parseInt(data.substring(6,10));
				int a1=Integer.parseInt(data13.substring(0,2));
				int b1=Integer.parseInt(data13.substring(3,5));
				int c1=Integer.parseInt(data13.substring(6,10));
				Boolean flag=true;
				if(c1<c){
					flag=false;		
				}else{
					if(b1<b){
						flag=false;
					}else{
						if(b1==b){
							if(a1<a){
								flag=false;
							}							
						}
					}
				}*/
				//fim do código pra impedir a mudança na escala do passado
					resHTML += "	<TD>";
					resHTML += "<select  name='pla1'>"+Util.comboboxUSUARIOSidVector((res.getInt("plantonista1")), vectorpla1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='pla2'>"+Util.comboboxUSUARIOSidVector((res.getInt("plantonista2")), vectorpla1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='apf1'>"+Util.comboboxUSUARIOSidVector((res.getInt("agente1")), vectorapf1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='apf2'>"+Util.comboboxUSUARIOSidVector((res.getInt("agente2")), vectorapf1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='epf'>"+Util.comboboxUSUARIOSidVector((res.getInt("escrivao")), vectoraepf1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='ppf'>"+Util.comboboxUSUARIOSidVector((res.getInt("papiloscopista")), vectorppf1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='dpf'>"+Util.comboboxUSUARIOSidVector((res.getInt("delegado")), vectordpf1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "	<TD>";
					resHTML += "<select  name='pcf'>"+Util.comboboxUSUARIOSidVector((res.getInt("perito")), vectorapcf1)+"</select>";
					resHTML += "	</TD>";
					resHTML += "</TR>";
			}
			while( res.next() );
			
			resHTML +="<tr>";
			resHTML +="<td>";
			resHTML +="&nbsp;&nbsp;&nbsp;";
			resHTML +="</td>";
			resHTML +="</tr>";
			resHTML +="<tr>";
			resHTML +="<td>";
			resHTML +="</td>";
			resHTML +="<td>";
			resHTML +="</td>";
			resHTML +="<td>";
			resHTML +="</td>";
			resHTML +="<td>";
			resHTML +="</td>";
			resHTML +="<td>";
			resHTML +="<center><b><input type='submit' value='SALVAR' name='salvar'></b></center>";
			resHTML +="</td>";
			resHTML +="</tr>";
			resHTML += "</form>";
			resHTML += "</table>";
			resHTML += "</div>";
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há escalas gravadas...</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String DataHoje() {
		Date data=new Date();
		String a="";
		SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy HH:MM:SS");  
		String dataHojeAsString = formato.format(data);
		a=dataHojeAsString;
		return a;
	}
	public static int AnoAtual() {
		Date data=new Date();
		String a="";
		SimpleDateFormat formato = new SimpleDateFormat("yyyy");  
		String dataHojeAsString = formato.format(data);
		a=dataHojeAsString;
		int i=Integer.parseInt(a);
		return i;
	}
	public static String DataHojePM() {
		Date data=new Date();
		String a="";
		SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy HH:MM:SS");  
		String dataHojeAsString = formato.format(data);
		a=dataHojeAsString;
		return a;
	}
	public static String DataHojesemHORA() {
		Date data=new Date();
		String a="";
		SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");  
		String dataHojeAsString = formato.format(data);
		a=dataHojeAsString;
		return a;
	}
	public static String comboboxCargo() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM cargos ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxClasse() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM classe ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxClassealtera(int id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM classe ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			if(id==0){
				resHTML += "<option selected value='0'></option>";
			}
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				if(id!=0){
					if(aux==id){
						resHTML += "<option selected value='"+aux+"'>"+aux2+"</option>";
					}else{
						resHTML += "<option value='"+aux+"'>"+aux2+"</option>";					
					}
				}else{
					resHTML += "<option value='"+aux+"'>"+aux2+"</option>";
				}
			
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxTipo(String i) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		int id=0;
		if(i!=null){
			id=Integer.parseInt(i);			
		}
		sql = "SELECT * FROM tipoequipinfo ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			if(id==0){
				resHTML += "<option selected value='0'></option>";
			}
			do
			{ 
				aux=res.getInt("cod_tipoequipinfo");
				aux2=res.getString("descricao");
				if(id!=0){
					if(aux==id){
						resHTML += "<option selected value='"+aux+"'>"+aux2+"</option>";
					}else{
						resHTML += "<option value='"+aux+"'>"+aux2+"</option>";					
					}
				}else{
					resHTML += "<option value='"+aux+"'>"+aux2+"</option>";
				}
			
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxTipoSelect() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tipoequipinfo ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
		
			//resHTML += "<option selected value='0'></option>";
			
			do
			{ 
				aux=res.getInt("cod_tipoequipinfo");
				aux2=res.getString("descricao");
				resHTML += "<option value='"+aux+"'>"+aux2+"</option>";					
					
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxStatus(String i) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		int id=0;
		if(i!=null){
			id=Integer.parseInt(i);			
		}
		sql = "SELECT * FROM status ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			if(id==0){
				resHTML += "<option selected value='0'></option>";
			}
			do
			{ 
				aux=res.getInt("cod_status");
				aux2=res.getString("descricao");
				if(id!=0){
					if(aux==id){
						resHTML += "<option selected value='"+aux+"'>"+aux2+"</option>";
					}else{
						resHTML += "<option value='"+aux+"'>"+aux2+"</option>";					
					}
				}else{
					resHTML += "<option value='"+aux+"'>"+aux2+"</option>";
				}
			
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxStatusSelect() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM status ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			
			//resHTML += "<option selected value='0'></option>";
			
			do
			{ 
				aux=res.getInt("cod_status");
				aux2=res.getString("descricao");
				resHTML += "<option value='"+aux+"'>"+aux2+"</option>";						
			
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxDataEspecial() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbdataespecial ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String[][] retornaDATASFP(int nome, String data) throws Exception
	{
	
		String sql;
		String sap[][]=new String[1000][6];
		sql = "SELECT SUBSTRING(DATA, 3,10), he1, hs1, he2, hs2, ocorrencia, frequenciaint FROM TBFOLHAPONTO WHERE SUBSTRING(DATA, 3,10)='"+data+"' and usuario="+nome+"  order by id;";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		int a = 0;
		if ( res.next() ){
			
			do
			{ 
				sap[a][0]=res.getString("he1");
				sap[a][1]=res.getString("hs1");
				sap[a][2]=res.getString("he2");
				sap[a][3]=res.getString("hs2");
				sap[a][4]=res.getString("ocorrencia");					
				sap[a][5]=Boolean.toString(res.getBoolean("frequenciaint"));
				a++;
			}while(res.next());
		}
		bd.desconectar();
		return sap;
	}
	public static String comboboxUSUARIOS() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			resHTML += "<option selected value='0'></option>";
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static ResultSet comboboxUSUARIOSRecordset() throws Exception
	{
		String sql;
		sql = "SELECT * FROM tbusuarios ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		//List<String> listpla1 = new ArrayList<String>();
		bd.desconectar();
		return res;
	}
	public static String[][] comboboxUSUARIOSArrayList() throws Exception
	{
		String sql;
		sql = "SELECT nome, id FROM tbusuarios ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		//List<String> listpla1 = new ArrayList<String>();
		String[][] aaaa = new String[1000][2];
		int i = 0;
		while(res.next()){
			aaaa[i][0] = String.valueOf(res.getInt("id"));
			aaaa[i][1] = res.getString("nome");
			//System.out.println(i);
			//System.out.println(res.getString("nome").toString());
			//System.out.println(aaaa[i][1]);
			i++;
		}
		bd.desconectar();
		return aaaa;
	}
	public static String[][] comboboxUSUARIOSArrayListUPPER() throws Exception
	{
		String sql;
		sql = "SELECT nome, id FROM tbusuarios ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		//List<String> listpla1 = new ArrayList<String>();
		String[][] aaaa = new String[1000][2];
		int i = 0;
		while(res.next()){
			aaaa[i][0] = String.valueOf(res.getInt("id"));
			aaaa[i][1] = res.getString("nome").toUpperCase();
			//System.out.println(i);
			//System.out.println(res.getString("nome").toString());
			//System.out.println(aaaa[i][1]);
			i++;
		}
		bd.desconectar();
		return aaaa;
	}
	public static String[][] cargosArrayList() throws Exception
	{
		String sql;
		sql = "SELECT * FROM cargos ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		String[][] aaaa = new String[100][2];
		int i = 0;
		while(res.next()){
			aaaa[i][0] = String.valueOf(res.getInt("id"));
			aaaa[i][1] = res.getString("descricao");
			i++;
		}
		bd.desconectar();
		return aaaa;
	}
	public static String[][] comboboxLotacoesArrayList() throws Exception
	{
		String sql;
		sql = "SELECT UPPER(descricao), id FROM lotacoes ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		//List<String> listpla1 = new ArrayList<String>();
		String[][] aaaa = new String[1000][2];
		int i = 0;
		while(res.next()){
			aaaa[i][0] = String.valueOf(res.getInt("id"));
			aaaa[i][1] = res.getString("upper").toString();
			i++;
		}
		bd.desconectar();
		return aaaa;
	}
	public static String[][] comboboxAGENTESArrayList() throws Exception
	{
		String sql;
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=2 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		//List<String> listpla1 = new ArrayList<String>();
		String[][] aaaa = new String[1000][2];
		int i = 0;
		while(res.next()){
			aaaa[i][0] = String.valueOf(res.getInt("id"));
			aaaa[i][1] = res.getString("nome").toString();
			//System.out.println(i);
			//System.out.println(res.getString("nome").toString());
			//System.out.println(aaaa[i][1]);
			i++;
		}
		bd.desconectar();
		return aaaa;
	}
	public static String[][] comboboxESCRIVAESArrayList() throws Exception
	{
		String sql;
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=3 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		//List<String> listpla1 = new ArrayList<String>();
		String[][] aaaa = new String[1000][2];
		int i = 0;
		while(res.next()){
			aaaa[i][0] = String.valueOf(res.getInt("id"));
			aaaa[i][1] = res.getString("nome").toString();
			//System.out.println(i);
			//System.out.println(res.getString("nome").toString());
			//System.out.println(aaaa[i][1]);
			i++;
		}
		bd.desconectar();
		return aaaa;
	}
	public static String[][] comboboxPAPILOSCOPISTASArrayList() throws Exception
	{
		String sql;
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=5 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		//List<String> listpla1 = new ArrayList<String>();
		String[][] aaaa = new String[1000][2];
		int i = 0;
		while(res.next()){
			aaaa[i][0] = String.valueOf(res.getInt("id"));
			aaaa[i][1] = res.getString("nome").toString();
			//System.out.println(i);
			//System.out.println(res.getString("nome").toString());
			//System.out.println(aaaa[i][1]);
			i++;
		}
		bd.desconectar();
		return aaaa;
	}
	public static String[][] comboboxDELEGADOSArrayList() throws Exception
	{
		String sql;
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=1 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		//List<String> listpla1 = new ArrayList<String>();
		String[][] aaaa = new String[1000][2];
		int i = 0;
		while(res.next()){
			aaaa[i][0] = String.valueOf(res.getInt("id"));
			aaaa[i][1] = res.getString("nome").toString();
			//System.out.println(i);
			//System.out.println(res.getString("nome").toString());
			//System.out.println(aaaa[i][1]);
			i++;
		}
		bd.desconectar();
		return aaaa;
	}
	public static String[][] comboboxPERITOSArrayList() throws Exception
	{
		String sql;
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=4 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		//List<String> listpla1 = new ArrayList<String>();
		String[][] aaaa = new String[1000][2];
		int i = 0;
		while(res.next()){
			aaaa[i][0] = String.valueOf(res.getInt("id"));
			aaaa[i][1] = res.getString("nome").toString();
			//System.out.println(i);
			//System.out.println(res.getString("nome").toString());
			//System.out.println(aaaa[i][1]);
			i++;
		}
		bd.desconectar();
		return aaaa;
	}
	
	public static String comboboxUSUARIOSLogin() throws Exception
	{
	
		String sql;
		String resHTML = "";
		//int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios where situacao = true ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			resHTML = "<option value=''>Selecione um login</option>";
			do
			{ 
				//aux=res.getInt("id");
				aux2=res.getString("nome");
				resHTML += "<option value="+aux2+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxUSUARIOSid(int id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
		
				resHTML += "<option selected value='0'></option>";
		
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				//System.out.println(id);
				if(id!=0){
					if(aux==id){
						resHTML += "<option selected value='"+aux+"'>"+aux2+"</option>";
					}else{
						resHTML += "<option value='"+aux+"'>"+aux2+"</option>";					
					}
				}else{
					resHTML += "<option value='"+aux+"'>"+aux2+"</option>";
				}
			
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxUSUARIOSidResultSet(int id, ResultSet res) throws Exception
	{
		String resHTML = "";
		int aux=0;
		String aux2="";
		if ( res.next() ){
		
				resHTML += "<option selected value='0'></option>";
		
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				//System.out.println(id);
				if(id!=0){
					if(aux==id){
						resHTML += "<option selected value='"+aux+"'>"+aux2+"</option>";
					}else{
						resHTML += "<option value='"+aux+"'>"+aux2+"</option>";					
					}
				}else{
					resHTML += "<option value='"+aux+"'>"+aux2+"</option>";
				}
			
			}while(res.next());
		}
		System.out.println(resHTML);
		return resHTML;
	}
	public static String comboboxUSUARIOSidVector(int id, String[][] aaaa) throws Exception
	{
		String resHTML = "";
		int aux=0;
		String aux2="";
		if ( aaaa==null ){
				resHTML += "<option selected value='0'></option>";
		}else{ 
			resHTML += "<option value='0'></option>";
			//System.out.println("entrou no for");
				for(int i=0; i<aaaa.length; i++){
					if(aaaa[i][0]!=null){
						aux=Integer.parseInt(aaaa[i][0]);
						if(aaaa[i][1]!=null){
							aux2=(aaaa[i][1]);
							if(id!=0){
								//System.out.println("macumba");
								if(aux==id){
									//System.out.println("tetet"+resHTML);
									resHTML += "<option selected value='"+aux+"'>"+aux2+"</option>";
								}else{
									resHTML += "<option value='"+aux+"'>"+aux2+"</option>";					
								}
							}else{
								resHTML += "<option value='"+aux+"'>"+aux2+"</option>";
							}
						}else{
							aux2="";
						}
					}else{
						aux=0;
					}
					//aux2=aaaa[i][1];
				
					//System.out.println(id);
					
				}
		}
		//System.out.println(resHTML+"to forea");
		return resHTML;
	}
	public static String comboboxUSUARIOSidVectorMostraNome(int id, String[][] aaaa) throws Exception
	{
		String resHTML = "";
		int aux=0;
		String aux2="";
		if ( aaaa==null ){
				
		}else{ 
				for(int i=0; i<aaaa.length; i++){
					if(aaaa[i][0]!=null){
						aux=Integer.parseInt(aaaa[i][0]);
						if(aaaa[i][1]!=null){
							aux2=(aaaa[i][1]);
							if(id!=0){
								//System.out.println("macumba");
								if(aux==id){
									//System.out.println("tetet"+resHTML);
									resHTML += aux2;
								}
							}
						}else{
							aux2="";
						}
					}else{
						aux=0;
					}
					//aux2=aaaa[i][1];
				
					//System.out.println(id);
					
				}
		}
		//System.out.println(resHTML+"to forea");
		return resHTML;
	}
	public static String cargosidVectorMostraNome(int id, String[][] aaaa) throws Exception
	{
		String resHTML = "";
		int aux=0;
		String aux2="";
		if ( aaaa==null ){
				
		}else{ 
				for(int i=0; i<aaaa.length; i++){
					if(aaaa[i][0]!=null){
						aux=Integer.parseInt(aaaa[i][0]);
						if(aaaa[i][1]!=null){
							aux2=(aaaa[i][1]);
							if(id!=0){
								//System.out.println("macumba");
								if(aux==id){
									//System.out.println("tetet"+resHTML);
									resHTML += aux2;
								}
							}
						}else{
							aux2="";
						}
					}else{
						aux=0;
					}
					//aux2=aaaa[i][1];
				
					//System.out.println(id);
					
				}
		}
		//System.out.println(resHTML+"to forea");
		return resHTML;
	}
	public static String VectorMostraNome(int id, String[][] aaaa) throws Exception
	{
		String resHTML = "";
		int aux=0;
		String aux2="";
		if ( aaaa==null ){
				
		}else{ 
				for(int i=0; i<aaaa.length; i++){
					if(aaaa[i][0]!=null){
						aux=Integer.parseInt(aaaa[i][0]);
						if(aaaa[i][1]!=null){
							aux2=(aaaa[i][1]);
							if(id!=0){
								//System.out.println("macumba");
								if(aux==id){
									//System.out.println("tetet"+resHTML);
									resHTML += aux2;
								}
							}
						}else{
							aux2="";
						}
					}else{
						aux=0;
					}
					//aux2=aaaa[i][1];
				
					//System.out.println(id);
					
				}
		}
		//System.out.println(resHTML+"to forea");
		return resHTML;
	}
	public static String comboboxAGENTES() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=2 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			resHTML += "<option selected value='0'></option>";
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxAGENTESid(int id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=2 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
		
				resHTML += "<option selected value='0'></option>";
		
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				//System.out.println(id);
				if(id!=0){
					if(aux==id){
						resHTML += "<option selected value='"+aux+"'>"+aux2+"</option>";
					}else{
						resHTML += "<option value='"+aux+"'>"+aux2+"</option>";					
					}
				}else{
					resHTML += "<option value='"+aux+"'>"+aux2+"</option>";
				}
			
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxESCRIVAO() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=3 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			resHTML += "<option selected value='0'></option>";
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxESCRIVAOid(int id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=3 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			
				resHTML += "<option selected value='0'></option>";
		
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				//System.out.println(id);
				if(id!=0){
					if(aux==id){
						resHTML += "<option selected value='"+aux+"'>"+aux2+"</option>";
					}else{
						resHTML += "<option value='"+aux+"'>"+aux2+"</option>";					
					}
				}else{
					resHTML += "<option value='"+aux+"'>"+aux2+"</option>";
				}
			
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxDELEGADO() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=1 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			resHTML += "<option selected value='0'></option>";
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxDELEGADOid(int id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=1 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
		
				resHTML += "<option selected value='0'></option>";
			
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				//System.out.println(id);
				if(id!=0){
					if(aux==id){
						resHTML += "<option selected value='"+aux+"'>"+aux2+"</option>";
					}else{
						resHTML += "<option value='"+aux+"'>"+aux2+"</option>";					
					}
				}else{
					resHTML += "<option value='"+aux+"'>"+aux2+"</option>";
				}
			
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxPAPILOSCOPISTA() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=5 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			resHTML += "<option selected value='0'></option>";
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxPAPILOSCOPISTAid(int id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=5 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			if(id==0){
				resHTML += "<option selected value='0'></option>";
			}
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				//System.out.println(id);
				if(id!=0){
					if(aux==id){
						resHTML += "<option selected value='"+aux+"'>"+aux2+"</option>";
					}else{
						resHTML += "<option value='"+aux+"'>"+aux2+"</option>";					
					}
				}else{
					resHTML += "<option value='"+aux+"'>"+aux2+"</option>";
				}
			
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxPERITO() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=4 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			resHTML += "<option selected value='0'></option>";
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxPERITOid(int id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios where codigo_tbusuarios=4 ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			
				resHTML += "<option selected value='0'></option>";
			
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				//System.out.println(id);
				if(id!=0){
					if(aux==id){
						resHTML += "<option selected value='"+aux+"'>"+aux2+"</option>";
					}else{
						resHTML += "<option value='"+aux+"'>"+aux2+"</option>";					
					}
				}else{
					resHTML += "<option value='"+aux+"'>"+aux2+"</option>";
				}
			
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxAtendentes() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tbusuarios where codigo_funcao=3 or codigo_funcao=2 or codigo_funcao=9  ORDER BY nome;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("nome");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxTipoOS() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM tipoordem ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxStatusOS() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM statusordem ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxStatusOSAbertura() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM statusordem where descricao='Aberta';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxFuncao() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM funcao ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				//método novo de selecionar o valor padrão do select
				//método antigo é mais lento, pq faz mais conexões com o banco
				//por motivo de tempo não modificarei os métodos antigos...
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				if(aux2.equals("Usuario")){
					resHTML += "<option selected value="+aux+">"+aux2+"</option>";
				}else{
					resHTML += "<option value="+aux+">"+aux2+"</option>";					
				}
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxFuncaoApagar() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM funcao ORDER BY descricao where descricao!='Usuario' or where descricao!='Administrador';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				//método novo de selecionar o valor padrão do select
				//método antigo é mais lento, pq faz mais conexões com o banco
				//por motivo de tempo não modificarei os métodos antigos...
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				if(aux2.equals("Usuario")){
					resHTML += "<option selected value="+aux+">"+aux2+"</option>";
				}else{
					resHTML += "<option value="+aux+">"+aux2+"</option>";					
				}
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String comboboxLotacao() throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM lotacoes ORDER BY descricao;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			//resHTML = "<option value='0'>Selecione uma Lotação</option>";
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String selectCargoAlterarLogin(String id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM cargos where id!="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String selectFuncaoAlterarLogin(String id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM funcao where id!="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String selectLotacaoAlterarLogin(String id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM lotacoes where id!="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String selectCargoAlterarCadastro(String id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM cargos where id="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String selectFuncaoAlterarCadastro(String id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM funcao where id="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String selectLotacaoAlterarCadastro(String id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		int aux=0;
		String aux2="";
		sql = "SELECT * FROM lotacoes where id="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		if ( res.next() ){
			do
			{ 
				aux=res.getInt("id");
				aux2=res.getString("descricao");
				resHTML += "<option value="+aux+">"+aux2+"</option>";
			}while(res.next());
		}
		bd.desconectar();
		return resHTML;
	}
	public static String Cargo(int nome) throws Exception
	{
	
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM cargos WHERE id = " + nome + ";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML += res.getString("descricao");
		}
		bd.desconectar();
		return resHTML;
	}
	public static String Funcao(int nome) throws Exception
	{
	
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM funcao WHERE id = " + nome + ";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML += res.getString("descricao");
		}
		bd.desconectar();
		return resHTML;
	}
	public static int selectCargo(String nome) throws Exception
	{
	
		String sql;
		int resHTML = 0;
		
		sql = "SELECT * FROM tbusuarios WHERE nome = '" + nome + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML += res.getInt("codigo_tbusuarios");
		}
		bd.desconectar();
		return resHTML;
	}
	public static String selectCargoDescricao(int id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM cargos WHERE id = '" + id + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML += res.getString("descricao");
		}
		bd.desconectar();
		return resHTML;
	}
	public static String selectLotacaoDescricao(int id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM lotacoes WHERE id = '" + id + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML += res.getString("descricao");
		}
		bd.desconectar();
		return resHTML;
	}
	public static int selectFuncoes(String nome) throws Exception
	{
	
		String sql;
		int resHTML = 0;
		
		sql = "SELECT * FROM tbusuarios WHERE nome = '" + nome + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML += res.getInt("codigo_funcao");
		}
		bd.desconectar();
		return resHTML;
	}
	public static int selectFuncao(String nome) throws Exception
	{
	
		String sql;
		int resHTML = 0;
		
		sql = "SELECT * FROM tbusuarios WHERE nome = '" + nome + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML += res.getInt("codigo_funcao");
		}
		bd.desconectar();
		return resHTML;
	}
	public static String selectNome(String nome) throws Exception
	{
	
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbusuarios WHERE nome = '" + nome + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML += res.getString("nome");
				
		}
		bd.desconectar();
		return resHTML;
	}
	public static String autenticaPatrimonio(String nome) throws Exception
	{
	
		String sql;
		String resHTML = "";
		
		sql = "SELECT patrimonio FROM equipinfo WHERE patrimonio = '" + nome + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML += res.getString("patrimonio");
				
		}
		bd.desconectar();
		return resHTML;
	}
	public static String autenticaMaterial(String nome) throws Exception
	{
	
		String sql;
		String resHTML = "";
		
		sql = "SELECT cod_matconsumoinfo FROM matconsumoinfo WHERE cod_matconsumoinfo = '" + nome + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML += res.getInt("cod_matconsumoinfo");
				
		}
		bd.desconectar();
		return resHTML;
	}
	public static String retornaNome(int id) throws Exception
	{
	
		String sql;
		String resHTML = "&nbsp;";
		
		sql = "SELECT UPPER(nome) FROM tbusuarios WHERE id = " + id + ";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML = res.getString("upper");
				//System.out.print(resHTML);
		}
		bd.desconectar();
		return resHTML;
	}
	public static String retornaTipo(int id) throws Exception
	{
	
		String sql;
		String resHTML = "&nbsp;";
		
		sql = "SELECT UPPER(descricao) FROM tipoequipinfo WHERE cod_tipoequipinfo = " + id + ";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML = res.getString("upper");
		}
		bd.desconectar();
		return resHTML;
	}
	public static String retornaStatusEquip(int id) throws Exception
	{
	
		String sql;
		String resHTML = "&nbsp;";
		
		sql = "SELECT UPPER(descricao) FROM status WHERE cod_status = " + id + ";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML = res.getString("upper");
		}
		bd.desconectar();
		return resHTML;
	}
	public static int retornaFuncao(String id) throws Exception
	{
	
		String sql;
		int resHTML =0;
		
		sql = "SELECT * FROM funcao WHERE descricao = '" + id + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML = res.getInt("id");
		}
		bd.desconectar();
		return resHTML;
	}
	public static String retornaStatus(int id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM statusordem WHERE id = '" + id + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML += res.getString("descricao");
				
		}
		bd.desconectar();
		return resHTML;
	}
	public static String retornaTipoOS(int id) throws Exception
	{
	
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tipoordem WHERE id = '" + id + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTML += res.getString("descricao");
				
		}
		bd.desconectar();
		return resHTML;
	}
	public static String selectSenha(String nome) throws Exception
	{
		String sql;
		String resHTM = "";
		
		sql = "SELECT * FROM tbusuarios WHERE nome = '" + nome + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
				resHTM += res.getString("senha");
		}
		bd.desconectar();
		return resHTM;
	}
	public static String selectID(int nome) throws Exception
	{
		String sql;
		String resHTM = "";
		
		sql = "SELECT * FROM tbusuarios WHERE id = '" + nome + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		
		if( res.next() ){
			resHTM += res.getInt("id");			
		}
		
		bd.desconectar();
		return resHTM;
	}
	public static int retornaID(String nome) throws Exception
	{
		String sql;
		int resHTM = 0;
		
		sql = "SELECT * FROM tbusuarios WHERE nome = '" + nome + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		
		if( res.next() ){
			resHTM += res.getInt("id");		
			//System.out.println(resHTM);
		}
		
		bd.desconectar();
		return resHTM;
	}
	public static int retornaCod_equipinfo(String nome) throws Exception
	{
		String sql;
		int resHTM = 0;
		
		sql = "SELECT * FROM equipinfo WHERE patrimonio = '" + nome + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		
		if( res.next() ){
			resHTM += res.getInt("cod_equipinfo");		
			//System.out.println(resHTM);
		}
		
		bd.desconectar();
		return resHTM;
	}
	public static ResultSet retornaResultset(String data) throws Exception
	{
		String sql;
		String dto=data.substring(3,10);
		//System.out.println(data);
		sql = "SELECT * from tbescala where SUBSTRING(data, 4,10)='"+dto+"' order by data;";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		
		//if( res.next() ){
			//resHTM += res.getInt("id");		
			//System.out.println(resHTM);
		//}
		
		bd.desconectar();
		return res;
	}
	public static ResultSet retornaDadosUser(String user) throws Exception
	{
		String sql;
		
		sql = "SELECT * from tbusuarios where nome='"+user+"';";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		
		//if( res.next() ){
			//resHTM += res.getInt("id");		
			//System.out.println(resHTM);
		//}
		
		bd.desconectar();
		return res;
	}
	public static ResultSet retornaFolhaponto(int id, String data) throws Exception
	{
		String sql;
		sql = "SELECT SUBSTRING(DATA, 3,10), he1, hs1, he2, hs2, ocorrencia, frequenciaint FROM TBFOLHAPONTO WHERE SUBSTRING(DATA, 3,10)='"+data+"' and usuario="+id+"  order by id;";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		bd.desconectar();
		return res;
	}
	public static String[] selectTudoNoticia(int nome) throws Exception
	{
		String sql;
		String resHTM[] = new String[40];
		
		sql = "SELECT * FROM tbnoticias WHERE id = " + nome + ";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		
		if( res.next() ){
			resHTM[0] = res.getString("titulo");
			resHTM[1] = res.getString("descricao");
			resHTM[2] = res.getString("expira");
 		}
		
		bd.desconectar();
		return resHTM;
	}
	public static String[] selectTudoLogin(int id) throws Exception
	{
		String sql;
		String resHTM[] = new String[40];
		
		sql = "SELECT * FROM tbusuarios WHERE id = '" + id + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		
		if( res.next() ){
			resHTM[0] = res.getString("nome");
			resHTM[1] = res.getString("senha");
			resHTM[2] = Integer.toString(res.getInt("codigo_tbusuarios"));
			resHTM[3] = res.getString("nomecp");
			resHTM[4] = Integer.toString(res.getInt("id"));
			resHTM[5] = Integer.toString(res.getInt("codigo_funcao"));
			resHTM[6] = res.getString("numero_sala");
			resHTM[7] = Integer.toString(res.getInt("lotacao"));
			resHTM[8] = Integer.toString(res.getInt("ramal"));
			resHTM[9] = res.getString("email");
			resHTM[10] = res.getString("telcasa");
			resHTM[11] = res.getString("cel1");
			resHTM[12] = res.getString("cel2");
			resHTM[13] = Integer.toString(res.getInt("matricula"));
			resHTM[14] = Integer.toString(res.getInt("cargahoraria"));
			SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");  
			String dta = formato.format(res.getDate("admissao"));
			resHTM[15] = dta;
			resHTM[16] = Boolean.toString(res.getBoolean("situacao"));
			resHTM[17] = Integer.toString(res.getInt("classe"));
			resHTM[18] = Boolean.toString(res.getBoolean("sexo"));
			resHTM[19] = res.getString("banco");
			resHTM[20] = Integer.toString(res.getInt("agencia"));
			resHTM[21] = Integer.toString(res.getInt("conta"));
			resHTM[22] = res.getString("cpf");
 		}
		
		bd.desconectar();
		return resHTM;
	}
	
	public static String[] selectEquipsaltera(String id) throws Exception
	{
		String sql;
		String resHTM[] = new String[10];
		
		sql = "SELECT * FROM equipinfo WHERE patrimonio = '" + id + "';";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		
		if( res.next() ){
			resHTM[0] = res.getString("patrimonio");
			resHTM[1] = Integer.toString(res.getInt("tipo"));
			resHTM[2] = Integer.toString(res.getInt("status"));
			resHTM[3] = res.getString("serial");
			resHTM[4] = res.getString("observacao");
			resHTM[5] = res.getString("marca");
			resHTM[6] = res.getString("modelo");
			resHTM[7] = res.getString("valor");
			resHTM[8] = Integer.toString(res.getInt("cod_equipinfo"));
			//resHTM[9] = res.getString("email");
			//resHTM[10] = res.getString("telcasa");
			//resHTM[11] = res.getString("cel1");
		
 		}
		
		bd.desconectar();
		return resHTM;
	}
	public static String[] selectEquipsConsumoaltera(String id) throws Exception
	{
		String sql;
		String resHTM[] = new String[10];
		
		sql = "SELECT * FROM matconsumoinfo WHERE cod_matconsumoinfo = '" + id + "';";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);
		
		
		if( res.next() ){
			resHTM[0] = res.getString("descricao");
			resHTM[1] = Integer.toString(res.getInt("quantidade"));
			resHTM[2] = res.getString("valor");
			//resHTM[3] = res.getString("serial");
			//resHTM[4] = res.getString("observacao");
			//resHTM[5] = res.getString("marca");
			//resHTM[6] = res.getString("modelo");
			//resHTM[7] = res.getString("valor");
			//resHTM[8] = Integer.toString(res.getInt("cod_equipinfo"));
			//resHTM[9] = res.getString("email");
			//resHTM[10] = res.getString("telcasa");
			//resHTM[11] = res.getString("cel1");
		
 		}
		
		bd.desconectar();
		return resHTM;
	}
	public static boolean gravaNovoUsuario(Bean bean) throws Exception
	{
		String sql;
		String matricula=bean.getMatricula();
		String telcasa=bean.getTelcasa();
		String cel2=bean.getCel2();
		if(bean.getMatricula().equals("") || bean.getMatricula().equals(null)){
			matricula="0";
		}
		if(bean.getTelcasa().equals("") || bean.getTelcasa().equals(null)){
			telcasa="0";
		}
		if(bean.getCel2().equals("") || bean.getCel2().equals(null)){
			cel2="0";
		}
		sql = "insert into tbusuarios (nome, senha, codigo_tbusuarios, nomecp, codigo_funcao, numero_sala, lotacao, ramal, email, cel1, cel2, telcasa, matricula, cargahoraria, cpf, admissao, situacao, classe, sexo, banco, agencia, conta) values ('"+bean.getNome()+"', '"+bean.getSenha()+"', '"+bean.getCodigo_tbusuarios()+"', '"+bean.getNomecp()+"', '"+bean.getCodigo_funcao()+"', '"+bean.getNumero_sala()+"', '"+bean.getLotacao()+"', '"+bean.getRamal()+"', '"+bean.getEmail()+"', '"+bean.getCel1()+"', '"+cel2+"', '"+telcasa+"'" +
				", '"+matricula+"', '"+bean.getCargahoraria()+"', '"+bean.getCpf()+"', '"+bean.getAdmissao()+"', '"+bean.isSituacao()+"', '"+bean.getClasse()+"', '"+bean.isSexo()+"', '"+bean.getBanco()+"', '"+bean.getAgencia()+"', '"+bean.getConta()+"');";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			
			bd.executeUpdate(sql);
			bd.desconectar();
			System.out.println("true");
			return true;
			
		} catch (PSQLException e) {
			System.out.println("false");
			System.out.println(e);
			bd.desconectar();
			return false;
		}
	}
	public static boolean gravaNovoArquivo(byte a) throws Exception
	{
		String sql;
	
		
		sql = "insert into arquivos (nome) values ('"+a+"');";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception e) {
			bd.desconectar();
			return false;
		}
	}
	
	
	public static boolean autenticaOrdem(int id) throws Exception
	{
		String sql;
		boolean flag=false;
		sql = "select * from tbos  where id="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		
			ResultSet res = bd.executeQuery(sql);
			bd.desconectar();
			if ( res.next() ) {
				String a=res.getString("dtfinalizacao");
				//System.out.println(a);
				if(a.equals("null")){
					flag=true;
					//System.out.println("entrou");
				}else{
					flag=false;
				}
			}
		
		return flag;
	}
	public static boolean autenticaOrdemFinaliza(int id) throws Exception
	{
		String sql;
		boolean flag=false;
		sql = "select * from tbos where id="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		
			ResultSet res = bd.executeQuery(sql);
			bd.desconectar();
			if ( res.next() ) {
				String a=res.getString("dtatribuicao");
				//System.out.println(a);
				if(a.equals("null")){
					flag=true;
					//System.out.println("entrou");
				}else{
					flag=false;
				}
			}
		
		return flag;
	}
	public static boolean verificaData(String id, int nome) throws Exception
	{
		String sql;
		boolean flag=false;
		sql = "select * from tbfolhaponto where data='"+id+"' and usuario="+nome+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		
			ResultSet res = bd.executeQuery(sql);
			bd.desconectar();
			if ( res.next() ) {
				//String a=res.getString("data");
				//System.out.println(a);
				//if(a.equals(" ")){
				flag=false;
					System.out.println("entrou");
			}else{
				flag=true;
				System.out.println("naum sdeu");
			}
			//}
		
		return flag;
	}
	
	public static boolean autenticaOrdemFinalizaVerifica(int id) throws Exception
	{
		String sql;
		boolean flag=false;
		sql = "select * from tbos where id="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		
			ResultSet res = bd.executeQuery(sql);
			bd.desconectar();
			if ( res.next() ) {
				String a=res.getString("dtfinalizacao");
				//System.out.println(a);
				if(a.equals("null")){
					flag=false;
					//System.out.println("entrou");
				}else{
					flag=true;
				}
			}
		
		return flag;
	}
	public static String[] retornaHorapadrao(int id) throws Exception
	{
		String sql;
		String[] a = new String[4];
		sql = "select * from horapadrao where id="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		
		ResultSet res = bd.executeQuery(sql);
			bd.desconectar();
			if ( res.next() ) {
				a[0]=res.getString("he1");
				a[1]=res.getString("hs1");
				a[2]=res.getString("he2");
				a[3]=res.getString("hs2");
			}
		return a;
	}
	public static boolean autenticaOrdemFecha(int id) throws Exception
	{
		String sql;
		boolean flag=false;
		sql = "select * from tbos where id="+id+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		
			ResultSet res = bd.executeQuery(sql);
			bd.desconectar();
			if ( res.next() ) {
				int a=res.getInt("codigostatus");
				//System.out.println(a);
				if(a==1){
					flag=false;
					//System.out.println("entrou");
				}else{
					flag=true;
				}
			}
		
		return flag;
	}
	
	
	public static boolean gravaNovoCargo(Bean bean) throws Exception
	{
		String sql;
		
		sql = "insert into cargos (descricao) values ('"+bean.getNome()+"');";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception e) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean atualizaFolhaPonto(String a, String b, String c, String d, String e, String f, boolean j, int nome) throws Exception
	{
		String sql;
		
		sql = "update tbfolhaponto set he1='"+b+"', hs1='"+c+"', he2='"+d+"', hs2='"+e+"', ocorrencia='"+f+"', frequenciaint='"+j+"'  where data='"+a+"' and usuario="+nome+";";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return false;
			
		} catch (Exception eee) {
			bd.desconectar();
			return true;
		}
	}
	public static boolean atualizaFolhaPonto2(BeanFP bean) throws Exception
	{
		String sql;
		
		sql = "update tbfolhaponto set he1='"+bean.getHe1()+"', hs1='"+bean.getHs1()+"', he2='"+bean.getHe2()+"', hs2='"+bean.getHs2()+"', ocorrencia='"+bean.getOc()+"', frequenciaint='"+bean.isFrequenciaint()+"'  where data='"+bean.getData()+"' and usuario="+bean.getId()+";";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception eee) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean gravaFolhaPonto(String a, int i) throws Exception
	{
		String sql;
		String dt = "";
		String dia = Util.retornaDiadaSemana(a);
		if(dia.equals("DOM")){
			dt="DOMINGO";
		}
		if( dia.equals("SAB")){
			dt="SÁBADO";
			
		}
		sql = "insert into tbfolhaponto(data, he1, hs1, he2, hs2, ocorrencia, frequenciaint, usuario) values ('"+a+"', '"+dt+"', '"+dt+"', '"+dt+"', '"+dt+"', '', 'TRUE', "+i+");";
		//sql = "insert into tbfolhaponto(data, frequenciaint, usuario) values ('"+a+"', 'TRUE', "+i+");";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception ee) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean gravaHoraPadrao(String[] a, int i) throws Exception
	{
		String sql;
		sql = "insert into horapadrao (he1, hs1, he2, hs2, id) values  ('"+a[0]+"', '"+a[1]+"', '"+a[2]+"', '"+a[3]+"', "+i+") ;";		
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception ee) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean atualizaHoraPadrao(String[] a, int i) throws Exception
	{
		String sql;
		sql = "update horapadrao set he1='"+a[0]+"', hs1='"+a[1]+"', he2='"+a[2]+"', hs2='"+a[3]+"' where id="+i+";";		
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception ee) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean gravaNovaEscala(int dataespecial, int plantonista1, int plantonista2, int agente1, int agente2, int escrivao, int delegado, int papiloscopista, int perito, String data) throws Exception
	{
		//aki começa o código pra impedir a troca de users para os dias do passado
		Boolean flag=true;
		String dataatual=Util.DataHojesemHORA();
		int a=Integer.parseInt(dataatual.substring(0,2));
		int b=Integer.parseInt(dataatual.substring(3,5));
		int c=Integer.parseInt(dataatual.substring(6,10));
		int a1=Integer.parseInt(data.substring(0,2));
		int b1=Integer.parseInt(data.substring(3,5));
		int c1=Integer.parseInt(data.substring(6,10));
		if(c1<c){
			flag=false;
		}else{
			if(c1==c){
				if(b1<b){
					flag=false;
				}else{
					if(b1==b){
						if(a1<a){
							flag=false;
						}
					}
				}
			}
			
		}
		//fim do código pra impedir a mudança na escala do passado	
		if(flag==true){
			//System.out.println("flag= "+flag+" data ="+data);
			String sql;
			sql = "update tbescala  set dataespecial="+dataespecial+", plantonista1="+plantonista1+", plantonista2="+plantonista2+", " +
					"agente1="+agente1+", agente2="+agente2+", escrivao="+escrivao+", delegado="+delegado+", " +
							"papiloscopista="+papiloscopista+", perito="+perito+" where data='"+data+"';";
			//System.out.println("update = "+sql);
			Conexao bd = new Conexao();
			bd.conectarAccess();
			bd.prepareStmt();
			try {
				bd.executeUpdate(sql);
				bd.desconectar();
				return true;
			} catch (Exception e) {
				bd.desconectar();
				return false;
			}
		}else{
			//System.out.println("flag= "+flag+" data ="+data);
			return true;
		}
	}
	public static boolean gravaNovaEscala2(bean.BeanEscala bean) throws Exception
	{
		//aki começa o código pra impedir a troca de users para os dias do passado
		Boolean flag=true;
		String dataatual=Util.DataHojesemHORA();
		int a=Integer.parseInt(dataatual.substring(0,2));
		int b=Integer.parseInt(dataatual.substring(3,5));
		int c=Integer.parseInt(dataatual.substring(6,10));
		int a1=Integer.parseInt(bean.getData().substring(0,2));
		int b1=Integer.parseInt(bean.getData().substring(3,5));
		int c1=Integer.parseInt(bean.getData().substring(6,10));
		if(c1<c){
			flag=false;
		}else{
			if(c1==c){
				if(b1<b){
					flag=false;
				}else{
					if(b1==b){
						if(a1<a){
							flag=false;
						}
					}
				}
			}
			
		}
		//fim do código pra impedir a mudança na escala do passado	
		if(flag==true){
			String pla1 = "null";
			String pla2 = "null";
			String apf1 = "null";
			String apf2 = "null";
			String epf = "null";
			String ppf = "null";
			String dpf = "null";
			String pcf = "null";
			String dataespecial ="null";
			if(bean.getDataespecial()!=0){dataespecial=String.valueOf(bean.getDataespecial());}
			if(bean.getPlantonista1()!=0){pla1=String.valueOf(bean.getPlantonista1());}
			if(bean.getPlantonista2()!=0){pla2=String.valueOf(bean.getPlantonista2());}
			if(bean.getAgente1()!=0){apf1=String.valueOf(bean.getAgente1());}
			if(bean.getAgente2()!=0){apf2=String.valueOf(bean.getAgente2());}
			if(bean.getEscrivao()!=0){epf=String.valueOf(bean.getEscrivao());}
			if(bean.getPapiloscopista()!=0){ppf=String.valueOf(bean.getPapiloscopista());}
			if(bean.getDelegado()!=0){dpf=String.valueOf(bean.getDelegado());}
			if(bean.getPerito()!=0){pcf=String.valueOf(bean.getPerito());}
			String sql;
			sql = "update tbescala  set dataespecial="+dataespecial+", plantonista1="+pla1+", plantonista2="+pla2+", " +
					"agente1="+apf1+", agente2="+apf2+", escrivao="+epf+", delegado="+dpf+", " +
							"papiloscopista="+ppf+", perito="+pcf+" where data='"+bean.getData()+"';";
			System.out.println("update = "+sql);
			Conexao bd = new Conexao();
			bd.conectarAccess();
			bd.prepareStmt();
			try {
				bd.executeUpdate(sql);
				bd.desconectar();
				return true;
			} catch (Exception e) {
				bd.desconectar();
				return false;
			}
		}else{
			//System.out.println("flag= "+flag+" data ="+data);
			return false;
		}
	}
	public static boolean alteraCargo(Bean bean) throws Exception
	{
		String sql;
		
		sql = "update cargos set descricao='"+bean.getNome()+"' where id="+bean.getId()+";";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception e) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean alteraNoticia(bean.BeanNoticia bean) throws Exception
	{
		String sql;
		
		sql = "update tbnoticias set titulo='"+bean.getTitulo()+"', descricao='"+bean.getDescricao()+"', expira='"+bean.getExpira()+"' where id="+bean.getId()+";";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception e) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean alteraMenus(bean.BeanMenu bean) throws Exception
	{
		String sql;
		sql = "update menu set conteudo='"+bean.getConteudo()+"' where id="+bean.getFuncao()+";";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception e) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean alteralayout(bean.BeanLayout bean) throws Exception
	{
		String sql;
		sql = "update tblayout set conteudo='"+bean.getConteudo()+"' where id="+bean.getId()+";";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (SQLException e) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean incluinovoconteudo(bean.BeanConteudo bean) throws Exception
	{
		String sql;
		sql = "insert into tbconteudo (conteudo, descricao) values ('"+bean.getConteudo()+"', '"+bean.getDescricao()+"');";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (SQLException e) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean excluiconteudo(String id) throws Exception
	{
		String sql;
		sql = "DELETE FROM tbconteudo WHERE id = " + id + ";";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (SQLException e) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean alteraConteudo(bean.BeanConteudo bean) throws Exception
	{
		String sql;
		sql = "update tbconteudo set conteudo='"+bean.getConteudo()+"' where id="+bean.getId()+";";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (SQLException e) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean alteraLotacao(Bean bean) throws Exception
	{
		String sql;
		
		sql = "update lotacoes set descricao='"+bean.getNome()+"' where id="+bean.getId()+";";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception e) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean gravaNovoFuncao(Bean bean) throws Exception
	{
		String sql;
		
		sql = "insert into funcao (descricao) values ('"+bean.getNome()+"');";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception e) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean gravaNovoLotacao(Bean bean) throws Exception
	{
		String sql;
		
		sql = "insert into lotacoes (descricao) values ('"+bean.getNome()+"');";
		System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			System.out.println("deu certo");
			return true;
			
		} catch (Exception e) {
			bd.desconectar();
			System.out.println(e);
			return false;
		}
	}	
	public static boolean gravaNovaNotícia(bean.BeanNoticia bean) throws Exception
	{
		String sql;
		
		sql = "insert into tbnoticias (titulo, descricao, usuario, data, expira) values ('"+bean.getTitulo()+"', '"+bean.getDescricao()+"', '"+bean.getNome()+"', '"+bean.getData()+"', '"+bean.getExpira()+"');";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			//System.out.println(sql);
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception e) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean alteraLogin(Bean bean) throws Exception
	{
		String sql;
		String matricula=bean.getMatricula();
		String telcasa=bean.getTelcasa();
		String cel2=bean.getCel2();
		if(bean.getMatricula().equals("") || bean.getMatricula().equals(null)){
			matricula="0";
		}
		if(bean.getTelcasa().equals("") || bean.getTelcasa().equals(null)){
			telcasa="0";
		}
		if(bean.getCel2().equals("") || bean.getCel2().equals(null)){
			cel2="0";
		}
		sql = "update tbusuarios set nome='"+bean.getNome()+"', senha ='"+bean.getSenha()+"', codigo_tbusuarios="+bean.getCodigo_tbusuarios()+", nomecp='"+bean.getNomecp()+"', codigo_funcao="+bean.getCodigo_funcao()+", numero_sala='"+bean.getNumero_sala()+"', lotacao="+bean.getLotacao()+", ramal="+bean.getRamal()+", email='"+bean.getEmail()+"', telcasa='"+telcasa+"', cel1='"+bean.getCel1()+"', cel2='"+cel2+"', matricula="+matricula+", cargahoraria="+bean.getCargahoraria()+", cpf='"+bean.getCpf()+"', admissao='"+bean.getAdmissao()+"', situacao='"+bean.isSituacao()+"', classe="+bean.getClasse()+", sexo='"+bean.isSexo()+"', banco='"+bean.getBanco()+"', agencia="+bean.getAgencia()+", conta="+bean.getConta()+" where id="+bean.getId()+";";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception e) {
			bd.desconectar();
			return false;
		}
	}
	public static boolean alteraLoginCadastro(Bean bean) throws Exception
	{
		String sql;
		String matricula=bean.getMatricula();
		String telcasa=bean.getTelcasa();
		String cel2=bean.getCel2();
		if(bean.getMatricula().equals("") || bean.getMatricula().equals(null)){
			matricula="0";
		}
		if(bean.getTelcasa().equals("") || bean.getTelcasa().equals(null)){
			telcasa="0";
		}
		if(bean.getCel2().equals("") || bean.getCel2().equals(null)){
			cel2="0";
		}
		sql = "update tbusuarios set senha ='"+bean.getSenha()+"', codigo_tbusuarios="+bean.getCodigo_tbusuarios()+", nomecp='"+bean.getNomecp()+"', numero_sala='"+bean.getNumero_sala()+"', lotacao="+bean.getLotacao()+", ramal="+bean.getRamal()+", email='"+bean.getEmail()+"', telcasa='"+telcasa+"', cel1='"+bean.getCel1()+"', cel2='"+cel2+"', matricula="+matricula+", cargahoraria="+bean.getCargahoraria()+", cpf='"+bean.getCpf()+"', admissao='"+bean.getAdmissao()+"', situacao='"+bean.isSituacao()+"', classe="+bean.getClasse()+", sexo='"+bean.isSexo()+"', banco='"+bean.getBanco()+"', agencia="+bean.getAgencia()+", conta="+bean.getConta()+" where id="+bean.getId()+";";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		try {
			bd.executeUpdate(sql);
			bd.desconectar();
			return true;
			
		} catch (Exception e) {
			bd.desconectar();
			return false;
		}
	}
	/*
	public static String selectCarrinho(String nome) throws Exception
	{
		String sql;
		String resHTM = "";
		
		sql = "SELECT * FROM tabProdutos WHERE nome_produto = '" + nome + "';";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt(sql);
		ResultSet res = bd.executeQuery();

		if ( res.next() ) {
				resHTM += res.getInt("precoo");
		}
		bd.desconectar();
		return resHTM;
	}
	*/
	public static String apagarUsuarios() throws Exception
	{
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbusuarios ORDER BY nome";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			
			do
			{
				id = res.getInt("id");
				
				resHTML += "<TR>";
				resHTML += "	<TD><INPUT TYPE=RADIO NAME=chkExclusao value='"+ id + "' checked='true'></TD>";
				resHTML += "	<TD>" + res.getString("nomecp") + "</TD>";
				resHTML += "	<TD>" + Util.Cargo(res.getInt("codigo_tbusuarios")) + "</TD>";
				resHTML += "	<TD>" + res.getString("nome") + "</TD>";
				resHTML += "	<TD>" + id + "</TD>";				
				resHTML += "	<TD><INPUT TYPE=HIDDEN NAME=id VALUE=" + id + "></TD>";
				resHTML += "</TR>";
				
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type=button onclick='pergunta()' name='enviar' value='Apagar Selecionado'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			//resHTML += "<table class='search'>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String alterarUsuarios() throws Exception
	{
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbusuarios ORDER BY nome";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
			/*resHTML += "<div>";
			resHTML += "<table class='search'>";					
			resHTML += "<TR>"; 
			resHTML += "	<TD>&nbsp;&nbsp;</TD>";
			resHTML += "    <TD>&nbsp;Nome Completo</TD>";
			resHTML += "    <TD>Cargo</TD>";
			resHTML += "    <TD>Nome Login</TD>";
			resHTML += "	<TD>ID</TD>";
			resHTML += "	<TD></TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>";*/ 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			//resHTML += "<script> document.</script>";
			
			do
			{
				id = res.getInt("id");
				
				resHTML += "<TR>";
				resHTML += "	<TD><INPUT TYPE=RADIO NAME=chkExclusao value='"+ id + "' checked='true'></TD>";
				resHTML += "	<TD>" + res.getString("nomecp") + "</TD>";
				resHTML += "	<TD>" + Util.Cargo(res.getInt("codigo_tbusuarios")) + "</TD>";
				resHTML += "	<TD>" + res.getString("nome") + "</TD>";
				resHTML += "	<TD>" + id + "</TD>";				
				resHTML += "	<TD><INPUT TYPE=HIDDEN NAME=id VALUE=" + id + "></TD>";
				resHTML += "</TR>";
				
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type=submit name='enviar' value='Alterar Usuario Selecionado'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			//resHTML += "<script>document.forms.formalterar.chkExclusao[1].checked=true</script>";
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			//resHTML += "<table class='search'>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String usuariosMaster(int codigousuario) throws Exception
	{
		String cargos[][] = Util.cargosArrayList();
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbusuarios ORDER BY nomecp";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			
			do
			{
				id = res.getInt("id");
				
				resHTML += "<TR>";
				if(id==codigousuario){
					resHTML += "	<TD><INPUT TYPE='RADIO' NAME='chkExclusao' value='"+ id + "' checked></TD>";
				}else{
					resHTML += "	<TD><INPUT TYPE='RADIO' NAME='chkExclusao' value='"+ id + "'></TD>";}
				resHTML += "	<TD>" + res.getString("nomecp") + "</TD>";
				resHTML += "	<TD>" + Util.cargosidVectorMostraNome(res.getInt("codigo_tbusuarios"), cargos) + "</TD>";
				resHTML += "	<TD>" + res.getString("nome") + "</TD>";
				//resHTML += "	<TD><input type='button' name='patrimonio' value='PT'  onClick='enviar(this.name)'></TD>";				
				resHTML += "	<TD><INPUT TYPE=HIDDEN NAME=id VALUE=" + id + "></TD>";
				resHTML += "</TR>";
				
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input  type='image' src='img/bts/alterar.gif' onClick='enviar(this.name)' value='ALTERAR' name='alterar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/apagar.gif' onClick='enviar(this.name)' value='APAGAR' name='apagar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/novo.gif' onClick='enviar(this.name)' value='NOVO' name='novo'></center>";
			resHTML += "	</TD>";
			//resHTML += "	<TD>";
		    //resHTML += "		<br><br><center><input type='button' name='patrimonio' value='EQUIPS'  onClick='enviar(this.name)'></center>";
			//resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String usuariosEquipamentos(int qt) throws Exception
	{
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM equipinfo where usuario="+qt+" ORDER BY cod_equipinfo";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR><td>Usuario: "+Util.retornaNome(qt)+"</td></tr>";
			resHTML += "<TR><td>&nbsp;</td></tr>";
			do
			{
				id = res.getInt("cod_equipinfo");
				
				resHTML += "<TR>";
				resHTML += "	<TD><INPUT TYPE='RADIO' NAME='chkExclusao' value='"+ id + "' checked='true'></TD>";
				resHTML += "	<TD>" + res.getString("patrimonio") + "</TD>";
				resHTML += "	<TD>" + Util.retornaTipo(res.getInt("tipo")) + "</TD>";
				resHTML += "	<TD>" + res.getString("modelo") + "</TD>";
				resHTML += "	<TD>" + Util.retornaStatusEquip(res.getInt("status")) + "</TD>";
				//resHTML += "	<TD><input type='button' name='patrimonio' value='PT'  onClick='enviar(this.name)'></TD>";				
				resHTML += "	<TD><INPUT TYPE='HIDDEN' NAME='id' VALUE='" + id + "'></TD>";
				resHTML += "</TR>";
				
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input  type='image' src='img/bts/alterar.gif' onClick='enviar(this.name)' value='ALTERAR' name='alterar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/apagar.gif' onClick='enviar(this.name)' value='APAGAR' name='apagar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/novo.gif' onClick='enviar(this.name)' value='NOVO' name='novo'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/novo.gif' onClick='enviar(this.name)' value='NOVO' name='novo'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String noticiasMaster() throws Exception
	{
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbnoticias ORDER BY id";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			
			resHTML += "<tr><td></td><td><b>Título</b></td><td><b>Data Postagem</b></td><td><b>Data Expira</b></td></tr>";
			do
			{
				resHTML += "<TR>";
				resHTML += "	<TD><INPUT TYPE=RADIO NAME=chkExclusao value='"+res.getInt("id")+ "' checked='true'></TD>";
				resHTML += "	<TD>" + res.getString("titulo") + "</TD>";
				//resHTML += "	<TD>" + Util.Cargo(res.getInt("codigo_tbusuarios")) + "</TD>";
				resHTML += "	<TD>" + res.getString("data") + "</TD>";
				resHTML += "	<TD>" + res.getString("expira") + "</TD>";
				//resHTML += "	<TD>" + id + "</TD>";				
				resHTML += "	<TD><INPUT TYPE='HIDDEN' NAME='id' VALUE=" + res.getString("id") + "></TD>";
				resHTML += "</TR>";
				
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input  type='image' src='img/bts/alterar.gif' onClick='enviar(this.name)' value='ALTERAR' name='alterar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/apagar.gif' onClick='enviar(this.name)' value='APAGAR' name='apagar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/novo.gif' onClick='enviar(this.name)' value='NOVO' name='novo'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String ramaisMaster() throws Exception
	{
		String[][] vectorlotacoes = Util.comboboxLotacoesArrayList();
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbusuarios where situacao = true ORDER BY nomecp";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			
			do
			{
				id = res.getInt("id");
				
				resHTML += "<TR>";
				//resHTML += "	<TD><INPUT TYPE=RADIO NAME=chkExclusao value='"+ id + "' checked='true'></TD>";
				resHTML += "	<TD>" + res.getString("nomecp") + "</TD>";
				resHTML += "	<TD>" + res.getInt("ramal") + "</TD>";
				resHTML += "	<TD>&nbsp;</TD>";				
				resHTML += "	<TD>" + Util.VectorMostraNome(res.getInt("lotacao"), vectorlotacoes) + "</TD>";
				resHTML += "	<TD><INPUT TYPE=HIDDEN NAME=id VALUE=" + id + "></TD>";
				resHTML += "</TR>";
				
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input  type='hidden' src='img/bts/alterar.gif' onClick='enviar(this.name)' value='ALTERAR' name='alterar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='hidden' src='img/bts/apagar.gif' onClick='enviar(this.name)' value='APAGAR' name='apagar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='hidden' src='img/bts/novo.gif' onClick='enviar(this.name)' value='NOVO' name='novo'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String ramaisBusca(String no) throws Exception
	{
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbusuarios where upper(nomecp) like upper('%"+no+"%') and situacao = true ORDER BY nomecp";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			
			do
			{
				id = res.getInt("id");
				
				resHTML += "<TR>";
				//resHTML += "	<TD><INPUT TYPE=RADIO NAME=chkExclusao value='"+ id + "' checked='true'></TD>";
				resHTML += "	<TD>" + res.getString("nomecp") + "</TD>";
				resHTML += "	<TD>" + res.getInt("ramal") + "</TD>";
				resHTML += "	<TD>&nbsp;</TD>";				
				resHTML += "	<TD>" + Util.selectLotacaoDescricao(res.getInt("lotacao")) + "</TD>";
				resHTML += "	<TD><INPUT TYPE=HIDDEN NAME=id VALUE=" + id + "></TD>";
				resHTML += "</TR>";
				
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input  type='hidden' src='img/bts/alterar.gif' onClick='enviar(this.name)' value='ALTERAR' name='alterar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='hidden' src='img/bts/apagar.gif' onClick='enviar(this.name)' value='APAGAR' name='apagar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='hidden' src='img/bts/novo.gif' onClick='enviar(this.name)' value='NOVO' name='novo'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String ramaisLotacao(String lt) throws Exception
	{
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbusuarios where lotacao="+lt+" and situacao = true ORDER BY nomecp";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			
			do
			{
				id = res.getInt("id");
				
				resHTML += "<TR>";
				//resHTML += "	<TD><INPUT TYPE=RADIO NAME=chkExclusao value='"+ id + "' checked='true'></TD>";
				resHTML += "	<TD>" + res.getString("nomecp") + "</TD>";
				resHTML += "	<TD>" + res.getInt("ramal") + "</TD>";
				resHTML += "	<TD>&nbsp;</TD>";				
				//resHTML += "	<TD>" + Util.selectLotacaoDescricao(res.getInt("lotacao")) + "</TD>";
				resHTML += "	<TD><INPUT TYPE=HIDDEN NAME=id VALUE=" + id + "></TD>";
				resHTML += "</TR>";
				
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input  type='hidden' src='img/bts/alterar.gif' onClick='enviar(this.name)' value='ALTERAR' name='alterar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='hidden' src='img/bts/apagar.gif' onClick='enviar(this.name)' value='APAGAR' name='apagar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='hidden' src='img/bts/novo.gif' onClick='enviar(this.name)' value='NOVO' name='novo'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String ordensMaster(String nome) throws Exception
	{
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbos where codigousuarioatendente="+Util.retornaID(nome)+" ORDER BY id desc";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
		
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD><h2>&nbsp;&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Data de Abertura&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Usuario&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Atendente UTI&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Status&nbsp;</h2></TD>";			
			resHTML += "</TR>";
			
			do
			{
				id = res.getInt("id");
				
				resHTML += "<TR>";
				resHTML += "	<TD><INPUT TYPE=RADIO NAME=chkExclusao value='"+ id + "' checked='true'></TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtabertura") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioabriu")) + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtatribuicao") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtfinalizacao") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtaprovacao") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioatendente")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaStatus(res.getInt("codigostatus")) + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + id + "&nbsp;</TD>";				
				resHTML += "	<TD><INPUT TYPE=HIDDEN NAME=id VALUE=" + id + "></TD>";
				resHTML += "</TR>";
				
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/ler.gif' onClick='enviar(this.name)' value='Ler' name='ler'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button' src='img/bts/ler.gif' onClick='enviar(this.name)' value='NOVA O.S.' name='nova'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button'  onClick='enviar(this.name)' value='IMPRIMIR O.S.' name='imprimir'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há ordens de serviço..</b></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button' src='img/bts/ler.gif' onClick='enviar(this.name)' value='NOVA O.S.' name='nova'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String ordensMasterAtendente(String nome) throws Exception
	{
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbos where codigousuarioatendente="+Util.retornaID(nome)+" and codigostatus=3 ORDER BY id desc";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
		
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD><h2>&nbsp;&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Data de Abertura&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Usuario&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Atendente UTI&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Status&nbsp;</h2></TD>";			
			resHTML += "</TR>";
			
			do
			{
				id = res.getInt("id");
				
				resHTML += "<TR>";
				resHTML += "	<TD><INPUT TYPE=RADIO NAME=chkExclusao value='"+ id + "' checked='true'></TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtabertura") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioabriu")) + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtatribuicao") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtfinalizacao") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtaprovacao") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioatendente")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaStatus(res.getInt("codigostatus")) + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + id + "&nbsp;</TD>";				
				resHTML += "	<TD><INPUT TYPE=HIDDEN NAME=id VALUE=" + id + "></TD>";
				resHTML += "</TR>";
				
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/ler.gif' onClick='enviar(this.name)' value='Ler' name='ler'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button' src='img/bts/ler.gif' onClick='enviar(this.name)' value='NOVA O.S.' name='nova'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button'  onClick='enviar(this.name)' value='IMPRIMIR O.S.' name='imprimir'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há ordens de serviço..</b></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button' src='img/bts/ler.gif' onClick='enviar(this.name)' value='NOVA O.S.' name='nova'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String ordensAbertas(String nome) throws Exception
	{
		
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbos where codigousuarioabriu="+Util.retornaID(nome)+" and codigostatus=1 ORDER BY id desc";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
		
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
		//	resHTML += "	<TD><h2>&nbsp;&nbsp;</h2></TD>";
			resHTML += "	<TD>&nbsp;Data de Abertura&nbsp;</TD>";
			//resHTML += "	<TD><h2>&nbsp;Usuario&nbsp;</h2></TD>";
			resHTML += "	<TD>&nbsp;Atendente NTI&nbsp;</TD>";
			resHTML += "	<TD>&nbsp;Tipo&nbsp;</TD>";
			resHTML += "	<TD>&nbsp;Status&nbsp;</TD>";			
			resHTML += "</TR>";
			
			do
			{
				
				String at="&nbsp";
				if(res.getInt("codigousuarioatendente")!=0){
					at=Util.retornaNome(res.getInt("codigousuarioatendente"));	
				}
				resHTML +="<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>";
				resHTML += "<TR>";
				//resHTML += "	<TD><INPUT TYPE=RADIO NAME=chkExclusao value='"+ id + "' checked='true'></TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtabertura") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioabriu")) + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtatribuicao") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtfinalizacao") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtaprovacao") + "&nbsp;</TD>";
				resHTML += "	<TD><center>&nbsp;" + at + "&nbsp;</center></TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaTipoOS(res.getInt("codigotipos")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaStatus(res.getInt("codigostatus")) + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + id + "&nbsp;</TD>";				
				//resHTML += "	<TD><INPUT TYPE=HIDDEN NAME=id VALUE=" + id + "></TD>";
				resHTML += "</TR>";
				resHTML +="<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>";
				//resHTML += "</table>";
				//resHTML += "</div>"; 
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			/*resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/ler.gif' onClick='enviar(this.name)' value='Ler' name='ler'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>";*/ 
	
		}else{
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String ordensFinalizadas(String nome) throws Exception
	{
		
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbos where codigousuarioabriu="+Util.retornaID(nome)+" and codigostatus=4 ORDER BY id desc";
		//System.out.println(sql);
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
		
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
		//	resHTML += "	<TD><h2>&nbsp;&nbsp;</h2></TD>";
			resHTML += "	<TD>&nbsp;Data de Abertura&nbsp;</TD>";
			//resHTML += "	<TD><h2>&nbsp;Usuario&nbsp;</h2></TD>";
			resHTML += "	<TD>&nbsp;Atendente NTI&nbsp;</TD>";
			resHTML += "	<TD>&nbsp;Tipo&nbsp;</TD>";
			resHTML += "	<TD>&nbsp;Status&nbsp;</TD>";			
			resHTML += "</TR>";
			
			do
			{
				
				String at="&nbsp";
				if(res.getInt("codigousuarioatendente")!=0){
					at=Util.retornaNome(res.getInt("codigousuarioatendente"));	
				}
				resHTML +="<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>";
				resHTML += "<TR>";
				//resHTML += "	<TD><INPUT TYPE=RADIO NAME=chkExclusao value='"+ id + "' checked='true'></TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtabertura") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioabriu")) + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtatribuicao") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtfinalizacao") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtaprovacao") + "&nbsp;</TD>";
				resHTML += "	<TD><center>&nbsp;" + at + "&nbsp;</center></TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaTipoOS(res.getInt("codigotipos")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaStatus(res.getInt("codigostatus")) + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + id + "&nbsp;</TD>";				
				//resHTML += "	<TD><INPUT TYPE=HIDDEN NAME=id VALUE=" + id + "></TD>";
				resHTML += "</TR>";
				resHTML +="<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>";
				//resHTML += "</table>";
				//resHTML += "</div>"; 
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			/*resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/ler.gif' onClick='enviar(this.name)' value='Ler' name='ler'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>";*/ 
	
		}else{
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String ordensMasterGerente() throws Exception
	{
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbos ORDER BY id desc";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
		
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD><h2>&nbsp;&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Data de Abertura&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Usuario&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Atendente UTI&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Status&nbsp;</h2></TD>";			
			resHTML += "</TR>";
			
			do
			{
				id = res.getInt("id");
				
				resHTML += "<TR>";
				resHTML += "	<TD><INPUT TYPE=RADIO NAME=chkExclusao value='"+ id + "' checked='true'></TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtabertura") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioabriu")) + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtatribuicao") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtfinalizacao") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtaprovacao") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioatendente")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaStatus(res.getInt("codigostatus")) + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + id + "&nbsp;</TD>";				
				resHTML += "	<TD><INPUT TYPE=HIDDEN NAME=id VALUE=" + id + "></TD>";
				resHTML += "</TR>";
				
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/ler.gif' onClick='enviar(this.name)' value='Ler' name='ler'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button' src='img/bts/ler.gif' onClick='enviar(this.name)' value='NOVA O.S.' name='nova'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TD";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button' src='img/bts/ler.gif' onClick='enviar(this.name)' value='NOVA O.S.' name='nova'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String ordensMasterAprovacao(int codigo) throws Exception
	{
		int id;
		String sql;
		String resHTML = "";
		
		//sql = "SELECT * FROM tbos where codigousuarioabriu="+codigo+" and dtaprovacao='null' and dtfinalizacao!='null' and dtatribuicao !='null';";
		sql = "SELECT * FROM tbos where codigousuarioabriu="+codigo+" ORDER BY id desc;";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
		
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD><h2>&nbsp;&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Data de Abertura&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Descrição&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Atendente UTI&nbsp;</h2></TD>";
			resHTML += "	<TD><h2>&nbsp;Status&nbsp;</h2></TD>";			
			resHTML += "</TR>";
		/*	resHTML += "</table>";
			resHTML += "</div>";
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>&nbsp;&nbsp;</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>";
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>&nbsp;&nbsp;</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>";*/
			do
			{
				id = res.getInt("id");
				//resHTML += "<div>";
				//resHTML += "<table class='search'>";
				resHTML += "<TR>";
				resHTML += "	<TD><INPUT TYPE=RADIO NAME=chkExclusao value='"+ id + "' checked='true'></TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtabertura") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioabriu")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("descricao") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtfinalizacao") + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + res.getString("dtaprovacao") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioatendente")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaStatus(res.getInt("codigostatus")) + "&nbsp;</TD>";
				//resHTML += "	<TD>&nbsp;" + id + "&nbsp;</TD>";				
				resHTML += "	<TD><INPUT TYPE=HIDDEN NAME=id VALUE=" + id + "></TD>";
				resHTML += "</TR>";
				
				/* resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<TR>";
				resHTML += "	<TD>&nbsp;&nbsp;</TD>";
				resHTML += "</TR>";
				resHTML += "</table>";
				resHTML += "</div>";
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<TR>";
				resHTML += "	<TD>&nbsp;&nbsp;</TD>";
				resHTML += "</TR>";
				resHTML += "</table>";
				resHTML += "</div>"; */
				
			} while( res.next() );
			
			resHTML += "</table>";
			resHTML += "</div>"; 
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button' src='img/bts/aprovar.gif' onClick='enviar(this.name)' value='APROVAR O.S.' name='aprovar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button' src='img/bts/fechar.gif' onClick='enviar(this.name)' value='CANCELAR O.S.' name='fechar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button' src='img/bts/abrir.gif' onClick='enviar(this.name)' value='NOVA O.S.' name='abrir'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button'  onClick='enviar(this.name)' value='IMPRIMIR O.S.' name='imprimir'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='button' src='img/bts/abrir.gif' onClick='enviar(this.name)' value='NOVA O.S.' name='abrir'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String ordensMasterLeitura(int codigo) throws Exception
	{
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbos where id="+codigo+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
		
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<tr>";
			resHTML += "<td>&nbsp;<h2>Data Abertura&nbsp;&nbsp;</h2></td>";
			resHTML += "<td>&nbsp;&nbsp;<h2>Data Atribuição&nbsp;&nbsp;</h2></td>";
			resHTML += "<td>&nbsp;&nbsp;<h2>Data Finalização&nbsp;&nbsp;</h2></td>";
			resHTML += "<td>&nbsp;&nbsp;<h2>Data Aprovação&nbsp;&nbsp;</h2></td>";
			resHTML += "<td>&nbsp;&nbsp;<h2>Usuário Atendente&nbsp;&nbsp;</h2></td>";
			resHTML += "<td>&nbsp;&nbsp;<h2>Status&nbsp;&nbsp;</h2></td>";
			resHTML += "<td>&nbsp;&nbsp;<h2>ID</h2></td>";
			resHTML += "</tr>";
			resHTML += "<tr>";
			resHTML += "<td>&nbsp;</td>";
			resHTML += "</tr>";
				
			
			do
			{
				id = res.getInt("id");
				
				resHTML += "<TR>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtabertura") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtatribuicao") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtfinalizacao") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtaprovacao") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioatendente")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaStatus(res.getInt("codigostatus")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + id;				
				resHTML += "	<INPUT TYPE=HIDDEN NAME=id VALUE=" + id + ">";
				resHTML += "	<INPUT TYPE='hidden' NAME=chkExclusao value='"+ id + "'></TD>";
				resHTML += "</TR>";
				resHTML += "</table>";
				resHTML += "</div>";
				

				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<tr>&nbsp;";
				resHTML += "</tr>";
				resHTML += "</table>";
				resHTML += "</div>"; 
				
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<tr>";
				resHTML += "<td>&nbsp;&nbsp;<h2>Usuário Abriu&nbsp;&nbsp;</h2></td>";
				resHTML += "<td>&nbsp;&nbsp;<h2>Tipo OS&nbsp;&nbsp;</h2></td>";
				resHTML += "<td><h2>Descricão</h2></td>";
				resHTML += "</tr>";
				resHTML += "<tr>";
				resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioabriu")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaTipoOS(res.getInt("codigotipos")) + "&nbsp;</TD>";
				resHTML += "	<TD>" + res.getString("descricao") + "</TD>";
				resHTML += "</tr>";
				resHTML += "</table>";
				resHTML += "</div>"; 
				
			} while( res.next() );
			
		
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/finalizar.gif' onClick='enviar(this.name)' value='Finalizar' name='finalizar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/voltar.gif' onClick='enviar(this.name)' value='VOLTAR' name='voltar'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	public static String ordensAtendenteLeitura(int codigo) throws Exception
	{
		int id;
		String sql;
		String resHTML = "";
		String cs="";
		
		sql = "SELECT * FROM tbos where id="+codigo+";";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt();
		ResultSet res = bd.executeQuery(sql);

		if ( res.next() ) {
			
		
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<tr>";
			resHTML += "<td>&nbsp;<h2>Data Abertura&nbsp;&nbsp;</h2></td>";
			resHTML += "<td>&nbsp;&nbsp;<h2>Data Atribuição&nbsp;&nbsp;</h2></td>";
			resHTML += "<td>&nbsp;&nbsp;<h2>Data Finalização&nbsp;&nbsp;</h2></td>";
			resHTML += "<td>&nbsp;&nbsp;<h2>Data Aprovação&nbsp;&nbsp;</h2></td>";
			resHTML += "<td>&nbsp;&nbsp;<h2>Usuário Atendente&nbsp;&nbsp;</h2></td>";
			resHTML += "<td>&nbsp;&nbsp;<h2>Status&nbsp;&nbsp;</h2></td>";
			resHTML += "<td>&nbsp;&nbsp;<h2>ID</h2></td>";
			resHTML += "</tr>";
			resHTML += "<tr>";
			resHTML += "<td>&nbsp;</td>";
			resHTML += "</tr>";
				
			
			do
			{
				id = res.getInt("id");
				
				resHTML += "<TR>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtabertura") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtatribuicao") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtfinalizacao") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + res.getString("dtaprovacao") + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioatendente")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaStatus(res.getInt("codigostatus")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + id;				
				resHTML += "	<INPUT TYPE=HIDDEN NAME=id VALUE=" + id + ">";
				resHTML += "	<INPUT TYPE='hidden' NAME=chkExclusao value='"+ id + "'></TD>";
				resHTML += "</TR>";
				resHTML += "</table>";
				resHTML += "</div>";
				

				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<tr>&nbsp;";
				resHTML += "</tr>";
				resHTML += "</table>";
				resHTML += "</div>"; 
				
				resHTML += "<div>";
				resHTML += "<table class='search'>";
				resHTML += "<tr>";
				resHTML += "<td>&nbsp;&nbsp;<h2>Usuário Abriu&nbsp;&nbsp;</h2></td>";
				resHTML += "<td>&nbsp;&nbsp;<h2>Tipo OS&nbsp;&nbsp;</h2></td>";
				resHTML += "<td><h2>Descricão</h2></td>";
				resHTML += "</tr>";
				resHTML += "<tr>";
				resHTML += "	<TD>&nbsp;" + Util.retornaNome(res.getInt("codigousuarioabriu")) + "&nbsp;</TD>";
				resHTML += "	<TD>&nbsp;" + Util.retornaTipoOS(res.getInt("codigotipos")) + "&nbsp;</TD>";
				resHTML += "	<TD>" + res.getString("descricao") + "</TD>";
				resHTML += "</tr>";
				resHTML += "</table>";
				resHTML += "</div>"; 
				cs=res.getString("conclusao");
			} while( res.next() );
			
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		&nbsp;";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		&nbsp;";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<h2>Conclusão:</h2>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><textarea NAME='conclusao' COLS='60' ROWS='12'>"+cs+"</textarea></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/finalizar.gif' onClick='enviar(this.name)' value='Finalizar' name='finalizar'></center>";
			resHTML += "	</TD>";
			resHTML += "	<TD>";
			resHTML += "		<br><br><center><input type='image' src='img/bts/voltar.gif' onClick='enviar(this.name)' value='VOLTAR' name='voltar'></center>";
			resHTML += "	</TD>";
			resHTML += "</TR>";
			resHTML += "</table>";
			resHTML += "</div>"; 
	
		}else{
			
			resHTML += "<div>";
			resHTML += "<table class='search'>";
			resHTML += "<TR>";
			resHTML += "	<TD>";
			resHTML += "		<center><b>Não há registros no Banco de Dados !!!</b></center>";
			resHTML += "	</TR>";
			resHTML += "</TD>";
			resHTML += "</table>";
			resHTML += "</div>"; 
		bd.desconectar();	
		}
		return resHTML;
	}
	/*public static String selectPage(String nome) throws Exception
	{
		String id;
		String sql;
		String resHTML = "";

		sql = "SELECT * FROM tabProdutos WHERE categoria = '" + nome + "'" + "ORDER BY nome_produto";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt(sql);
		ResultSet res = bd.executeQuery();

		if ( res.next() ) {
			
			resHTML += "<FORM NAME=agreeform method=Post action=test.jsp onSubmit='return defaultagree(this)'>";
			
			resHTML += "<TABLE BORDER=0 CELLPADING=0 CELLSPACING=0 WIDTH=800 ALIGN=CENTER>";
			resHTML += "<TR>"; 
			resHTML += "    <TD>Foto</TD>";
			resHTML += "	<TD>Nome</TD>";
			resHTML += "    <TD>Preï¿½o</TD>";
			//resHTML += "	<TD>null</TD>";
			resHTML += "</TR>";
			
			do
			{
				id = res.getString("nome_produto");
				resHTML += "<TR bgcolor='#229bc9'>";
				resHTML += "<TD> <a href='produto.jsp?cda="+id+"' target='newpage'><image src='"+ res.getString("endereco_imagem")+"'></a> </TD>";
				//resHTML += "<INPUT TYPE=HIDDEN NAME=id VALUE=" + id + ">";
				resHTML += "<TD>" + id + "</TD>";
				resHTML += "<TD>R$" + res.getString("precoo") + "</TD>";
				//resHTML += "<TD>" + res.getString("nome_completo") + "</TD>";
				//resHTML += "<TD>" + res.getString("email") + "</TD>";
				//resHTML += "<TD>" + id + "</TD>";
				resHTML += "</TR>";
			} while( res.next() );
			
			
		} else
			resHTML += "<center><b>Nï¿½o hï¿½ registros no Banco de Dados !!!</b></center>";
		
		bd.desconectar();	

		return resHTML;
	}
	public static String selectOfertas() throws Exception
	{
		String id;
		String sql;
		String resHTML = "";

		sql = "SELECT * FROM tabProdutos WHERE id_oferta = 'sim' ORDER BY nome_produto";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt(sql);
		ResultSet res = bd.executeQuery();

		if ( res.next() ) {
			
			resHTML += "<FORM NAME=agreeform method=Post action=test.jsp onSubmit='return defaultagree(this)'>";
			
			resHTML += "<TABLE BORDER=0 CELLPADING=0 CELLSPACING=0 WIDTH=800 ALIGN=CENTER>";
			resHTML += "<h1>Ofertas do dia.</h1>"; 
			resHTML += "<TR>"; 
			resHTML += "    <TD>Foto</TD>";
			resHTML += "	<TD>Nome</TD>";
			resHTML += "    <TD>Preï¿½o</TD>";
			//resHTML += "	<TD>null</TD>";
			resHTML += "</TR>";
			
			do
			{
				id = res.getString("nome_produto");
				resHTML += "<TR bgcolor='#229bc9'>";
				resHTML += "<TD> <a href='produto.jsp?cda="+id+"' target='newpage'><image src='"+ res.getString("endereco_imagem")+"'></a> </TD>";
				//resHTML += "<INPUT TYPE=HIDDEN NAME=id VALUE=" + id + ">";
				resHTML += "<TD>" + id + "</TD>";
				resHTML += "<TD>R$" + res.getString("precoo") + "</TD>";
				//resHTML += "<TD>" + res.getString("nome_completo") + "</TD>";
				//resHTML += "<TD>" + res.getString("email") + "</TD>";
				//resHTML += "<TD>" + id + "</TD>";
				resHTML += "</TR>";
			} while( res.next() );
			
			
		} else
			resHTML += "<center><b>Nï¿½o hï¿½ produto em Oferta no momento !!!</b></center>";
		
		bd.desconectar();	

		return resHTML;
	}
	public static String selectProduto(String nome) throws Exception
	{
		String id;
		String prego;
		String sql;
		String resHTML = "";

		sql = "SELECT * FROM tabProdutos WHERE nome_produto= '" + nome + "'" + "ORDER BY nome_produto";
		Conexao bd = new Conexao();
		bd.conectarAccess();
		bd.prepareStmt(sql);
		ResultSet res = bd.executeQuery();

		if ( res.next() ) {
			
			resHTML += "<FORM NAME=comprar method=Post action=antescarrinho.jsp target='21'>";
			
			resHTML += "<TABLE BORDER=0 CELLPADING=0 CELLSPACING=0 WIDTH=800 ALIGN=CENTER>";
			resHTML += "<TR>"; 
			resHTML += "    <TD></TD>";
			resHTML += "	<TD>Nome</TD>";
			resHTML += "    <TD>Preï¿½o</TD>";
			resHTML += "	<TD>Sobre</TD>";
			resHTML += "</TR>";
			
			do
			{
				id = res.getString("nome_produto");
				prego = res.getString("precoo");
				resHTML += "<TR bgcolor='#229bc9'>";
				resHTML += "<TD> <image src='"+ res.getString("endereco_imagem")+"'> </TD>";
				//resHTML += "<INPUT TYPE=HIDDEN NAME=id VALUE=" + id + ">";
				resHTML += "<TD>" + id + "<br><br><br><br><br><input type='submit' value='Comprar'><INPUT TYPE=HIDDEN NAME=nome_produto VALUE='" + id +"'><INPUT TYPE=HIDDEN NAME=preco VALUE='" + prego +"'></TD>";
				resHTML += "<TD>R$" + prego + "<br><br><br><br><br><br></TD>";
				resHTML += "<TD>" + res.getString("ad_produto") + "<br><br><br><br><br><br></TD>";
				resHTML += "<TD>Item em Oferta: " + res.getString("id_oferta") + "<br><br><br><br><br><br></TD>";
				//resHTML += "<TD>" + id + "</TD>";
				resHTML += "<TR bgcolor='499B898' bgproperties='fixed'>";
				resHTML += "<td width=20%></td><td>";
				resHTML += "<IFRAME SRC='pagina.jsp' name='21'   FRAMEBORDER=0 SCROLLING=no WIDTH=100% height=100%></IFRAME>";
				resHTML += "</td></tr>";
				resHTML += "</form>";
				resHTML += "</table>";
			} while( res.next() );
			
			
		} else
			resHTML += "<center><b>Nï¿½o hï¿½ registros no Banco de Dados !!!</b></center>";
		
		bd.desconectar();	

		return resHTML;
	}

	public static String selectCDs()
	{
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tbUsuarios ORDER BY nome";
		try {
			Conexao bd = new Conexao();
			bd.conectarAccess();
			bd.prepareStmt(sql);
			ResultSet res = bd.executeQuery();
			
			if ( res.next() ) {
				
				do
				{
					id = res.getInt("id");
					resHTML += "<TR bgcolor='#229bc9'>";
					resHTML += "<TD> <INPUT TYPE=RADIO NAME=radAlterar VALUE=" + id + "> </TD>";
					resHTML += "<TD> <INPUT TYPE=CHECKBOX NAME=chkExcluir onClick='agreesubmit(this)' VALUE=" + id + "> </TD>";
					resHTML += "<TD>" + res.getString("nome") + "</TD>";
					resHTML += "<TD>" + res.getString("senha") + "</TD>";
					resHTML += "<TD>" + res.getString("nome_completo") + "</TD>";
					resHTML += "<TD>" + res.getString("email") + "</TD>";
					resHTML += "<TD>" + id + "</TD>";
					resHTML += "</TR>";
				} while( res.next() );
				
			}
			
			bd.desconectar();	
		} catch (Exception e) {
			System.out.println("Erro");
			resHTML = "";
		}
		
		return resHTML;
	}
	public static String selectCarrinho()
	{
		String id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tabItemCompra ORDER BY codigo_produto";
		try {
			Conexao bd = new Conexao();
			bd.conectarAccess();
			bd.prepareStmt(sql);
			ResultSet res = bd.executeQuery();
			
			if ( res.next() ) {
				
				do
				{
					id = res.getString("codigo_produto");
					resHTML += "<TR bgcolor='#229bc9'>";
					//resHTML += "<TD> <INPUT TYPE=RADIO NAME=radAlterar VALUE=" + id + "> </TD>";
					resHTML += "<TD> <INPUT TYPE=CHECKBOX NAME=chkExcluir onClick='agreesubmit(this)' VALUE=" + id + "> </TD>";
					resHTML += "<TD>" + id + "</TD>";
					resHTML += "<TD>" + res.getString("preco") + "</TD>";
					resHTML += "<TD>" + res.getString("quantidade") + "</TD>";
					//resHTML += "<TD>" + res.getString("email") + "</TD>";
					//resHTML += "<TD>" + id + "</TD>";
					resHTML += "</TR>";
				} while( res.next() );
				
			} else
			resHTML += "<center><b>Nï¿½o hï¿½ registros no Banco de Dados !!!</b></center>";
			
			bd.desconectar();	
		} catch (Exception e) {
			System.out.println("Erro");
			resHTML = "";
		}
		
		return resHTML;
	}
	public static String selectCategoria()
	{
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tabCategorias ORDER BY categoria";
		try {
			Conexao bd = new Conexao();
			bd.conectarAccess();
			bd.prepareStmt(sql);
			ResultSet res = bd.executeQuery();
			
			if ( res.next() ) {
				
				do
				{
					id = res.getInt("codigo");
					resHTML += "<TR bgcolor='#229bc9'>";
					resHTML += "<TD> <INPUT TYPE=CHECKBOX NAME=chkExcluir onClick='agreesubmit(this)' VALUE=" + id + "> </TD>";
					resHTML += "<TD>" + res.getString("categoria") + "</TD>";
					resHTML += "<TD>" + id + "</TD>";
					resHTML += "</TR>";
				} while( res.next() );
				
			}
			
			bd.desconectar();	
		} catch (Exception e) {
			System.out.println("Erro");
			resHTML = "";
		}
		
		return resHTML;
	}
	public static String selectProdutos()
	{
		int id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tabProdutos ORDER BY codigo_produto";
		try {
			Conexao bd = new Conexao();
			bd.conectarAccess();
			bd.prepareStmt(sql);
			ResultSet res = bd.executeQuery();
			
			if ( res.next() ) {
				
				do
				{
					id = res.getInt("codigo_produto");
					resHTML += "<TR bgcolor='#229bc9'>";
					resHTML += "<TD> <INPUT TYPE=CHECKBOX NAME=chkExcluir onClick='agreesubmit(this)' VALUE=" + id + "> </TD>";
					resHTML += "<TD>" + res.getString("nome_produto") + "</TD>";
					resHTML += "<TD>" + res.getString("precoo") + "</TD>";
					resHTML += "<TD>" + res.getString("ad_produto") + "</TD>";
					resHTML += "<TD>" + id + "</TD>";
					resHTML += "</TR>";
				} while( res.next() );
				
			}
			
			bd.desconectar();	
		} catch (Exception e) {
			System.out.println("Erro");
			resHTML = "";
		}
		
		return resHTML;
	}
	public static String selectMenu()
	{
		String id;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tabCategorias ORDER BY categoria";
		try {
			Conexao bd = new Conexao();
			bd.conectarAccess();
			bd.prepareStmt(sql);
			ResultSet res = bd.executeQuery();
			
			if ( res.next() ) {
				
				do
				{
					id = res.getString("categoria");
					//resHTML += "<TR bgcolor='#229bc9'>";
					//resHTML += "<TD> <INPUT TYPE=CHECKBOX NAME=chkExcluir onClick='agreesubmit(this)' VALUE=" + id + "> </TD>";
					resHTML += "<a href='imprime.jsp?cdc=" + id + "' target=1>"+id+"</a>"+"&nbsp;&nbsp;&nbsp;";
					//resHTML += "<TD>" + id + "</TD>";
					//resHTML += "</TR>";
				} while( res.next() );
				
			}
			
			bd.desconectar();	
		} catch (Exception e) {
			System.out.println("Erro");
			resHTML = "";
		}
		
		return resHTML;
	}
	public static String selectInput()
	{
		String cate;
		String sql;
		String resHTML = "";
		
		sql = "SELECT * FROM tabCategorias ORDER BY categoria";
		try {
			Conexao bd = new Conexao();
			bd.conectarAccess();
			bd.prepareStmt(sql);
			ResultSet res = bd.executeQuery();
			
			if ( res.next() ) {
				
				do
				{
					cate = res.getString("categoria");
					//resHTML += "<select name='categoria'><br>";
					resHTML += "<option value='" + cate +"'>" + cate;//+"<br>";
					//resHTML += "</select><br>";
				} while( res.next() );
				
			}
			
			bd.desconectar();	
		} catch (Exception e) {
			System.out.println("Erro");
			resHTML = "";
		}
		
		return resHTML;
	}
	public static Bean selectCD(int id)
	{
		Bean bean = null;
		String sql;
		
		sql = "SELECT * FROM tbUsuarios WHERE id = " + id ;
		try {
			Conexao bd = new Conexao();
			bd.conectarAccess();
			bd.prepareStmt(sql);
			ResultSet res = bd.executeQuery();
			
			if ( res.next() ) {
				bean = new Bean();
				bean.setId(res.getInt("id"));
				bean.setNome(res.getString("nome"));
				bean.setSenha(res.getString("senha"));
			}
			
			bd.desconectar();	
		} catch (Exception e) {
			bean = null;
		}

		return bean;
	}
	
	*/
	public static boolean deleteLogin(String[] chkCDs)
	{
		boolean resposta=false;
		if (chkCDs != null) {
			
			String sql = "";
			try {
				Conexao bd = new Conexao();
				bd.conectarAccess();
				
				for (int i=0; i<chkCDs.length; i++) {
					sql = "DELETE FROM tbusuarios WHERE id = " + chkCDs[0] + ";";
					//System.out.println(sql);
					bd.prepareStmt();
					bd.executeUpdate(sql);
				}
				
				bd.desconectar();
				resposta=true;
			} catch (Exception e) {
				resposta=false;
			}
		}
		return resposta;
	}
	
	public static boolean deleteLoginHora(String[] chkCDs)
	{
		boolean resposta=false;
		if (chkCDs != null) {
			
			String sql = "";
			try {
				Conexao bd = new Conexao();
				bd.conectarAccess();
				
				for (int i=0; i<chkCDs.length; i++) {
					sql = "DELETE FROM horapadrao WHERE id = " + chkCDs[0] + ";";
					//System.out.println(sql);
					bd.prepareStmt();
					bd.executeUpdate(sql);
				}
				
				bd.desconectar();
				resposta=true;
			} catch (Exception e) {
				resposta=false;
			}
		}
		return resposta;
	}
	public static boolean deleteCargos(String[] chkCDs)
	{
		boolean resposta=false;
		if (chkCDs != null) {
			
			String sql = "";
			try {
				Conexao bd = new Conexao();
				bd.conectarAccess();
				for (int i=0; i<chkCDs.length; i++) {
					sql = "DELETE FROM cargos WHERE id = " + chkCDs[i] + ";";
					bd.prepareStmt();
					bd.executeUpdate(sql);
				}
				bd.desconectar();
				resposta=true;
			} catch (Exception e) {
				resposta=false;
			}
		}
		return resposta;
	}
	public static boolean deletaNoticias(String[] chkCDs)
	{
		boolean resposta=false;
		if (chkCDs != null) {
			
			String sql = "";
			try {
				Conexao bd = new Conexao();
				bd.conectarAccess();
				for (int i=0; i<chkCDs.length; i++) {
					sql = "DELETE FROM tbnoticias WHERE id = " + chkCDs[i] + ";";
					bd.prepareStmt();
					bd.executeUpdate(sql);
				}
				bd.desconectar();
				resposta=true;
			} catch (Exception e) {
				resposta=false;
			}
		}
		return resposta;
	}
	public static boolean deleteFuncoes(String[] chkCDs)
	{
		boolean resposta=false;
		if (chkCDs != null) {
			
			String sql = "";
			try {
				Conexao bd = new Conexao();
				bd.conectarAccess();
				for (int i=0; i<chkCDs.length; i++) {
					sql = "DELETE FROM funcao WHERE id = " + chkCDs[i] + ";";
					bd.prepareStmt();
					bd.executeUpdate(sql);
				}
				bd.desconectar();
				resposta=true;
			} catch (Exception e) {
				resposta=false;
			}
		}
		return resposta;
	}
	public static boolean deleteEquip(String chkCDs)
	{
		boolean resposta=false;
		if (chkCDs != null) {
			
			String sql = "";
			try {
				Conexao bd = new Conexao();
				bd.conectarAccess();
				//for (int i=0; i<chkCDs.length; i++) {
					sql = "DELETE FROM equipinfo WHERE cod_equipinfo = " + chkCDs + ";";
					System.out.println(sql);
					bd.prepareStmt();
					bd.executeUpdate(sql);
				//}
				bd.desconectar();
				resposta=true;
			} catch (Exception e) {
				resposta=false;
			}
		}
		return resposta;
	}
	public static boolean deleteLotacoes(String[] chkCDs)
	{
		boolean resposta=false;
		if (chkCDs != null) {
			
			String sql = "";
			try {
				Conexao bd = new Conexao();
				bd.conectarAccess();
				for (int i=0; i<chkCDs.length; i++) {
					sql = "DELETE FROM lotacoes WHERE id = " + chkCDs[i] + ";";
					bd.prepareStmt();
					bd.executeUpdate(sql);
				}
				bd.desconectar();
				resposta=true;
			} catch (Exception e) {
				resposta=false;
			}
		}
		return resposta;
	}
	/*public static int deletaProdutos(String[] chkCDs)
	{
		int qt = 0;

		if (chkCDs != null) {
			
			String sql = "";
			try {
				Conexao bd = new Conexao();
				bd.conectarAccess();
				
				for (int i=0; i<chkCDs.length; i++) {
					sql = "DELETE FROM tabProdutos WHERE codigo_produto = " + chkCDs[i];
					bd.prepareStmt(sql);
					qt += bd.executeUpdate();
				}
				
				bd.desconectar();
			} catch (Exception e) {
				qt = 0;
			}
		}
		return qt;
	}
	public static int deletaCategoria(String[] chkCDs)
	{
		int qt = 0;

		if (chkCDs != null) {
			
			String sql = "";
			try {
				Conexao bd = new Conexao();
				bd.conectarAccess();
				
				for (int i=0; i<chkCDs.length; i++) {
					sql = "DELETE FROM tabCategorias WHERE codigo = " + chkCDs[i];
					bd.prepareStmt(sql);
					qt += bd.executeUpdate();
				}
				
				bd.desconectar();
			} catch (Exception e) {
				qt = 0;
			}
		}
		return qt;
	}
	*/
	
}
