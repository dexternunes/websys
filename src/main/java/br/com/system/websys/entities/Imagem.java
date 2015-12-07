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

}
