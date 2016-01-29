package br.com.system.websys.job;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.system.websys.business.ReservaBusiness;

@Component
class ReservaJobImpl implements ReservaJob {

	@Autowired
	public ReservaBusiness reservaBusiness;
	
	@Override
	public void validaReservas() {

		System.out.println("SCHEDULE RODANDO RODANDO RODANDO....");
		
	}

	
}
