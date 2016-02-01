package br.com.system.websys.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.core.MediaType;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.system.websys.business.GrupoBusiness;
import br.com.system.websys.business.ParseDTO;
import br.com.system.websys.business.ReservaBusiness;
import br.com.system.websys.business.ReservaValidacaoBusiness;
import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.GrupoDTO;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaDTO;
import br.com.system.websys.entities.ReservaEventoDTO;
import br.com.system.websys.entities.ReservaStatus;
import br.com.system.websys.entities.ReservaValidacao;
import br.com.system.websys.entities.ReservaValidacaoStatus;
import br.com.system.websys.entities.ReservasDTO;
import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.TerceiroDTO;
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
	
	@Autowired
	private ParseDTO parseReserva;
	
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
				reserva.setGrupo(reservaBD.getGrupo());
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
	@RequestMapping(value="/api/salvar", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON)
	public ReservaValidacaoStatus salvar(HttpServletRequest request, @RequestBody ReservaDTO reservaDTO) throws Exception {

		Reserva reserva = parseReserva.parseReservaDTO2Reserva(reservaDTO);
		
		ReservaValidacaoStatus statusReserva = reservaBusiness.validaReserva(reserva);
		
		try {
			
			String server;
			if(request.getServerPort() == 80)
				server = "http://" + request.getServerName();
			else
				server = "http://" + request.getServerName() + ":" + request.getServerPort();
			
			if(statusReserva.equals(ReservaValidacaoStatus.OK)){
				if(reservaDTO.getId() != null){
					reserva = reservaBusiness.salvar(reserva);
					reservaBusiness.sendEmailValidacao(reserva, server);					
				}
				else
					reserva = reservaBusiness.salvar(reserva);				
			}
			
		} catch (Exception e) {
			throw new Exception("Erro ao salvar a solicitação");
		}
		
		return statusReserva;
	}
	
	@ResponseBody
	@RequestMapping(value = "/api/get", method = RequestMethod.GET )
	public ReservasDTO getReserva(HttpServletRequest request) throws Exception {
		
		ReservasDTO reservas = new ReservasDTO();
		
		User userBD = userBusiness.getCurrent();
		List<Reserva> listReservas = reservaBusiness.getReservasParaExibicao(userBD);
		
		for(Reserva reserva: listReservas){
			if(reserva.getInicioReserva() != null && reserva.getFimReserva() != null && reserva.getSolicitante().getNome() != null){
				
				String tipo_evento = "";
				
				if(reserva.getStatus().equals(ReservaStatus.AGUARDANDO_APROVACAO)){
					tipo_evento = "[S] ";
				}
				
				if(reserva.getStatus().equals(ReservaStatus.APROVADA)){
					tipo_evento = "[R] ";
				}
				
				if(reserva.getStatus().equals(ReservaStatus.EM_USO)){
					tipo_evento = "[E] ";
				}

			reservas.getReservas().add(new ReservaDTO(
					reserva.getId(), 
					tipo_evento + reserva.getSolicitante().getNome(), 
					new TerceiroDTO(reserva.getSolicitante().getId(), reserva.getSolicitante().getNome()),
					reserva.getInicioReserva(),
					reserva.getFimReserva(), 
					reserva.getUtilizaMarinheiro(), 
					reserva.getObs(), 
					reserva.getStatus(),
					new ReservaEventoDTO(reserva.getEventoInicio().getId()), 
					new ReservaEventoDTO(reserva.getEventoFim().getId()), 
					new GrupoDTO(reserva.getGrupo().getId(), reserva.getGrupo().getDescricao(), reserva.getGrupo().getColor())));
			}
		}
		return reservas;
	}
	
	@ResponseBody
	@RequestMapping(value = "/api/get/{id}", method = RequestMethod.GET )
	public ReservaDTO getReservaById(@PathVariable Long id, Model model, @RequestParam("dataReserva") String dataReserva) throws Exception {
		
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		
		Date data = format.parse(dataReserva);				
		
		ReservaDTO reservas = reservaBusiness.getReservaDTOById(id, userBusiness.getCurrent().getTerceiro(), data);
		
		return reservas;
	}
	
	@ResponseBody
	@RequestMapping(value = "/api/getReservaSolicitante", method = RequestMethod.GET )
	public ReservasDTO getReservaSolicitante() throws Exception {

		User user = userBusiness.getCurrent();

		ReservasDTO reservas = new ReservasDTO();
		
		for(Reserva reserva : reservaBusiness.getReservaByTerceiro(user.getTerceiro())){
			reservas.getReservas().add(new ReservaDTO(
					reserva.getId(), 
					reserva.getSolicitante().getNome(), 
					new TerceiroDTO(reserva.getSolicitante().getId(), reserva.getSolicitante().getNome()),
					reserva.getInicioReserva(),
					reserva.getFimReserva(), 
					reserva.getUtilizaMarinheiro(), 
					reserva.getObs(), 
					reserva.getStatus(),
					new ReservaEventoDTO(reserva.getEventoInicio().getId()), 
					new ReservaEventoDTO(reserva.getEventoFim().getId()), 
					new GrupoDTO(reserva.getGrupo().getId(), reserva.getGrupo().getDescricao(), reserva.getGrupo().getColor())));
		}

		return reservas;
	}
	
	@ResponseBody
	@RequestMapping(value = "/api/getGruposSolicitante", method = RequestMethod.GET )
	public List<Grupo> getGruposSolicitante() throws Exception {

		User user = userBusiness.getCurrent();
		List<Grupo> grupos;
		
		if(user.getRole().equals(Role.ROLE_COTISTA))
			grupos = reservaBusiness.getGrupoPermiteReserva(user.getTerceiro());
		else
			grupos = grupoBusiness.findAllAtivos();
		
		return grupos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/api/validaExclusao/{id}", method = RequestMethod.GET )
	public String validaExclusao(@PathVariable Long id) throws Exception {
		Reserva reserva = reservaBusiness.get(id);
		
		String retorno = reservaBusiness.validaExclusao(reserva);
		
		return retorno;
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