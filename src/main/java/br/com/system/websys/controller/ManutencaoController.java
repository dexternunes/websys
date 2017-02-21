package br.com.system.websys.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import br.com.system.websys.business.ManutencaoBusiness;
import br.com.system.websys.business.ProdutoBusiness;
import br.com.system.websys.entities.Manutencao;
import br.com.system.websys.entities.ManutencaoStatus;
import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.ProdutoStatus;
import br.com.system.websys.entities.ProdutoTipo;
import br.com.system.websys.entities.Reserva;

@Controller
@RequestMapping("/manutencao")
public class ManutencaoController {
	
	private static final Logger logger = LoggerFactory.getLogger(TerceiroController.class);

	@Autowired
	private ManutencaoBusiness ManutencaoBusiness;

	@Autowired
	private ProdutoBusiness produtoBusiness;

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm");
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(
	            dateFormat, false));
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String configBases(Model model) {

		model.addAttribute("manutencaoList", ManutencaoBusiness.getAll());
		return "cadastro/manutencao/manutencao";
	}


	@RequestMapping(value = "/cadastro", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(Model model)
			throws Exception {

		List<Produto> produtosList = new ArrayList<Produto>(); 
		produtosList = produtoBusiness.getAll();
		Manutencao manutencao = new Manutencao();
		model.addAttribute("manutencao", manutencao);
		model.addAttribute("listaManutencaoStatus", ManutencaoStatus.values());
		model.addAttribute("listaProdutos", produtosList);
		
		
		return "cadastro/manutencao/formulario_manutencao";
	}


	@RequestMapping(value = "/cadastro/{id}", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(@PathVariable Long id, Model model)
			throws Exception {
		 
		List<Produto> produtosList = new ArrayList<Produto>(); 
		produtosList = produtoBusiness.getAll();
		Manutencao manutencao = ManutencaoBusiness.get(id);
		
		Produto p = produtoBusiness.get(manutencao.getProduto().getId());
		manutencao.setProduto(p);
		model.addAttribute("manutencao", manutencao);
		model.addAttribute("listaProdutos", produtosList);
		
		return "cadastro/manutencao/formulario_manutencao";
	}
	

	

	
	@RequestMapping(value = "/cadastro/salvar", method = RequestMethod.POST)
	public String manutencaoSalvar(@Valid @ModelAttribute("manutencao") Manutencao manutencao, BindingResult result, Model model)
			throws Exception {

		if (result.hasErrors()) { 
			
			
			List<Produto> produtosList = new ArrayList<Produto>(); 
			produtosList = produtoBusiness.getAll();
			List<ProdutoStatus> status = new ArrayList<ProdutoStatus>();
			status.add(ProdutoStatus.DISPONIVEL);

			model.addAttribute("listProdutos", produtoBusiness.getAllByTipoAndStatus(ProdutoTipo.EMBARCACAO, status));
			model.addAttribute("manutencao", manutencao);
			model.addAttribute("listaProdutos", produtosList);
			return "cadastro/manutencao/formulario_manutencao";
		}

		try {
			Produto p = produtoBusiness.get(manutencao.getProduto().getId());
			manutencao.setProduto(p);
			manutencao.setFimManutencao(manutencao.getInicioManutencao());
			ManutencaoBusiness.salvar(manutencao);
		} catch (Exception e) {

			model.addAttribute("manutencao", manutencao);
			model.addAttribute("message", e.getMessage());
			
			return "cadastro/manutencao/form";
		}		

		return "redirect:/manutencao/";
	}
	
	@RequestMapping(value = "/remove", method = RequestMethod.POST, headers = "Accept=application/json", produces = "application/json", consumes = "application/json")
	@ResponseBody
	public void excluiManutencao(@RequestBody Long idManutencao) throws Exception {

		Manutencao manutencao = ManutencaoBusiness.get(idManutencao);
		manutencao.setExcluida(true);

		try {
			ManutencaoBusiness.salvar(manutencao);
		} catch (Exception e) {
			logger.info("Erro: " + e.toString());
		}
	}
}
