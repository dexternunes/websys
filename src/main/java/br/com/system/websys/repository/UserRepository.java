package br.com.system.websys.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.User;

public interface UserRepository extends RepositoryBaseRoot<User> {

	@Query("select u from User u where u.login = :login")
	User findByLogin(@Param("login") String login); 
	
}

