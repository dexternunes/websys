package br.com.system.websys.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.system.websys.business.FaturamentoBusiness;
import br.com.system.websys.business.GrupoBusiness;
import br.com.system.websys.business.ManutencaoBusiness;
import br.com.system.websys.business.ProdutoBusiness;
import br.com.system.websys.business.ReservaBusiness;
import br.com.system.websys.entities.Faturamento;
import br.com.system.websys.entities.FaturamentoDTO;
import br.com.system.websys.entities.FaturamentoRateio;
import br.com.system.websys.entities.FaturamentoRateioDTO;
import br.com.system.websys.entities.FaturamentoStatus;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Manutencao;
import br.com.system.websys.entities.ManutencaoStatus;
import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.Terceiro;

@Controller
@RequestMapping("/faturamento")
public class FaturamentoController{
	
	
	@Autowired
	private ProdutoBusiness ProdutoBusiness;
	
	@Autowired
	private ManutencaoBusiness ManutencaoBusiness;
	
	@Autowired
	private GrupoBusiness grupoBusiness;
	
	@Autowired
	private FaturamentoBusiness FaturamentoBusiness;
	
	@Autowired
	private ReservaBusiness ReservaBusiness;

	//Quando clicado no menu.
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String configBases(Model model) {
		List<Grupo> gruposList = new ArrayList<Grupo>(); 
		gruposList = grupoBusiness.getAll();
		model.addAttribute("listaGrupos", gruposList);
		
		
		return "faturamento/faturamento";
	}

	
	//Quando selecionar um grupo no combobox
	@RequestMapping(value = "/grupo/{id}", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(@PathVariable Long id, Model model)
			throws Exception {

		/*
		Long totalSecs = (long) 8024;
		Long hours;
		Long minutes;
		Long seconds;
		
		hours = totalSecs / 3600;
		minutes = (totalSecs % 3600) / 60;
		seconds = totalSecs % 60;
		*/
		
		Grupo grupo = grupoBusiness.get(id);
		List<Reserva> reservaList = ReservaBusiness.getByGrupoByStatus(grupo, FaturamentoStatus.PENDENTE);
		
		Produto produto =  grupo.getProdutos().get(0);

		List<Terceiro> terceiroList = grupo.getTerceiros();
		List<Manutencao> manutencaoList =  ManutencaoBusiness.findByProdutoByStatus(produto, ManutencaoStatus.PENDENTE);
		

		model.addAttribute("terceiroList", terceiroList);
		model.addAttribute("manutencaoList", manutencaoList);
		model.addAttribute("reservaList", reservaList);


		
		return "faturamento/lista_faturamento";
	}
	
	
	//Historico
	
	//Quando clicado no menu.
	//Quando selecionar um grupo no combobox
	@RequestMapping(value = "/historico", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String historicoBase(Model model)
			throws Exception {

		List<Grupo> gruposList = new ArrayList<Grupo>(); 
		gruposList = grupoBusiness.getAll();
		model.addAttribute("listaGrupos", gruposList);
		

		
		return "rel/historico";
	}

	//Quando selecionar um grupo no combobox
	@RequestMapping(value = "/historico/grupo/{id}", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String listarHistorico(@PathVariable Long id, Model model)
			throws Exception {


		
		Grupo grupo = grupoBusiness.get(id);

		
		Produto produto =  grupo.getProdutos().get(0);


		List<Manutencao> manutencaoList =  ManutencaoBusiness.findByProdutoByStatus(produto, ManutencaoStatus.PAGA);
		
		
		model.addAttribute("manutencaoList", manutencaoList);


		
		return "rel/lista_historico";
	}
	


	@ResponseBody
	@RequestMapping(value= "/api/faturar", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON)
	public FaturamentoDTO postReserva(HttpServletRequest request, @RequestBody FaturamentoDTO faturamentoDto) throws Exception {
		
		
		Faturamento faturamento = new Faturamento();
		List<Manutencao> manutencoesSelecionadasList = new ArrayList<Manutencao>();
		Manutencao manutencao = new Manutencao();
		List<Reserva> reservasSelecionadasList = new ArrayList<Reserva>();
		Reserva reserva = new Reserva();
		FaturamentoDTO faturamentoDTO = new FaturamentoDTO();
		FaturamentoRateioDTO faturamentoRateioDTO = new FaturamentoRateioDTO();
		List<FaturamentoRateioDTO> faturamentoRateioDTOList = new ArrayList <FaturamentoRateioDTO>();
		
		faturamentoDTO.setValorTotal(0.00);
		
		
		
		for (long id:faturamentoDto.getIdsManutencao()){
			manutencao = ManutencaoBusiness.get(id);
			manutencoesSelecionadasList.add(manutencao);
		}
		
		
		
		for (long id:faturamentoDto.getIdsHoraMotor()){
			reserva = ReservaBusiness.get(id);
			reservasSelecionadasList.add(reserva);
		}

		faturamento = FaturamentoBusiness.calcularFaturamento(manutencoesSelecionadasList, reservasSelecionadasList);
		
		for (FaturamentoRateio f:faturamento.getFaturamentoRateios()){
			faturamentoRateioDTO = new FaturamentoRateioDTO();
			faturamentoRateioDTO.setHoras(f.getHoras());
			faturamentoRateioDTO.setTerceiro(f.getTerceiro());
			faturamentoRateioDTO.setValor(f.getValor());
			faturamentoDTO.setValorTotal(faturamento.getValor());
			//DecimalFormat twoDForm = new DecimalFormat("#.##");
			//faturamentoDTO.setValorTotal(Double.valueOf(twoDForm.format(faturamentoDTO.getValorTotal())));
			faturamentoRateioDTOList.add(faturamentoRateioDTO);
		}
		
		faturamentoDTO.setFaturamentoRateioLista(faturamentoRateioDTOList);
		
		
		//try {
		return faturamentoDTO;
			
		//} catch (Exception e) {
			//return "redirect:/home";
		//}
	}
	
	//salvar
	@ResponseBody
	@RequestMapping(value= "/api/salvar", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON)
	public String salvarFaturamento(HttpServletRequest request, @RequestBody FaturamentoDTO faturamentoDto) throws Exception {

		
		Faturamento faturamento = new Faturamento();
		List<Manutencao> manutencoesSelecionadasList = new ArrayList<Manutencao>();
		Manutencao manutencao = new Manutencao();
		List<Reserva> reservasSelecionadasList = new ArrayList<Reserva>();
		Reserva reserva = new Reserva();
		
		
		
		
		for (long id:faturamentoDto.getIdsManutencao()){
			manutencao = ManutencaoBusiness.get(id);
			manutencao.setStatus(ManutencaoStatus.PAGA);
			manutencoesSelecionadasList.add(manutencao);
		}
		
		for (long id:faturamentoDto.getIdsHoraMotor()){
			reserva = ReservaBusiness.get(id);
			reserva.setFaturamentoStatus(FaturamentoStatus.PAGA);
			reservasSelecionadasList.add(reserva);
		}		
		faturamento = FaturamentoBusiness.calcularFaturamento(manutencoesSelecionadasList, reservasSelecionadasList);
		
		
		try {
			FaturamentoBusiness.salvar(faturamento);
		} catch (Exception e) {


			
			return "Ocorreu um erro ao faturar. Favor contatar o administrador do sistema";
		}

		return "Faturado com sucesso.";
	}

	
	
}