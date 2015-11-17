package br.com.system.websys.business;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.User;
import br.com.system.websys.repository.UserRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class UserBusinessImpl implements UserBusiness {

	@Autowired  
    private UserRepository userRepository;  
	
	@Autowired  
	private RoleBusiness roleBusiness;
	
	@Value("#{appProperties.primary_role}")
	private String primaryRole;

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
		user.getTerceiro().getRoles().add(roleBusiness.getByName(primaryRole));		
		userRepository.save(user);				
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

}
