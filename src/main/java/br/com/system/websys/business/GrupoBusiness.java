package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.User;
import br.com.system.websys.repository.GrupoRepository;

public interface GrupoBusiness extends BusinessBaseRoot<Grupo, GrupoRepository> {
	
	public List<Grupo> getAll();
	
	public List<Grupo> getAllOrderByDescricaoAsc();

	public void grupoNovo(Grupo grupo);
	
	public List<Grupo> findAtivosByTerceito(Terceiro terceiro);
	
	public List<Grupo> findAtivosByProduto(Produto produto);

	public List<Grupo> findAllAtivos();	
	
	public List<Grupo> getByTerceiro(Terceiro terceiro);

	public Grupo delete(Grupo grupo) throws Exception;

	public List<Grupo> findAllByProduto(Produto produto);

	public List<Grupo> getAllByUser(User user);
}
