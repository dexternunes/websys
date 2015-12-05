package br.com.system.websys.entities;

import java.util.ArrayList;
import java.util.List;

public class ReservasDTO {
	
	private List<ReservaDTO> reservas = new ArrayList<ReservaDTO>();

	public List<ReservaDTO> getReservas() {
		return reservas;
	}

	public void setReservas(List<ReservaDTO> reservas) {
		this.reservas = reservas;
	}
				
}
