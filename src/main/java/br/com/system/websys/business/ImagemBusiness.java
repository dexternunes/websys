package br.com.system.websys.business;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import br.com.system.websys.entities.Imagem;
import br.com.system.websys.repository.ImagemRepository;

public interface ImagemBusiness extends BusinessBaseRoot<Imagem, ImagemRepository> {
	
	public List<Imagem> getAll();

	public Imagem upload(MultipartFile fileupload, String server) throws Exception;
	
	public Boolean delete(Imagem imagem);
	
}
