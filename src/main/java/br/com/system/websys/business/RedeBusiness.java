package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Rede;
import br.com.system.websys.repository.RedeRepository;

public interface RedeBusiness extends BusinessBaseRoot<Rede, RedeRepository> {

	Rede criar(String nome, String documento, String login, String senha) throws Exception;
	
	List<Rede> getAll();
	
	Rede getByDocumento(String documento);
	
	Rede getByLoginName(String login);
	
	Rede getCurrent() throws Exception;
	
}
