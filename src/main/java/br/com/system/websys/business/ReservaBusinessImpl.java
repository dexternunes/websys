package br.com.system.websys.business;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.FaturamentoStatus;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.repository.ReservaRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class ReservaBusinessImpl extends BusinessBaseRootImpl<Reserva, ReservaRepository> implements ReservaBusiness {
    
	@Autowired
	protected ReservaBusinessImpl(ReservaRepository repository) {
		super(repository, Reserva.class);
	}

	@Override
	protected void validateBeforeSave(Reserva entity) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public List<Reserva> getAll() {
		return ((ReservaRepository)repository).findAll();
	}



	public List<Reserva> getAllByGrupo(List<Grupo> grupos) {
		List<Reserva> reserva = ((ReservaRepository) repository).getAllByGrupo(grupos);
		return reserva;
	}

	@Override
	public Reserva getGetProprietario(Terceiro terceiro) {
		Reserva proprietarioreserva = ((ReservaRepository)repository).getGetProprietario(terceiro);
		return proprietarioreserva;
	}

	@Override
	public String validaExclusao(Reserva reserva) {
		Date horaInicioReserva = reserva.getInicioReserva();
		Calendar horaInicioReservaCal = Calendar.getInstance();
		horaInicioReservaCal.setTime(horaInicioReserva);
		
		long dif = (horaInicioReservaCal.getTimeInMillis() - System.currentTimeMillis()) / (60 * 60 * 1000);
		
		if(dif < 2)
			return "false";
		else
			return "true";
	}

	public List<Reserva> getByGrupoByStatus(Grupo grupo, FaturamentoStatus faturamentoStatus) {
		List<Reserva> reservas = ((ReservaRepository)repository).findByReservaByGrupoByStatus(grupo, faturamentoStatus);
		return reservas;
	}






}
