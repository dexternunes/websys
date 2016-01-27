package br.com.system.websys.business;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.DefinirNovaSenhaDTO;
import br.com.system.websys.entities.RecuperarSenhaDTO;
import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.User;
import br.com.system.websys.repository.UserRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class UserBusinessImpl implements UserBusiness {

	@Autowired  
    private UserRepository userRepository;
	
	@Value("#{appProperties.primary_role}")
	private String primaryRole;
	
	@Autowired 
	private MailBusiness mailBusiness;

	@Override
	@Transactional(readOnly = true)
	public synchronized User getCurrent() {
		
		org.springframework.security.core.userdetails.User springUser;
		
		try {
			springUser = (org.springframework.security.core.userdetails.User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		}
		catch(ClassCastException e) {
			return null;
		}
		catch(NullPointerException e) {
			return null;
		}
		
		return getByLogin(springUser.getUsername());
	}

	@Override
	public void salvar(User user) throws Exception {
		
		if(user.getRole() == null)
			user.setRole(Role.valueOf(primaryRole));
		
		userRepository.save(user);				
	}

	@Override
	public User getUid(String uid) {
		return userRepository.findByUid(uid);  
	}
	
	@Override
	@Transactional(readOnly = true)
	public User get(Long id) {
		return userRepository.findOne(id);  
	}
	
	@Override
	@Transactional(readOnly = true)
	public User getByLogin(String login) {
		return userRepository.findByLogin(login);  
	}

	@Override
	public List<User> getAll() {
		return ((UserRepository)userRepository).findAll();
	}
	
	@Override
	public Boolean enviarEmailRecuperarSenha(RecuperarSenhaDTO recuperarSenha, String server) throws Exception {
		User user = ((UserRepository)userRepository).findByLogin(recuperarSenha.getLogin());
		
		if(user != null && user.getTerceiro().getEmails().equals(recuperarSenha.getEmail())){
			
			String uid = UUID.randomUUID().toString();
			user.setUidRecurerarSenha(uid);
			this.salvar(user);
			
			String link = server + "/websys/usuarios/recuperarsenha/" + uid; 
			 
			mailBusiness.sendMail("e2a.system@gmail.com", new String[]{user.getTerceiro().getEmails()}, 
					"Prime Share Club - Recuperação de Senha", "Você solicitou a recuperação do acesso ao Prime Share System "
							+ "<br><br> "
							+ "Clique <a href='" + link + "'>aqui</a> para cadastrar uma nova senha."
							+ "<br><br> "
							+ "Atenciosamente"
							+ "Equipe Prime Share Club");
			
			return true;
		}
		
		return false;
	}
	
	@Override
	public Boolean redefinirSenha(DefinirNovaSenhaDTO definirNovaSenhaDTO) throws Exception{
		User user = this.getUid(definirNovaSenhaDTO.getUid());
		
		if(user.getId().equals(definirNovaSenhaDTO.getIdUser())){
			if(definirNovaSenhaDTO.getSenha().equals(definirNovaSenhaDTO.getRepetirSenha())){
				user.setSenha(definirNovaSenhaDTO.getSenha());
				user.setUidRecurerarSenha(null);
				this.salvar(user);
				return true;
			}
		}
		
		return false;
	} 
	
	@Override
	public List<User> getByRoles(List<Role> roles){
		return userRepository.findByRoles(roles);
	}

}
