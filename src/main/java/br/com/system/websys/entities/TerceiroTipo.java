package br.com.system.websys.entities;

public enum TerceiroTipo{

	CLIENTE("CLIENTE", "Cliente"),
	FUNCIONARIO("FUNCIONARIO","Funcionario");
	
	private String descricao;
	private String code;

	private TerceiroTipo(String code, String descricao){
		this.descricao = descricao;
		this.code = code;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	public String getCode(){
		return code;
	}
	
	public void setCode(String code){
		this.code = code;
	}
}