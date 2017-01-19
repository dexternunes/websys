package br.com.system.websys.job;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.system.websys.business.MailBusiness;
import br.com.system.websys.business.ReservaBusiness;
import br.com.system.websys.controller.TerceiroController;
import br.com.system.websys.entities.Mail;

@Component
class ReservaJobImpl implements ReservaJob {

	private static final Logger logger = LoggerFactory.getLogger(TerceiroController.class);

	@Autowired
	private ReservaBusiness reservaBusiness;

	@Autowired
	private MailBusiness mailBusiness;

	@Override
	public void validaReservas() {
		
		logger.info("=================================================================================");
		logger.info("================================= VALIDA RESERVAS ===============================");
		logger.info("=================================================================================");
		
		try{
			reservaBusiness.validaAPoraToda();
		} catch (Exception e) {
			logger.info("=================================================================================");
			logger.info("========================= INICIO ERRO VALIDA RESERVAS ===========================");
			logger.info("=================================================================================");

			logger.info(e.getMessage());
			logger.info(e.getStackTrace().toString());

			logger.info("=================================================================================");
			logger.info("============================= FIM VALIDA RESERVAS ===============================");
			logger.info("=================================================================================");
		}
	}

	@Override
	public void loadAndSendMail() throws Exception {

		logger.info("=================================================================================");
		logger.info("================================= SEND EMAIL ====================================");
		logger.info("=================================================================================");

		try {
			List<Mail> mails = mailBusiness.findAll();

			if (mails == null || mails.size() == 0)
				return;

			for (Mail mail : mails) {

				if (mail.getEnding() || mail.getMailTo() == null || mail.getMailTo().size() == 0
						|| mail.getMailTo().get(0).equals("") || !mail.getMailTo().get(0).contains("@"))
					continue;

				mail.setEnding(true);
				mailBusiness.salvar(mail);

				try {
					String[] to = new String[] { mail.getMailTo().get(0) };
					mailBusiness.sendMail(mail.getMailFrom(), to, mail.getSubject(), mail.getMsg(), true);
					mailBusiness.removeLocal(mail);
				} catch (Exception e) {
					mail.setEnding(false);
					mailBusiness.salvar(mail);
				}

			}

		} catch (Exception e) {
			logger.info("=================================================================================");
			logger.info("========================= INICIO ERRO SEND EMAIL ================================");
			logger.info("=================================================================================");

			logger.info(e.getMessage());
			logger.info(e.getStackTrace().toString());

			logger.info("=================================================================================");
			logger.info("============================= FIM SEND EMAIL ====================================");
			logger.info("=================================================================================");
		}
	}

	@Override
	public void alterarStatusReserva() throws Exception {

		logger.info("=================================================================================");
		logger.info("============================  Alteração status reserva ==========================");
		logger.info("=================================================================================");
		try {
			reservaBusiness.alterarStatusReserva();
		} catch (Exception e) {
			logger.info("=================================================================================");
			logger.info("============== INICIO ERRRO EM: Alteração status reserva ========================");
			logger.info("=================================================================================");

			logger.info(e.getMessage());
			logger.info(e.getStackTrace().toString());

			logger.info("=================================================================================");
			logger.info("===================== FIM ERRO EM: Alteração status reserva =====================");
			logger.info("=================================================================================");
		}
	}

}
