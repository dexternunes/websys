package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Imagem;
import br.com.system.websys.entities.ReservaEvento;
import br.com.system.websys.entities.dto.ReservaEventoDTO;
import br.com.system.websys.repository.ReservaEventoRepository;

public interface ReservaEventoBusiness extends BusinessBaseRoot<ReservaEvento, ReservaEventoRepository> {
	
	public List<ReservaEvento> getAll();

	public ReservaEvento addImagem(ReservaEvento evento, Imagem imagem) throws Exception;

	public ReservaEventoDTO parseToDTO(ReservaEvento reservaEvento);
	
}
