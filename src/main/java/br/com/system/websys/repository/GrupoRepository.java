package br.com.system.websys.repository;

import br.com.system.websys.entities.Grupo;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Terceiro;

public interface GrupoRepository extends RepositoryBaseRoot<Grupo> {

	//@Query("SELECT g.descricao FROM Grupo g JOIN g.terceiros t WHERE t.terceiro = :terceiro")
	@Query("SELECT g.descricao FROM Grupo g WHERE g.terceiros IN (:terceiro)")
	List<Grupo> findByTerceiro(@Param("terceiro") Terceiro terceiro);
}

