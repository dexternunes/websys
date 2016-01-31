package br.com.system.websys.entities;

import java.io.Serializable;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ReservaEventoDTO implements Serializable {
	
	private static final long serialVersionUID = 8631801890193962990L;

	private Long id;

	public ReservaEventoDTO(){
		
	}
	
	public ReservaEventoDTO(Long id){
		this.id = id;
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
