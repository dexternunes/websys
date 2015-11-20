package br.com.system.websys.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.repository.TerceiroRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class TerceiroBusinessImpl extends BusinessBaseRootImpl<Terceiro, TerceiroRepository> implements TerceiroBusiness {
    
	@Autowired
	protected TerceiroBusinessImpl(TerceiroRepository repository) {
		super(repository, Terceiro.class);
	}

	@Override
	protected void validateBeforeSave(Terceiro entity) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public List<Terceiro> getAll() {
		return ((TerceiroRepository)repository).findAll();
	}

}
