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
import br.com.system.websys.business.ReservaValidacaoBusiness;
import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaDTO;
import br.com.system.websys.entities.ReservaValidacao;
import br.com.system.websys.entities.ReservasDTO;
import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.User;

@Controller
@RequestMapping("/reserva")
public class ReservaController{
	
	private static final Logger logger = LoggerFactory
			.getLogger(TerceiroController.class);
	
	@Autowired
	private ReservaBusiness reservaBusiness;
	
	@Autowired
	private UserBusiness userBusiness;
	
	@Autowired
	private ReservaValidacaoBusiness reservaValidacaoBusiness;
	
	@Autowired
	private GrupoBusiness grupoBusiness;
	
	@RequestMapping(value="/salvar", method = RequestMethod.POST)
	public String salvarBase(HttpServletRequest request, @Valid @ModelAttribute("reserva") Reserva reserva,
			BindingResult result, RedirectAttributes attr) throws Exception {

		if (result.hasErrors()) {

			for (ObjectError error : result.getAllErrors())
				logger.info("Erro: " + error.toString());
			
			return "redirect:/home";
		}

		try {
			
			String server;
			if(request.getServerPort() == 80)
				server = "http://" + request.getServerName();
			else
				server = "http://" + request.getServerName() + ":" + request.getServerPort();
			
			if(reserva.getId()==null){
				reserva = reservaBusiness.createReserva(reserva);				
			}
			else{				
				Reserva reservaBD = reservaBusiness.get(reserva.getId());
				reserva.setEventoInicio(reservaBD.getEventoInicio());
				reserva.setEventoFim(reservaBD.getEventoFim());
				reserva.setSolicitante(reservaBD.getSolicitante());
			}
			reserva = reservaBusiness.salvar(reserva);
			reservaBusiness.sendEmailValidacao(reserva, server);
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
		
		User userBD = userBusiness.getCurrent();
		
		if(userBD.getRole().equals(Role.ROLE_ADMIN) || userBD.getRole().equals(Role.ROLE_MARINHEIRO)){
			listReservas = reservaBusiness.getAll();
		}
		else		
			listReservas = reservaBusiness.getAllByGrupo(grupoBusiness.findAllByTerceito(userBD.getTerceiro()));
		
		for(Reserva reserva: listReservas){
			if(reserva.getInicioReserva() != null && reserva.getFimReserva() != null && reserva.getSolicitante().getNome() != null){

			reservas.getReservas().add(new ReservaDTO(reserva.getId(), reserva.getSolicitante().getNome(), reserva.getInicioReserva(), 
					reserva.getFimReserva(), false, "", reserva.getUtilizaMarinheiro(), reserva.getObs(), reserva.getStatus()));
			}
		}
		return reservas;
	}
	
	@ResponseBody
	@RequestMapping(value = "/get/{id}", method = RequestMethod.GET )
	public void getReservaById(@PathVariable Long id, Model model) throws Exception {
		
		Reserva reserva = reservaBusiness.get(id);
		model.addAttribute("reserva", reserva);
	}
	
	@RequestMapping(value = "/validar/{uid}", method = RequestMethod.GET )
	public String validarReserva(@PathVariable String uid, Model model) throws Exception {
		
		ReservaValidacao reservaValidacao = reservaValidacaoBusiness.getByUid(uid);
		model.addAttribute("reservaValidacao", reservaValidacao);
		
		return "reserva/validarReserva";
	}
	
	@RequestMapping(value="/validar/salvar", method = RequestMethod.POST)
	public String salvarValidacao(HttpServletRequest request, @ModelAttribute("reservaValidacao") ReservaValidacao reservaValidacao,
			BindingResult result, Model model) throws Exception{
		
		ReservaValidacao reservaValidacaoDB = reservaValidacaoBusiness.getByUid(reservaValidacao.getUid());
		
		reservaValidacaoDB.setValidado(true);
		reservaValidacaoDB.setMotivo(reservaValidacao.getMotivo());
		reservaValidacaoDB.setAprovado(reservaValidacao.getAprovado());
		
		reservaValidacaoBusiness.salvar(reservaValidacaoDB);
		
		model.addAttribute("message", "Obrigado validar a locação!");
		
		return "reserva/validarReserva";
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