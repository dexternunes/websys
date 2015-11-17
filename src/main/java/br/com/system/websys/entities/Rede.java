/**
 * 
 */
package br.com.system.websys.entities;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.MapKeyColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;

import br.com.system.websys.entities.EntityBaseRoot;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "rede", uniqueConstraints = {
		@UniqueConstraint(name = "un_rede_login", columnNames = { "login" }),
		@UniqueConstraint(name = "un_rede_documento", columnNames = { "documento" }) })
public class Rede extends EntityBaseRoot {

	private String nome;

	private String documento;

	private String login;

	private String senha;

	private List<Ponto> pontos = new ArrayList<Ponto>();

	private Map<String, String> properties = new HashMap<String, String>();

	@Id
	@GeneratedValue
	@Column(name = "id_rede")
	@Override
	public Long getId() {

		return id;
	}

	@NotNull
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public String getDocumento() {
		return documento;
	}

	public void setDocumento(String documento) {
		this.documento = documento;
	}

	@NotNull
	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	@NotNull
	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	@JsonManagedReference
	@OneToMany(mappedBy = "rede", cascade = {CascadeType.DETACH, CascadeType.REFRESH}, fetch=FetchType.EAGER)
	public List<Ponto> getPontos() {
		return pontos;
	}

	public void setPontos(List<Ponto> pontos) {
		this.pontos = pontos;
	}

	@ElementCollection(fetch = FetchType.EAGER)
	@JoinTable(name = "rede_properties", joinColumns = @JoinColumn(name = "id_rede"))
	@MapKeyColumn(name = "property")
	@Column(name = "value")
	public Map<String, String> getProperties() {
		return properties;
	}

	public void setProperties(Map<String, String> properties) {
		this.properties = properties;
	}
}
