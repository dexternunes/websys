package br.com.system.websys.entities;

import java.util.ArrayList;
import java.util.List;

public class UserDTO {
	
	private String nome;
	
	private List<Grupo> grupos = new ArrayList<Grupo>();
	
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public List<Grupo> getGrupos(){
		return grupos;
	}
	
	public void setGrupos(List<Grupo> grupos){
		this.grupos = grupos;
	}
} 