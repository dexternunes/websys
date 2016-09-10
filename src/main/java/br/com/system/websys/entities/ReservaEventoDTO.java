package br.com.system.websys.entities;

import java.io.Serializable;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ReservaEventoDTO implements Serializable {
	
	private static final long serialVersionUID = 8631801890193962990L;

	private Long id;
	
	private Long hora;
	
	private List<String> imagens;
	
	private String dataRegistro;
	
	private String obsFim;


	public ReservaEventoDTO(){
		
	}
	
	public ReservaEventoDTO(Long id){
		this.id = id;
	}
	
	public ReservaEventoDTO(Long id, Long hora, List<String> imagens, String dataRegistro, String obsFim){
		this.id = id;
		this.hora = hora;
		this.imagens = imagens;
		this.dataRegistro = dataRegistro;
		this.obsFim = obsFim == null ? "": obsFim;
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getHora() {
		return hora;
	}

	public void setHora(Long hora) {
		this.hora = hora;
	}

	public List<String> getImagens() {
		return imagens;
	}

	public void setImagens(List<String> imagens) {
		this.imagens = imagens;
	}

	public String getDataRegistro() {
		return dataRegistro;
	}

	public void setDataRegistro(String dataRegistro) {
		this.dataRegistro = dataRegistro;
	}

	public String getObsFim() {
		return obsFim;
	}

	public void setObsFim(String obsFim) {
		this.obsFim = obsFim;
	}
	
}
