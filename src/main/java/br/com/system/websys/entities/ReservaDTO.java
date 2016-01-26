package br.com.system.websys.entities;

import java.io.Serializable;
import java.util.Date;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown=true)
public class ReservaDTO  implements Serializable {

	private static final long serialVersionUID = 8631801890193962830L;
	
	private Long id;
	
	private String title;
	
	private Date start;
	
	private Date end;
	
	private Boolean allDay;
	
	private String url;
	
	private Boolean utilizaMarinheiro = false;
	
	private String obs;
	
	private ReservaStatus status;
	
	private ReservaEvento eventoInicio;
	
	private ReservaEvento eventoFim;

	public ReservaDTO(){
		
	}
	
	public ReservaDTO(Long id, String title, Date start, Date end, Boolean allDay, String url, Boolean utilizaMarinheiro, String obs,
			ReservaStatus status, ReservaEvento eventoInicio, ReservaEvento eventoFim){
		this.id = id;
		this.title = title;
		this.start = start;
		this.end = end;
		this.allDay = allDay;
		this.url = url;
		this.utilizaMarinheiro = utilizaMarinheiro;
		this.obs = obs;
		this.status = status;
		this.eventoInicio = eventoInicio;
		this.eventoFim = eventoFim;
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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
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
}
