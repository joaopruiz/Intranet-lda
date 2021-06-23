package metodos;

import bean.Bean;

public class Autentica {
	static public boolean validaNome(Bean usuario) throws Exception {
		String sub = usuario.getNome();
		boolean flag=true;
		int i=0;
			while(true){
				if(i>=sub.length()){
					break;
				}
				char aux = sub.charAt(i);
				if(!Character.isLetterOrDigit(aux)){
					flag=false;
					break;
				}else{
					flag=true;
				}
				i++;
			}
			if(flag==true){
				return true;
			}else{
				return false;
			}
	}
	static public boolean validaRamal(Bean usuario) throws Exception {
		String sub = usuario.getRamal();
		boolean flag=true;
		int i=0;
			while(true){
				if(i>=sub.length()){
					break;
				}
				char aux = sub.charAt(i);
				if(!Character.isDigit(aux)){
					flag=true;
				}else{
					flag=false;
					break;
				}
				i++;
			}
			
		if(flag==true){
			return true;
		}else{
			return false;
		}
	}
	static public boolean validaTelcasa(Bean usuario) throws Exception {
		String sub = usuario.getTelcasa();
		boolean flag=true;
		int i=0;
			while(true){
				if(i>=sub.length()){
					break;
				}
				char aux = sub.charAt(i);
				if(!Character.isDigit(aux)){
					flag=true;
				}else{
					flag=false;
					break;
				}
				i++;
			}
			
		if(flag==true){
			return true;
		}else{
			return false;
		}
	}
	static public boolean validaCel1(Bean usuario) throws Exception {
		String sub = usuario.getCel1();
		boolean flag=true;
		int i=0;
			while(true){
				if(i>=sub.length()){
					break;
				}
				char aux = sub.charAt(i);
				if(!Character.isDigit(aux)){
					flag=true;
				}else{
					flag=false;
					break;
				}
				i++;
			}
			
		if(flag==true){
			return true;
		}else{
			return false;
		}
	}
	static public boolean validaCel2(Bean usuario) throws Exception {
		String sub = usuario.getMatricula();
		boolean flag=true;
		int i=0;
			while(true){
				if(i>=sub.length()){
					break;
				}
				char aux = sub.charAt(i);
				if(!Character.isDigit(aux)){
					flag=true;
				}else{
					flag=false;
					break;
				}
				i++;
			}
			
		if(flag==true){
			return true;
		}else{
			return false;
		}
	}
	static public boolean validaMatricula(Bean usuario) throws Exception {
		String sub = usuario.getMatricula();
		boolean flag=true;
		int i=0;
			while(true){
				if(i>=sub.length()){
					break;
				}
				char aux = sub.charAt(i);
				if(!Character.isDigit(aux)){
					flag=true;
				}else{
					flag=false;
					break;
				}
				i++;
			}
			
		if(flag==true){
			return true;
		}else{
			return false;
		}
	}
	static public boolean validaCargahoraria(Bean usuario) throws Exception {
		String sub = usuario.getCargahoraria();
		boolean flag=true;
		int i=0;
			while(true){
				if(i>=sub.length()){
					break;
				}
				char aux = sub.charAt(i);
				if(!Character.isDigit(aux)){
					flag=true;
				}else{
					flag=false;
					break;
				}
				i++;
			}
			
		if(flag==true){
			return true;
		}else{
			return false;
		}
	}
	static public boolean autenticaNome(Bean usuario) throws Exception {
			if (usuario.getNome().equals(Util.selectNome(usuario.getNome()))){
				return true;
			}else{
				return false;
			}
	}
	static public boolean autenticaCPF(Bean usuario) throws Exception {
		int tt=0;
		if (tt==0){
			return true;
		}else{
			return false;
		}
}
	static public boolean validaSenha(Bean usuario) throws Exception {
		String sub = usuario.getSenha();
		boolean flag=true;
		int i=0;
		while(true){
			if(i>=sub.length()){
				break;
			}
			char aux = sub.charAt(i);
			if(!Character.isLetterOrDigit(aux)){
				flag=false;
				break;
			}else{
				flag=true;
			}
			i++;
		}
		if(flag==true){
			return true;
		}else{
			return false;
		}
	}
	static public boolean autenticaSenha(Bean usuario) throws Exception {
		if (usuario.getSenha().equals(Util.selectSenha(usuario.getNome()))){
			return true;
		}else{
			return false;		
		}
}
static public int validaFuncao(Bean usuario) throws Exception {
	int d=Util.selectFuncao(usuario.getNome());
	return d;
	
}
static public String Cargo(Bean usuario) throws Exception {
	String cargo="";
	cargo = Util.Cargo(Util.selectCargo(usuario.getNome()));	
	return cargo;
}
static public String Funcao(Bean usuario) throws Exception {
	String funcao="";
	funcao = Util.Funcao(Util.selectFuncao(usuario.getNome()));	
	return funcao;
}
static public String id_Usuario(Bean usuario) throws Exception {
	String id_usuario="";
	id_usuario = Integer.toString(Util.retornaID(usuario.getNome()));	
	return id_usuario;
}
}