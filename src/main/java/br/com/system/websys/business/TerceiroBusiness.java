package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.TerceiroTipo;
import br.com.system.websys.repository.TerceiroRepository;

public interface TerceiroBusiness extends BusinessBaseRoot<Terceiro, TerceiroRepository> {
	
	public List<Terceiro> getAll();

	public List<Terceiro> getAllByTipo(TerceiroTipo tipo);
	
}
