package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Produto;
import br.com.system.websys.repository.ProdutoRepository;

public interface ProdutoBusiness extends BusinessBaseRoot<Produto, ProdutoRepository> {
	
	public List<Produto> getAll();
	
}
