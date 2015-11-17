package br.com.system.websys.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@MappedSuperclass
public abstract class EntityBaseRoot extends Entity {

	protected Date created;
	
    protected Date updated;

    @PrePersist
    protected void onCreate() {
    	updated = created = new Date();
    }

    @PreUpdate
    protected void onUpdate() {
    	updated = new Date();
    	
    	if(created == null)
    		created = updated;
    }

	@Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created", nullable = false)
	public Date getCreated() {
		return created;
	}

	protected void setCreated(Date created) {
		this.created = created;
	}

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated", nullable = false)
	public Date getUpdated() {
		return updated;
	}

	protected void setUpdated(Date updated) {
		this.updated = updated;
	}
}
