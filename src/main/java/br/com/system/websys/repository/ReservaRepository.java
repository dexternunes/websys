package br.com.system.websys.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Reserva;

public interface ReservaRepository extends RepositoryBaseRoot<Reserva> {
	
	@Query("SELECT  r FROM Reserva r WHERE r.grupo IN(:grupo) AND r.excluido = 0 AND r.ativo = 1")
	List<Reserva> getAllByGrupo(@Param("grupo") List<Grupo> grupos);
}

