package br.com.system.websys.controller;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.com.system.websys.business.ProdutoBusiness;
import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.ProdutoStatus;
import br.com.system.websys.entities.ProdutoTipo;

@Controller
@RequestMapping("/produtos")
public class ProdutoController{
	
	private static final Logger logger = LoggerFactory
			.getLogger(ConfiguracoesController.class);
	
	@Autowired
	private ProdutoBusiness ProdutoBusiness;

	//Quando clicado no menu.
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String configBases(Model model) {

		model.addAttribute("produtoList", ProdutoBusiness.getAll());
		return "produto/produto";
	}

	//Quando clicar para adicionar produto
	@RequestMapping(value = "/cadastro", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(Model model)
			throws Exception {

		Produto produto = new Produto();
		model.addAttribute("listaProdutoTipo", ProdutoTipo.values());
		model.addAttribute("listaProdutoStatus", ProdutoStatus.values());
		model.addAttribute("produto", produto);
		
		
		return "produto/formulario_produto";
	}
	
	//Quando clicar em um produto listado na tabela
	@RequestMapping(value = "/cadastro/{id}", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(@PathVariable Long id, Model model)
			throws Exception {

		Produto produto = ProdutoBusiness.get(id);
		

		model.addAttribute("produto", produto);
		
		return "produto/formulario_produto";
	}
	
	
	@RequestMapping(value = "/cadastro/salvar", method = RequestMethod.POST)
	public String salvarBase(@Valid @ModelAttribute("produto") Produto produto,
			BindingResult result, Model model) throws Exception {

		if (result.hasErrors()) {

			for (ObjectError error : result.getAllErrors())
				logger.info("Erro: " + error.toString());
			
			model.addAttribute("produto", produto);
			
			return "produto/formulario_produto";
		}

		try {
			ProdutoBusiness.salvar(produto);
		} catch (Exception e) {

			model.addAttribute("produto", produto);
			model.addAttribute("message", e.getMessage());
			
			return "user/formulario_user";
		}

		return "redirect:/produto/produto";
	}

	
}