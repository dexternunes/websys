package br.com.system.websys.entities;

public class PermiteReservaDTO{
	private Long idGrupoReserva;
	private String descricaoGrupo;
	private Long idReserva;
	private Long idSolicitanteReserva;
	private Boolean permiteReserva;
	
	public PermiteReservaDTO(){
		
	}
	
	public PermiteReservaDTO(Long idGrupoReserva, String descricaoGrupo, Long idReserva, Long idSolicitanteReserva, Boolean permiteReserva){
		this.idGrupoReserva = idGrupoReserva;
		this.descricaoGrupo = descricaoGrupo;
		this.idReserva = idReserva;
		this.idSolicitanteReserva = idSolicitanteReserva;
		this.permiteReserva = permiteReserva;
	}

	public Long getIdGrupoReserva() {
		return idGrupoReserva;
	}

	public void setIdGrupoReserva(Long idGrupoReserva) {
		this.idGrupoReserva = idGrupoReserva;
	}

	public Long getIdReserva() {
		return idReserva;
	}

	public void setIdReserva(Long idReserva) {
		this.idReserva = idReserva;
	}

	public Long getIdSolicitanteReserva() {
		return idSolicitanteReserva;
	}

	public void setIdSolicitanteReserva(Long idSolicitanteReserva) {
		this.idSolicitanteReserva = idSolicitanteReserva;
	}

	public Boolean getPermiteReserva() {
		return permiteReserva;
	}

	public void setPermiteReserva(Boolean permiteReserva) {
		this.permiteReserva = permiteReserva;
	}

	public String getDescricaoGrupo() {
		return descricaoGrupo;
	}

	public void setDescricaoGrupo(String descricaoGrupo) {
		this.descricaoGrupo = descricaoGrupo;
	}
}