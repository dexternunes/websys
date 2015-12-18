package br.com.system.websys.business;

import javax.mail.MessagingException;

public interface MailBusiness {

	void sendMail(String from, String[] to, String subject, String msg) throws MessagingException;

}
