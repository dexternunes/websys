package br.com.system.websys.specifications;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import br.com.system.websys.entities.Ponto;

public class PontoSpecification <T extends Ponto> {
	
	private Root<T> root;
	
	@SuppressWarnings("unused")
	private CriteriaQuery<?> query; 
	
	private CriteriaBuilder cb;
	
	public PontoSpecification(Root<T> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
		this.root = root;
		this.query = query;
		this.cb = cb;
	}
			
	public Predicate in(List<Long> ids) {
		return root.get("id").in(ids);
	}
	
	public Predicate nomeLike(String nome) {
        return cb.like(cb.lower(root.<String>get("nome")), '%' + nome.toLowerCase() + '%');
	}

}