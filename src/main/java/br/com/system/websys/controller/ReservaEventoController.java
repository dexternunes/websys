package br.com.system.websys.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import br.com.system.websys.entities.ReservaDTO;
import br.com.system.websys.entities.ReservasDTO;
import br.com.system.websys.entities.dto.ReservaEventoDTO;

@Controller
@RequestMapping("/reservaEvento")
public class ReservaEventoController{
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String root(Model model, HttpServletRequest request) throws Exception {
		
		model.addAttribute("reservaEvento", new ReservaEventoDTO());
		
		return "testeUpload";
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String upload(@RequestParam("fileupload") MultipartFile fileupload, Model model) throws Exception {
		
		return "testeUpload";
	}
	
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

	
}