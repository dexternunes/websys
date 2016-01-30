package br.com.system.websys.entities;

import java.io.Serializable;
import java.util.Date;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ReservaDTO implements Serializable {

	private static final long serialVersionUID = 8631801890193962830L;

	private Long id;

	private String title;

	private TerceiroDTO terceiro;

	private Date start;

	private Date end;

	private Boolean allDay;

	private Boolean utilizaMarinheiro = false;

	private String obs;

	private ReservaStatus status;

	private ReservaEventoDTO eventoInicio;

	private ReservaEventoDTO eventoFim;

		private GrupoDTO grupo;

	public ReservaDTO(Long id, String title, TerceiroDTO terceiro, Date start, Date end, Boolean allDay, Boolean utilizaMarinheiro,
			String obs, ReservaStatus status, ReservaEventoDTO eventoInicio, ReservaEventoDTO eventoFim, GrupoDTO grupo) {
		this.id = id;
		this.title = title;
		this.terceiro = terceiro;
		this.start = start;
		this.end = end;
		this.allDay = allDay;
		this.utilizaMarinheiro = utilizaMarinheiro;
		this.obs = obs;
		this.status = status;
		this.eventoInicio = eventoInicio;
		this.eventoFim = eventoFim;
		this.grupo = grupo;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	public Boolean getAllDay() {
		return allDay;
	}

	public void setAllDay(Boolean allDay) {
		this.allDay = allDay;
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

	public ReservaStatus getStatus() {
		return status;
	}

	public void setStatus(ReservaStatus status) {
		this.status = status;
	}

	public ReservaEventoDTO getEventoInicio() {
		return eventoInicio;
	}

	public void setEventoInicio(ReservaEventoDTO eventoInicio) {
		this.eventoInicio = eventoInicio;
	}

	public ReservaEventoDTO getEventoFim() {
		return eventoFim;
	}

	public void setEventoFim(ReservaEventoDTO eventoFim) {
		this.eventoFim = eventoFim;
	}

	public GrupoDTO getGrupo() {
		return grupo;
	}

	public void setGrupo(GrupoDTO grupo) {
		this.grupo = grupo;
	}

	public TerceiroDTO getTerceiro() {
		return terceiro;
	}

	public void setTerceiro(TerceiroDTO terceiro) {
		this.terceiro = terceiro;
	}

}
