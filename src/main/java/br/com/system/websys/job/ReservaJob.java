package br.com.system.websys.job;

public interface ReservaJob {

	public void validaReservas();

	void loadAndSendMail() throws Exception;

}
