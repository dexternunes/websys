package br.com.system.websys.entities;

public enum FaturamentoStatus{

	PENDENTE("PENDENTE", "Pendente"),
	PAGA("PAGA", "Paga");

	
	private String descricao;

	private String code;

	private FaturamentoStatus(String code, String descricao){
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