package br.com.system.websys.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Imagem;
import br.com.system.websys.entities.ReservaEvento;
import br.com.system.websys.entities.dto.ReservaEventoDTO;
import br.com.system.websys.repository.ReservaEventoRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class ReservaEventoBusinessImpl extends BusinessBaseRootImpl<ReservaEvento, ReservaEventoRepository> implements ReservaEventoBusiness {
    
	@Autowired
	private ImagemBusiness imagemBusiness;
	
	@Autowired
	protected ReservaEventoBusinessImpl(ReservaEventoRepository repository) {
		super(repository, ReservaEvento.class);
	}

	@Override
	protected void validateBeforeSave(ReservaEvento entity) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public List<ReservaEvento> getAll() {
		return ((ReservaEventoRepository)repository).findAll();
	}
	
	@Override
	public ReservaEvento addImagem(ReservaEvento evento, Imagem imagem) throws Exception{
		evento.getImagens().add(imagem);
		evento = salvar(evento);
		imagem.setReservaEvento(evento);
		imagemBusiness.salvar(imagem);
		
		return evento;
	}
	
	@Override
	public ReservaEventoDTO parseToDTO(ReservaEvento reservaEvento){
		
		ReservaEventoDTO dto = new ReservaEventoDTO();
		dto.setHora(reservaEvento.getHora());
	
		return dto;
	}

}
