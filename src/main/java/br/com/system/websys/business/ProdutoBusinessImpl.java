package br.com.system.websys.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.ProdutoStatus;
import br.com.system.websys.entities.ProdutoTipo;
import br.com.system.websys.repository.ProdutoRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class ProdutoBusinessImpl extends BusinessBaseRootImpl<Produto, ProdutoRepository> implements ProdutoBusiness {
    
	@Autowired
	protected ProdutoBusinessImpl(ProdutoRepository repository) {
		super(repository, Produto.class);
	}

	@Override
	protected void validateBeforeSave(Produto entity) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public List<Produto> getAll() {
		return ((ProdutoRepository)repository).findAll();
	}
	
	@Override
	public List<Produto> getAllByTipoAndStatus(ProdutoTipo tipo, List<ProdutoStatus>status) {
		return ((ProdutoRepository)repository).findAllByTipoAndStatus(tipo, status);
	}

}
