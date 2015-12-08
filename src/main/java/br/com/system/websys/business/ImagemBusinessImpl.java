package br.com.system.websys.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Imagem;
import br.com.system.websys.repository.ImagemRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class ImagemBusinessImpl extends BusinessBaseRootImpl<Imagem, ImagemRepository> implements ImagemBusiness {
    
	@Autowired
	protected ImagemBusinessImpl(ImagemRepository repository) {
		super(repository, Imagem.class);
	}

	@Override
	protected void validateBeforeSave(Imagem entity) throws Exception {
		
	}

	@Override
	public List<Imagem> getAll() {
		return ((ImagemRepository)repository).findAll();
	}
	
}
