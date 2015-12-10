package br.com.system.websys.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import br.com.system.websys.business.ImageResizeBusiness;
import br.com.system.websys.business.ImagemBusiness;
import br.com.system.websys.business.ReservaEventoBusiness;
import br.com.system.websys.entities.Imagem;
import br.com.system.websys.entities.ReservaEvento;

@Controller
@RequestMapping("/reservaEvento")
public class ReservaEventoController{
	
	@Autowired
	ImageResizeBusiness imageResizeBusiness;
	
	@Autowired
	ImagemBusiness imagemBusiness;
	
	@Autowired
	ReservaEventoBusiness reservaEventoBusiness;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String root(Model model, HttpServletRequest request) throws Exception {
		
		model.addAttribute("reservaEvento", new ReservaEvento());
		
		return "testeUpload";
	}
	
	@RequestMapping(value = "/{reservaEventoId}", method = RequestMethod.GET)
	public String get(@PathVariable("reservaEventoId") Long reservaEventoId, Model model, HttpServletRequest request) throws Exception {
		
		ReservaEvento reservaEvento = reservaEventoBusiness.get(reservaEventoId);
		model.addAttribute("reservaEvento", reservaEvento);
		
		return "testeUpload";
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String upload(@RequestParam("fileupload") MultipartFile fileupload, @RequestParam("reservaEventoId") Long reservaEventoId, Model model, HttpServletRequest request) throws Exception {
		
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
		
}