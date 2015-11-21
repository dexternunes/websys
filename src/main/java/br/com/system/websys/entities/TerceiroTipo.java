package br.com.system.websys.entities;

public enum TerceiroTipo{

	CLIENTE("Cliente"),
	FUNCIONARIO("Funcionario");
	
	private String descricao;

	private TerceiroTipo(String descricao){
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
}