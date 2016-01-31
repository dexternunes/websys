package br.com.system.websys.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import br.com.system.websys.entities.FaturamentoStatus;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaEvento;
import br.com.system.websys.entities.ReservaStatus;
import br.com.system.websys.entities.Terceiro;

public interface ReservaRepository extends RepositoryBaseRoot<Reserva> {

	@Query("SELECT  r FROM Reserva r WHERE r.grupo IN(:grupo) AND r.excluido = 0 AND r.ativo = 1")
	List<Reserva> getAllByGrupo(@Param("grupo") List<Grupo> grupos);

	@Query("SELECT r FROM Reserva r WHERE r.solicitante = :terceiro AND r.excluido = 0 AND r.ativo = 1 AND r.status in :status")
	List<Reserva> getReservaByTerceiro(@Param("terceiro") Terceiro terceiro, @Param("status") List<ReservaStatus> status);
	
	@Query("SELECT r FROM Reserva r WHERE r.solicitante in :terceiros AND r.excluido = 0 AND r.ativo = 1 AND r.status = :status order by r.fimReserva")
	List<Reserva> getReservaByTerceirosByStatus(@Param("terceiros") List<Terceiro> terceiros, @Param("status") ReservaStatus status);

	@Query("SELECT r FROM Reserva r WHERE r.eventoFim = :eventoFim")
	Reserva getReservaByEventoFim(@Param("eventoFim") ReservaEvento eventoFim);

	@Query("SELECT r FROM Reserva r WHERE r.eventoFim = :evento OR r.eventoInicio = :evento")
	Reserva getByEvento(@Param("evento") ReservaEvento evento);
	
	@Query("SELECT r FROM Reserva r  WHERE r.grupo = :grupo and r.faturamentoStatus = :faturamentoStatus")
	List<Reserva> findByReservaByGrupoByStatus(@Param("grupo") Grupo grupo, @Param("faturamentoStatus") FaturamentoStatus faturamentoStatus);
	
	@Query("SELECT  r FROM Reserva r WHERE r.grupo IN :grupos AND r.status in :status AND r.excluido = 0 AND r.ativo = 1")
	List<Reserva> getByGruposByStatus(@Param("grupos") List<Grupo> grupos, @Param("status") List<ReservaStatus> status);
	
	@Query("SELECT  r FROM Reserva r WHERE r.grupo = :grupo AND r.status = :status AND r.excluido = 0 AND r.ativo = 1 and r.created <= :data")
	List<Reserva> getByGruposByStatusByDateCreated(@Param("grupo") Grupo grupo, @Param("status") ReservaStatus status, @Param("data") Date data);

}
