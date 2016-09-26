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
import br.com.system.websys.business.ReservaBusiness;
import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.ProdutoStatus;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaStatus;
import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.User;

@Controller
public class HomeController {

	@Autowired
	private UserBusiness userBusiness;

	@Autowired
	private GrupoBusiness grupoBusiness;
	
	@Autowired
	private ReservaBusiness reservaBusiness;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String root() {
		return "redirect:/home";
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(HttpServletRequest request, Locale locale, Model model, Reserva reserva) {

		User user = userBusiness.getCurrent();
		List<Grupo> grupos;
		
		if(user.getRole().equals(Role.ROLE_COTISTA)){
			grupos = reservaBusiness.getGrupoPermiteReserva(user.getTerceiro());

			for (Grupo g : grupos) {
				if(g.getProdutos().get(0).getStatus().equals(ProdutoStatus.EM_MANUTENCAO)){
					model.addAttribute("emManutencao", 1);
				}
			}
			
			if(grupos.size() > 0)

				model.addAttribute("permiteReserva", 1);
			else{
				model.addAttribute("permiteReserva", 0);
			}
		}
		else
		{
			grupos = grupoBusiness.getAllByUser(user);
		}
		
		model.addAttribute("listaReservaGrupos", grupos);
		
		model.addAttribute("listaReservaStatus", ReservaStatus.values());
		
		if(user.getRole() == Role.ROLE_ADMIN){
			model.addAttribute("admin", 1);
		}
		else{
			model.addAttribute("admin",0);
		}
		
		if(user.getRole() == Role.ROLE_MARINHEIRO){
			model.addAttribute("marinheiro", 1);
		}
		else{
			model.addAttribute("marinheiro", 0);
		}
		
		if(!request.getHeader("User-Agent").contains("Firefox")){
			model.addAttribute("css", ".modal{position: absolute;}");
		}
		return "home";
	}
}
