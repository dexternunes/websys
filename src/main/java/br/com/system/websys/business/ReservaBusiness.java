package br.com.system.websys.business;

import java.util.List;

import javax.mail.MessagingException;

import br.com.system.websys.entities.FaturamentoStatus;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.PermiteReservasDTO;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaEvento;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.User;
import br.com.system.websys.repository.ReservaRepository;

public interface ReservaBusiness extends BusinessBaseRoot<Reserva, ReservaRepository> {
	
	public List<Reserva> getAll();

	public List<Reserva> getByGrupoByStatus(Grupo grupo, FaturamentoStatus faturamentoStatus);
	
	public List<Reserva> getAllByGrupo(List<Grupo> grupos);

	public Reserva createReserva(Reserva reserva) throws Exception;

	public Boolean sendEmailValidacao(Reserva reserva, String server) throws MessagingException;
	
	public List<Reserva> getReservaByTerceiro(Terceiro terceiro);
	
	public String validaExclusao(Reserva reserva);
	
	public Reserva getReservaByEventoFim(ReservaEvento eventoFim);
	
	public PermiteReservasDTO validaSolicitanteReserva(User user);

	public Reserva adicionaReservaEvento(ReservaEvento reservaEvento) throws Exception;

	public List<Reserva> getReservasParaExibicao(User user);

}
