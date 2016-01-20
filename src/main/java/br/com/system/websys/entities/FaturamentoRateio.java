package br.com.system.websys.entities;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.codehaus.jackson.annotate.JsonManagedReference;

@Entity
@Table(name="faturamento_rateio")
public class FaturamentoRateio extends EntityBaseRoot  {


	private Double valor;
	private Terceiro terceiro = new Terceiro();
	private Faturamento faturamento = new Faturamento();
	
	
	@OneToOne(cascade = {CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch=FetchType.EAGER)
	@JoinColumn(name="id_faturamento", referencedColumnName="id_faturamento")
	@JsonManagedReference
	public Faturamento getFaturamento() {
		return faturamento;
	}

	public void setFaturamento(Faturamento faturamento) {
		this.faturamento = faturamento;
	}

	@Id
	@GeneratedValue
	@Column(name = "id_faturamento_rateio")
	@Override
	public Long getId() {
		return id;
	}
	@OneToOne(cascade = {CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch=FetchType.EAGER)
	@JoinColumn(name="id_terceiro", referencedColumnName="id_terceiro")
	public Terceiro getTerceiro() {
		return terceiro;
	}

	public void setTerceiro(Terceiro terceiro) {
		this.terceiro = terceiro;
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
