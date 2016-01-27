package br.com.system.websys.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.User;

public interface UserRepository extends RepositoryBaseRoot<User> {

	@Query("select u from User u where u.login = :login")
	User findByLogin(@Param("login") String login);
	
	@Query("select u from User u where u.uidRecurerarSenha = :uid")
	User findByUid(@Param("uid") String uid);
	
	@Query("select u from User u where u.role in :roles")
	List<User> findByRoles(@Param("roles") List<Role> roles);
	
}

