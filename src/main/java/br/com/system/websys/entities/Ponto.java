/**
 * 
 */
package br.com.system.websys.entities;

import java.util.HashMap;
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
import javax.persistence.ManyToOne;
import javax.persistence.MapKeyColumn;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name = "ponto")
public class Ponto extends EntityBaseRoot {

	private Entidade entidade;
	
	private String nome;

	private Rede rede;

	private Map<String, String> properties = new HashMap<String, String>();

	@Id
	@GeneratedValue
	@Column(name = "id_ponto")
	@Override
	public Long getId() {
		return id;
	}

	@ManyToOne(cascade = {CascadeType.DETACH, CascadeType.REFRESH}, fetch = FetchType.EAGER)
	@JoinColumn(name = "id_entidade", referencedColumnName = "id_entidade")
	public Entidade getEntidade() {
		return entidade;
	}

	public void setEntidade(Entidade entidade) {
		this.entidade = entidade;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	@ManyToOne(cascade = {CascadeType.DETACH, CascadeType.REFRESH}, fetch = FetchType.LAZY)
	@JsonBackReference
	@JoinColumn(name = "id_rede", referencedColumnName = "id_rede")
	public Rede getRede() {
		return rede;
	}

	public void setRede(Rede rede) {
		this.rede = rede;
	}

	@ElementCollection(fetch = FetchType.EAGER)
	@JoinTable(name = "ponto_properties", joinColumns = @JoinColumn(name = "id_ponto"))
	@MapKeyColumn(name = "property")
	@Column(name = "value")
	public Map<String, String> getProperties() {
		return properties;
	}

	public void setProperties(Map<String, String> properties) {
		this.properties = properties;
	}

}
