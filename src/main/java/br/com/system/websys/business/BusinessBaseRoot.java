package br.com.system.websys.business;

import java.util.List;

import javax.persistence.Query;

import org.hibernate.Criteria;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import br.com.system.websys.entities.EntityBaseRoot;
import br.com.system.websys.repository.RepositoryBaseRoot;


public interface BusinessBaseRoot<TBusiness extends EntityBaseRoot, TRepository extends RepositoryBaseRoot<TBusiness>> {

	TBusiness salvar(TBusiness entity) throws Exception;

	List<TBusiness> salvar(List<TBusiness> entities) throws Exception;

	TBusiness get(Long id) throws Exception;
	
	List<TBusiness> get(List<Long> ids) throws Exception;

	Page<TBusiness> findAll(Specification<TBusiness> specification, Pageable pageable);

	List<TBusiness> findAll(Specification<TBusiness> specification);

	void removeLocal(List<TBusiness> entities) throws Exception;

	void removeLocal(TBusiness entity) throws Exception;

	Criteria createCriteria();

	Criteria createCriteria(String alias);

	Query findNativeQuery(String sqlString);
}
