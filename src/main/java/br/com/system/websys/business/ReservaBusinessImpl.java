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
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaEvento;
import br.com.system.websys.entities.ReservaStatus;
import br.com.system.websys.entities.ReservaValidacao;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.formatter.Formatters;
import br.com.system.websys.repository.ReservaRepository;


@Service  
@Transactional(propagation=Propagation.REQUIRED)
class ReservaBusinessImpl extends BusinessBaseRootImpl<Reserva, ReservaRepository> implements ReservaBusiness {
    
	@Autowired
	public UserBusiness userBusiness;
	
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
		return ((ReservaRepository)repository).findAll();
	}



	public List<Reserva> getAllByGrupo(List<Grupo> grupos) {
		List<Reserva> reserva = ((ReservaRepository) repository).getAllByGrupo(grupos);
		return reserva;
	}
	
	@Override
	public Reserva createReserva(Reserva reserva) throws Exception{
		reserva.setEventoInicio(new ReservaEvento());
		reserva.setEventoFim(new ReservaEvento());
		reserva.setStatus(ReservaStatus.AGUARDANDO_APROVACAO);
		reserva.setSolicitante(userBusiness.getCurrent().getTerceiro());
		
		List<ReservaValidacao> validacoes = new ArrayList<ReservaValidacao>();
		for(Terceiro terceiro : reserva.getGrupo().getTerceiros()){
			if(!reserva.getSolicitante().equals(terceiro)){
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
	public Boolean sendEmailValidacao(Reserva reserva, String server) throws MessagingException{
		
		String link = server + "/websys/reserva/validar/"; 
		
		for(ReservaValidacao validacao : reserva.getValidacoes()){
			mailBusiness.sendMail("e2a.system@gmail.com"
					, new String[]{validacao.getTerceiro().getEmails()}
					, "Prime Share Club - Reserva Solicitada"
					, "Uma nova reserva foi solicitada <br />"
							+ "<br />Embarcação: " + reserva.getGrupo().getProdutos().get(0).getDescricao()
							+ "<br />Solicitante: " + reserva.getSolicitante().getNome()
							+ "<br />Data inicio da reserva: " + Formatters.formatDate(reserva.getInicioReserva())
							+ "<br />Data fim da reserva: " + Formatters.formatDate(reserva.getFimReserva())
							+ "<br /><br />Clique <a href='" + link + validacao.getUid() + "'>aqui</a> para validar/questionar a reserva" 
							+ "<br /><br /><br />Att"
							+ "<br />Equipe Prime Share Club");
		}
		return false;
	}

	@Override
	public List<Reserva> getGetProprietario(Terceiro terceiro) {
		List<Reserva> reservas = ((ReservaRepository)repository).getGetProprietario(terceiro);
		if(reservas == null || reservas.size() == 0)
			return null;
		
		return reservas;
	}

	@Override
	public String validaExclusao(Reserva reserva) {
		Date horaInicioReserva = reserva.getInicioReserva();
		Calendar horaInicioReservaCal = Calendar.getInstance();
		horaInicioReservaCal.setTime(horaInicioReserva);
		
		long dif = (horaInicioReservaCal.getTimeInMillis() - System.currentTimeMillis()) / (60 * 60 * 1000);
		
		if(dif < 2)
			return "false";
		else
			return "true";
	}

	@Override
	public Reserva getReservaByEventoFim(ReservaEvento eventoFim) {
		Reserva reserva = ((ReservaRepository)repository).getReservaByEventoFim(eventoFim);
		return reserva;
	}

	public List<Reserva> getByGrupoByStatus(Grupo grupo, FaturamentoStatus faturamentoStatus) {
		List<Reserva> reservas = ((ReservaRepository)repository).findByReservaByGrupoByStatus(grupo, faturamentoStatus);
		return reservas;
	}
}
