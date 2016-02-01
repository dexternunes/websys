package br.com.system.websys.entities;

public enum ReservaValidacaoStatus{

	DIAS_CONSECUTIVOS("Esse tipo de solicitação deve ser feita com 7 dias de antecedência!"),
	DIA_UNICO("Esse tipo de solicitação deve ser feita com 24 horas de antecedência!"),
	OK("Solicitação registrada com sucesso!");
	
	private String descricao;

	private ReservaValidacaoStatus(String descricao){
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}	
}