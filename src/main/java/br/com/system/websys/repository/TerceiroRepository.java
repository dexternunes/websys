package br.com.system.websys.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.TerceiroTipo;

public interface TerceiroRepository  extends RepositoryBaseRoot<Terceiro> {

	@Query("select t from Terceiro t where :tipo MEMBER OF t.tipos and t.excluido = 0")
	List<Terceiro> findAllByTipo(@Param("tipo") TerceiroTipo tipo);
	
	@Query("SELECT distinct t FROM User u JOIN u.terceiro t WHERE u.role = :role and t.excluido = 0 and u.excluido = 0")
	List<Terceiro> getAllByRole(@Param("role") Role role);
	
	@Query("SELECT t FROM Terceiro t WHERE t.excluido = 0")
	List<Terceiro> getAll();
	
}