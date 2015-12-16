package br.com.system.websys.repository;

import br.com.system.websys.entities.Grupo;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Terceiro;

public interface GrupoRepository extends RepositoryBaseRoot<Grupo> {

	@Query("select descricao from Grupo where terceiro = :terceiro")
	List<Grupo> findByTerceiro(@Param("terceiro") Terceiro terceiro);
}

