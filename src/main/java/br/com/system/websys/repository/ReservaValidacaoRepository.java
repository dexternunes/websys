package br.com.system.websys.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.ReservaValidacao;

public interface ReservaValidacaoRepository extends RepositoryBaseRoot<ReservaValidacao> {
	
	@Query("SELECT r FROM ReservaValidacao r WHERE r.uid = :uid")
	ReservaValidacao getByUid(@Param("uid") String uid);
}

