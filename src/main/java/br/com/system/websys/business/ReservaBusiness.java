package br.com.system.websys.business;

import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;

import br.com.system.websys.entities.FaturamentoStatus;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaDTO;
import br.com.system.websys.entities.ReservaEvento;
import br.com.system.websys.entities.ReservaValidacaoStatus;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.User;
import br.com.system.websys.repository.ReservaRepository;

public interface ReservaBusiness extends BusinessBaseRoot<Reserva, ReservaRepository> {
	
	public List<Reserva> getAll();

	public List<Reserva> getByGrupoByStatus(Grupo grupo, List<FaturamentoStatus> faturamentoStatus);
	
	public List<Reserva> getAllByGrupo(List<Grupo> grupos);
	
	public Reserva getReservaByEvento(ReservaEvento reservaEvento);

	public Reserva createReserva(Reserva reserva) throws Exception;

	public Boolean sendEmailValidacao(Reserva reserva, String server) throws MessagingException, Exception;
	
	public List<Reserva> getReservaByTerceiro(Terceiro terceiro);
	
	public String validaExclusao(Reserva reserva);
	
	public String validaCancela(Reserva reserva);
	
	public Reserva getReservaByEventoFim(ReservaEvento eventoFim);
	
	public Reserva adicionaReservaEvento(ReservaEvento reservaEvento, String server) throws Exception;

	public List<Reserva> getReservasParaExibicao(User user);
	
	public List<Grupo> getGrupoPermiteReserva(Terceiro terceiro);

	public ReservaDTO getReservaDTOById(Long id, Terceiro terceiro, Date dataReserva) throws Exception;

	public void validaAPoraToda();
	
	public ReservaValidacaoStatus validaReserva(Reserva reserva) throws Exception;
	
	public Reserva getReservaByDate(Reserva reserva);
	
	public Boolean sendEmailInterno(Reserva reserva) throws MessagingException, Exception;
	
	public Boolean sendEmailCancelamento(Reserva reserva) throws MessagingException, Exception;
	
	public Boolean sendEmailExclusaoSolicitacao(Reserva reserva) throws MessagingException, Exception;

	public List<Terceiro> getTerceiroPermiteReservaGrupo(Grupo grupo);

	public Boolean contemReservaAtiva(Terceiro terceiro, Grupo grupo);

	public void alterarStatusReserva() throws Exception;
}
