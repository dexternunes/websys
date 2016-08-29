package br.com.system.websys.job;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.system.websys.business.MailBusiness;
import br.com.system.websys.business.ReservaBusiness;
import br.com.system.websys.entities.Mail;

@Component
class ReservaJobImpl implements ReservaJob {

	@Autowired
	private ReservaBusiness reservaBusiness;
	
	@Autowired
	private MailBusiness mailBusiness;
	
	@Override
	public void validaReservas() {
		reservaBusiness.validaAPoraToda();		
	}
	
	@Override
	public void loadAndSendMail() throws Exception{
		List<Mail> mails = mailBusiness.findAll();
		
		if(mails == null || mails.size() == 0)
			return;
		
		for(Mail mail : mails){
			
			if(mail.getEnding() || mail.getMailTo() == null || mail.getMailTo().size() == 0 
					|| mail.getMailTo().get(0).equals("") || !mail.getMailTo().get(0).contains("@"))
				continue;
			
			mail.setEnding(true);
			mailBusiness.salvar(mail);
			
			try{
				String[] to = new String[]{mail.getMailTo().get(0)}; 
				mailBusiness.sendMail(mail.getMailFrom(), to, mail.getSubject(), mail.getMsg(), true);
				mailBusiness.removeLocal(mail);
			}
			catch(Exception e){
				mail.setEnding(false);
				mailBusiness.salvar(mail);
			}
			
		}
		
	}
	
	@Override
	public void alterarStatusReserva() throws Exception{
		reservaBusiness.alterarStatusReserva();
	}
	
}
