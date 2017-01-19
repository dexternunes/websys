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

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

import br.com.system.websys.serializer.JsonDateTimeDeserializer;
import br.com.system.websys.serializer.JsonDateTimeSerializer;


@Entity 
@Table(name="manutencao")
public class Manutencao extends EntityBaseRoot {
	
	private ManutencaoStatus status;
	

	@NotNull(message="Campo obrigatório!")
	@NotEmpty(message="Campo obrigatório!")
	private String obs = "";
	

	@NotNull(message="Campo obrigatório!")
	@Column(columnDefinition="Decimal(10,2) default '0.00'")
	private Double valor;
	

	@DateTimeFormat(pattern="dd/MM/YYYY hh:mm")
	@NotNull(message="Campo obrigatório!")
	private Date inicioManutencao;
	
	@DateTimeFormat(pattern="dd/MM/YYYY hh:mm")
	private Date fimManutencao;

	private Produto produto;
	
	@Id
	@GeneratedValue
	@Column(name = "id_manutencao")	
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

	@JsonSerialize( using=JsonDateTimeSerializer.class)
	public Date getInicioManutencao() {
		return inicioManutencao;
	}

	@JsonDeserialize( using=JsonDateTimeDeserializer.class)
	public void setInicioManutencao(Date inicioManutencao) {
		this.inicioManutencao = inicioManutencao;
	}

	@JsonSerialize( using=JsonDateTimeSerializer.class)
	public Date getFimManutencao() {
		return fimManutencao;
	}
	
	@JsonDeserialize( using=JsonDateTimeDeserializer.class)
	public void setFimManutencao(Date fimManutencao) {
		this.fimManutencao = fimManutencao;
	}

	@ManyToOne(cascade = {CascadeType.DETACH, CascadeType.REFRESH})
	@JoinColumn(name="id_produto", referencedColumnName="id_produto")
	@LazyCollection(LazyCollectionOption.TRUE)
	public Produto getProduto() {
		return produto;
	}

	public void setProduto(Produto produto) {
		this.produto = produto;
	}
			
}