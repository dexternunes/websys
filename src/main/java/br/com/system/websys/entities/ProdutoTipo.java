package br.com.system.websys.entities;

public enum ProdutoTipo{

	EMBARCACAO("EMBARCACAO", "Embarcação");
	
	private String code;
	
	private String descricao;

	private ProdutoTipo(String code, String descricao){
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
}