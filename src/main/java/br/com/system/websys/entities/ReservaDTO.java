package br.com.system.websys.entities;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import br.com.system.websys.formatter.Formatters;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ReservaDTO implements Serializable {

	private static final long serialVersionUID = 8631801890193962830L;

	private Long id;

	private String title;

	private TerceiroDTO terceiro;

	private Date start;
	
	@SuppressWarnings("unused")
	private String startStr;
	
	@SuppressWarnings("unused")
	private String endStr;

	private Date end;

	private Boolean utilizaMarinheiro = false;

	private String obs;

	private ReservaStatus status;

	private ReservaEventoDTO eventoInicio;

	private ReservaEventoDTO eventoFim;

	private GrupoDTO grupo;
	
	private String tipoEvento;
	
	private List<String> imagensUrl = new ArrayList<String>();
	
	private String urlImagens;
	private Boolean mostrarDetalhes = false;
	
	public ReservaDTO(Long id, String title, TerceiroDTO terceiro, Date start, Date end, Boolean utilizaMarinheiro,
			String obs, ReservaStatus status, ReservaEventoDTO eventoInicio, ReservaEventoDTO eventoFim, GrupoDTO grupo, String tipoEvento) {
		this.id = id;
		this.title = title;
		this.terceiro = terceiro;
		setStart(start);
		setEnd(end);
		this.utilizaMarinheiro = utilizaMarinheiro;
		this.obs = obs;
		this.status = status;
		this.eventoInicio = eventoInicio;
		this.eventoFim = eventoFim;
		this.grupo = grupo;
		this.tipoEvento = tipoEvento;
	}
	public ReservaDTO(Long id, String title, TerceiroDTO terceiro, Date start, Date end, Boolean utilizaMarinheiro,
			String obs, ReservaStatus status, ReservaEventoDTO eventoInicio, ReservaEventoDTO eventoFim, GrupoDTO grupo, String tipoEvento, Boolean mostrarDetalhes) {
		this.id = id;
		this.title = title;
		this.terceiro = terceiro;
		setStart(start);
		setEnd(end);
		this.utilizaMarinheiro = utilizaMarinheiro;
		this.obs = obs;
		this.status = status;
		this.eventoInicio = eventoInicio;
		this.eventoFim = eventoFim;
		this.grupo = grupo;
		this.tipoEvento = tipoEvento;
		this.mostrarDetalhes = mostrarDetalhes;
	}
	
	
	public ReservaDTO(){
		
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
		this.startStr = Formatters.formatDate(start);				
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
		this.endStr = Formatters.formatDate(end);
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

	public String getStartStr() {
		return Formatters.formatDate(start);
	}

	public void setStartStr(String startStr) {
		this.startStr = startStr;
	}

	public String getEndStr() {
		return Formatters.formatDate(end);
	}

	public void setEndStr(String endStr) {
		this.endStr = endStr;
	}

	public String getTipoEvento() {
		return tipoEvento;
	}

	public void setTipoEvento(String tipoEvento) {
		this.tipoEvento = tipoEvento;
	}

	public List<String> getImagensUrl() {
		return imagensUrl;
	}

	public void setImagensUrl(List<String> imagensUrl) {
		this.imagensUrl = imagensUrl;
	}

	public String getUrlImagens() {
		return urlImagens;
	}

	public void setUrlImagens(String urlImagens) {
		this.urlImagens = urlImagens;
	}
	public Boolean getMostrarDetalhes() {
		return mostrarDetalhes;
	}
	public void setMostrarDetalhes(Boolean mostrarDetalhes) {
		this.mostrarDetalhes = mostrarDetalhes;
	}
	
}
