package br.com.system.websys.entities;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.springframework.util.StringUtils;

@Entity
@Table(name="terceiro")
public class Terceiro extends EntityBaseRoot {

	private String nome;
	
	private String documento;
	
	private String ie;
	
	private String rg;
	
	private Boolean ativo;
	
	private String nomeFantasia;
	
	private List<String> emails = new ArrayList<String>();
	
	private Set<Role> roles;
	
	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Column(name = "id_terceiro")
	@Override
	public Long getId() {
		return id;
	}

	@NotNull(message="{notnull}") 
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDocumento() {
		return documento;
	}

	public void setDocumento(String documento) {
		this.documento = documento;
	}
	
	public String getIe() {
		
		if(StringUtils.isEmpty(this.ie))
			return "ISENTO";
		
		return ie;
	}

	public void setIe(String ie) {
		this.ie = ie;
	}

	public String getRg() {
		return rg;
	}

	public void setRg(String rg) {
		this.rg = rg;
	}

	public Boolean getAtivo() {
		return ativo;
	}

	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}

	public String getNomeFantasia() {
		return nomeFantasia;
	}

	public void setNomeFantasia(String nomeFantasia) {
		this.nomeFantasia = nomeFantasia;
	}

	@ElementCollection(targetClass=String.class)
	@CollectionTable(name = "terceiro_email", joinColumns = @JoinColumn(name = "id_terceiro"))
	public List<String> getEmails() {
		return emails;
	}

	public void setEmails(List<String> emails) {
		this.emails = emails;
	}

	@ManyToMany(cascade = {CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch=FetchType.LAZY)
	@JoinTable(name="terceiro_has_roles", 
		joinColumns = {@JoinColumn(name="id_terceiro", referencedColumnName="id_terceiro")},
		inverseJoinColumns = {@JoinColumn(name="id_role", referencedColumnName="id_role")}
	)
	public Set<Role> getRoles() {
		
		if(roles == null)
			roles = new HashSet<Role>();
		
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
}
