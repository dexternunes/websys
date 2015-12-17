package br.com.system.websys.entities;

import java.util.Date;

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
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;


@Entity 
@Table(name="manutencao")
public class Manutencao extends EntityBaseRoot {
	
	private ManutencaoStatus status;
	

	@NotNull(message="Campo obrigatório!")
	@NotEmpty(message="Campo obrigatório!")
	private String obs = "";
	

	@NotNull(message="Campo obrigatório!")
	private Double valor;
	

	@NotNull(message="Campo obrigatório!")
	private Date inicioManutencao;
	

	private Date fimManutencao;

	private Produto produto;
	
	@Id
	@GeneratedValue
	@Column(name = "id_user")	
	@Override
	public Long getId() {
		return id;
	}

	@Enumerated(EnumType.STRING)
	public ManutencaoStatus getStatus() {
		return status;
	}

	public void setStatus(ManutencaoStatus status) {
		this.status = status;
	}

	public String getObs() {
		return obs;
	}

	public void setObs(String obs) {
		this.obs = obs;
	}

	public Double getValor() {
		return valor;
	}

	public void setValor(Double valor) {
		this.valor = valor;
	}

	public Date getInicioManutencao() {
		return inicioManutencao;
	}

	public void setInicioManutencao(Date inicioManutencao) {
		this.inicioManutencao = inicioManutencao;
	}

	public Date getFimManutencao() {
		return fimManutencao;
	}

	public void setFimManutencao(Date fimManutencao) {
		this.fimManutencao = fimManutencao;
	}

	@ManyToOne(cascade = {CascadeType.DETACH, CascadeType.REFRESH}, fetch=FetchType.LAZY)
	@JoinColumn(name="id_produto", referencedColumnName="id_produto")
	public Produto getProduto() {
		return produto;
	}

	public void setProduto(Produto produto) {
		this.produto = produto;
	}
			
}