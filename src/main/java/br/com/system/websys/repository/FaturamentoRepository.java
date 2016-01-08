package br.com.system.websys.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Faturamento;
import br.com.system.websys.entities.ProdutoStatus;
import br.com.system.websys.entities.ProdutoTipo;

public interface FaturamentoRepository extends RepositoryBaseRoot<Faturamento> {

	@Query("select p from Produto p where p.tipoProduto = :tipo and p.status in :status")
	List<Faturamento> findAllByTipoAndStatus(@Param("tipo") ProdutoTipo tipo, @Param("status") List<ProdutoStatus> status);
	
}

