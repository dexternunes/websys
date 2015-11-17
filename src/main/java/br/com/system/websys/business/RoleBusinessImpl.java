package br.com.system.websys.business;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Role;
import br.com.system.websys.repository.RoleRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class RoleBusinessImpl implements RoleBusiness {

	@Autowired
    private RoleRepository roleRepository;  
    	
	@Override
	public Role getByName(String name) {
		return roleRepository.findByName(name);
	}
}
