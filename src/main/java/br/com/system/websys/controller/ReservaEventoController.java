package br.com.system.websys.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.MessageFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import br.com.system.websys.business.ImageResizeBusiness;
import br.com.system.websys.business.ImagemBusiness;
import br.com.system.websys.business.ReservaBusiness;
import br.com.system.websys.entities.Imagem;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaDTO;
import br.com.system.websys.entities.ReservaEvento;
import br.com.system.websys.entities.ReservasDTO;
import br.com.system.websys.entities.dto.ReservaEventoDTO;

@Controller
@RequestMapping("/reservaEvento")
public class ReservaEventoController{
	
	@Autowired
	ImageResizeBusiness imageResizeBusiness;
	
	@Autowired
	ImagemBusiness imagemBusiness;
	
	@Autowired
	ReservaBusiness reservaBusiness;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String root(Model model, HttpServletRequest request) throws Exception {
		
		model.addAttribute("reservaEvento", new ReservaEventoDTO());
		
		return "testeUpload";
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String upload(@RequestParam("fileupload") MultipartFile fileupload, @RequestParam("isInicio") Boolean isInicio, @RequestParam("reservaId") Long reservaId, Model model) throws Exception {
		
		Reserva reserva = reservaBusiness.get(reservaId);
		
		File file = readUploadedFile(fileupload);
		File fileResized = imageResizeBusiness.resize(file);
		
		byte[] bFile = new byte[(int) fileResized.length()];
     
        try {
            FileInputStream fileInputStream = new FileInputStream(fileResized);
            fileInputStream.read(bFile);
            fileInputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        Imagem imagem = new Imagem();
        
        imagem.setImagem(bFile);
        imagem.setName(file.getName());
        imagem.setSize(fileResized.length());
        imagem.setUid(UUID.randomUUID().toString());
        
        imagemBusiness.salvar(imagem);
        
        if(isInicio){
        	if(reserva.getEventoInicio() == null)
        		reserva.setEventoInicio(new ReservaEvento());
        	
        	reserva.getEventoInicio().getImagens().add(imagem);
        }
        else{
        	if(reserva.getEventoFim() == null)
        		reserva.setEventoFim(new ReservaEvento());
        	
        	reserva.getEventoFim().getImagens().add(imagem);
        }
        
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
	
	private File readUploadedFile(MultipartFile file) throws IOException, IllegalStateException {
		String tempPath = System.getProperty("java.io.tmpdir");
		String tempFile = UUID.randomUUID().toString();
		String extension = FilenameUtils.getExtension(file.getOriginalFilename());
		String fullPath = FilenameUtils.concat(tempPath, MessageFormat.format("{0}.{1}", tempFile, extension));
		File realFile = new File(fullPath);
		file.transferTo(realFile);
		return realFile;
	}

	
}