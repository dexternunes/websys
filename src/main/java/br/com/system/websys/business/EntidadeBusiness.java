package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Entidade;
import br.com.system.websys.entities.User;
import br.com.system.websys.repository.EntidadeRepository;

public interface EntidadeBusiness extends BusinessBaseRoot<Entidade, EntidadeRepository> {
	
	List<Entidade> getAllOrder();

	List<Entidade> findAllOrderByUser(User user);
	
}
