package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Imagem;
import br.com.system.websys.repository.ImagemRepository;

public interface ImagemBusiness extends BusinessBaseRoot<Imagem, ImagemRepository> {
	
	public List<Imagem> getAll();
	
}
