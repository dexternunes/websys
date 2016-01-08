package br.com.system.websys.entities;

import java.beans.Transient;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

@Entity 
@Table(name="user")
public class User extends EntityBaseRoot {
	
	@NotNull(message="Campo obrigatório!")
	@NotEmpty(message="Campo obrigatório!")
	private String login;
	

	@NotNull(message="Campo obrigatório!")
	@NotEmpty(message="Campo obrigatório!")
	private String senha;
	
	private String confirmarSenha;
	
	private Terceiro terceiro;
	
	private Role role;
	
	private String uidRecurerarSenha;
	
	private Boolean ativo = true;
	
	private Boolean excluido = false;
	
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
	
	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	@Transient
	public String getConfirmarSenha() {
		return confirmarSenha;
	}

	public void setConfirmarSenha(String confirmarSenha) {
		this.confirmarSenha = confirmarSenha;
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

	@Enumerated(EnumType.STRING)
	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getUidRecurerarSenha() {
		return uidRecurerarSenha;
	}

	public void setUidRecurerarSenha(String uidRecurerarSenha) {
		this.uidRecurerarSenha = uidRecurerarSenha;
	}

	public Boolean getAtivo() {
		return ativo;
	}

	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}

	public Boolean getExcluido() {
		return excluido;
	}

	public void setExcluido(Boolean excluido) {
		this.excluido = excluido;
	}
			
}