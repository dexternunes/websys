package br.com.system.websys.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="reserva_evento")
public class ReservaEvento extends EntityBaseRoot {

	private List<Imagem> imagens = new ArrayList<Imagem>();
	
	private Long hora;
	
	@Id
	@GeneratedValue
	@Column(name = "id_reserva_evento")
	@Override
	public Long getId() {
		return id;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="reservaEvento")
	public List<Imagem> getImagens() {
		return imagens;
	}

	public void setImagens(List<Imagem> imagens) {
		this.imagens = imagens;
	}

	public Long getHora() {
		return hora;
	}

	public void setHora(Long hora) {
		this.hora = hora;
	}

}
