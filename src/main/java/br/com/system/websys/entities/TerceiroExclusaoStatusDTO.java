package br.com.system.websys.entities;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TerceiroExclusaoStatusDTO implements Serializable{
	
	private static final long serialVersionUID = 863180189019397846L;

	private int id;
	
	private String mensagem;
	
	public TerceiroExclusaoStatusDTO(){
		
	}
	
	public TerceiroExclusaoStatusDTO(int id, String mensagem){
		this.id = id;
		this.mensagem = mensagem;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getMensagem(){
		return mensagem;
	}
	
	public void setMensagem(String mensagem){
		this.mensagem = mensagem;
	}
}
