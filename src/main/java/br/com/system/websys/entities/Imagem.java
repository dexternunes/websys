package br.com.system.websys.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="imagem")
public class Imagem extends EntityBaseRoot {

	private String imagem;
	
	private String uid;
	
	private String size;
	
	private String name;

	@Id
	@GeneratedValue
	@Column(name = "id_imagem")
	@Override
	public Long getId() {
		return id;
	}

	@Column(columnDefinition="LONGTEXT")
	public String getImagem() {
		return imagem;
	}

	public void setImagem(String imagem) {
		this.imagem = imagem;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
