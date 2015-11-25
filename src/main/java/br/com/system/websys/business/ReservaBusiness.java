package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Reserva;
import br.com.system.websys.repository.ReservaRepository;

public interface ReservaBusiness extends BusinessBaseRoot<Reserva, ReservaRepository> {
	
	public List<Reserva> getAll();
	
}