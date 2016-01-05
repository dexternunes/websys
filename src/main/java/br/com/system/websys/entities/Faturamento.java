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
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="faturamento")
public class Faturamento extends EntityBaseRoot {

	//Propriedades
	private List<Reserva> reservas = new ArrayList<Reserva>();
	
	private List<Manutencao> manutencoes = new ArrayList<Manutencao>();
	
	private List<FaturamentoRateio> faturamentoRateios = new ArrayList<FaturamentoRateio>();
	
	private Grupo grupo = new Grupo();
	
	private Double valor;
	
	
	//Gets and Sets
	@Id
	@GeneratedValue
	@Column(name = "id_faturamento")
	@Override
	public Long getId() {
		return id;
	}
	
	@ManyToMany(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE,
 			CascadeType.REFRESH }, fetch = FetchType.LAZY)
 	@JoinTable(name = "faturamento_has_manutencao", joinColumns = {
 			@JoinColumn(name = "id_faturamento", referencedColumnName = "id_faturamento") }, inverseJoinColumns = {
 					@JoinColumn(name = "id_reserva", referencedColumnName = "id_reserva") })
 	public List<Reserva> getReservas() {
		return reservas;
	}

	public void setReservas(List<Reserva> listaReservas) {
		this.reservas = listaReservas;
	}

	@ManyToMany(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE,
			 			CascadeType.REFRESH }, fetch = FetchType.LAZY)
			 	@JoinTable(name = "faturamento_has_manutencao", joinColumns = {
			 			@JoinColumn(name = "id_faturamento", referencedColumnName = "id_faturamento") }, inverseJoinColumns = {
			 					@JoinColumn(name = "id_manutencao", referencedColumnName = "id_manutencao") })
			 	
	public List<Manutencao> getManutencoes() {
		return manutencoes;
	}

	public void setManutencoes(List<Manutencao> listaManutencao) {
		this.manutencoes = listaManutencao;
	}


	 	@ManyToMany(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE,
	 			CascadeType.REFRESH }, fetch = FetchType.LAZY)
		@JoinTable(name = "faturamento_has_faturamento_rateio", joinColumns = {
	 			@JoinColumn(name = "id_faturamento", referencedColumnName = "id_faturamento") }, inverseJoinColumns = {
	 					@JoinColumn(name = "id_faturamento_rateio", referencedColumnName = "id_faturamento_rateio") })
	 	
	public List<FaturamentoRateio> getFaturamentoRateios() {
		return faturamentoRateios;
	}

	public void setFaturamentoRateios(List<FaturamentoRateio> faturamentoRateios) {
		this.faturamentoRateios = faturamentoRateios;
	}

	@OneToOne(cascade = {CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch=FetchType.EAGER)
 	@JoinColumn(name="id_grupo", referencedColumnName="id_grupo")
	public Grupo getGrupo() {
		return grupo;
	}

	public void setGrupo(Grupo grupo) {
		this.grupo = grupo;
	}

	@NotNull(message="Campo obrigatório!")
	@Column(columnDefinition="Decimal(10,2) default '0.00'")
	public Double getValor() {
		return valor;
	}

	public void setValor(Double valor) {
		this.valor = valor;
	}

}
