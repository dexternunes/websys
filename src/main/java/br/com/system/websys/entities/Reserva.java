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
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "reserva")
public class Reserva extends EntityBaseRoot {

	private Terceiro solicitante;

	private Grupo grupo;

	private Date inicioReserva;

	private Date fimReserva;

	private ReservaStatus status;

	private Boolean ativo = true;

	private Boolean excluido = false;

	private ReservaEvento eventoInicio;

	private ReservaEvento eventoFim;

	private Boolean utilizaMarinheiro = false;

	private String obs;

	@Id
	@GeneratedValue
	@Column(name = "id_reserva")
	@Override
	public Long getId() {
		return id;
	}

	@ManyToOne(cascade = { CascadeType.DETACH, CascadeType.REFRESH }, fetch = FetchType.LAZY)
	@JoinColumn(name = "id_terceiro", referencedColumnName = "id_terceiro")
	public Terceiro getSolicitante() {
		return solicitante;
	}

	public void setSolicitante(Terceiro solicitante) {
		this.solicitante = solicitante;
	}

	@ManyToOne(cascade = { CascadeType.DETACH, CascadeType.REFRESH }, fetch = FetchType.LAZY)
	@JoinColumn(name = "id_grupo", referencedColumnName = "id_grupo")
	public Grupo getGrupo() {
		return grupo;
	}

	public void setGrupo(Grupo grupo) {
		this.grupo = grupo;
	}

	public Date getInicioReserva() {
		return inicioReserva;
	}

	public void setInicioReserva(Date inicioReserva) {
		this.inicioReserva = inicioReserva;
	}

	public Date getFimReserva() {
		return fimReserva;
	}

	public void setFimReserva(Date fimReserva) {
		this.fimReserva = fimReserva;
	}

	@Enumerated(EnumType.STRING)
	public ReservaStatus getStatus() {
		return status;
	}

	public void setStatus(ReservaStatus status) {
		this.status = status;
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

	public Boolean getUtilizaMarinheiro() {
		return utilizaMarinheiro;
	}

	public void setUtilizaMarinheiro(Boolean utilizaMarinheiro) {
		this.utilizaMarinheiro = utilizaMarinheiro;
	}

	public String getObs() {
		return obs;
	}

	public void setObs(String obs) {
		this.obs = obs;
	}

	@OneToOne(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE,
			CascadeType.REFRESH }, fetch = FetchType.EAGER)
	@JoinColumn(name = "id_reserva_evento_inicio", referencedColumnName = "id_reserva_evento")
	public ReservaEvento getEventoInicio() {
		return eventoInicio;
	}

	public void setEventoInicio(ReservaEvento eventoInicio) {
		this.eventoInicio = eventoInicio;
	}

	@OneToOne(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE,
			CascadeType.REFRESH }, fetch = FetchType.EAGER)
	@JoinColumn(name = "id_reserva_evento_fim", referencedColumnName = "id_reserva_evento")
	public ReservaEvento getEventoFim() {
		return eventoFim;
	}

	public void setEventoFim(ReservaEvento eventoFim) {
		this.eventoFim = eventoFim;
	}

}
