package br.com.system.websys.entities;

public enum ReservaValidacaoStatus{

	OK(0, "Solicitação registrada com sucesso!"),
	OK_RESERVA(0,"Solicitação registrada com sucesso!"),
	OK_DUPLICADO(0,"Solicitação registrada com sucesso!"),
	DIAS_CONSECUTIVOS(1, "Esse tipo de solicitação deve ser feita com 7 dias de antecedência!"),
	DIA_UNICO(1, "Esse tipo de solicitação deve ser feita com 24 horas de antecedência!"),
	DIA_UNICO_RESERVA(1,"Esse tipo de solicitação dever ser feita com 1 hora de antecedência!"),
	EXISTE_RESERVA(1,"Já existe uma reserva para a data solicitada!"),
	ERRO(2, "Ocorreu um erro. Favor reportar com o codigo de erro:88");

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