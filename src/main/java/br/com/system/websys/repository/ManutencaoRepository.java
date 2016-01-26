package br.com.system.websys.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Manutencao;
import br.com.system.websys.entities.ManutencaoStatus;
import br.com.system.websys.entities.Produto;

public interface ManutencaoRepository extends RepositoryBaseRoot<Manutencao> {

	@Query("SELECT m FROM Manutencao m  WHERE m.produto = :produto and m.status = :status")
	List<Manutencao> findByProdutoByStatus(@Param("produto") Produto produto, @Param("status") ManutencaoStatus status);
}

