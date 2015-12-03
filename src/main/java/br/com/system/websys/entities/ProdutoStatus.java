package br.com.system.websys.entities;

public enum ProdutoStatus{

	DISPONIVEL("DISPONIVEL", "Disponível"),
	EM_USO("EM_USO", "Em uso"),
	EM_MANUTENCAO("EM_MANUTENCAO", "Em manutenção");
	
	private String descricao;
	private String code;

	private ProdutoStatus(String code, String descricao){
		this.descricao = descricao;
		this.code = code;
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