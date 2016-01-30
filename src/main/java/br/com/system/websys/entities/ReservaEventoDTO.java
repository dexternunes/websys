package br.com.system.websys.entities;

public class ReservaEventoDTO extends EntityBaseRoot {

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
