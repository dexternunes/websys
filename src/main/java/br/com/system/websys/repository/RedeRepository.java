package br.com.system.websys.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Rede;
import br.com.system.websys.repository.RepositoryBaseRoot;


public interface RedeRepository extends RepositoryBaseRoot<Rede> {


	@Query("select f from Rede f JOIN f.pontos where f.login = :login")
	Rede findByLogin(@Param("login") String login);

	@Query("select f from Rede f where f.documento = :documento")
	Rede findByDocumento(@Param("documento") String documento);
}
