package br.com.system.websys.business;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.ProdutoStatus;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.repository.GrupoRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class GrupoBusinessImpl extends BusinessBaseRootImpl<Grupo, GrupoRepository> implements GrupoBusiness {
    
	@Autowired
	protected GrupoBusinessImpl(GrupoRepository repository) {
		super(repository, Grupo.class);
	}
	
	@Override
	protected void validateBeforeSave(Grupo entity) throws Exception {
		// TODO Auto-generated method stub
	}
	
	@Override
	public Grupo salvar(Grupo grupo) throws Exception{
		if(grupo.getId() == null){
			grupoNovo(grupo);
			return super.salvar(grupo);
		}
		else{
			Grupo grupoBD = this.get(grupo.getId());
			grupoBD.setDescricao(grupo.getDescricao());
			grupoBD.setAtivo(grupo.getAtivo());
			grupoBD.setTerceiros(grupo.getTerceiros());
			if(grupoBD.getColor() == null || grupoBD.getColor().isEmpty()){
				StringBuffer sb = new StringBuffer();
				Random randCol = new Random();  
				for(int x = 0 ; x < 3 ; x++){
					for (int i = 0; i < 2; i++) {  
			            sb.append(Integer.toString(Math.abs(randCol.nextInt()) % 16, 16));  
			        }
				}				
				grupoBD.setColor("#"+sb.toString());				
			}
			return super.salvar(grupoBD);
		}
	}
	
	@Override
	public void grupoNovo(Grupo grupo){
		
		for(Produto produto : grupo.getProdutos()){
			produto.setStatus(ProdutoStatus.DISPONIVEL);
		}
		
		StringBuffer sb = new StringBuffer();
		Random randCol = new Random();  
		for(int x = 0 ; x < 3 ; x++){
			for (int i = 0; i < 2; i++) {  
	            sb.append(Integer.toString(Math.abs(randCol.nextInt()) % 16, 16));  
	        }
		}
		
		grupo.setColor("#"+sb.toString());

	}

	@Override
	public List<Grupo> getAll() {
		return ((GrupoRepository)repository).findAll();
	}

	@Override
	public List<Grupo> findAllByTerceito(Terceiro terceiro) {
		List<Grupo> grupos = ((GrupoRepository)repository).findByTerceiro(terceiro);
		return grupos;
	}

	@Override
	public List<Grupo> findAllByProduto(Produto produto) {
		List<Grupo> grupos = ((GrupoRepository)repository).findByProduto(produto);
		return grupos;
	}
	
	@Override
	public List<Grupo> findAllAtivos() {
		List<Grupo> grupos = ((GrupoRepository)repository).findAllAtivos();
		return grupos;
	}
}
