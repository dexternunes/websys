package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.repository.GrupoRepository;

public interface GrupoBusiness extends BusinessBaseRoot<Grupo, GrupoRepository> {
	
	public List<Grupo> getAll();

	public void grupoNovo(Grupo grupo);
	
	public List<Grupo> findAllByTerceito(Terceiro terceiro);
	
	public List<Grupo> findAllByProduto(Produto produto);

	public List<Grupo> findAllAtivos();
	
}
