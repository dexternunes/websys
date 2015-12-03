package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.User;

public interface UserBusiness {


	User getCurrent();

	void salvar(User user) throws Exception;
	
	User get(Long id);

	User getByLogin(String login);
	
	public List<User> getAll();
}
