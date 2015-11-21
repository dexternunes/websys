package br.com.system.websys.entities;

public enum ProdutoStatus{

	DISPONIVEL("Disponível"),
	EM_USO("Em uso"),
	EM_MANUTENCAO("Em manutenção");
	
	private String descricao;

	private ProdutoStatus(String descricao){
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
}