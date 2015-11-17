package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Ponto;
import br.com.system.websys.entities.Rede;
import br.com.system.websys.repository.PontoRepository;

public interface PontoBusiness extends BusinessBaseRoot<Ponto, PontoRepository> {
	
	List<Ponto> getAll();
	
	void remover(Ponto ponto);
	
	List<Ponto> getByRede(Rede rede);
}
