package br.com.system.websys.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

@Entity 
@Table(name="produto")
public class Produto extends EntityBaseRoot {
	
	@NotNull(message="Campo obrigatório!")
	@NotEmpty(message="Campo obrigatório!")
	private String descricao;
	

	@NotNull(message="Campo obrigatório!")
	@NotEmpty(message="Campo obrigatório!")
	private String marca;
	

	@NotNull(message="Campo obrigatório!")
	@NotEmpty(message="Campo obrigatório!")
	private String modelo;
	

	@Column(columnDefinition="Decimal(10,2) default '0.00'")
	private Double comprimento;

	@Column(columnDefinition="Decimal(10,2) default '0.00'")
	private Double largura;

	@Column(columnDefinition="Decimal(10,2) default '0.00'")
	private Double altura;
	

	private ProdutoTipo tipoProduto;
	
	private ProdutoStatus status;
	
	@Id
	@GeneratedValue
	@Column(name = "id_produto")	
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

	public String getMarca() {
		return marca;
	}

	public void setMarca(String marca) {
		this.marca = marca;
	}

	public String getModelo() {
		return modelo;
	}

	public void setModelo(String modelo) {
		this.modelo = modelo;
	}



	public Double getComprimento() {
		return comprimento;
	}

	public void setComprimento(Double comprimento) {
		this.comprimento = comprimento;
	}

	public Double getLargura() {
		return largura;
	}

	public void setLargura(Double largura) {
		this.largura = largura;
	}

	public Double getAltura() {
		return altura;
	}

	public void setAltura(Double altura) {
		this.altura = altura;
	}

	@Enumerated(EnumType.STRING)
	public ProdutoTipo getTipoProduto() {
		return tipoProduto;
	}

	public void setTipoProduto(ProdutoTipo tipoProduto) {
		this.tipoProduto = tipoProduto;
	}

	@Enumerated(EnumType.STRING)
	public ProdutoStatus getStatus() {
		return status;
	}

	public void setStatus(ProdutoStatus status) {
		this.status = status;
	}
				
}