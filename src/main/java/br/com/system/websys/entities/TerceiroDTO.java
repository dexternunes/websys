package br.com.system.websys.entities;

import java.io.Serializable;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TerceiroDTO implements Serializable {
	
	private static final long serialVersionUID = 8631801890193946598L;


	private Long id;
	
	private String nome;

	public TerceiroDTO(){
		
	}
	
	public TerceiroDTO(Long id, String nome){
		this.id = id;
		this.nome = nome;
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
}
