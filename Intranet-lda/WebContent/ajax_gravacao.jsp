<% // Importação de Classes Java %>

<%@ page import = "java.sql.*" %>
<%@ page import = "java.text.*" %>
<%@ page import = "java.util.*" %>

<% // Variáveis da conexão com o banco de dados %>


<%
    String url1 = "jdbc:mysql://localhost/projeto2";
    String usuario = "mysql";
    String senha = "mysql";
    Connection con = null;
    ResultSet sqlretorno1 = null;
    Statement sqlconsulta1 = null;
    ResultSet sqlretorno2 = null;
    Statement sqlconsulta2 = null;
    Statement SQLS = null;

    // conexão ao banco de dados
    Class.forName("org.gjt.mm.mysql.Driver").newInstance();
    con = DriverManager.getConnection( url1, usuario, senha);
    sqlconsulta1 = con.createStatement();
    sqlconsulta2 = con.createStatement();
    SQLS = con.createStatement();



//Parâmetros recuperados do Ajax
String login = request.getParameter("login");
String senha1 = request.getParameter("senha");
String nome = request.getParameter("nome");
String endereco = request.getParameter("endereco");
String telefone = request.getParameter("telefone");
String cidade = request.getParameter("cidade");




%>


<%  String consulta_2 = "";
    consulta_2 = "insert into geral2 (nome, endereco, telefone, cidade, login, senha) values ('"+nome+"', '"+endereco+"', '"+telefone+"', '"+cidade+"', '"+login+"', '"+senha1+"') ";

    sqlconsulta2.executeUpdate(consulta_2);
    //Este comando devolverá "Dados inseridos com Sucesso para" o Ajax.
    out.println("Dados inseridos com Sucesso!!!");
%>

<% con.close(); %>

<%// Note que, após a inserção, a página não redireciona para nenhuma página.%> 