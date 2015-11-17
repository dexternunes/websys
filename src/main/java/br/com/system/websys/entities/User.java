package br.com.system.websys.entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity 
@Table(name="user")
public class User extends EntityBaseRoot {
	
	private String login;
	
	private String nome;
	
	private String authCode;
	
	private String token;
	
	private Boolean admin;
	
	private Terceiro terceiro;
	
	public List<Entidade> entidadesPermitidas;

	@Id
	@GeneratedValue
	@Column(name = "id_user")	
	@Override
	public Long getId() {
		return id;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	@Column(name = "auth_code")
	public String getAuthCode() {
		return authCode;
	}

	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}

	@NotNull
	@Column(name = "access_token")
	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Boolean getAdmin() {
		return admin;
	}

	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}

	@NotNull
	@OneToOne(cascade = {CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch=FetchType.EAGER)
	@JoinColumn(name="id_terceiro", referencedColumnName="id_terceiro")
	public Terceiro getTerceiro() {
		return terceiro;
	} 

	public void setTerceiro(Terceiro terceiro) {
		this.terceiro = terceiro;
	}

	@ManyToMany(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH }, fetch = FetchType.LAZY)
	@JoinTable(name = "usuario_has_entidade", 
		joinColumns = { @JoinColumn(name = "id_user", referencedColumnName = "id_user") }, 
		inverseJoinColumns = { @JoinColumn(name = "id_entidade", referencedColumnName = "id_entidade") })
	public List<Entidade> getEntidadesPermitidas() {
		return entidadesPermitidas;
	}

	public void setEntidadesPermitidas(List<Entidade> entidadesPermitidas) {
		this.entidadesPermitidas = entidadesPermitidas;
	}

}