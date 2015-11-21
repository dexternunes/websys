package br.com.system.websys.entities;

public enum EnderecoTipo{

	RESIDENCIAL("Residencial"),
	COMERCIAL("Comercial"),
	OUTRO("Outro");
	
	private String descricao;

	private EnderecoTipo(String descricao){
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
}