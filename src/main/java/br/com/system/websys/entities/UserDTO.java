package br.com.system.websys.entities;

public class UserDTO {
	
	private String nome;
	
	private Long idTerceiro;
	
	private Long idUser;
	
	private String imagemURL;
	
	private String role;

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public Long getIdTerceiro() {
		return idTerceiro;
	}

	public void setIdTerceiro(Long idTerceiro) {
		this.idTerceiro = idTerceiro;
	}

	public Long getIdUser() {
		return idUser;
	}

	public void setIdUser(Long idUser) {
		this.idUser = idUser;
	}

	public String getImagemURL() {
		return imagemURL;
	}

	public void setImagemURL(String imagemURL) {
		this.imagemURL = imagemURL;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
} 