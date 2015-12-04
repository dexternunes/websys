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
	

	@NotNull(message="Campo obrigatório!")
	private Long comprimento;

	@NotNull(message="Campo obrigatório!")
	private Long largura;


	@NotNull(message="Campo obrigatório!")
	private Long altura;
	

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

	public Long getComprimento() {
		return comprimento;
	}

	public void setComprimento(Long comprimento) {
		this.comprimento = comprimento;
	}

	public Long getLargura() {
		return largura;
	}

	public void setLargura(Long largura) {
		this.largura = largura;
	}

	public Long getAltura() {
		return altura;
	}

	public void setAltura(Long altura) {
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