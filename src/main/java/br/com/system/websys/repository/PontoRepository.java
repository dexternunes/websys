package br.com.system.websys.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Ponto;
import br.com.system.websys.entities.Rede;
import br.com.system.websys.repository.RepositoryBaseRoot;

public interface PontoRepository extends RepositoryBaseRoot<Ponto> {

	@Query("select p from Ponto p where p.rede = :rede")
	List<Ponto> findByRede(@Param("rede") Rede rede);
}
