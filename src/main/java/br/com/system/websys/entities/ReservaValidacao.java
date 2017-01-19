package br.com.system.websys.entities;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

@Entity
@Table(name = "reserva_validacao")
public class ReservaValidacao extends EntityBaseRoot {

	private Reserva reserva;

	private Terceiro terceiro;

	private String uid;

	private Boolean validado = false;

	private Boolean aprovado = false;

	private String motivo;

	@Id
	@GeneratedValue
	@Column(name = "id_reserva_validacao")
	@Override
	public Long getId() {
		return id;
	}

	@OneToOne(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE,
			CascadeType.REFRESH })
	@LazyCollection(LazyCollectionOption.FALSE)
	@JoinColumn(name = "id_reserva", referencedColumnName = "id_reserva")
	public Reserva getReserva() {
		return reserva;
	}

	public void setReserva(Reserva reserva) {
		this.reserva = reserva;
	}

	@OneToOne(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE,
			CascadeType.REFRESH })
	@LazyCollection(LazyCollectionOption.FALSE)
	@JoinColumn(name = "id_terceiro", referencedColumnName = "id_terceiro")
	public Terceiro getTerceiro() {
		return terceiro;
	}

	public void setTerceiro(Terceiro terceiro) {
		this.terceiro = terceiro;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public Boolean getValidado() {
		return validado;
	}

	public void setValidado(Boolean validado) {
		this.validado = validado;
	}

	public Boolean getAprovado() {
		return aprovado;
	}

	public void setAprovado(Boolean aprovado) {
		this.aprovado = aprovado;
	}

	public String getMotivo() {
		return motivo;
	}

	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}

}
