package br.com.system.websys.business;

import java.util.List;

import javax.mail.MessagingException;

import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.repository.ReservaRepository;

public interface ReservaBusiness extends BusinessBaseRoot<Reserva, ReservaRepository> {
	
	public List<Reserva> getAll();
	
	public List<Reserva> getAllByGrupo(List<Grupo> grupos);

	public Reserva createReserva(Reserva reserva) throws Exception;

	public Boolean sendEmailValidacao(Reserva reserva, String server) throws MessagingException;
	
}
