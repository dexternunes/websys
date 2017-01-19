package br.com.system.websys.entities;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

@Entity
@Table(name="terceiro_endereco")
public class TerceiroEndereco extends EntityBaseRoot {

	private Terceiro terceiro;
	
	private EnderecoTipo tipoEndereco;
	
	private String endereco;
	
	private String numero;
	
	private String bairro;
	
	private String cidade;
	
	private String estado;
	
	private String pais;
	
	@Id
	@GeneratedValue
	@Column(name = "id_terceiro_endereco")
	@Override
	public Long getId() {
		return id;
	}

	@ManyToOne(cascade = {CascadeType.DETACH, CascadeType.REFRESH})
	@JoinColumn(name="id_terceiro", referencedColumnName="id_terceiro")
	@LazyCollection(LazyCollectionOption.TRUE)
	public Terceiro getTerceiro() {
		return terceiro;
	}

	public void setTerceiro(Terceiro terceiro) {
		this.terceiro = terceiro;
	}

	@Enumerated(EnumType.STRING)
	public EnderecoTipo getTipoEndereco() {
		return tipoEndereco;
	}

	public void setTipoEndereco(EnderecoTipo tipoEndereco) {
		this.tipoEndereco = tipoEndereco;
	}

	public String getEndereco() {
		return endereco;
	}

	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}

	public String getNumero() {
		return numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}

	public String getBairro() {
		return bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getPais() {
		return pais;
	}

	public void setPais(String pais) {
		this.pais = pais;
	}
		
}
