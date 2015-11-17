package br.com.system.websys.entities;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

public abstract class Entity {

	protected Long id = null;
	
	@Id
	@GeneratedValue
	@Column(name = "[ID_ENTIDADE]")	
	public abstract Long getId();
	
	public void setId(Long id) {
		this.id = id;
	}
	
	@Override
	public int hashCode() {
		
		final int prime = 31;
		int result = 1;
		
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		
		if (this == obj)
			return true;
		
		if (obj == null)
			return false;
		
		if (!this.getClass().isAssignableFrom(obj.getClass()))
	        return false;
		
		EntityBaseRoot other = (EntityBaseRoot) obj;
		
		if (this.getId() == null)
			return false;
		
		if (!this.getId().equals(other.getId()))
			return false;
		
		return true;
	}
}