package br.com.system.websys.entities;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name = "role")
public class Role extends EntityBaseRoot {

	private String name;

	private Set<Terceiro> terceiroRoles;

	@Id
	@GeneratedValue
	@Column(name = "id_role")
	@Override
	public Long getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public void setName(String role) {
		this.name = role;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "terceiro_has_roles", joinColumns = { @JoinColumn(name = "id_role", referencedColumnName = "id_role") }, inverseJoinColumns = { @JoinColumn(name = "id_terceiro", referencedColumnName = "id_terceiro") })
	public Set<Terceiro> getTerceiroRoles() {
		return terceiroRoles;
	}

	public void setTerceiroRoles(Set<Terceiro> terceiroRoles) {
		this.terceiroRoles = terceiroRoles;
	}
}