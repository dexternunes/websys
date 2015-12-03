package br.com.system.websys.entities;

public enum ProdutoStatus{

	A_VENDA("A_VENDA", "A Venda"),
	DISPONIVEL("DISPONIVEL", "Disponível"),
	EM_USO("EM_USO", "Em uso"),
	EM_MANUTENCAO("EM_MANUTENCAO", "Em manutenção"),
	INATIVO("INATIVO", "Inativo");

	
	private String descricao;

	private String code;

	private ProdutoStatus(String code, String descricao){
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