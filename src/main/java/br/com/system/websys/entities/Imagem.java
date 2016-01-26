package br.com.system.websys.entities;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="imagem")
public class Imagem extends EntityBaseRoot {

	private String uid;
	
	private Long size;
	
	private String name;
	
	private ReservaEvento reservaEvento;
	
	private String url;

	@Id
	@GeneratedValue
	@Column(name = "id_imagem")
	@Override
	public Long getId() {
		return id;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public Long getSize() {
		return size;
	}

	public void setSize(Long size) {
		this.size = size;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@ManyToOne(cascade = {CascadeType.DETACH, CascadeType.REFRESH}, fetch=FetchType.LAZY)
	@JoinColumn(name="id_reserva_evento", referencedColumnName="id_reserva_evento")
	public ReservaEvento getReservaEvento() {
		return reservaEvento;
	}

	public void setReservaEvento(ReservaEvento reservaEvento) {
		this.reservaEvento = reservaEvento;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}
