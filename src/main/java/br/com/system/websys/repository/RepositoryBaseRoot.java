package br.com.system.websys.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import br.com.system.websys.entities.EntityBaseRoot;

public interface RepositoryBaseRoot<TBusiness extends EntityBaseRoot> extends JpaRepository<TBusiness, Long>, JpaSpecificationExecutor<TBusiness> {
	
}