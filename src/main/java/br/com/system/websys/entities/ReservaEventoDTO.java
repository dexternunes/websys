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

	public ReservaEventoDTO(){
		
	}
	
	public ReservaEventoDTO(Long id){
		this.id = id;
	}
	
	public ReservaEventoDTO(Long id, Long hora, List<String> imagens){
		this.id = id;
		this.hora = hora;
		this.imagens = imagens;
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
	

}
