package br.com.system.websys.entities;

import java.util.Date;

public class ReservaDTO {
	
	private String title;
	
	private Date start;
	
	private Date end;
	
	private Boolean allDay;
	
	private String url;

	public ReservaDTO(String title, Date start, Date end, Boolean allDay, String url){
		this.title = title;
		this.start = start;
		this.end = end;
		this.allDay = allDay;
		this.url = url;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	public Boolean getAllDay() {
		return allDay;
	}

	public void setAllDay(Boolean allDay) {
		this.allDay = allDay;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
				
}
