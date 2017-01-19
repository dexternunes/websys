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

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

@Entity
@Table(name = "mail")
public class Mail extends EntityBaseRoot {

	private String mailFrom;

	private List<String> mailTo;

	private String subject;

	private String msg;
	
	private Boolean ending = false;

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

	@ElementCollection(targetClass = String.class)
	@CollectionTable(name = "email_to", joinColumns = @JoinColumn(name = "id_mail") )
	@LazyCollection(LazyCollectionOption.TRUE)
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

	public Boolean getEnding() {
		return ending;
	}

	public void setEnding(Boolean ending) {
		this.ending = ending;
	}
	
}
