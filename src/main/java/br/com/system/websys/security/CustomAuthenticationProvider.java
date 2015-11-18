package br.com.system.websys.security;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.business.UserBusiness;

@Service
@Transactional(readOnly=true)
public class CustomAuthenticationProvider implements UserDetailsService {
	
	@Autowired
	private UserBusiness userBusiness;	
	
	public UserDetails loadUserByUsername(String login)
			throws UsernameNotFoundException {
		
		br.com.system.websys.entities.User domainUser = userBusiness.getByLogin(login);
		
		boolean enabled = true;
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;
		
		return new User(
				login,
				domainUser.getSenha(),
				enabled, 
				accountNonExpired, 
				credentialsNonExpired, 
				accountNonLocked,
				getGrantedAuthorities(domainUser.getTerceiro().getRoles())
		);
	}
	
	public static List<GrantedAuthority> getGrantedAuthorities(Set<br.com.system.websys.entities.Role> userRoles) {
		
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		
		for (br.com.system.websys.entities.Role role : userRoles) 
			authorities.add(new SimpleGrantedAuthority(role.getName()));
		
		return authorities;
	} 

}	