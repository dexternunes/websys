package br.com.system.websys.business;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailBusinessImpl implements MailBusiness {

	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	public void sendMail(String from, String[] to, String subject, String msg) throws MessagingException {

		MimeMessage message = mailSender.createMimeMessage();
		
		message.setContent(msg, "text/html; charset=latin1");
		
		MimeMessageHelper helper = new MimeMessageHelper(message);
		
		helper.setFrom(from);
		helper.setTo(to);
		helper.setSubject(subject);

		mailSender.send(message);
	}
	
}
