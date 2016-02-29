package br.com.system.websys.business;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import br.com.system.websys.entities.Imagem;
import br.com.system.websys.repository.ImagemRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class ImagemBusinessImpl extends BusinessBaseRootImpl<Imagem, ImagemRepository> implements ImagemBusiness {
    
	protected static final Logger logger = LogManager.getLogger(ImagemBusinessImpl.class);
	
	@Autowired
	protected ImagemBusinessImpl(ImagemRepository repository) {
		super(repository, Imagem.class);
	}

	
	@Autowired
	public ImageResizeBusiness imageResizeBusiness;
	
	@Override
	protected void validateBeforeSave(Imagem entity) throws Exception {
		
	}

	@Override
	public List<Imagem> getAll() {
		return ((ImagemRepository)repository).findAll();
	}
	
	@Override
	public Imagem upload(MultipartFile fileupload, String server) throws Exception{
		
		 if (!fileupload.isEmpty()) {
			 try {
				
				String realPathtoUploads = "/home/primesha/public_html/upload/";

				//String realPathtoUploads = "/mnt/files/";
				if(! new File(realPathtoUploads).exists())
				{
				    new File(realPathtoUploads).mkdir();
				}
				
				String uid = UUID.randomUUID().toString();
				String nameParts[] = fileupload.getOriginalFilename().split("\\.");
            	String fileName = uid + "." + nameParts[nameParts.length-1];
            	String filePath = realPathtoUploads + fileName;
				File dest = new File(filePath);
				fileupload.transferTo(dest);
                
				String url = "http://" + server + "/files-upload/" + fileName;
				Imagem imagem = new Imagem();
                
            	imagem.setUrl(url);
            	imagem.setName(fileName);
                imagem.setSize(fileupload.getSize());
                imagem.setUid(uid);
                return salvar(imagem);

            } catch (Exception e) {
            	
            	logger.error("ERRO NO UPLOAD DE IMAGEM: " + e.getMessage());
            	
                throw new Exception("Erro no upload e imagem: (" + e.getLocalizedMessage() + ") (" + e.getStackTrace() + ")");
            }
           
        }
		
		 return null;
	}

	public Boolean delete(Imagem imagem){
		
		 try {
			  	String filePath = "/home/primesha/public_html/upload/";
				//String filePath = "/mnt/files/" + imagem.getName();
				File file = new File(filePath);
				if(file.exists())
				{
					file.delete();
				}
				
				imagem.getReservaEvento().getImagens().remove(imagem);
				
				super.removeLocal(imagem);
				
				return true;
				
		 }
		 catch(Exception e){
			 return false;
		 }
		 
	}
	
}
