package br.com.system.websys.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="terceiro")
public class Terceiro extends EntityBaseRoot {

	private String nome;
	
	private String documento;
	
	private List<TerceiroEndereco> enderecos = new ArrayList<TerceiroEndereco>();
	
	private List<TerceiroContato> contatos = new ArrayList<TerceiroContato>();
	
	private List<TerceiroTipo> tipos = new ArrayList<TerceiroTipo>(); 
	
	private Boolean ativo = true;
	
	private Boolean excluido = false;
	
	private List<String> emails = new ArrayList<String>();
	
	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Column(name = "id_terceiro")
	@Override
	public Long getId() {
		return id;
	}

	@NotNull(message="{notnull}")
	@NotEmpty(message="{min.error}")	
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	@NotNull(message="{notnull}")
	@NotEmpty(message="{Informar o documento!}")
	public String getDocumento() {
		return documento;
	}

	public void setDocumento(String documento) {
		this.documento = documento;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="terceiro")
	public List<TerceiroEndereco> getEnderecos() {
		return enderecos;
	}

	public void setEnderecos(List<TerceiroEndereco> enderecos) {
		this.enderecos = enderecos;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="terceiro")
	public List<TerceiroContato> getContatos() {
		return contatos;
	}

	public void setContatos(List<TerceiroContato> contatos) {
		this.contatos = contatos;
	}
	
	@ElementCollection(targetClass=TerceiroTipo.class)
	@Enumerated(EnumType.STRING)
	@CollectionTable(name = "terceiro_tipo", joinColumns = @JoinColumn(name = "id_terceiro"))
	public List<TerceiroTipo> getTipos() {
		return tipos;
	}

	public void setTipos(List<TerceiroTipo> tipos) {
		this.tipos = tipos;
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

	@ElementCollection(targetClass=String.class)
	@CollectionTable(name = "terceiro_email", joinColumns = @JoinColumn(name = "id_terceiro"))
	@NotNull(message="{notnull}")
	@NotEmpty(message="{Informar um email válido!}")
	@Email(message="Informar um email válido!")
	public List<String> getEmails() {
		return emails;
	}

	public void setEmails(List<String> emails) {
		this.emails = emails;
	}

}
