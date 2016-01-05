package br.com.system.websys.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.com.system.websys.business.GrupoBusiness;
import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Reserva;

@Controller
public class HomeController {

	@Autowired
	private UserBusiness userBusiness;

	@Autowired
	private GrupoBusiness grupoBusiness;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String root() {
		return "redirect:/home";
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(HttpServletRequest request, Locale locale, Model model, Reserva reserva) {

		if (reserva.getId() == null) {
			reserva = new Reserva();
			reserva.setSolicitante(userBusiness.getCurrent().getTerceiro());
		}

		List<Grupo> grupos = grupoBusiness.findAllByTerceito(userBusiness.getCurrent().getTerceiro());

		model.addAttribute("reserva", reserva);
		model.addAttribute("listaReservaGrupos", grupos);

		return "home";
	}
}
