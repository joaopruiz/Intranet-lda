package conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;


public class Conexao {

	private Connection con = null;
	private Statement prepStmt = null;
	
	public void conectarAccess() throws Exception
	{
		try {		
			Class.forName("org.postgresql.Driver");  
			//con = DriverManager.getConnection("jdbc:postgresql://10.1.1.17:5432/Banco", "jpruiz" , "jpruiz");
			
			con = DriverManager.getConnection("jdbc:postgresql://34.95.202.122:5432/Banco", "postgres" , "ucmcwb18");
		} catch (Exception ex) {
			System.out.println("Erro de conexao com o banco.....");
			//+ex.getMessage());
			throw ex;
		}
	}
	
	public void desconectar() throws Exception 
	{
		if (con != null) {
			con.close();
			con = null;
			System.out.println("conexao finalizada...");
		}
	}
	
	public int executeUpdate(String sql) throws Exception
	{
		return prepStmt.executeUpdate(sql);
	}
	
	public ResultSet executeQuery(String sql) throws Exception {
		return prepStmt.executeQuery(sql);
	}
	
	public void prepareStmt() throws Exception
	{	
		prepStmt = con.createStatement();				
	}
	
	public Statement getPrepStmt()
	{
		return prepStmt;
	}
	
	public void finalize() throws Exception
	{
		this.desconectar();
	}
}
