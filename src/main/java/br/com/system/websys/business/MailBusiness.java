package br.com.system.websys.business;

import java.util.List;

import javax.mail.MessagingException;

import br.com.system.websys.entities.Mail;
import br.com.system.websys.repository.MailRepository;

public interface MailBusiness  extends BusinessBaseRoot<Mail, MailRepository> {

	void sendMail(String from, String[] to, String subject, String msg) throws MessagingException, Exception;

	void sendMail(String from, String[] to, String subject, String msg, Boolean disparar) throws MessagingException;

	List<Mail> findAll();

}
