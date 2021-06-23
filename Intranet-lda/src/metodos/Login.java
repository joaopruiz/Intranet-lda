package metodos;


public class Login {
	public static String imprimeLogin(Object user , Object cargo, Object funcao){
		String HTML="";
		//"<td><input type='text' value='' name='nome'/></td>";
		if(user==null){
			try {
				HTML=	"<div>"+
				"<table class='search'>"+
				"<tr>"+
					"<td>Login:</td>"+
				"</tr>"+
				"<tr>"+
					"<td><select  name='nome'>"+Util.comboboxUSUARIOSLogin()+"</option></select></td>"+
				"</tr>"+
				"</table>"+
				"</div>"+
				"<div>"+
				"<table class='search'>"+
				"<tr>"+
					"<td>Senha:</td>"+
				"</tr>"+
				"<tr>"+
					"<td><input type='password' value='' name='senha'/></td>"+
					"<td style='padding-left: 2px'><input type='image' src='img/bts/entrar2.gif' /></td>"+
				"</tr>"+
				"</table>"+
				"</div>";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
			HTML="<div>"+
			"<table class='search'>"+
			"<tr>" +
				"<td>"+
					user+
				"</td>" +
			"</tr>" +
			"<tr>" +
				"<td>"+
					cargo+
				"</td>" +
			"</tr>"+
			"<tr>" +
				"<td>"+
					funcao+
				"</td>" +
			"</tr>"+
			"</table>"+
		"</div>"+
			"<div>"+
			"<table class='search'>"+
			"<tr>"+
				"<td>&nbsp;</td>"+
			"</tr>"+
			"</table>"+
		"</div>"+
		"<div>"+
			"<table class='search'>"+
			"<tr>"+
				"<td style='padding-left: 10px'><center><a href='logout.jsp'><img src='img/bts/sair2.gif'/></a></center></td>"+
			"</tr>"+
			"</table>"+
		"</div>";
		}
		
		
		return HTML;
	}
}
