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

@Entity
@Table(name = "faturamento")
public class Faturamento extends EntityBaseRoot {

	private Grupo grupo;

	private List<FaturamentoRateio> rateio;

	private List<Manutencao> manutencoes = new ArrayList<Manutencao>();

	@Id
	@GeneratedValue
	@Column(name = "id_faturamento")
	@Override
	public Long getId() {
		return id;
	}

	@OneToOne(cascade = {CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch=FetchType.EAGER)
	@JoinColumn(name="id_grupo", referencedColumnName="id_grupo")
	public Grupo getGrupo() {
		return grupo;
	}

	public void setGrupo(Grupo grupo) {
		this.grupo = grupo;
	}

	@ManyToMany(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE,
			CascadeType.REFRESH }, fetch = FetchType.LAZY)
	@JoinTable(name = "faturamento_has_faturamento_rateio", joinColumns = {
			@JoinColumn(name = "id_faturamento", referencedColumnName = "id_faturamento") }, inverseJoinColumns = {
					@JoinColumn(name = "id_faturamento_rateio", referencedColumnName = "id_faturamento_rateio") })
	public List<FaturamentoRateio> getRateio() {
		return rateio;
	}

	public void setRateio(List<FaturamentoRateio> rateio) {
		this.rateio = rateio;
	}

	@ManyToMany(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE,
			CascadeType.REFRESH }, fetch = FetchType.LAZY)
	@JoinTable(name = "faturamento_has_manutencao", joinColumns = {
			@JoinColumn(name = "id_faturamento", referencedColumnName = "id_faturamento") }, inverseJoinColumns = {
					@JoinColumn(name = "id_manutencao", referencedColumnName = "id_manutencao") })
	public List<Manutencao> getManutencoes() {
		return manutencoes;
	}

	public void setManutencoes(List<Manutencao> manutencoes) {
		this.manutencoes = manutencoes;
	}

}
