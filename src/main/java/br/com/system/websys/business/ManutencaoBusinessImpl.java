package br.com.system.websys.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Manutencao;
import br.com.system.websys.entities.ManutencaoStatus;
import br.com.system.websys.entities.Produto;
import br.com.system.websys.repository.ManutencaoRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class ManutencaoBusinessImpl extends BusinessBaseRootImpl<Manutencao, ManutencaoRepository> implements ManutencaoBusiness {
    
	@Autowired
	protected ManutencaoBusinessImpl(ManutencaoRepository repository) {
		super(repository, Manutencao.class);
	}

	@Override
	protected void validateBeforeSave(Manutencao entity) throws Exception {
		// TODO Auto-generated method stub
	}
	

	@Override
	public List<Manutencao> getAll() {
		return ((ManutencaoRepository)repository).findAll();
	}

	@Override
	public List<Manutencao> findByProdutoByStatus(Produto produto, ManutencaoStatus status) {
		List<Manutencao> manutencoes = ((ManutencaoRepository)repository).findByProdutoByStatus(produto, status);
		return manutencoes;
	}
	
}
