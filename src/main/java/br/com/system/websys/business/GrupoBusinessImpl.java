package br.com.system.websys.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Grupo;
import br.com.system.websys.repository.GrupoRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class GrupoBusinessImpl extends BusinessBaseRootImpl<Grupo, GrupoRepository> implements GrupoBusiness {
    
	@Autowired
	protected GrupoBusinessImpl(GrupoRepository repository) {
		super(repository, Grupo.class);
	}

	@Override
	protected void validateBeforeSave(Grupo entity) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public List<Grupo> getAll() {
		return ((GrupoRepository)repository).findAll();
	}

}
