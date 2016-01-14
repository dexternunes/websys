package br.com.system.websys.entities;

public enum ReservaStatus{

	AGUARDANDO_APROVACAO("AGUARDANDO_APROVACAO","Aguardando aprovação"),
	APROVADA("APROVADA","Aprovada"),
	EM_USO("EM_USO","Em uso"),
	ENCERRADA("ENCERRADA","Encerrada");
	
	private String descricao;
	private String code;

	private ReservaStatus(String code, String descricao){
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	public String getCode(){
		return code;
	}
	
	public void setCode(String code){
		this.code = code;
	}
	
}