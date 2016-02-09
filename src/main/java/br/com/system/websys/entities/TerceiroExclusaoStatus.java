package br.com.system.websys.entities;

public enum TerceiroExclusaoStatus{

	OK(0, "Terceiro exclu�do com sucesso!"),
	TERCEIRO_USUARIO(1,"Este terceiro est� vinculado a um usuario, favor realizar a exclus�o do usu�rio!"),
	TERCEIRO_GRUPO(2, "Este terceiro est� vinculado a um grupo, favor realizar a exclus�o do grupo!");

	private String descricao;
	private int code;

	private TerceiroExclusaoStatus(int code, String descricao){
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