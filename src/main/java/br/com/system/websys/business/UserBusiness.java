package br.com.system.websys.business;

import java.util.List;

import javax.mail.MessagingException;

import br.com.system.websys.entities.DefinirNovaSenhaDTO;
import br.com.system.websys.entities.RecuperarSenhaDTO;
import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.User;

public interface UserBusiness {


	public User getCurrent();

	public void salvar(User user) throws Exception;
	
	public User get(Long id);

	public User getByLogin(String login);
	
	public List<User> getAll();

	public Boolean enviarEmailRecuperarSenha(RecuperarSenhaDTO recuperarSenha, String server) throws MessagingException, Exception;

	public User getUid(String uid);

	public Boolean redefinirSenha(DefinirNovaSenhaDTO definirNovaSenhaDTO) throws Exception;
	
	public List<User> getByRoles(List<Role> roles);
}
