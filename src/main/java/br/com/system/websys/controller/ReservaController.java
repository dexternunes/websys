package br.com.system.websys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.system.websys.business.GrupoBusiness;
import br.com.system.websys.business.ReservaBusiness;
import br.com.system.websys.business.TerceiroBusiness;
import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaDTO;
import br.com.system.websys.entities.ReservaEvento;
import br.com.system.websys.entities.ReservaStatus;
import br.com.system.websys.entities.ReservasDTO;
import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.User;

@Controller
@RequestMapping("/reserva")
public class ReservaController{
	
	private static final Logger logger = LoggerFactory
			.getLogger(TerceiroController.class);
	
	@Autowired
	ReservaBusiness reservaBusiness;
	
	@Autowired
	UserBusiness userBusiness;
	
	@Autowired
	TerceiroBusiness terceiroBusiness;
	
	@Autowired
	GrupoBusiness grupoBusiness;
	
	@RequestMapping(value="/salvar", method = RequestMethod.POST)
	public String salvarBase(@Valid @ModelAttribute("reserva") Reserva reserva,
			BindingResult result, RedirectAttributes attr) throws Exception {

		if (result.hasErrors()) {

			for (ObjectError error : result.getAllErrors())
				logger.info("Erro: " + error.toString());
			
			return "redirect:/home";
		}

		try {
			if(reserva.getId()==null){
				reserva.setEventoInicio(new ReservaEvento());
				reserva.setEventoFim(new ReservaEvento());
				reserva.setStatus(ReservaStatus.AGUARDANDO_APROVACAO);
				reserva.setSolicitante(userBusiness.getCurrent().getTerceiro());
			}
			else{
				reserva.setEventoInicio(reservaBusiness.get(reserva.getId()).getEventoInicio());
				reserva.setEventoFim(reservaBusiness.get(reserva.getId()).getEventoFim());
				reserva.setSolicitante(reservaBusiness.get(reserva.getId()).getSolicitante());
			}
			reservaBusiness.salvar(reserva);
		} catch (Exception e) {
			return "redirect:/home";
		}
		
		attr.addFlashAttribute("reserva", reserva);
		return "redirect:/home";
	}
	
	@ResponseBody
	@RequestMapping(value = "/get", method = RequestMethod.GET )
	public ReservasDTO getReserva(HttpServletRequest request) throws Exception {
		
		ReservasDTO reservas = new ReservasDTO();
		List<Reserva> listReservas;
		User user = userBusiness.getCurrent();
		if(user.getRole().equals(Role.ROLE_ADMIN) || user.getRole().equals(Role.ROLE_MARINHEIRO)){
			listReservas = reservaBusiness.getAll();
		}
		else		
			listReservas = reservaBusiness.getAllByGrupo(grupoBusiness.findAllByTerceito(user.getTerceiro()));
		
		for(Reserva reserva: listReservas){
			if(reserva.getInicioReserva() != null && reserva.getFimReserva() != null && reserva.getSolicitante().getNome() != null){

			reservas.getReservas().add(new ReservaDTO(reserva.getId(), reserva.getSolicitante().getNome(), reserva.getInicioReserva(), 
					reserva.getFimReserva(), false, "", reserva.getUtilizaMarinheiro(), reserva.getObs(), reserva.getStatus(),
					reserva.getEventoInicio(), reserva.getEventoFim()));
			}
		}
		return reservas;
	}
	
	@ResponseBody
	@RequestMapping(value = "/get/{id}", method = RequestMethod.GET )
	public ReservasDTO getReservaById(@PathVariable Long id, Model model) throws Exception {
		
		ReservasDTO reservas = new ReservasDTO();
		Reserva reserva = reservaBusiness.get(id);
		reservas.getReservas().add(new ReservaDTO(reserva.getId(), reserva.getSolicitante().getNome(), reserva.getInicioReserva(), 
				reserva.getFimReserva(), false, "", reserva.getUtilizaMarinheiro(), reserva.getObs(), reserva.getStatus(),
				reserva.getEventoInicio(), reserva.getEventoFim()));
		
		return reservas;
	}
	
	@ResponseBody
	@RequestMapping(value = "/validaExclusao/{id}", method = RequestMethod.GET )
	public String validaExclusao(@PathVariable Long id) throws Exception {
		Reserva reserva = reservaBusiness.get(id);
		
		String retorno = reservaBusiness.validaExclusao(reserva);
		
		return retorno;
	}
	
	@RequestMapping(value= "/api/remove", method = RequestMethod.POST, headers="Accept=application/json", produces = "application/json", consumes = "application/json")
	@ResponseBody
	public String postReserva(@RequestBody Long id_reserva) throws Exception {
		
		Reserva reserva = reservaBusiness.get(id_reserva);
		reserva.setExcluido(true);

		try {
			reservaBusiness.salvar(reserva);
		} catch (Exception e) {
			return "redirect:/home";
		}
		
		return "redirect:/home";
	}
}