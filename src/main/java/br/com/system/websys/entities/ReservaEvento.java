package br.com.system.websys.entities;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.springframework.format.annotation.DateTimeFormat;

import br.com.system.websys.serializer.JsonDateTimeDeserializer;
import br.com.system.websys.serializer.JsonDateTimeSerializer;

@Entity
@Table(name="reserva_evento")
public class ReservaEvento extends EntityBaseRoot {

	private Boolean isEventoFim = false;

	private List<Imagem> imagens = new ArrayList<Imagem>();
	
	private Long hora;
	
	private String obs;
	
	@DateTimeFormat(pattern="dd/MM/yyyy HH:mm")
	private Date horaRegistro;
	
	@Id
	@GeneratedValue
	@Column(name = "id_reserva_evento")
	@Override
	public Long getId() {
		return id;
	}

	@OneToMany(cascade = CascadeType.ALL, mappedBy="reservaEvento")
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

	@JsonSerialize( using=JsonDateTimeSerializer.class)
	public Date getHoraRegistro() {
		return horaRegistro;
	}

	@JsonDeserialize( using=JsonDateTimeDeserializer.class)
	public void setHoraRegistro(Date horaRegistro) {
		this.horaRegistro = horaRegistro;
	}

	public String getObs() {
		return obs;
	}

	public void setObs(String obs) {
		this.obs = obs;
	}

	public Boolean getIsEventoFim() {
		return isEventoFim;
	}

	public void setIsEventoFim(Boolean isEventoFim) {
		this.isEventoFim = isEventoFim;
	}
	
}
