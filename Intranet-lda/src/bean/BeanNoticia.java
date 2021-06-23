package bean;

public class BeanNoticia {
	private int nome=0;
	private String titulo="";
	private String descricao="";
	private String data="";
	private String id="";
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getExpira() {
		return expira;
	}
	public void setExpira(String expira) {
		this.expira = expira;
	}
	private String expira="";
	
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public int getNome() {
		return nome;
	}
	public void setNome(int nome) {
		this.nome = nome;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
}
