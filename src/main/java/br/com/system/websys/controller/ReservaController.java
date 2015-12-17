package br.com.system.websys.controller;

import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.system.websys.business.GrupoBusiness;
import br.com.system.websys.business.ReservaBusiness;
import br.com.system.websys.business.TerceiroBusiness;
import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaDTO;
import br.com.system.websys.entities.ReservasDTO;

@Controller
@RequestMapping("/reserva")
public class ReservaController{
	
	private static final Logger logger = LoggerFactory
			.getLogger(TerceiroController.class);
	
	@Autowired
	ReservaBusiness reservaBusiness;
	UserBusiness userBusiness;
	TerceiroBusiness terceiroBusiness;
	GrupoBusiness grupoBusiness;
	
	@RequestMapping(value="/salvar", method = RequestMethod.POST)
	public String salvarBase(@Valid @ModelAttribute("reserva") Reserva reserva,
			BindingResult result, Model model) throws Exception {

		if (result.hasErrors()) {

			for (ObjectError error : result.getAllErrors())
				logger.info("Erro: " + error.toString());
			
			return "redirect:/home";

		}

		try {
			reservaBusiness.salvar(reserva);
		} catch (Exception e) {
			return "redirect:/home";
		}

		return "redirect:/home";
	}
	
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "/get", method = RequestMethod.GET )
	public ReservasDTO getReserva(HttpServletRequest request) throws Exception {
		
		ReservasDTO reservas = new ReservasDTO();
		reservas.getReservas().add(new ReservaDTO("Locação 1", new Date(115, 11, 5), new Date(115, 11, 7), false, "google.com.br"));
		reservas.getReservas().add(new ReservaDTO("Locação 2", new Date(115, 11, 8), new Date(115, 11, 9), false, "google.com.br"));
		reservas.getReservas().add(new ReservaDTO("Locação 3", new Date(115, 11, 10), new Date(115, 11, 12), false, "google.com.br"));
		reservas.getReservas().add(new ReservaDTO("Locação 4", new Date(115, 11, 30), new Date(115, 12, 6), false, "google.com.br"));
		reservas.getReservas().add(new ReservaDTO("Locação 5", new Date(115, 12, 7), new Date(115, 12, 12), false, "google.com.br"));
		
		return reservas;
	}
	
	@RequestMapping(value= "/post", method = RequestMethod.POST, headers="Accept=application/json", produces = "application/json", consumes = "application/json")
	@ResponseBody
	public String postReserva(@RequestBody ReservaDTO reserva) throws Exception {
		
		reserva.getTitle();

		return "home";
	}
	
	@ResponseBody
	@RequestMapping(value = "/nova", method = RequestMethod.GET )
	public String getNovaReserva(HttpServletRequest request, Model model) throws Exception {
		
		Reserva reserva = new Reserva();
		reserva.setSolicitante(userBusiness.getCurrent().getTerceiro());
		
		List<Grupo> grupos = grupoBusiness.findAllByTerceito(reserva.getSolicitante());

		model.addAttribute("reserva", reserva);
		model.addAttribute("grupos", grupos);
		
		return "ok";
	}
}