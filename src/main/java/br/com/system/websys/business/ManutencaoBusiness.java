package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Manutencao;
import br.com.system.websys.entities.ManutencaoStatus;
import br.com.system.websys.entities.Produto;
import br.com.system.websys.repository.ManutencaoRepository;

public interface ManutencaoBusiness extends BusinessBaseRoot<Manutencao, ManutencaoRepository> {
	
	public List<Manutencao> getAll();
	

	public List<Manutencao> findByProdutoByStatus(Produto produto, ManutencaoStatus status);

	
}
