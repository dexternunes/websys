package br.com.system.websys.entities;

public enum ReservaStatus{

	AGUARDANDO_APROVACAO("Aguardando aprovação"),
	APROVADA("Aprovada"),
	EM_USO("Em uso"),
	ENCERRADA("Encerrada");
	
	private String descricao;

	private ReservaStatus(String descricao){
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
}