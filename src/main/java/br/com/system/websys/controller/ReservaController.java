package br.com.system.websys.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.system.websys.business.ReservaBusiness;
import br.com.system.websys.business.TerceiroBusiness;
import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaDTO;
import br.com.system.websys.entities.ReservasDTO;
import br.com.system.websys.entities.User;

@Controller
@RequestMapping("/reserva")
public class ReservaController{
	
	@Autowired
	ReservaBusiness reservaBusiness;
	UserBusiness userBusiness;
	TerceiroBusiness terceiroBusiness;
	
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "/get", method = RequestMethod.GET)
	public ReservasDTO getReserva(HttpServletRequest request) throws Exception {
		
		ReservasDTO reservas = new ReservasDTO();
		reservas.getReservas().add(new ReservaDTO("Locação 1", new Date(115, 11, 5), new Date(115, 11, 7), false, "google.com.br"));
		reservas.getReservas().add(new ReservaDTO("Locação 2", new Date(115, 11, 8), new Date(115, 11, 9), false, "google.com.br"));
		reservas.getReservas().add(new ReservaDTO("Locação 3", new Date(115, 11, 10), new Date(115, 11, 12), false, "google.com.br"));
		reservas.getReservas().add(new ReservaDTO("Locação 4", new Date(115, 11, 30), new Date(115, 12, 6), false, "google.com.br"));
		reservas.getReservas().add(new ReservaDTO("Locação 5", new Date(115, 12, 7), new Date(115, 12, 12), false, "google.com.br"));
		
		return reservas;
	}
	
	@RequestMapping(value= "/post", method = RequestMethod.POST)
	public String postReserva(@ModelAttribute("reserva") Reserva reserva, @ModelAttribute("user") User user, BindingResult result, 
			Model model) throws Exception {
		
		
		
//		reserva.setAtivo(true);
//		reserva.setExcluido(false);
//		reserva.setSolicitante(userBusiness.get);
//		reserva.setStatus(ReservaStatus.APROVADA);
		//reserva.setFimReserva(new Date(Date.parse("2015-12-10")));
		//reserva.setInicioReserva(new Date(Date.parse("2015-12-10")));

//		if(result.hasErrors()){
//			for (ObjectError error : result.getAllErrors())
//				logger.info("Erro: " + error.toString());
//		}
		
		try{
		reservaBusiness.salvar(reserva);
		}
		catch(NullPointerException np){
			np.getMessage();
		}
		catch(Exception ex){

			return "home";
		}		
		
		return "home";
	}
}