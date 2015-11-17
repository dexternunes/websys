package br.com.system.websys.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Entidade;
import br.com.system.websys.entities.User;
import br.com.system.websys.repository.EntidadeRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class EntidadeBusinessImpl extends BusinessBaseRootImpl<Entidade, EntidadeRepository> implements EntidadeBusiness {
    
	@Autowired
	protected EntidadeBusinessImpl(EntidadeRepository repository) {
		super(repository, Entidade.class);
	}

	@Override
	public List<Entidade> getAllOrder() {
		return ((EntidadeRepository)repository).findAllOrder();
	}	
	
	@Override
	public List<Entidade> findAllOrderByUser(User user){
		return ((EntidadeRepository)repository).findAllOrderByUser(user);
	}

	@Override
	protected void validateBeforeSave(Entidade entity) throws Exception {

		// TODO Auto-generated method stub
		
	}

}
