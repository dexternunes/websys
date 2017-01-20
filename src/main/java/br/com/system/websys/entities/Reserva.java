package br.com.system.websys.entities;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.Where;
import org.springframework.format.annotation.DateTimeFormat;

import br.com.system.websys.serializer.JsonDateTimeDeserializer;
import br.com.system.websys.serializer.JsonDateTimeSerializer;

@Entity
@Table(name = "reserva")
@Where(clause = "excluido = 0")
public class Reserva extends EntityBaseRoot {

	private Terceiro solicitante;

	private Grupo grupo;

	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	private Date inicioReserva;

	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	private Date fimReserva;

	private ReservaStatus status;

	private Boolean ativo = true;

	private Boolean excluido = false;

	private ReservaEvento eventoInicio;

	private ReservaEvento eventoFim;

	private Boolean utilizaMarinheiro = false;

	private List<ReservaValidacao> validacoes;

	private String obs;

	private FaturamentoStatus faturamentoStatus;

	private Long horaMotorTotal;

	private Boolean allDay = false;

	public Long getHoraMotorTotal() {
		return horaMotorTotal;
	}

	public void setHoraMotorTotal(Long horaMotorTotal) {
		this.horaMotorTotal = horaMotorTotal;
	}

	@Enumerated(EnumType.STRING)
	public FaturamentoStatus getFaturamentoStatus() {
		return faturamentoStatus;
	}

	public void setFaturamentoStatus(FaturamentoStatus faturamentoStatus) {
		this.faturamentoStatus = faturamentoStatus;
	}

	private Long segundoTotal;

	public Long getSegundoTotal() {
		return segundoTotal;
	}

	public void setSegundoTotal(Long segundoTotal) {
		this.segundoTotal = segundoTotal;
	}

	@Id
	@GeneratedValue
	@Column(name = "id_reserva")
	@Override
	public Long getId() {
		return id;
	}

	@ManyToOne(cascade = { CascadeType.DETACH, CascadeType.REFRESH })
	@JoinColumn(name = "id_terceiro", referencedColumnName = "id_terceiro")
	public Terceiro getSolicitante() {
		return solicitante;
	}

	public void setSolicitante(Terceiro solicitante) {
		this.solicitante = solicitante;
	}

	@ManyToOne(cascade = { CascadeType.DETACH, CascadeType.REFRESH, CascadeType.PERSIST })
	@JoinColumn(name = "id_grupo", referencedColumnName = "id_grupo")
	public Grupo getGrupo() {
		return grupo;
	}

	public void setGrupo(Grupo grupo) {
		this.grupo = grupo;
	}

	@JsonSerialize(using = JsonDateTimeSerializer.class)
	public Date getInicioReserva() {
		return inicioReserva;
	}

	@JsonDeserialize(using = JsonDateTimeDeserializer.class)
	public void setInicioReserva(Date inicioReserva) {
		this.inicioReserva = inicioReserva;
	}

	@JsonSerialize(using = JsonDateTimeSerializer.class)
	public Date getFimReserva() {
		return fimReserva;
	}

	@JsonDeserialize(using = JsonDateTimeDeserializer.class)
	public void setFimReserva(Date fimReserva) {
		this.fimReserva = fimReserva;
	}

	@Enumerated(EnumType.STRING)
	public ReservaStatus getStatus() {
		return status;
	}

	public void setStatus(ReservaStatus status) {
		this.status = status;
	}

	public Boolean getExcluido() {
		return excluido;
	}

	public void setExcluido(Boolean excluido) {
		this.excluido = excluido;
	}

	public Boolean getAtivo() {
		return ativo;
	}

	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}

	public Boolean getUtilizaMarinheiro() {
		return utilizaMarinheiro;
	}

	public void setUtilizaMarinheiro(Boolean utilizaMarinheiro) {
		this.utilizaMarinheiro = utilizaMarinheiro;
	}

	public String getObs() {
		return obs;
	}

	public void setObs(String obs) {
		this.obs = obs;
	}

	@OneToOne(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH })
	@JoinColumn(name = "id_reserva_evento_inicio", referencedColumnName = "id_reserva_evento")
	public ReservaEvento getEventoInicio() {
		return eventoInicio;
	}

	public void setEventoInicio(ReservaEvento eventoInicio) {
		this.eventoInicio = eventoInicio;
	}

	@OneToOne(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH })
	@JoinColumn(name = "id_reserva_evento_fim", referencedColumnName = "id_reserva_evento")
	public ReservaEvento getEventoFim() {
		return eventoFim;
	}

	public void setEventoFim(ReservaEvento eventoFim) {
		this.eventoFim = eventoFim;
	}

	@ManyToMany(cascade = { CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH })
	@JoinTable(name = "reserva_has_reserva_validacao", joinColumns = {
			@JoinColumn(name = "id_reserva", referencedColumnName = "id_reserva") }, inverseJoinColumns = {
					@JoinColumn(name = "id_reserva_validacao", referencedColumnName = "id_reserva_validacao") })
	public List<ReservaValidacao> getValidacoes() {
		return validacoes;
	}

	public void setValidacoes(List<ReservaValidacao> validacoes) {
		this.validacoes = validacoes;
	}

	public Boolean getAllDay() {
		return allDay;
	}

	public void setAllDay(Boolean allDay) {
		this.allDay = allDay;
	}

}
