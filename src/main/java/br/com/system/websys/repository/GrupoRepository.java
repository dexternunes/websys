package br.com.system.websys.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.Terceiro;

public interface GrupoRepository extends RepositoryBaseRoot<Grupo> {

	@Query("SELECT g FROM Grupo g JOIN g.terceiros t WHERE t = :terceiro")
	//@Query("SELECT g.descricao FROM Grupo g WHERE g.terceiros IN (:terceiro)")
	List<Grupo> findByTerceiro(@Param("terceiro") Terceiro terceiro);

	@Query("SELECT g FROM Grupo g JOIN g.produtos p WHERE p = :produto")
	List<Grupo> findByProduto(@Param("produto") Produto produto);
}

