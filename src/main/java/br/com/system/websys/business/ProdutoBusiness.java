package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.ProdutoStatus;
import br.com.system.websys.entities.ProdutoTipo;
import br.com.system.websys.repository.ProdutoRepository;

public interface ProdutoBusiness extends BusinessBaseRoot<Produto, ProdutoRepository> {
	
	public List<Produto> getAll();

	public List<Produto> getAllByTipoAndStatus(ProdutoTipo tipo, List<ProdutoStatus> status);
	
}
