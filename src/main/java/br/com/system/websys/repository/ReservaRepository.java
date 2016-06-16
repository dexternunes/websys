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

	@Query("SELECT r FROM Reserva r WHERE r.solicitante in (:terceiros) AND r.excluido = 0 AND r.ativo = 1 AND r.grupo = :grupo AND r.status IN (:status) order by r.fimReserva")
	List<Reserva> getReservaByTerceirosByGrupoByStatus(@Param("terceiros") List<Terceiro> terceiros, @Param("grupo") Grupo grupo, @Param("status") List<ReservaStatus> status);

	@Query("SELECT r FROM Reserva r WHERE r.eventoFim = :eventoFim")
	Reserva getReservaByEventoFim(@Param("eventoFim") ReservaEvento eventoFim);

	@Query("SELECT r FROM Reserva r WHERE r.eventoFim = :evento OR r.eventoInicio = :evento")
	Reserva getByEvento(@Param("evento") ReservaEvento evento);

	@Query("SELECT r FROM Reserva r  WHERE r.grupo = :grupo and r.excluido = 0 and r.faturamentoStatus in :faturamentoStatus order by r.inicioReserva desc")
	List<Reserva> findByReservaByGrupoByStatus(@Param("grupo") Grupo grupo, @Param("faturamentoStatus") List<FaturamentoStatus> faturamentoStatus);

	@Query("SELECT  r FROM Reserva r WHERE r.grupo IN (:grupos) AND r.status in (:status) AND r.excluido = 0 AND r.ativo = 1")
	List<Reserva> getByGruposByStatus(@Param("grupos") List<Grupo> grupos, @Param("status") List<ReservaStatus> status);

	@Query("SELECT r FROM Reserva r WHERE r.inicioReserva = :inicioReserva AND r.excluido = 0 AND r.ativo = 1 AND r.grupo = :grupo AND r.status IN :status")
	Reserva getReservaByDate(@Param("inicioReserva") Date inicioReserva, @Param("grupo")Grupo grupo, @Param("status") List<ReservaStatus> status);

	@Query("SELECT r FROM Reserva r WHERE r.inicioReserva = :inicioReserva AND fimReserva = :fimReserva AND r.solicitante = :terceiro AND r.grupo = :grupo AND r.excluido = 0 AND r.ativo = 1 AND r.status in :status")
	Reserva existeReservaIgual(@Param("inicioReserva") Date inicioReserva, @Param("fimReserva") Date fimReserva, @Param("terceiro") Terceiro terceiro, @Param("grupo") Grupo grupo,
			@Param("status") List<ReservaStatus> status);
	
	@Query("SELECT r FROM Reserva r WHERE (r.inicioReserva between :inicioReserva and :fimReserva or r.fimReserva between :inicioReserva and :fimReserva) AND r.grupo = :grupo AND r.excluido = 0 AND r.ativo = 1 AND r.status in :status")
	Reserva existeReserva(@Param("inicioReserva") Date inicioReserva, @Param("fimReserva") Date fimReserva, @Param("grupo") Grupo grupo,
			@Param("status") List<ReservaStatus> status);
}
