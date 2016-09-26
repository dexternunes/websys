package br.com.system.websys.business;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.FaturamentoStatus;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.GrupoDTO;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaDTO;
import br.com.system.websys.entities.ReservaEvento;
import br.com.system.websys.entities.ReservaEventoDTO;
import br.com.system.websys.entities.ReservaStatus;
import br.com.system.websys.entities.ReservaValidacao;
import br.com.system.websys.entities.ReservaValidacaoStatus;
import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.TerceiroDTO;
import br.com.system.websys.entities.User;
import br.com.system.websys.formatter.Formatters;
import br.com.system.websys.repository.ReservaRepository;

@Service
@Transactional(propagation = Propagation.REQUIRED)
class ReservaBusinessImpl extends BusinessBaseRootImpl<Reserva, ReservaRepository> implements ReservaBusiness {

	@Autowired
	public UserBusiness userBusiness;
	
	@Autowired
	public TerceiroBusiness terceiroBusiness;

	@Autowired
	public GrupoBusiness grupoBusiness;

	@Autowired
	public MailBusiness mailBusiness;

	@Autowired
	protected ReservaBusinessImpl(ReservaRepository repository) {
		super(repository, Reserva.class);
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	@Override
	public Reserva salvar(Reserva reserva) throws Exception {
		return super.salvar(reserva);
	}

	@Override
	protected void validateBeforeSave(Reserva entity) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public List<Reserva> getAll() {
		return ((ReservaRepository) repository).findAll();
	}

	public List<Reserva> getAllByGrupo(List<Grupo> grupos) {
		List<Reserva> reserva = ((ReservaRepository) repository).getAllByGrupo(grupos);
		return reserva;
	}

	public Reserva getReservaByEvento(ReservaEvento reservaEvento) {
		Reserva reserva = ((ReservaRepository) repository).getReservaByEvento(reservaEvento);
		return reserva;
	}

	@Override
	public Reserva createReserva(Reserva reserva) throws Exception {
		reserva.setEventoInicio(new ReservaEvento());
		reserva.setEventoFim(new ReservaEvento());
		reserva.setStatus(ReservaStatus.AGUARDANDO_APROVACAO);
		reserva.setSolicitante(userBusiness.getCurrent().getTerceiro());

		List<ReservaValidacao> validacoes = new ArrayList<ReservaValidacao>();
		for (Terceiro terceiro : reserva.getGrupo().getTerceiros()) {
			if (!reserva.getSolicitante().equals(terceiro)) {
				ReservaValidacao validacao = new ReservaValidacao();
				validacao.setTerceiro(terceiro);
				validacao.setUid(UUID.randomUUID().toString());
				validacao.setReserva(reserva);
				validacoes.add(validacao);
			}
		}

		reserva.setValidacoes(validacoes);

		return reserva;
	}

	@Override
	public Boolean sendEmailValidacao(Reserva reserva, String server) throws Exception {

		List<Terceiro> terceiroList = reserva.getGrupo().getTerceiros();

		for (Terceiro terceiro : terceiroList) {
			mailBusiness.sendMail("websys@primeshareclub.com.br", new String[] { terceiro.getEmails() },

					"Prime Share Club - Reserva Solicitada",
					"<div align='center' style='background-color:rgb(255,255,255)'></br></br>"
							+ "<div align='center' style='background-color:rgb(255,255,255)'>"
							+ "	<img width='112' height='110' alt='Logo' src='http://ec2-54-233-141-81.sa-east-1.compute.amazonaws.com/files-upload/icon-embarcacoes.png'  />"
							+ "</div>" + "</br></br><font color='#1C3C6A'>"
							+ "	<h3>Uma nova reserva foi solicitada </h3><br /><br /> Embarcação: "
							+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />" + "	Solicitante: "
							+ reserva.getSolicitante().getNome() + "<br />" + "	Data inicio da reserva: "
							+ Formatters.formatDate(reserva.getInicioReserva()) 
							+ "<br />" 
							+ "	Data fim da reserva: "
							+ Formatters.formatDate(reserva.getFimReserva()) 
							+ "<br />" 
							+ "	Utiliza Marinheiro: "
							+ (reserva.getUtilizaMarinheiro() ? "Sim" : "Não") 
							+ "<br />" 
							+ "	Observação: "
							+ reserva.getObs() + "<br /><br />Att,<br /> " + "	</font>"
							+ "	<div>"
							+ "		<h2><font color='#1C3C6A' size=26px> EQUIPE PRIME SHARE CLUB </font></h2>"
							+ "		<p><font color='#1C3C6A'>©2016 All Rights Reserved.</font></p>" + "	</div> "
							+ "</br></br></div>");
		}
		return false;
	}

	public Boolean sendEmailInterno(Reserva reserva) throws Exception {

		List<Terceiro> terceiros = terceiroBusiness.getAllByRole(Role.ROLE_ADMIN);
		
		if(reserva.getGrupo().getMarinheiros() != null && reserva.getGrupo().getMarinheiros().size() > 0)
			terceiros.addAll(reserva.getGrupo().getMarinheiros());
		
		for (Terceiro terceiro : terceiros) {
			mailBusiness.sendMail("websys@primeshareclub.com.br", new String[] { terceiro.getEmails() },
					"Prime Share Club - Reserva Solicitada",
					"<div align='center' style='background-color:rgb(255,255,255)'></br></br>"
							+ "<div align='center' style='background-color:rgb(255,255,255)'>"
							+ "	<img width='112' height='110' alt='Logo' src='http://ec2-54-233-141-81.sa-east-1.compute.amazonaws.com/files-upload/icon-embarcacoes.png'  />"
							+ "</div>" + "</br></br><font color='#1C3C6A'>"
							+ "	<h3>Uma nova reserva foi solicitada </h3><br /><br /> Embarcação: "
							+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />" + "	Solicitante: "
							+ reserva.getSolicitante().getNome() + "<br />" + "	Data inicio da reserva: "
							+ Formatters.formatDate(reserva.getInicioReserva()) + "<br />" + "	Data fim da reserva: "
							+ Formatters.formatDate(reserva.getFimReserva())
							+ "<br />" 
							+ "	Utiliza Marinheiro: "
							+ (reserva.getUtilizaMarinheiro() ? "Sim" : "Não") 
							+ "<br />" 
							+ "	Observação: "
							+ reserva.getObs() + "<br /><br />Att,<br /> " + "	</font>"
							+ "	<div>"
							+ "		<h2><font color='#1C3C6A' size=26px> EQUIPE PRIME SHARE CLUB </font></h2>"
							+ "		<p><font color='#1C3C6A'>©2016 All Rights Reserved.</font></p>" + "	</div> "
							+ "</br></br></div>");
		}
		return false;
	}

	@Override
	public List<Reserva> getReservaByTerceiro(Terceiro terceiro) {

		List<ReservaStatus> status = new ArrayList<ReservaStatus>();

		status.add(ReservaStatus.AGUARDANDO_APROVACAO);
		status.add(ReservaStatus.APROVADA);
		status.add(ReservaStatus.EM_USO);
		status.add(ReservaStatus.CANCELADA);
		status.add(ReservaStatus.ENCERRADA);
		status.add(ReservaStatus.CANCELADA_MENOS_DUAS);

		List<Reserva> reservas = ((ReservaRepository) repository).getReservaByTerceiro(terceiro, status);

		return reservas;
	}
	
	@Override 
	public Boolean contemReservaAtiva(Terceiro terceiro, Grupo grupo) {

		List<ReservaStatus> status = new ArrayList<ReservaStatus>();
		List<Terceiro> terceiros = new ArrayList<Terceiro>();
		terceiros.add(terceiro);

		status.add(ReservaStatus.AGUARDANDO_APROVACAO);
		status.add(ReservaStatus.APROVADA);
		status.add(ReservaStatus.EM_USO);
		
		List<Reserva> reservas = ((ReservaRepository) repository).getReservaByTerceirosByGrupoByStatus(terceiros, grupo, status);

		return reservas != null && reservas.size() > 0;
	}

	public List<Grupo> getGrupoPermiteReserva(Terceiro terceiro) {
		
		User user = userBusiness.getCurrent();
		
		List<Grupo> grupo = grupoBusiness.getAllByUser(user);

		for (Reserva r : getReservaByTerceiro(terceiro)) {
			if (
					grupo.contains(r.getGrupo()) 
					&& (
							!r.getStatus().equals(ReservaStatus.CANCELADA)
							&& !r.getStatus().equals(ReservaStatus.CANCELADA_MENOS_DUAS)
							&& !r.getStatus().equals(ReservaStatus.ENCERRADA)
					)
				) {
				grupo.remove(r.getGrupo());
			}
		}
		
		return grupo;
	}
	
	@Override 
	public List<Terceiro> getTerceiroPermiteReservaGrupo(Grupo grupo) {
		List<Terceiro> terceirosPermiteReserva = new ArrayList<Terceiro>(); 

		for(Terceiro terceiro : grupo.getTerceiros()){
			if(!contemReservaAtiva(terceiro, grupo))
				terceirosPermiteReserva.add(terceiro);
		}
		
		return terceirosPermiteReserva;
	}

	public String validaExclusao(Reserva reserva) {
		Date horaInicioReserva = reserva.getInicioReserva();
		Calendar horaInicioReservaCal = Calendar.getInstance();
		horaInicioReservaCal.setTime(horaInicioReserva);

		if ((horaInicioReservaCal.getTimeInMillis() - System.currentTimeMillis()) / (60 * 60 * 1000) < 2)
			return "false";
		else
			return "true";
	}

	public String validaCancela(Reserva reserva) {
		Date horaInicioReserva = reserva.getInicioReserva();
		Calendar horaInicioReservaCal = Calendar.getInstance();
		horaInicioReservaCal.setTime(horaInicioReserva);

		if ((horaInicioReservaCal.getTimeInMillis() - System.currentTimeMillis()) / (60 * 60 * 1000) < 2)
			return "false";
		else
			return "true";
	}

	@Override
	public Reserva getReservaByEventoFim(ReservaEvento eventoFim) {
		Reserva reserva = ((ReservaRepository) repository).getReservaByEventoFim(eventoFim);
		return reserva;
	}

	public List<Reserva> getByGrupoByStatus(Grupo grupo, List<FaturamentoStatus> faturamentoStatus) {
		List<Reserva> reservas = ((ReservaRepository) repository).findByReservaByGrupoByStatus(grupo,
				faturamentoStatus);
		return reservas;
	}

	public List<Reserva> getByGruposByStatus(List<Grupo> grupos, List<ReservaStatus> status) {
		List<Reserva> reservas = ((ReservaRepository) repository).getByGruposByStatus(grupos, status);
		return reservas;
	}

	@Override
	public List<Reserva> getReservasParaExibicao(User user) {

		List<Grupo> grupos = grupoBusiness.getAllByUser(user);
		
		if (grupos.size() > 0) {

			List<ReservaStatus> status = new ArrayList<ReservaStatus>();

			status.add(ReservaStatus.AGUARDANDO_APROVACAO);
			status.add(ReservaStatus.APROVADA);
			status.add(ReservaStatus.EM_USO);
			//status.add(ReservaStatus.CANCELADA);
			status.add(ReservaStatus.CANCELADA_MENOS_DUAS);
			status.add(ReservaStatus.ENCERRADA);

			return this.getByGruposByStatus(grupos, status);
		} else
			return null;
	}

	public Reserva getByEvento(ReservaEvento evento) {

		return ((ReservaRepository) repository).getByEvento(evento);
	}

	@Override
	public Reserva adicionaReservaEvento(ReservaEvento reservaEvento, String server) throws Exception {

		Reserva reserva = this.getByEvento(reservaEvento);

		if (reserva.getEventoInicio().equals(reservaEvento)) {
			if (reserva.getEventoInicio() == null)
				throw new Exception("Informe as horas do motor.");
			reserva.getEventoInicio().setHora(reservaEvento.getHora());
			reserva.getEventoInicio().setHoraRegistro(reservaEvento.getHoraRegistro());
			reserva.getEventoInicio().setObs(reservaEvento.getObs());
		}
		
		if (reserva.getEventoInicio().getHora() == null) {
			throw new Exception("Informe primeiro a hora motor do evento inicial.");
		}
		
		
		if (reserva.getEventoFim().equals(reservaEvento)) {
			if (reserva.getEventoFim() == null)
				throw new Exception("Informe as horas do motor.");
			if (reservaEvento.getHora() <= reserva.getEventoInicio().getHora()) {
				throw new Exception("Hora final deve ser maior que a hora inicial.");
			}
			reserva.getEventoFim().setHora(reservaEvento.getHora());
			reserva.getEventoFim().setHoraRegistro(reservaEvento.getHoraRegistro());
			reserva.setHoraMotorTotal(reserva.getEventoFim().getHora() - reserva.getEventoInicio().getHora());
			reserva.setFaturamentoStatus(FaturamentoStatus.PENDENTE);
			reserva.getEventoFim().setObs(reservaEvento.getObs());
			sendEmailFinalizacao(reserva, server);
			
		}

		return this.salvar(reserva);
	}

	@Autowired
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void validaAPoraToda() {
		vareSolicitacoesPorGrupo();
	}

	private void vareSolicitacoesPorGrupo() {

		List<Grupo> grupos = grupoBusiness.getAll();

		for (Grupo grupo : grupos) {

			List<Grupo> grs = new ArrayList<Grupo>();
			grs.add(grupo);

			List<ReservaStatus> statusList = new ArrayList<ReservaStatus>();
			statusList.add(ReservaStatus.AGUARDANDO_APROVACAO);
			statusList.add(ReservaStatus.CANCELADA_MENOS_DUAS);

			Calendar date = Calendar.getInstance();
			date.add(Calendar.DATE, -1);

			try {
				List<Reserva> reservas = ((ReservaRepository) repository).getByGruposByStatus(grs, statusList);
				if (reservas == null)
					continue;

				validaSolicitacoesPorGrupo(reservas);
			} catch (Exception e) {
				return;
			}
		}
	}

	public ReservaDTO getReservaDTOById(Long id, Terceiro terceiro, Date dataReserva) throws Exception {

		ReservaDTO reservaDTO;
		Reserva reserva = this.get(id);

		if (reserva != null) {
			String tipoEvento = "";

			if (reserva.getStatus().equals(ReservaStatus.AGUARDANDO_APROVACAO)) {
				tipoEvento = "[S] ";
			}

			if (reserva.getStatus().equals(ReservaStatus.APROVADA)) {
				tipoEvento = "[R] ";
			}

			if (reserva.getStatus().equals(ReservaStatus.EM_USO)) {
				tipoEvento = "[E] ";
			}

			if (reserva.getStatus().equals(ReservaStatus.CANCELADA)
					|| reserva.getStatus().equals(ReservaStatus.CANCELADA_MENOS_DUAS)) {
				tipoEvento = "[C] ";
			}

			if (reserva.getStatus().equals(ReservaStatus.ENCERRADA)) {
				tipoEvento = "[F] ";
			}

			reservaDTO = new ReservaDTO(reserva.getId(), reserva.getSolicitante().getNome(),
					new TerceiroDTO(reserva.getSolicitante().getId(), reserva.getSolicitante().getNome()),
					reserva.getInicioReserva(), reserva.getFimReserva(), reserva.getUtilizaMarinheiro(),
					reserva.getObs(), reserva.getStatus(), new ReservaEventoDTO(reserva.getEventoInicio().getId()),
					new ReservaEventoDTO(reserva.getEventoFim().getId()), new GrupoDTO(reserva.getGrupo().getId(),
							reserva.getGrupo().getDescricao(), reserva.getGrupo().getColor()),
					tipoEvento);
		} else {
			reservaDTO = new ReservaDTO(null, terceiro.getNome(), new TerceiroDTO(terceiro.getId(), terceiro.getNome()),
					calculaDataInicioReserva(dataReserva), null, null, null, ReservaStatus.AGUARDANDO_APROVACAO, null,
					null, null, null);

		}
		return reservaDTO;
	}

	@SuppressWarnings("deprecation")
	private Date calculaDataInicioReserva(Date dataReserva) {
		Calendar horaInicioReservaCal = Calendar.getInstance();

		if (!(horaInicioReservaCal.get(Calendar.DAY_OF_MONTH) == dataReserva.getDate()
				&& horaInicioReservaCal.get(Calendar.MONTH) == dataReserva.getMonth()
				&& horaInicioReservaCal.get(Calendar.YEAR) == dataReserva.getYear() + 1900)) {
			horaInicioReservaCal.setTime(dataReserva);
			horaInicioReservaCal.set(Calendar.HOUR, 6);
			horaInicioReservaCal.set(Calendar.MINUTE, 0);
			return horaInicioReservaCal.getTime();
		}

		int calculoDifHoraInicio = (horaInicioReservaCal.get(Calendar.MINUTE) % 15);

		if (calculoDifHoraInicio == 0)
			horaInicioReservaCal.add(Calendar.MINUTE, 60);
		else
			horaInicioReservaCal.add(Calendar.MINUTE, (15 - calculoDifHoraInicio) + 60);

		if (horaInicioReservaCal.get(Calendar.HOUR_OF_DAY) > 18) {
			horaInicioReservaCal.add(Calendar.DAY_OF_MONTH, 1);
			horaInicioReservaCal.set(Calendar.HOUR_OF_DAY, 6);
			horaInicioReservaCal.set(Calendar.MINUTE, 0);
		}

		if (horaInicioReservaCal.get(Calendar.HOUR_OF_DAY) < 6) {
			horaInicioReservaCal.set(Calendar.HOUR_OF_DAY, 6);
			horaInicioReservaCal.set(Calendar.MINUTE, 0);
		}

		return horaInicioReservaCal.getTime();
	}

	public ReservaValidacaoStatus validaReserva(Reserva reserva) throws ParseException {

		if (reserva.getId() == null) {

			if (existeReservaIgual(reserva) != null) {
				return ReservaValidacaoStatus.OK_DUPLICADO;
			}

			if (isReservaMesmoDia(reserva)) {
				return validaReservaMesmoDia(reserva);
			}

			if (isReservaDiaUnico(reserva)) {
				return validaReservaDiaUnico(reserva);
			}

			return validaReservaDiasConsecutivos(reserva);
		}
		return ReservaValidacaoStatus.OK;
	}

	private ReservaValidacaoStatus validaReservaMesmoDia(Reserva reserva) {
		Date dataAtual = new Date();

		if (existeReserva(reserva) == null) {
			if ((reserva.getInicioReserva().getTime() - dataAtual.getTime()) / (60 * 60 * 1000) < 1) {
				return ReservaValidacaoStatus.DIA_UNICO_RESERVA;
			}
			return ReservaValidacaoStatus.OK_RESERVA;
		}
		return ReservaValidacaoStatus.EXISTE_RESERVA;
	}

	@SuppressWarnings("deprecation")
	private Boolean isReservaMesmoDia(Reserva reserva) {
		Date dataAtual = new Date();

		if (dataAtual.getDate() == reserva.getFimReserva().getDate() && reserva.getFimReserva().getHours() <= 20) {
			return true;
		}
		return false;
	}

	private Boolean validaSolicitacoesPorGrupo(List<Reserva> reservas) throws Exception {

		List<Reserva> reservasReprovadas = new ArrayList<Reserva>();

		for (Reserva reserva : reservas) {
			if (!verificaValidacoesEmail(reserva)) {
				reservasReprovadas.add(reserva);
				reprovaReserva(reserva);
			}
		}

		if (reservasReprovadas.size() > 0)
			reservas.removeAll(reservasReprovadas);

		List<Reserva> reservasUnicas = validaReservasConcomitantes(reservas);

		for (Reserva reserva : reservasUnicas) {

			Calendar date = Calendar.getInstance();
			date.add(Calendar.HOUR, -24);
			if (reserva.getCreated().getTime() >= date.getTime().getTime()) {
				continue;
			}

			if (!isReservaDiaUnico(reserva)) {
				date.add(Calendar.HOUR, -24);
				if (reserva.getCreated().getTime() >= date.getTime().getTime()) {
					continue;
				}
			}

			if (verificaValidacoesEmail(reserva)) {
				reserva.setStatus(ReservaStatus.APROVADA);
				dispararEmailAprovacaoReserva(reserva);
			}

		}
		return true;
	}

	public ReservaValidacaoStatus validaReservaDiaUnico(Reserva reserva) throws ParseException {

		Date dataAtual = new Date();

		if (((reserva.getInicioReserva().getTime() - dataAtual.getTime()) / (60 * 60 * 1000)) <= 24) {
			if (existeReserva(reserva) != null) {
				return ReservaValidacaoStatus.EXISTE_RESERVA;
			} else
				return ReservaValidacaoStatus.OK_RESERVA;
		}
		return ReservaValidacaoStatus.OK;
	}

	private List<Reserva> validaReservasConcomitantes(List<Reserva> reservas) throws Exception {

		List<Reserva> reservasUnicas = new ArrayList<Reserva>();

		Boolean continua = false;

		do {

			if (reservasUnicas.size() > 0) {
				reservas.clear();
				reservas.addAll(reservasUnicas);

				reservasUnicas.clear();
			}

			continua = false;

			if (reservas == null || reservas.size() == 1)
				return reservas;

			for (Reserva reservaDaVez : reservas) {
				for (Reserva reservaVerificacao : reservas) {

					if (reservaDaVez.equals(reservaVerificacao))
						continue;

					Calendar inicioReserva = Calendar.getInstance();
					Calendar fimReserva = Calendar.getInstance();
					Calendar inicioR = Calendar.getInstance();
					Calendar fimR = Calendar.getInstance();

					inicioReserva.setTime(reservaDaVez.getInicioReserva());
					inicioReserva.add(Calendar.HOUR, -2);
					fimReserva.setTime(reservaDaVez.getFimReserva());
					fimReserva.add(Calendar.HOUR, 2);
					inicioR.setTime(reservaVerificacao.getInicioReserva());
					fimR.setTime(reservaVerificacao.getFimReserva());

					if ((inicioReserva.before(inicioR) && fimReserva.after(inicioR))
							|| (inicioReserva.before(fimR) && fimReserva.after(fimR))) {
						if (!reservasUnicas.contains(reservaDaVez) && !reservasUnicas.contains(reservaVerificacao))
							reservasUnicas.add(elegeReserva(reservaDaVez, reservaVerificacao));
						continua = true;
					} else
						reservasUnicas.add(reservaDaVez);

				}
			}
		} while (continua);

		return reservasUnicas;

	}

	public ReservaValidacaoStatus validaReservaDiasConsecutivos(Reserva reserva) {
		
		User user = userBusiness.getCurrent();
		
		Date dataAtual = new Date();
		GregorianCalendar atual = new GregorianCalendar();
		GregorianCalendar dataReserva = new GregorianCalendar();
		
		atual.setTime(dataAtual);
		dataReserva.setTime(reserva.getInicioReserva());

		if (!user.getRole().equals(Role.ROLE_ADMIN) && (dataReserva.get(GregorianCalendar.DAY_OF_YEAR) - atual.get(GregorianCalendar.DAY_OF_YEAR)) < 7) {
			return ReservaValidacaoStatus.DIAS_CONSECUTIVOS;
		}

		return ReservaValidacaoStatus.OK;
	}

	private Reserva elegeReserva(Reserva reserva1, Reserva reserva2) throws Exception {

		List<Terceiro> terceiros = new ArrayList<Terceiro>();
		terceiros.add(reserva1.getSolicitante());
		terceiros.add(reserva2.getSolicitante());

		List<ReservaStatus> status = new ArrayList<ReservaStatus>();
		status.add(ReservaStatus.ENCERRADA);
		status.add(ReservaStatus.CANCELADA_MENOS_DUAS);

		List<Reserva> reservas = ((ReservaRepository) repository).getReservaByTerceirosByGrupoByStatus(terceiros,
				reserva1.getGrupo(), status);

		if (reservas == null || reservas.size() == 0) {
			if (reserva1.getCreated().before(reserva2.getCreated())) {
				reprovaReserva(reserva2);

				return reserva1;
			} else {
				reprovaReserva(reserva1);
				return reserva2;
			}
		}

		Reserva ultimaReserva = reservas.get(0);

		if (ultimaReserva.getSolicitante().equals(reserva1.getSolicitante())) {
			reprovaReserva(reserva1);
			return reserva2;
		} else {
			reprovaReserva(reserva2);
			return reserva1;
		}

	}

	private void reprovaReserva(Reserva reserva) throws Exception {
		reserva.setStatus(ReservaStatus.REPROVADA);
		this.salvar(reserva);
		dispararEmailReprovacaoReserva(reserva);
	}

	private void dispararEmailAprovacaoReserva(Reserva reserva) throws MessagingException {

		if (reserva.getSolicitante().getEmails() == null)
			return;

		String[] destinatario = new String[] { reserva.getSolicitante().getEmails() };
		String title = "Prime Share Club - Reserva Aprovada";
		String texto = "<div align='center' style='background-color:rgb(255,255,255)'></br></br>"
				+ "<div align='center' style='background-color:rgb(255,255,255)'>"
				+ "	<img width='112' height='110' alt='Logo' src='http://ec2-54-233-141-81.sa-east-1.compute.amazonaws.com/files-upload/icon-embarcacoes.png'  />"
				+ "</div>" + "</br></br><font color='#1C3C6A'>"
				+ "	<h3>Sua solicitação de reserva foi aprovada </h3><br /><br /> Embarcação: "
				+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />" + "	Solicitante: "
				+ reserva.getSolicitante().getNome() + "<br />" + "	Data inicio da reserva: "
				+ Formatters.formatDate(reserva.getInicioReserva()) + "<br />" + "	Data fim da reserva: "
				+ Formatters.formatDate(reserva.getFimReserva())
				+ "<br />" 
				+ "	Utiliza Marinheiro: "
				+ (reserva.getUtilizaMarinheiro() ? "Sim" : "Não") 
				+ "<br />" 
				+ "	Observação: "
				+ reserva.getObs() + "<br /><br />Att,<br /> " + "	</font>"
				+ "	<div>"
				+ "		<h2><font color='#1C3C6A' size=26px> EQUIPE PRIME SHARE CLUB </font></h2>"
				+ "		<p><font color='#1C3C6A'>©2016 All Rights Reserved.</font></p>" + "	</div> "
				+ "</br></br></div>";

		try {
			mailBusiness.sendMail("websys@primeshareclub.com.br", destinatario, title, texto);
		} catch (Exception e) {
			System.out.println("ERRO AO ENVIAR EMAIL!");
		}

	}

	private void dispararEmailReprovacaoReserva(Reserva reserva) throws MessagingException {

		if (reserva.getSolicitante().getEmails() == null)
			return;

		String[] destinatario = new String[] { reserva.getSolicitante().getEmails() };
		String title = "Prime Share Club - Reserva Reprovada";
		String texto = "<div align='center' style='background-color:rgb(255,255,255)'></br></br>"
				+ "<div align='center' style='background-color:rgb(255,255,255)'>"
				+ "	<img width='112' height='110' alt='Logo' src='http://ec2-54-233-141-81.sa-east-1.compute.amazonaws.com/files-upload/icon-embarcacoes.png'  />"
				+ "</div>" + "</br></br><font color='#1C3C6A'>"
				+ "	<h3>Sua solicitação de reserva foi reprovada </h3><br /><br /> Embarcação: "
				+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />" + "	Solicitante: "
				+ reserva.getSolicitante().getNome() + "<br />" + "	Data inicio da reserva: "
				+ Formatters.formatDate(reserva.getInicioReserva()) + "<br />" + "	Data fim da reserva: "
				+ Formatters.formatDate(reserva.getFimReserva())
				+ "<br />" 
				+ "	Utiliza Marinheiro: "
				+ (reserva.getUtilizaMarinheiro() ? "Sim" : "Não") 
				+ "<br />" 
				+ "	Observação: "
				+ reserva.getObs() + "<br /><br />Att,<br /> " + "	</font>"
				+ "	<div>"
				+ "		<h2><font color='#1C3C6A' size=26px> EQUIPE PRIME SHARE CLUB </font></h2>"
				+ "		<p><font color='#1C3C6A'>©2016 All Rights Reserved.</font></p>" + "	</div> "
				+ "</br></br></div>";
		try {
			mailBusiness.sendMail("websys@primeshareclub.com.br", destinatario, title, texto);
		} catch (Exception e) {
			System.out.println("ERRO AO ENVIAR EMAIL!");
		}

	}

	@SuppressWarnings("deprecation")
	private Boolean isReservaDiaUnico(Reserva reserva) {
		if (reserva.getInicioReserva().getDay() != reserva.getFimReserva().getDay())
			return false;
		if (reserva.getInicioReserva().getMonth() != reserva.getFimReserva().getMonth())
			return false;
		if (reserva.getInicioReserva().getYear() != reserva.getFimReserva().getYear())
			return false;

		return true;
	}

	private Boolean verificaValidacoesEmail(Reserva reserva) {

		for (ReservaValidacao validacao : reserva.getValidacoes()) {
			if (validacao.getValidado() && !validacao.getAprovado()) {
				return false;
			}
		}

		return true;
	}

	@Override
	public Reserva getReservaByDate(Reserva reserva) {
		List<ReservaStatus> status = new ArrayList<ReservaStatus>();

		status.add(ReservaStatus.AGUARDANDO_APROVACAO);
		status.add(ReservaStatus.APROVADA);

		return ((ReservaRepository) repository).getReservaByDate(reserva.getInicioReserva(), reserva.getGrupo(),
				status);
	}

	public Reserva existeReserva(Reserva reserva) {
		List<ReservaStatus> status = new ArrayList<ReservaStatus>();

		status.add(ReservaStatus.AGUARDANDO_APROVACAO);
		status.add(ReservaStatus.APROVADA);

		return ((ReservaRepository) repository).existeReserva(reserva.getInicioReserva(), reserva.getFimReserva(), reserva.getGrupo(), status);
	}
	
	public Reserva existeReservaIgual(Reserva reserva) {
		List<ReservaStatus> status = new ArrayList<ReservaStatus>();

		status.add(ReservaStatus.AGUARDANDO_APROVACAO);
		status.add(ReservaStatus.APROVADA);

		return ((ReservaRepository) repository).existeReservaIgual(reserva.getInicioReserva(), reserva.getFimReserva(),
				reserva.getSolicitante(), reserva.getGrupo(), status);
	}

	public Boolean sendEmailCancelamento(Reserva reserva) throws Exception {

		List<Terceiro> terceiroList = reserva.getGrupo().getTerceiros();

		for (Terceiro t : terceiroList) {
			mailBusiness.sendMail("websys@primeshareclub.com.br", new String[] { t.getEmails() },
					"Prime Share Club - Reserva Cancelada",
					"<div align='center' style='background-color:rgb(255,255,255)'></br></br>"
							+ "<div align='center' style='background-color:rgb(255,255,255)'>"
							+ "	<img width='112' height='110' alt='Logo' src='http://ec2-54-233-141-81.sa-east-1.compute.amazonaws.com/files-upload/icon-embarcacoes.png'  />"
							+ "</div>" + "</br></br><font color='#1C3C6A'>"
							+ "	<h3>Uma reserva foi cancelada </h3><br /><br />	Embarcação: "
							+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />" + "	Solicitante: "
							+ reserva.getSolicitante().getNome() + "<br />" + "	Data inicio da reserva: "
							+ Formatters.formatDate(reserva.getInicioReserva()) + "<br />" + "	Data fim da reserva: "
							+ Formatters.formatDate(reserva.getFimReserva())
							+ "<br />" 
							+ "	Utiliza Marinheiro: "
							+ (reserva.getUtilizaMarinheiro() ? "Sim" : "Não") 
							+ "<br />" 
							+ "	Observação: "
							+ reserva.getObs() + "<br /><br />Att,<br /> " + "	</font>"
							+ "	<div>"
							+ "		<h2><font color='#1C3C6A' size=26px> EQUIPE PRIME SHARE CLUB </font></h2>"
							+ "		<p><font color='#1C3C6A'>©2016 All Rights Reserved.</font></p>" + "	</div> "
							+ "</br></br></div>");
		}

		List<Role> roles = new ArrayList<Role>();
		roles.add(Role.ROLE_ADMIN);
		roles.add(Role.ROLE_MARINHEIRO);

		List<User> users = userBusiness.getByRoles(roles);
		for (User user : users) {
			if (user.getAtivo()) {
				mailBusiness.sendMail("websys@primeshareclub.com.br", new String[] { user.getTerceiro().getEmails() },
						"Prime Share Club - Reserva Cancelada",
						"<div align='center' style='background-color:rgb(255,255,255)'></br></br>"
								+ "<div align='center' style='background-color:rgb(255,255,255)'>"
								+ "	<img width='112' height='110' alt='Logo' src='http://ec2-54-233-141-81.sa-east-1.compute.amazonaws.com/files-upload/icon-embarcacoes.png'  />"
								+ "</div>" + "</br></br><font color='#1C3C6A'>"
								+ "	<h3>Uma reserva foi cancelada </h3><br /><br />	Embarcação: "
								+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />" + "	Solicitante: "
								+ reserva.getSolicitante().getNome() + "<br />" + "	Data inicio da reserva: "
								+ Formatters.formatDate(reserva.getInicioReserva()) + "<br />"
								+ "	Data fim da reserva: " + Formatters.formatDate(reserva.getFimReserva())
								+ "<br />" 
								+ "	Utiliza Marinheiro: "
								+ (reserva.getUtilizaMarinheiro() ? "Sim" : "Não") 
								+ "<br />" 
								+ "	Observação: "
								+ reserva.getObs() 
								+ "<br /><br />Att,<br /> " + "	</font>" + "	<div>"
								+ "		<h2><font color='#1C3C6A' size=26px> EQUIPE PRIME SHARE CLUB </font></h2>"
								+ "		<p><font color='#1C3C6A'>©2016 All Rights Reserved.</font></p>" + "	</div> "
								+ "</br></br></div>");
			}
		}

		return false;

	}

	public Boolean sendEmailFinalizacao(Reserva reserva, String server) throws Exception {

		List<Terceiro> terceiroList = reserva.getGrupo().getTerceiros();

		String link = server + "/reserva/visualizaImagensReserva/" + reserva.getId();

		for (Terceiro t : terceiroList) {
			String html ="<div align='center' style='background-color:rgb(255,255,255)'></br></br>"
					+ "<div align='center' style='background-color:rgb(255,255,255)'>"
					+ "	<img width='112' height='110' alt='Logo' src='http://ec2-54-233-141-81.sa-east-1.compute.amazonaws.com/files-upload/icon-embarcacoes.png'  />"
					+ "</div>" + "</br></br><font color='#1C3C6A'>"
					+ "	<h3>Reserva finalizada: </h3><br /><br />Embarcação: "
					+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />" + "	Solicitante: "
					+ reserva.getSolicitante().getNome() + "<br />" + "	Data inicio da reserva: "
					+ Formatters.formatDate(reserva.getInicioReserva()) 
					+ "<br />" 
					+ "	Data fim da reserva: " + Formatters.formatDate(reserva.getFimReserva())
					+ "<br />" 
					+ "	Hora de registro do início da utilização: " + Formatters.formatDate(reserva.getEventoInicio().getHoraRegistro())
					+ "<br />" 
					+ "	Hora de registro do fim da utilização: " + Formatters.formatDate(reserva.getEventoFim().getHoraRegistro())
					+ "<br /> <br />";
			
					if(t== reserva.getSolicitante()){
						html = html.concat(" Para visualizar as imagens clique <a href='" + link + "' style='color:white;'>aqui</a>");
					}
					html = html.concat( " Para visualizar as imagens clique <a href='" + link + "' style='color:white;'>aqui</a>"
					+ "<br /><br />Att,<br /> " + "	</font>" + "	<div>"
					+ "		<h2><font color='#1C3C6A' size=26px> EQUIPE PRIME SHARE CLUB </font></h2>"
					+ "		<p><font color='#1C3C6A'>©2016 All Rights Reserved.</font></p>" + "	</div> "
					+ "</br></br></div>");
			
			mailBusiness.sendMail("websys@primeshareclub.com.br", new String[] { t.getEmails() },
					"Prime Share Club - Reserva Finalizada",html);
		}

		List<Role> roles = new ArrayList<Role>();
		roles.add(Role.ROLE_ADMIN);
		roles.add(Role.ROLE_MARINHEIRO);

		List<User> users = userBusiness.getByRoles(roles);
		for (User user : users) {
			if (user.getAtivo()) {
				mailBusiness.sendMail("websys@primeshareclub.com.br", new String[] { user.getTerceiro().getEmails() },
						"Prime Share Club - Reserva Finalizada",
						"<div align='center' style='background-color:rgb(255,255,255)'></br></br>"
								+ "<div align='center' style='background-color:rgb(255,255,255)'>"
								+ "	<img width='112' height='110' alt='Logo' src='http://ec2-54-233-141-81.sa-east-1.compute.amazonaws.com/files-upload/icon-embarcacoes.png'  />"
								+ "</div>" + "</br></br><font color='#1C3C6A'>"
								+ "	<h3>Reserva finalizada: </h3><br /><br />Embarcação: "
								+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />" + "	Solicitante: "
								+ reserva.getSolicitante().getNome() + "<br />" + "	Data inicio da reserva: "
								+ Formatters.formatDate(reserva.getInicioReserva()) + "<br />"
								+ "	Data fim da reserva: " + Formatters.formatDate(reserva.getFimReserva())
								+ "<br />" 
								+ "	Hora de registro do início da utilização: " + Formatters.formatDate(reserva.getEventoInicio().getHoraRegistro())
								+ "<br />" 
								+ "	Hora de registro do fim da utilização: " + Formatters.formatDate(reserva.getEventoFim().getHoraRegistro())
								+ "<br /> <br />" + " Para visualizar as imagens clique <a href='" + link
								+ "' style='color:white;'>aqui</a>" + "<br /><br />Att,<br /> " + "	</font>"
								+ "	<div>"
								+ "		<h2><font color='#1C3C6A' size=26px> EQUIPE PRIME SHARE CLUB </font></h2>"
								+ "		<p><font color='#1C3C6A'>©2016 All Rights Reserved.</font></p>" + "	</div> "
								+ "</br></br></div>");
			}
		}

		return false;

	}

	public Boolean sendEmailExclusaoSolicitacao(Reserva reserva) throws Exception {

		List<Terceiro> terceiroList = reserva.getGrupo().getTerceiros();

		for (Terceiro t : terceiroList) {
			mailBusiness.sendMail("websys@primeshareclub.com.br", new String[] { t.getEmails() },
					"Prime Share Club - Solicitação de reserva excluída.",
					"<div align='center' style='background-color:rgb(255,255,255)'></br></br>"
							+ "<div align='center' style='background-color:rgb(255,255,255)'>"
							+ "	<img width='112' height='110' alt='Logo' src='http://ec2-54-233-141-81.sa-east-1.compute.amazonaws.com/files-upload/icon-embarcacoes.png'  />"
							+ "</div>" + "</br></br><font color='#1C3C6A'>"
							+ "	<h3>Uma solicitação de reserva foi excluída </h3><br /><br />Embarcação: "
							+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />" + "	Solicitante: "
							+ reserva.getSolicitante().getNome() + "<br />" + "	Data inicio da solicitação: "
							+ Formatters.formatDate(reserva.getInicioReserva()) + "<br />"
							+ "	Data fim da solicitação: " + Formatters.formatDate(reserva.getFimReserva())
							+ "<br />" 
							+ "	Utiliza Marinheiro: "
							+ (reserva.getUtilizaMarinheiro() ? "Sim" : "Não") 
							+ "<br />" 
							+ "	Observação: "
							+ reserva.getObs() 
							+ "<br /><br />Att,<br /> " + "	</font>" + "	<div>"
							+ "		<h2><font color='#1C3C6A' size=26px> EQUIPE PRIME SHARE CLUB </font></h2>"
							+ "		<p><font color='#1C3C6A'>©2016 All Rights Reserved.</font></p>" + "	</div> "
							+ "</br></br></div>");
		}

		List<Role> roles = new ArrayList<Role>();
		roles.add(Role.ROLE_ADMIN);
		roles.add(Role.ROLE_MARINHEIRO);

		List<User> users = userBusiness.getByRoles(roles);
		for (User user : users) {
			if (user.getAtivo()) {
				mailBusiness.sendMail("websys@primeshareclub.com.br", new String[] { user.getTerceiro().getEmails() },
						"Prime Share Club - Solicitação de reserva excluída.",
						"<div align='center' style='background-color:rgb(255,255,255)'></br></br>"
								+ "<div align='center' style='background-color:rgb(255,255,255)'>"
								+ "	<img width='112' height='110' alt='Logo' src='http://ec2-54-233-141-81.sa-east-1.compute.amazonaws.com/files-upload/icon-embarcacoes.png'  />"
								+ "</div>" + "</br></br><font color='#1C3C6A'>"
								+ "	<h3>Uma solicitação de reserva foi excluída </h3><br /><br />Embarcação: "
								+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />" + "	Solicitante: "
								+ reserva.getSolicitante().getNome() + "<br />" + "	Data inicio da solicitação: "
								+ Formatters.formatDate(reserva.getInicioReserva()) + "<br />"
								+ "	Data fim da solicitação: " + Formatters.formatDate(reserva.getFimReserva())
								+ "<br />" 
								+ "	Utiliza Marinheiro: "
								+ (reserva.getUtilizaMarinheiro() ? "Sim" : "Não") 
								+ "<br />" 
								+ "	Observação: "
								+ reserva.getObs() 
								+ "<br /><br />Att,<br /> " + "	</font>" + "	<div>"
								+ "		<h2><font color='#1C3C6A' size=26px> EQUIPE PRIME SHARE CLUB </font></h2>"
								+ "		<p><font color='#1C3C6A'>©2016 All Rights Reserved.</font></p>" + "	</div> "
								+ "</br></br></div>");
			}
		}

		return false;

	}
	
	@Override
	public void alterarStatusReserva() throws Exception{
		
		Calendar data = Calendar.getInstance();
		
		Criteria criteriaEmUso = this.createCriteria("r");
		criteriaEmUso.add(Restrictions.le("r.inicioReserva", data.getTime()))
			.add(Restrictions.eq("r.status", ReservaStatus.APROVADA));
		
		List<Reserva> reservasEmUso = criteriaEmUso.list();
		
		if(reservasEmUso != null){
			for(Reserva reserva : reservasEmUso){
				reserva.setStatus(ReservaStatus.EM_USO);
				this.salvar(reserva);
			}
		}
		
		Criteria criteriaEncerreda = this.createCriteria("r");
		criteriaEncerreda.add(Restrictions.le("r.fimReserva", data.getTime()))
			.add(Restrictions.eq("r.status", ReservaStatus.EM_USO));
		
		List<Reserva> reservasEncerradas = criteriaEncerreda.list();
		
		if(reservasEncerradas != null){
			for(Reserva reserva : reservasEncerradas){
				reserva.setStatus(ReservaStatus.ENCERRADA);
				this.salvar(reserva);
			}
		}
	}
}
