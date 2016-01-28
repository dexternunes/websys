package br.com.system.websys.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.Terceiro;

public interface GrupoRepository extends RepositoryBaseRoot<Grupo> {


	@Query("SELECT g FROM Grupo g WHERE g.ativo = 1")
	List<Grupo> findAllAtivos();
	
	@Query("SELECT g FROM Grupo g JOIN g.terceiros t WHERE t = :terceiro and g.ativo = 1")
	List<Grupo> findByTerceiro(@Param("terceiro") Terceiro terceiro);

	@Query("SELECT g FROM Grupo g JOIN g.produtos p WHERE p = :produto and g.ativo = 1")
	List<Grupo> findByProduto(@Param("produto") Produto produto);
}

