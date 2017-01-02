package br.com.system.websys.entities;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown=true)
public class HistoricoReservaDTO {

	private Long idReserva;
	
	private Terceiro solicitante;
	
	private ReservaEvento eventoInicio;

	private ReservaEvento eventoFim;

	public Terceiro getSolicitante() {
		return solicitante;
	}

	public void setSolicitante(Terceiro solicitante) {
		this.solicitante = solicitante;
	}

	public ReservaEvento getEventoInicio() {
		return eventoInicio;
	}

	public void setEventoInicio(ReservaEvento eventoInicio) {
		this.eventoInicio = eventoInicio;
	}

	public ReservaEvento getEventoFim() {
		return eventoFim;
	}

	public void setEventoFim(ReservaEvento eventoFim) {
		this.eventoFim = eventoFim;
	}

	public Long getIdReserva() {
		return idReserva;
	}

	public void setIdReserva(Long idReserva) {
		this.idReserva = idReserva;
	}


	
}
