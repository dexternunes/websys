package br.com.system.websys.job;

public interface ReservaJob {

	public void validaReservas();

	public void loadAndSendMail() throws Exception;

	public void alterarStatusReserva() throws Exception;

}
