package br.com.system.websys.entities;

public enum ReservaValidacaoStatus{

	OK(0, "Solicitação registrada com sucesso!"),
	OK_RESERVA(1,"Solicitação registrada com sucesso!"),
	DIAS_CONSECUTIVOS(2, "Esse tipo de solicitação deve ser feita com 7 dias de antecedência!"),
	DIA_UNICO(3, "Esse tipo de solicitação deve ser feita com 24 horas de antecedência!"),
	DIA_UNICO_RESERVA(4,"Esse tipo de solicitação dever ser feita com 2 horas de antecedência!"),
	ERRO(5, "Ocorreu um erro. Favor reportar com o codigo de erro:88");

	private String descricao;
	private int code;

	private ReservaValidacaoStatus(int code, String descricao){
		this.code = code;
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}	
}