package br.com.system.websys.entities.dto;

import org.springframework.web.multipart.MultipartFile;

public class ReservaEventoDTO{

	private MultipartFile imagem;
	
	private Long hora;
	
	private Long minuto;
	
	private Long segundo;

	public MultipartFile getImagem() {
		return imagem;
	}

	public void setImagem(MultipartFile imagem) {
		this.imagem = imagem;
	}

	public Long getHora() {
		return hora;
	}

	public void setHora(Long hora) {
		this.hora = hora;
	}

	public Long getMinuto() {
		return minuto;
	}

	public void setMinuto(Long minuto) {
		this.minuto = minuto;
	}

	public Long getSegundo() {
		return segundo;
	}

	public void setSegundo(Long segundo) {
		this.segundo = segundo;
	}
	
}
