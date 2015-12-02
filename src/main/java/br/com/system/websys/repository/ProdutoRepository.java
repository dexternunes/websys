package br.com.system.websys.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.ProdutoStatus;
import br.com.system.websys.entities.ProdutoTipo;

public interface ProdutoRepository extends RepositoryBaseRoot<Produto> {

	@Query("select p from Produto p where p.tipoProduto = :tipo and p.status in :status")
	List<Produto> findAllByTipoAndStatus(@Param("tipo") ProdutoTipo tipo, @Param("status") List<ProdutoStatus> status);
	
}

