package br.com.system.websys.business;

import br.com.system.websys.entities.ReservaValidacao;
import br.com.system.websys.repository.ReservaValidacaoRepository;

public interface ReservaValidacaoBusiness extends BusinessBaseRoot<ReservaValidacao, ReservaValidacaoRepository> {
	
	public ReservaValidacao getByUid(String uid);

	
}
