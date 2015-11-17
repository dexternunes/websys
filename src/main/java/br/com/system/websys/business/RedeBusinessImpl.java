package br.com.system.websys.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Rede;
import br.com.system.websys.repository.RedeRepository;

@Service
@Transactional
public class RedeBusinessImpl extends BusinessBaseRootImpl<Rede, RedeRepository> implements RedeBusiness {

	@Autowired
	protected RedeBusinessImpl(RedeRepository repository) {
		super(repository, Rede.class);
	}

	@Override
	public Rede criar(String nome, String documento, String login, String senha) throws Exception {
		
		Rede rede = new Rede();
		
		rede.setNome(nome);
		rede.setDocumento(documento);
		rede.setLogin(login);
		rede.setSenha(senha);
		
		rede = salvar(rede);
		
		return rede;
	}

	@Override
	public List<Rede> getAll() {
		return ((RedeRepository)repository).findAll();
	}

	@Override
	public Rede getByLoginName(String login) {
		return ((RedeRepository)repository).findByLogin(login);
	}

	@Override
	public Rede getByDocumento(String documento) {
		return ((RedeRepository)repository).findByDocumento(documento);
	}

	@Override
	protected void validateBeforeSave(Rede entity) throws Exception {
		
		if(entity.getId() == null) 
			return;
		
		Rede current = get(entity.getId());
		entity.setProperties(current.getProperties());
	}

	@Override
	public Rede getCurrent() throws Exception {
		
		String login = "";
		try {
			login = SecurityContextHolder.getContext().getAuthentication().getName();
		}
		catch(NullPointerException e) {
			throw new SecurityException("A requisição atual não está associada à um contexto de segurança autenticado no aplicativo.");
		}
		
		if(login.trim().isEmpty()) 
			return null;
		
		Rede rede = getByLoginName(login);		
		if(rede == null)
			throw new Exception(login);		
		
		return rede;
	}
}
