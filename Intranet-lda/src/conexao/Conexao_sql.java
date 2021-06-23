package conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class Conexao_sql {

	private Connection con = null;
	private PreparedStatement prepStmt = null;
	
	public void conectarAccess() throws Exception
	{
		try {		
			Class.forName("com.mysql.jdbc.Driver");  
			con = DriverManager.getConnection("jdbc:mysql://localhost/Banco?user=root&password=");
			
		} catch (Exception ex) {
			System.out.println("erro de conexao com o banco"+ex.getMessage());
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
	
	public int executeUpdate() throws Exception
	{
		return prepStmt.executeUpdate();
	}
	
	public ResultSet executeQuery() throws Exception {
		return prepStmt.executeQuery();
	}
	
	public ResultSet sqlSelect() throws Exception {
		return prepStmt.executeQuery();
	}
	
	public void prepareStmt(String sql) throws Exception
	{
		try {
			prepStmt = con.prepareStatement(sql);
		} catch (Exception e) {
			System.out.println("Erro no SQL...");
			e.printStackTrace();
		}
	}
	
	public PreparedStatement getPrepStmt()
	{
		return prepStmt;
	}
	
	public void finalize() throws Exception
	{
		this.desconectar();
	}
}
