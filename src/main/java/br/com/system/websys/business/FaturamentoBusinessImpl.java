package br.com.system.websys.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Faturamento;
import br.com.system.websys.repository.FaturamentoRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class FaturamentoBusinessImpl extends BusinessBaseRootImpl<Faturamento, FaturamentoRepository> implements FaturamentoBusiness {
    
	@Autowired
	protected FaturamentoBusinessImpl(FaturamentoRepository repository) {
		super(repository, Faturamento.class);
	}

	@Override
	protected void validateBeforeSave(Faturamento entity) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public List<Faturamento> getAll() {
		return ((FaturamentoRepository)repository).findAll();
	}
	
	//@Override
	//public List<Produto> getAllByTipoAndStatus(ProdutoTipo tipo, List<ProdutoStatus>status) {
	//	return ((ProdutoRepository)repository).findAllByTipoAndStatus(tipo, status);
	//}

}
