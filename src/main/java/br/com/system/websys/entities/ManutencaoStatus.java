package br.com.system.websys.entities;

public enum ManutencaoStatus{

	CONCLUIDA("CONCLUIDA", "Concluída"),
	EM_ANDAMENTO("EM_ANDAMENTO", "Em andamento");

	
	private String descricao;

	private String code;

	private ManutencaoStatus(String code, String descricao){
		this.code = code;
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