package br.com.system.websys.business;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.FaturamentoStatus;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.PermiteReservaDTO;
import br.com.system.websys.entities.PermiteReservasDTO;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaEvento;
import br.com.system.websys.entities.ReservaStatus;
import br.com.system.websys.entities.ReservaValidacao;
import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.User;
import br.com.system.websys.formatter.Formatters;
import br.com.system.websys.repository.ReservaRepository;

@Service
@Transactional(propagation = Propagation.REQUIRED)
class ReservaBusinessImpl extends BusinessBaseRootImpl<Reserva, ReservaRepository> implements ReservaBusiness {

	@Autowired
	public UserBusiness userBusiness;

	@Autowired
	public GrupoBusiness grupoBusiness;

	@Autowired
	public MailBusiness mailBusiness;

	@Autowired
	protected ReservaBusinessImpl(ReservaRepository repository) {
		super(repository, Reserva.class);
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
	public Boolean sendEmailValidacao(Reserva reserva, String server) throws MessagingException {

		String link = server + "/websys/reserva/validar/";

		for (ReservaValidacao validacao : reserva.getValidacoes()) {
			mailBusiness.sendMail("e2a.system@gmail.com", new String[] { validacao.getTerceiro().getEmails() },
					"Prime Share Club - Reserva Solicitada",
					"Uma nova reserva foi solicitada <br />" + "<br />Embarcação: "
							+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />Solicitante: "
							+ reserva.getSolicitante().getNome() + "<br />Data inicio da reserva: "
							+ Formatters.formatDate(reserva.getInicioReserva()) + "<br />Data fim da reserva: "
							+ Formatters.formatDate(reserva.getFimReserva()) + "<br /><br />Clique <a href='" + link
							+ validacao.getUid() + "'>aqui</a> para validar/questionar a reserva"
							+ "<br /><br /><br />Att" + "<br />Equipe Prime Share Club");
		}
		return false;
	}

	@Override
	public List<Reserva> getReservaByTerceiro(Terceiro terceiro) {

		List<ReservaStatus> status = new ArrayList<ReservaStatus>();

		status.add(ReservaStatus.AGUARDANDO_APROVACAO);
		status.add(ReservaStatus.APROVADA);
		status.add(ReservaStatus.EM_USO);

		List<Reserva> reservas = ((ReservaRepository) repository).getReservaByTerceiro(terceiro, status);

		return reservas;
	}
	
	public List<Grupo> getGrupoPermiteReserva(Terceiro terceiro){
		List<Grupo> grupo = grupoBusiness.findAllByTerceito(terceiro);
		
		for(Reserva r : getReservaByTerceiro(terceiro)){
			if(grupo.contains(r.getGrupo())){
				grupo.remove(r.getGrupo());
			}
		}
		
		return grupo;
	}

	@Override
	public String validaExclusao(Reserva reserva) {
		Date horaInicioReserva = reserva.getInicioReserva();
		Calendar horaInicioReservaCal = Calendar.getInstance();
		horaInicioReservaCal.setTime(horaInicioReserva);

		long dif = (horaInicioReservaCal.getTimeInMillis() - System.currentTimeMillis()) / (60 * 60 * 1000);

		if (dif < 2)
			return "false";
		else
			return "true";
	}

	@Override
	public Reserva getReservaByEventoFim(ReservaEvento eventoFim) {
		Reserva reserva = ((ReservaRepository) repository).getReservaByEventoFim(eventoFim);
		return reserva;
	}

	public List<Reserva> getByGrupoByStatus(Grupo grupo, FaturamentoStatus faturamentoStatus) {
		List<Reserva> reservas = ((ReservaRepository) repository).findByReservaByGrupoByStatus(grupo,
				faturamentoStatus);
		return reservas;
	}

	public PermiteReservasDTO validaSolicitanteReserva(User user) {

		Terceiro terceiro = user.getTerceiro();

		PermiteReservasDTO permiteReservas = new PermiteReservasDTO();

		if (user.getRole().equals(Role.ROLE_COTISTA)) {
			List<Grupo> gruposTerceiro = grupoBusiness.findAllByTerceito(terceiro);

			if (gruposTerceiro.size() > 1) {

				for (Grupo g : gruposTerceiro) {
					for (Reserva r : g.getReservas()) {
						if (r.getSolicitante().equals(terceiro)) {
							if (!permiteReservas.getPermiteReservaDTO().contains(g)) {
								permiteReservas.getPermiteReservaDTO().add(new PermiteReservaDTO(g.getId(),
										g.getDescricao(), r.getId(), terceiro.getId(), false));
							}
						} else {
							if (!permiteReservas.getPermiteReservaDTO().contains(g)) {
								permiteReservas.getPermiteReservaDTO().add(
										new PermiteReservaDTO(g.getId(), g.getDescricao(), 0L, terceiro.getId(), true));
							}
						}
					}
				}
			} else {
				Grupo g = gruposTerceiro.get(0);
				for (Reserva r : g.getReservas()) {
					if (r.getSolicitante().equals(terceiro)) {
						if (!permiteReservas.getPermiteReservaDTO().contains(g)) {
							permiteReservas.getPermiteReservaDTO().add(new PermiteReservaDTO(g.getId(),
									g.getDescricao(), r.getId(), terceiro.getId(), false));
						}
					} else {
						if (!permiteReservas.getPermiteReservaDTO().contains(g)) {
							permiteReservas.getPermiteReservaDTO().add(
									new PermiteReservaDTO(g.getId(), g.getDescricao(), 0L, terceiro.getId(), true));
						}
					}
				}
			}
		}

		return permiteReservas;
	}

	public List<Reserva> getByGruposByStatus(List<Grupo> grupos, List<ReservaStatus> status) {
		List<Reserva> reservas = ((ReservaRepository) repository).getByGruposByStatus(grupos, status);
		return reservas;
	}

	@Override
	public List<Reserva> getReservasParaExibicao(User user) {

		List<Grupo> grupos;
		if (user.getRole().equals(Role.ROLE_COTISTA))
			grupos = grupoBusiness.findAllByTerceito(user.getTerceiro());
		else
			grupos = grupoBusiness.findAllAtivos();

		List<ReservaStatus> status = new ArrayList<ReservaStatus>();

		status.add(ReservaStatus.AGUARDANDO_APROVACAO);
		status.add(ReservaStatus.APROVADA);
		status.add(ReservaStatus.EM_USO);

		return this.getByGruposByStatus(grupos, status);
	}

	public Reserva getByEvento(ReservaEvento evento) {

		return ((ReservaRepository) repository).getByEvento(evento);
	}

	@Override
	public Reserva adicionaReservaEvento(ReservaEvento reservaEvento) throws Exception {

		Reserva reserva = this.getByEvento(reservaEvento);

		if (reserva.getEventoInicio().equals(reservaEvento)) {
			reserva.getEventoInicio().setHora(reservaEvento.getHora());
			reserva.getEventoInicio().setImagens(reservaEvento.getImagens());
			reserva.setStatus(ReservaStatus.EM_USO);
		}
		if (reserva.getEventoFim().equals(reservaEvento)) {
			reserva.getEventoFim().setHora(reservaEvento.getHora());
			reserva.getEventoFim().setImagens(reservaEvento.getImagens());
			reserva.setStatus(ReservaStatus.ENCERRADA);
			reserva.setHoraMotorTotal(reserva.getEventoFim().getHora() - reserva.getEventoInicio().getHora());
		}

		return this.salvar(reserva);
	}
	
	@Autowired
	@Transactional(propagation=Propagation.REQUIRES_NEW)
	public void validaAPoraToda(){
		vareSolicitacoesPorGrupo();
	}
	
	private void vareSolicitacoesPorGrupo(){
		
		List<Grupo> grupos = grupoBusiness.getAll();
		
		for(Grupo grupo :grupos){
			
			Calendar date = Calendar.getInstance();
			date.add(Calendar.DATE, -1);
			
			/*Criteria criteria = this.createCriteria("r");
			criteria.add(Restrictions.eq("r.ativo", true));
			criteria.add(Restrictions.eq("r.cancelado", false));
			criteria.add(Restrictions.eq("r.status", ReservaStatus.AGUARDANDO_APROVACAO));
			criteria.add(Restrictions.le("r.created", date.getTime()));
			criteria.add(Restrictions.le("r.grupo", grupo));*/
			try{
				List<Reserva> reservas = ((ReservaRepository) repository).getByGruposByStatusByDateCreated(grupo, ReservaStatus.AGUARDANDO_APROVACAO, date.getTime()); 
				if(reservas == null)
					continue;
				
				validaSolicitacoesPorGrupo(reservas);
			}catch(Exception e){
				return;
			}

		}
		
	}
	
	private Boolean validaSolicitacoesPorGrupo(List<Reserva> reservas) throws Exception{
		
		List<Reserva> reservasReprovadas = new ArrayList<Reserva>();
		
		for(Reserva reserva : reservas){
			if(!verificaValidacoesEmail(reserva)){
				reservasReprovadas.add(reserva);
				reprovaReserva(reserva);
			}
		}
		
		if(reservasReprovadas.size() > 0)
			reservas.removeAll(reservasReprovadas);
		
		List<Reserva> reservasUnicas = validaReservasConcomitantes(reservas);
		
		for(Reserva reserva : reservasUnicas){
			
			if(!isReservaDiaUnico(reserva)){
				Calendar date = Calendar.getInstance();
				date.add(Calendar.HOUR, -48);
				if(reserva.getCreated().getTime() >= date.getTime().getTime()){
					continue;
				}
			}
			
			if(verificaValidacoesEmail(reserva)){
				reserva.setStatus(ReservaStatus.APROVADA);
				dispararEmailAprovacaoReserva(reserva);
			}			
			
		}
		
		return true;
	}
	
	private List<Reserva> validaReservasConcomitantes(List<Reserva> reservas) throws Exception{
		
		List<Reserva> reservasUnicas = new ArrayList<Reserva>();
		
		Boolean continua = false;
		
		do{
			
			if(reservasUnicas.size() > 0){
				reservas.clear();
				reservas.addAll(reservasUnicas);
				
				reservasUnicas.clear();
			}
			
			continua = false;
			
			if(reservas == null || reservas.size() == 1)
				return reservas;
			
			for(Reserva reservaDaVez : reservas){
				for(Reserva reservaVerificacao : reservas){
					
					if(reservaDaVez.equals(reservaVerificacao))
						continue;
					
					Calendar inicioReserva = Calendar.getInstance();
					Calendar fimReserva = Calendar.getInstance();
					Calendar inicioR = Calendar.getInstance();
					Calendar fimR = Calendar.getInstance();
					
					inicioReserva.setTime(reservaDaVez.getFimReserva());
					inicioReserva.add(Calendar.HOUR, -2);
					fimReserva.setTime(reservaDaVez.getFimReserva());
					fimReserva.add(Calendar.HOUR, 2);
					inicioR.setTime(reservaVerificacao.getFimReserva());
					fimR.setTime(reservaVerificacao.getFimReserva());
					
					if((inicioReserva.before(inicioR) && fimReserva.before(inicioR))
							|| (inicioReserva.before(inicioR) && fimReserva.before(inicioR))){
						reservasUnicas.add(elegeReserva(reservaDaVez, reservaVerificacao));
						continua = true;
					}
					else
						reservasUnicas.add(reservaDaVez);
					
				}
			}
		}while(continua);
		
		return reservasUnicas;
		
	}
	
	private Reserva elegeReserva(Reserva reserva1, Reserva reserva2) throws Exception{
		
		List<Terceiro> terceiros = new ArrayList<Terceiro>();
		terceiros.add(reserva1.getSolicitante());
		terceiros.add(reserva2.getSolicitante());
		
		List<Reserva> reservas = ((ReservaRepository) repository).getReservaByTerceirosByStatus(terceiros, ReservaStatus.ENCERRADA);
		
		if(reservas == null){
			if(reserva1.getCreated().before(reserva2.getCreated()))
				return reserva1;
			else
				return reserva2;
		}
		
		Reserva ultimaReserva = reservas.get(0);
		
		if(ultimaReserva.getSolicitante().equals(reserva1.getSolicitante())){
			reprovaReserva(reserva1);
			return reserva2;
		}
		else{
			reprovaReserva(reserva2);
			return reserva1;
		}
		
	}
	
	private void reprovaReserva(Reserva reserva) throws Exception{
		reserva.setStatus(ReservaStatus.ENCERRADA);
		this.salvar(reserva);
		dispararEmailReprovacaoReserva(reserva);
	}
	
	private void dispararEmailAprovacaoReserva(Reserva reserva) throws MessagingException{
		String[] destinatario = new String[]{reserva.getSolicitante().getEmails()};
		String title = "Prime Share Club - Reserva Aprovada";
		String texto = "Sua solicitação de reserva foi aprovada <br />" + "<br />Embarcação: "
				+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />Solicitante: "
				+ reserva.getSolicitante().getNome() + "<br />Data inicio da reserva: "
				+ Formatters.formatDate(reserva.getInicioReserva()) + "<br />Data fim da reserva: "
				+ Formatters.formatDate(reserva.getFimReserva())
				+ "<br /><br /><br />Att" 
				+ "<br />Equipe Prime Share Club";
		
		mailBusiness.sendMail("e2a.system@gmail.com", destinatario, title, texto);
				
	}
	
	private void dispararEmailReprovacaoReserva(Reserva reserva) throws MessagingException{
		String[] destinatario = new String[]{reserva.getSolicitante().getEmails()};
		String title = "Prime Share Club - Reserva Reprovada";
		String texto = "Sua solicitação de reserva foi reprovada <br />" + "<br />Embarcação: "
				+ reserva.getGrupo().getProdutos().get(0).getDescricao() + "<br />Solicitante: "
				+ reserva.getSolicitante().getNome() + "<br />Data inicio da reserva: "
				+ Formatters.formatDate(reserva.getInicioReserva()) + "<br />Data fim da reserva: "
				+ Formatters.formatDate(reserva.getFimReserva())
				+ "<br /><br /><br />Att" 
				+ "<br />Equipe Prime Share Club";
		
		mailBusiness.sendMail("e2a.system@gmail.com", destinatario, title, texto);
				
	}
	
	@SuppressWarnings("deprecation")
	private Boolean isReservaDiaUnico(Reserva reserva){
		if(reserva.getInicioReserva().getDay() != reserva.getFimReserva().getDay())
			return false;
		if(reserva.getInicioReserva().getMonth() != reserva.getFimReserva().getMonth())
			return false;
		if(reserva.getInicioReserva().getYear() != reserva.getFimReserva().getYear())
			return false;
		
		return true;
	}
	
	private Boolean verificaValidacoesEmail(Reserva reserva){
		
		for(ReservaValidacao validacao : reserva.getValidacoes()){
			if(validacao.getValidado() && !validacao.getAprovado()){
				return false;
			}
		}
		
		return true;
		
	}
	
}
