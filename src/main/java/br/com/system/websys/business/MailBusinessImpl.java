package br.com.system.websys.business;

import java.util.Arrays;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import br.com.system.websys.entities.Mail;
import br.com.system.websys.repository.MailRepository;

@Service
public class MailBusinessImpl extends BusinessBaseRootImpl<Mail, MailRepository> implements MailBusiness {

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	protected MailBusinessImpl(MailRepository repository) {
		super(repository, Mail.class);
	}

	@Override
	public void sendMail(String from, String[] to, String subject, String msg) throws Exception {
		Mail mail = new Mail();
		mail.setMailFrom(from);
		mail.setMailTo(Arrays.asList(to));
		mail.setSubject(subject);
		mail.setMsg(msg);
		
		this.salvar(mail);
	}
		
	@Override
	public void sendMail(String from, String[] to, String subject, String msg, Boolean disparar) throws MessagingException {

		MimeMessage message = mailSender.createMimeMessage();
		
		message.setContent(msg, "text/html; charset=latin1");
		
		MimeMessageHelper helper = new MimeMessageHelper(message);
		
		helper.setFrom(from);
		helper.setTo(to);
		helper.setSubject(subject);

		mailSender.send(message);
	}
	
	@Override
	public List<Mail> findAll(){
		return ((MailRepository) repository).findAll();
	}

	@Override
	protected void validateBeforeSave(Mail entity) throws Exception {
		// TODO Auto-generated method stub		
	}
	
}
