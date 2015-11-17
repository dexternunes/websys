package br.com.system.websys.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Entidade;
import br.com.system.websys.entities.User;

public interface EntidadeRepository  extends RepositoryBaseRoot<Entidade> {

	@Query("select e from User u join u.entidadesPermitidas e where u = :user order by e.nome")
	List<Entidade> findAllOrderByUser(@Param("user") User user);
	
	@Query("select e from Entidade e order by nome")
	List<Entidade> findAllOrder();
	
}