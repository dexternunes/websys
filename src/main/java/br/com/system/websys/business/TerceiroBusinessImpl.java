package br.com.system.websys.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.TerceiroContato;
import br.com.system.websys.entities.TerceiroEndereco;
import br.com.system.websys.entities.TerceiroExclusaoStatus;
import br.com.system.websys.entities.TerceiroTipo;
import br.com.system.websys.repository.TerceiroRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class TerceiroBusinessImpl extends BusinessBaseRootImpl<Terceiro, TerceiroRepository> implements TerceiroBusiness {
    
	@Autowired
	protected TerceiroBusinessImpl(TerceiroRepository repository) {
		super(repository, Terceiro.class);
	}
	
	@Autowired
	private UserBusiness userBusiness;
	
	@Autowired
	private GrupoBusiness grupoBusiness;

	@Override
	protected void validateBeforeSave(Terceiro entity) throws Exception {
		for(TerceiroEndereco endereco : entity.getEnderecos()){
			endereco.setTerceiro(entity);
		}
		for(TerceiroContato contato : entity.getContatos()){
			contato.setTerceiro(entity);
		}
	}

	@Override
	public List<Terceiro> getAll() {
		return ((TerceiroRepository)repository).getAll();
	}

	@Override
	public List<Terceiro> getAllByTipo(TerceiroTipo tipo) {

		List<Terceiro> terceiros = ((TerceiroRepository)repository).findAllByTipo(tipo);

		if(terceiros == null || terceiros.size() == 0)
			return ((TerceiroRepository)repository).getAll();
		else
			return terceiros; 
	}

	public TerceiroExclusaoStatus validaExclusao(Terceiro terceiro){

		if(terceiroHasUser(terceiro)){
			return TerceiroExclusaoStatus.TERCEIRO_USUARIO;
		}

		if(terceiroHasGrupo(terceiro)){
			return TerceiroExclusaoStatus.TERCEIRO_GRUPO;
		}
		return TerceiroExclusaoStatus.OK;
	}

	private Boolean terceiroHasUser(Terceiro terceiro){

		if(userBusiness.getUserByTerceiro(terceiro) != null)
			return true;

		return false;
	}

	private Boolean terceiroHasGrupo(Terceiro terceiro){
		
		if(grupoBusiness.findAtivosByTerceito(terceiro).size() > 0)
			return true;

		return false;
	}

	@Override
	public List<Terceiro> getAllByRole(Role role) {
		return ((TerceiroRepository)repository).getAllByRole(role);
	}
}
