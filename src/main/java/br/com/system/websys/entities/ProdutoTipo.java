package br.com.system.websys.entities;

public enum ProdutoTipo{

	EMBARCACAO("Embarcação");
	
	private String descricao;

	private ProdutoTipo(String descricao){
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
}