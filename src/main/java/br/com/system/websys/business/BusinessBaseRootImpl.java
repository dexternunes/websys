package br.com.system.websys.business;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.ejb.HibernateEntityManager;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.EntityBaseRoot;
import br.com.system.websys.repository.RepositoryBaseRoot;

public abstract class BusinessBaseRootImpl<TBusiness extends EntityBaseRoot, TRepository extends RepositoryBaseRoot<TBusiness>>
		implements BusinessBaseRoot<TBusiness, TRepository> {

	protected TRepository repository;
	
	@PersistenceContext
	protected EntityManager entityManager;

	protected Class<TBusiness> typeReference;
	
	protected BusinessBaseRootImpl(TRepository repository, Class<TBusiness> typeReference) {
		this.repository = repository;
		this.typeReference = typeReference;
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public TBusiness salvar(TBusiness entity) throws Exception {
		
		validateBeforeSave(entity);
		TBusiness resultado = repository.save(entity);
		executeAfterSave(resultado);
		
		return resultado;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public List<TBusiness> salvar(List<TBusiness> entities) throws Exception {

		for (TBusiness entity : entities)
			validateBeforeSave(entity);
		
		List<TBusiness> resultado = repository.save(entities);
		
		for (TBusiness entity : resultado)
			executeAfterSave(entity);
		
		return resultado;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public TBusiness get(Long id) throws Exception {
		return repository.findOne(id);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public List<TBusiness> get(List<Long> ids) throws Exception {		
		return iteratorToList(repository.findAll(ids).iterator());
	}
	
	protected List<TBusiness> iteratorToList(Iterator<TBusiness> iterator) {
	    List<TBusiness> copy = new ArrayList<TBusiness>();
	    while (iterator.hasNext())
	        copy.add(iterator.next());
	    return copy;
	}

	@Transactional(propagation=Propagation.REQUIRED)
	protected abstract void validateBeforeSave(TBusiness entity) throws Exception;
	
	@Transactional(propagation=Propagation.REQUIRED)
	protected void executeAfterSave(TBusiness entity) throws Exception {
		/*
		 * Caso algum business necessite executar algum relacionamento bidirecional com outra entidade dependente o sync com a API, pode utilizar este método para salvar a entidade e depois ajustar a referência na entidade dependente. 
		 * */
	};

	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public Page<TBusiness> findAll(Specification<TBusiness> specification, Pageable pageable) {		
		return repository.findAll(specification, pageable);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public List<TBusiness> findAll(Specification<TBusiness> specification) {
		return repository.findAll(specification);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public void removeLocal(List<TBusiness> entities) throws Exception {
		for(TBusiness entity : entities) {
			removeLocal(entity);
		}
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public void removeLocal(TBusiness entity) throws Exception {
		repository.delete(entity);
	}
	 
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public Criteria createCriteria(){
		return this.createCriteria(null);
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public Criteria createCriteria(String alias){
		HibernateEntityManager hem = entityManager.unwrap(HibernateEntityManager.class);
		Session session = hem.getSession();
		
		if(alias == null)
			return session.createCriteria(this.typeReference);
		
		return session.createCriteria(this.typeReference, alias);
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public Query findNativeQuery(String sqlString){
		return entityManager.createNativeQuery(sqlString);
	}
}
