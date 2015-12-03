package br.com.system.websys.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.TerceiroTipo;

public interface TerceiroRepository  extends RepositoryBaseRoot<Terceiro> {

	@Query("select t from Terceiro t where :tipo MEMBER OF t.tipos")
	List<Terceiro> findAllByTipo(@Param("tipo") TerceiroTipo tipo);
	
}