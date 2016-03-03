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
		
		if(mails == null)
			return;
		
		for(Mail mail : mails){
			String[] to = new String[]{mail.getMailTo().get(0)}; 
			mailBusiness.sendMail(mail.getMailFrom(), to, mail.getSubject(), mail.getMsg(), true);
		}
		mailBusiness.removeLocal(mails);
	}
	
}
