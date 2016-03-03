package br.com.system.websys.entities;

import java.util.List;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "mail")
public class Mail extends EntityBaseRoot {

	private String mailFrom;

	private List<String> mailTo;

	private String subject;

	private String msg;

	@Id
	@GeneratedValue
	@Column(name = "id_mail")
	@Override
	public Long getId() {
		return id;
	}

	public String getMailFrom() {
		return mailFrom;
	}

	public void setMailFrom(String mailFrom) {
		this.mailFrom = mailFrom;
	}

	@ElementCollection(targetClass = String.class, fetch=FetchType.EAGER)
	@CollectionTable(name = "email_to", joinColumns = @JoinColumn(name = "id_mail") )
	public List<String> getMailTo() {
		return mailTo;
	}

	public void setMailTo(List<String> mailTo) {
		this.mailTo = mailTo;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	@Column(length = 10000)
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}
