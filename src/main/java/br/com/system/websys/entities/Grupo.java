package br.com.system.websys.entities;

import java.util.ArrayList;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="grupo")
public class Grupo extends EntityBaseRoot {

	private String descricao;
	
	private List<Terceiro> terceiros = new ArrayList<Terceiro>();
	
	private List<Produto> produtos = new ArrayList<Produto>();
	
	private List<Reserva> reservas = new ArrayList<Reserva>();
	
	private List<Terceiro> marinheiros = new ArrayList<Terceiro>();
	
	private Boolean ativo = true;
	
	private Boolean excluido = false;
	
	private String color;
	
	@Id
	@GeneratedValue
	@Column(name = "id_grupo")
	@Override
	public Long getId() {
		return id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	@NotEmpty(message = "Selecione um cotista")
	@ManyToMany(cascade = {CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH})
	@JoinTable(name="grupo_has_terceiros", 
		joinColumns = {@JoinColumn(name="id_grupo", referencedColumnName="id_grupo")},
		inverseJoinColumns = {@JoinColumn(name="id_terceiro", referencedColumnName="id_terceiro")}
	)
	public List<Terceiro> getTerceiros() {
		return terceiros;
	}

	public void setTerceiros(List<Terceiro> terceiros) {
		this.terceiros = terceiros;
	}

	@NotEmpty(message = "Selecione um produto")
	@ManyToMany(cascade = {CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH})
	@JoinTable(name="grupo_has_produtos", 
		joinColumns = {@JoinColumn(name="id_grupo", referencedColumnName="id_grupo")},
		inverseJoinColumns = {@JoinColumn(name="id_produto", referencedColumnName="id_produto")}
	)
	public List<Produto> getProdutos() {
		return produtos;
	}

	public void setProdutos(List<Produto> produtos) {
		this.produtos = produtos;
	}
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy="grupo")
	public List<Reserva> getReservas() {
		return reservas;
	}

	public void setReservas(List<Reserva> reservas) {
		this.reservas = reservas;
	}
	
	@NotEmpty(message = "Selecione um marinheiro")
	@ManyToMany(cascade = {CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH})
	@JoinTable(name="grupo_has_marinheiros", 
		joinColumns = {@JoinColumn(name="id_grupo", referencedColumnName="id_grupo")},
		inverseJoinColumns = {@JoinColumn(name="id_terceiro", referencedColumnName="id_terceiro")}
	)
	public List<Terceiro> getMarinheiros() {
		return marinheiros;
	}

	public void setMarinheiros(List<Terceiro> marinheiros) {
		this.marinheiros = marinheiros;
	}

	public Boolean getExcluido() {
		return excluido;
	}

	public void setExcluido(Boolean excluido) {
		this.excluido = excluido;
	}

	public Boolean getAtivo() {
		return ativo;
	}

	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

}
