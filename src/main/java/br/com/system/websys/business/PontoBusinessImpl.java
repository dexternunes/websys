package br.com.system.websys.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Ponto;
import br.com.system.websys.entities.Rede;
import br.com.system.websys.repository.PontoRepository;

@Service
@Transactional
public class PontoBusinessImpl extends BusinessBaseRootImpl<Ponto, PontoRepository> implements PontoBusiness {
 
	@Autowired
	protected PontoBusinessImpl(PontoRepository repository) {
		super(repository, Ponto.class);
	}

	@Override
	public List<Ponto> getAll() {
		return ((PontoRepository)repository).findAll();
	}

	@Override
	protected void validateBeforeSave(Ponto entity) throws Exception {
		
		if(entity.getId() == null) 
			return;
		
		Ponto current = get(entity.getId());
		entity.setProperties(current.getProperties());			
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW)
	public void remover(Ponto ponto) {
		((PontoRepository)repository).delete(ponto);
	}

	@Override
	public List<Ponto> getByRede(Rede rede) {
		return ((PontoRepository)repository).findByRede(rede);
	}
}
