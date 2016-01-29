package br.com.system.websys.entities;

import java.util.ArrayList;
import java.util.List;

public class PermiteReservasDTO{
	private List<PermiteReservaDTO> permiteReservaDTO = new ArrayList<PermiteReservaDTO>();

	public List<PermiteReservaDTO> getPermiteReservaDTO() {
		return permiteReservaDTO;
	}

	public void setPermiteReservaDTO(List<PermiteReservaDTO> permiteReservaDTO) {
		this.permiteReservaDTO = permiteReservaDTO;
	}
}