package br.com.system.websys.business;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.GrupoDTO;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaDTO;
import br.com.system.websys.entities.ReservaEvento;
import br.com.system.websys.entities.ReservaEventoDTO;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.TerceiroDTO;

@Component
public class ParseDTO{

	@Autowired
	private ReservaBusiness reservaBusiness;
	
	@Autowired
	private ReservaEventoBusiness reservaEventoBusiness;
	
	@Autowired
	private GrupoBusiness grupoBusiness;
	
	@Autowired
	private TerceiroBusiness terceiroBusiness;
	
	public List<ReservaDTO> parseReserva2ReservaDTO(List<Reserva> reservas){
		List<ReservaDTO> reservasDTO = new ArrayList<ReservaDTO>();
		for(Reserva reserva : reservas){
			reservasDTO.add(parseReserva2ReservaDTO(reserva));
		}
		return reservasDTO;
	}
	
	public ReservaDTO parseReserva2ReservaDTO(Reserva reserva){
		
		return new ReservaDTO(
				reserva.getId(), 
				reserva.getSolicitante().getNome(), 
				parseTerceiro2TerceiroDTO(reserva.getSolicitante()),
				reserva.getInicioReserva(),
				reserva.getFimReserva(), 
				reserva.getUtilizaMarinheiro(), 
				reserva.getObs(), 
				reserva.getStatus(),
				parseReservaEnvento2ReservaEnventoDTO(reserva.getEventoInicio()), 
				parseReservaEnvento2ReservaEnventoDTO(reserva.getEventoFim()), 
				new GrupoDTO(reserva.getGrupo().getId(), reserva.getGrupo().getDescricao(), reserva.getGrupo().getColor()),
				null);
		
	}
	
	public Reserva parseReservaDTO2Reserva(ReservaDTO reservaDTO) throws Exception{
		
		Reserva reserva = null; 		
		
		if(reservaDTO.getId() != null)
			reserva = reservaBusiness.get(reservaDTO.getId());
		
		if(reserva == null){
			reserva = new Reserva();
			if(reservaDTO.getGrupo() != null)
				reserva.setGrupo(grupoBusiness.get(reservaDTO.getGrupo().getId()));
			reserva = reservaBusiness.createReserva(reserva);
		}
		
		if(reservaDTO.getEnd() != null)
			reserva.setFimReserva(reservaDTO.getEnd());
		
		if(reservaDTO.getStart() != null)
			reserva.setInicioReserva(reservaDTO.getStart());
		
		if(reservaDTO.getObs() != null)
			reserva.setObs(reservaDTO.getObs());
		
		if(reservaDTO.getStatus() != null)
			reserva.setStatus(reservaDTO.getStatus());
		
		if(reservaDTO.getUtilizaMarinheiro() != null)
			reserva.setUtilizaMarinheiro(reservaDTO.getUtilizaMarinheiro());
		
		if(reservaDTO.getEventoInicio() != null)
			reserva.setEventoInicio(reservaEventoBusiness.get(reservaDTO.getEventoInicio().getId()));
		
		if(reservaDTO.getEventoFim() != null)
			reserva.setEventoFim(reservaEventoBusiness.get(reservaDTO.getEventoFim().getId()));
		
		if(reservaDTO.getTerceiro() != null)
			reserva.setSolicitante(terceiroBusiness.get(reservaDTO.getTerceiro().getId()));
				
		return reserva;
	}
	
	public List<TerceiroDTO> parseTerceiro2TerceiroDTO(List<Terceiro> terceiros){
		List<TerceiroDTO> terceirosDTO = new ArrayList<TerceiroDTO>();
		for(Terceiro terceiro : terceiros){
			terceirosDTO.add(parseTerceiro2TerceiroDTO(terceiro));
		}
		return terceirosDTO;
	}
	
	public TerceiroDTO parseTerceiro2TerceiroDTO(Terceiro terceiro){
		return new TerceiroDTO(terceiro.getId(), terceiro.getNome());
	}
	
	public List<ReservaEventoDTO> parseReservaEnvento2ReservaEnventoDTO(List<ReservaEvento> reservasEvento){
		List<ReservaEventoDTO> reservasEventoDTO = new ArrayList<ReservaEventoDTO>();
		for(ReservaEvento reservaEvento : reservasEvento){
			reservasEventoDTO.add(parseReservaEnvento2ReservaEnventoDTO(reservaEvento));
		}
		return reservasEventoDTO;
	}
	
	public ReservaEventoDTO parseReservaEnvento2ReservaEnventoDTO(ReservaEvento reservaEvento){
		return new ReservaEventoDTO(reservaEvento.getId());
	}
	
	public List<GrupoDTO> parseReservaEnvento2GrupoDTO(List<Grupo> grupos){
		List<GrupoDTO> grupoDTO = new ArrayList<GrupoDTO>();
		for(Grupo grupo : grupos){
			grupoDTO.add(parseReservaEnvento2GrupoDTO(grupo));
		}
		return grupoDTO;
	}
	
	public GrupoDTO parseReservaEnvento2GrupoDTO(Grupo grupo){
		return new GrupoDTO(grupo.getId(), grupo.getDescricao(), grupo.getColor());
	}

	
	

	
}
