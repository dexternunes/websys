package br.com.system.websys.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.com.system.websys.business.ManutencaoBusiness;
import br.com.system.websys.business.ProdutoBusiness;
import br.com.system.websys.entities.Manutencao;
import br.com.system.websys.entities.ManutencaoStatus;
import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.ProdutoStatus;
import br.com.system.websys.entities.ProdutoTipo;

@Controller
@RequestMapping("/manutencao")
public class ManutencaoController {

	@Autowired
	private ManutencaoBusiness ManutencaoBusiness;

	@Autowired
	private ProdutoBusiness produtoBusiness;

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

		Manutencao manutencao = ManutencaoBusiness.get(id);
		
		Produto p = produtoBusiness.get(manutencao.getProduto().getId());
		manutencao.setProduto(p);
		model.addAttribute("manutencao", manutencao);
		
		return "cadastro/manutencao/formulario_manutencao";
	}
	

	

	
	@RequestMapping(value = "/cadastro/salvar", method = RequestMethod.POST)
	public String manutencaoSalvar(@Valid @ModelAttribute("manutencao") Manutencao manutencao, BindingResult result, Model model)
			throws Exception {

		if (result.hasErrors()) {

			List<ProdutoStatus> status = new ArrayList<ProdutoStatus>();
			status.add(ProdutoStatus.A_VENDA);

			model.addAttribute("listProdutos", produtoBusiness.getAllByTipoAndStatus(ProdutoTipo.EMBARCACAO, status));
			model.addAttribute("manutencao", manutencao);

			return "cadastro/manutencao/form";
		}

		try {
			Produto p = produtoBusiness.get(manutencao.getProduto().getId());
			manutencao.setProduto(p);
			ManutencaoBusiness.salvar(manutencao);
		} catch (Exception e) {

			model.addAttribute("manutencao", manutencao);
			model.addAttribute("message", e.getMessage());
			
			return "cadastro/manutencao/form";
		}

		return "redirect:/manutencao/";
	}
}
