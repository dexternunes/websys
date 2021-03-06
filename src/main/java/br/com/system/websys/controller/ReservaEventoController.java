package br.com.system.websys.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import br.com.system.websys.business.ImagemBusiness;
import br.com.system.websys.business.ReservaBusiness;
import br.com.system.websys.business.ReservaEventoBusiness;
import br.com.system.websys.entities.Imagem;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaEvento;

@Controller
@RequestMapping("/reservaEvento")
public class ReservaEventoController{
	
	@Autowired
	private ImagemBusiness imagemBusiness;
	
	@Autowired
	private ReservaEventoBusiness reservaEventoBusiness;
	
	@Autowired
	private ReservaBusiness reservaBusiness;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String root(Model model, HttpServletRequest request) throws Exception {
		
		model.addAttribute("reservaEvento", new ReservaEvento());
		
		return "reservaEvento";
	}
	
	@ResponseBody
	@RequestMapping(value = "/imagem/delete/{idImagem}", method = RequestMethod.GET)
	public String deleteImagem(@PathVariable("idImagem") Long idImagem, Model model, HttpServletRequest request) throws Exception {
		
		Imagem imagem = imagemBusiness.get(idImagem);
		if(imagemBusiness.delete(imagem))
			return "ok";
		
		return "error";
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String upload(@RequestParam("fileupload") MultipartFile fileupload, @RequestParam("reservaEventoId") Long reservaEventoId, Model model, HttpServletRequest request) throws Exception {
		
		
		if(!(fileupload.getContentType().equals("image/png")
			|| fileupload.getContentType().equals("image/bmp")
			|| fileupload.getContentType().equals("image/gif")
			|| fileupload.getContentType().equals("image/jpeg")))
			throw new Exception("Formato invalido");
		
		ReservaEvento reservaEvento = null;
		
		if(reservaEventoId != null)
			reservaEvento = reservaEventoBusiness.get(reservaEventoId);
		
		if(reservaEvento == null)
			reservaEvento = new ReservaEvento();
		
		String server;
		if(request.getServerPort() == 80)
			server = request.getServerName();
		else
			server = request.getServerName() + ":" + request.getServerPort();
		
		Imagem imagem = imagemBusiness.upload(fileupload, server);
		
		reservaEvento = reservaEventoBusiness.addImagem(reservaEvento, imagem);
        
		return "redirect:/reservaEvento/"+reservaEvento.getId();
	}
	
	@RequestMapping(value = "/{reservaEventoId}", method = RequestMethod.GET)
	public String get(@PathVariable("reservaEventoId") Long reservaEventoId, Model model, HttpServletRequest request) throws Exception {
		
		ReservaEvento reservaEvento = reservaEventoBusiness.get(reservaEventoId);
		
		model.addAttribute("reservaEvento", reservaEvento);
		
		return "reservaEvento";
	}
	
	@RequestMapping(value = "/salvar", method = RequestMethod.POST)
	public String salvarBase(@Valid @ModelAttribute("reservaEvento") ReservaEvento reservaEvento,
			BindingResult result, @RequestParam("submit") Boolean submit, Model model, HttpServletRequest request) throws Exception {
		
		ReservaEvento reventoBD = reservaEventoBusiness.get(reservaEvento.getId());
		reservaEvento.setImagens(reventoBD.getImagens());
		
		if (result.hasErrors()) {
			
			model.addAttribute("reservaEvento", reservaEvento);
			return "reservaEvento";
		}
	
		try {
			
			 String server = request.getRequestURL().toString().substring(0, request.getRequestURL().toString().indexOf(request.getRequestURI()));
			/*
			if (request.getServerPort() == 80)
				server = "http://" + request.getServerName();
			else
				server = "http://" + request.getServerName() + ":" + request.getServerPort();
			*/
			
			reservaBusiness.adicionaReservaEvento(reservaEvento, server);
		} catch (Exception e) {
			model.addAttribute("reservaEvento", reservaEvento);
			model.addAttribute("message", e.getMessage());
			return "reservaEvento";
		}
		
		if(submit)
			return "redirect:/home";
		
		else{
			model.addAttribute("reservaEvento", reservaEvento);
			return "reservaEvento";
		}
	}
		
}