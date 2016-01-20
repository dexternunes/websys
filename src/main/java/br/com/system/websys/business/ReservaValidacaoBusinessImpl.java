package br.com.system.websys.business;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.ReservaValidacao;
import br.com.system.websys.repository.ReservaValidacaoRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class ReservaValidacaoBusinessImpl extends BusinessBaseRootImpl<ReservaValidacao, ReservaValidacaoRepository> implements ReservaValidacaoBusiness {
    
	@Autowired
	protected ReservaValidacaoBusinessImpl(ReservaValidacaoRepository repository) {
		super(repository, ReservaValidacao.class);
	}

	@Override
	protected void validateBeforeSave(ReservaValidacao entity) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public ReservaValidacao getByUid(String uid) {
		return ((ReservaValidacaoRepository)repository).getByUid(uid);
	}

	

}
