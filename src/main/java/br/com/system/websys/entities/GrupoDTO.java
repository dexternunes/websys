package br.com.system.websys.entities;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class GrupoDTO implements Serializable{
	
	private static final long serialVersionUID = 8631801890193963540L;

	private Long id;
	
	private String descricao;
	
	private String color;

	public GrupoDTO(){
		
	}
	
	public GrupoDTO(Long id, String descricao, String color){
		this.id = id;
		this.descricao = descricao;
		this.color = color;		
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
	
}
