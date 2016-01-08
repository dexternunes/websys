package br.com.system.websys.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.com.system.websys.business.GrupoBusiness;
import br.com.system.websys.business.ManutencaoBusiness;
import br.com.system.websys.business.ProdutoBusiness;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Manutencao;
import br.com.system.websys.entities.ManutencaoStatus;
import br.com.system.websys.entities.Produto;

@Controller
@RequestMapping("/faturamento")
public class FaturamentoController{
	
	@Autowired
	private ProdutoBusiness ProdutoBusiness;
	
	@Autowired
	private ManutencaoBusiness ManutencaoBusiness;
	
	@Autowired
	private GrupoBusiness grupoBusiness;

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


		
		Grupo grupo = grupoBusiness.get(id);

		
		Produto produto =  grupo.getProdutos().get(0);


		List<Manutencao> manutencaoList =  ManutencaoBusiness.findByProdutoByStatus(produto, ManutencaoStatus.PENDENTE);
		
		
		model.addAttribute("manutencaoList", manutencaoList);


		
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
	
	
}