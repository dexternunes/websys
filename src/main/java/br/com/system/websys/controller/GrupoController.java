package br.com.system.websys.controller;

import java.util.ArrayList;
import java.util.List;

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

import br.com.system.websys.business.GrupoBusiness;
import br.com.system.websys.business.ProdutoBusiness;
import br.com.system.websys.business.TerceiroBusiness;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.ProdutoStatus;
import br.com.system.websys.entities.ProdutoTipo;
import br.com.system.websys.entities.TerceiroTipo;

@Controller
@RequestMapping("/grupo")
public class GrupoController {

	private static final Logger logger = LoggerFactory
			.getLogger(GrupoController.class);

	@Autowired
	private GrupoBusiness grupoBusiness;
	
	@Autowired
	private TerceiroBusiness terceiroBusiness;
	
	@Autowired
	private ProdutoBusiness produtoBusiness;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String grupo() {
		
		return "redirect:/grupo/list";
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String grupoList(Model model) {

		model.addAttribute("grupos", grupoBusiness.getAll());

		return "cadastro/grupo/list";
	}
	
	@RequestMapping(value = "/cadastro", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String grupoCadastro(Model model)
			throws Exception {

		Grupo grupo = new Grupo();
		
		List<ProdutoStatus> status = new ArrayList<ProdutoStatus>();
		status.add(ProdutoStatus.A_VENDA);
		
		model.addAttribute("grupo", grupo);
		model.addAttribute("listTerceiros", terceiroBusiness.getAllByTipo(TerceiroTipo.CLIENTE));
		model.addAttribute("listProdutos", produtoBusiness.getAllByTipoAndStatus(ProdutoTipo.EMBARCACAO, status));
		
		return "cadastro/grupo/form";
	}
	
	@RequestMapping(value = "/cadastro/{id}", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String grupoCadastro(@PathVariable Long id, Model model)
			throws Exception {

		Grupo grupo = grupoBusiness.get(id);
		
		model.addAttribute("grupo", grupo);
		
		return "cadastro/grupo/form";
	}
	
	@RequestMapping(value = "/cadastro/salvar", method = RequestMethod.POST)
	public String grupoSalvar(@Valid @ModelAttribute("grupo") Grupo grupo,
			BindingResult result, Model model) throws Exception {

		if (result.hasErrors()) {

			for (ObjectError error : result.getAllErrors())
				logger.info("Erro: " + error.toString());
			
			model.addAttribute("grupo", grupo);
			
			return "cadastro/grupo/form";
		}

		try {
			grupoBusiness.salvar(grupo);
		} catch (Exception e) {

			model.addAttribute("grupo", grupo);
			model.addAttribute("message", e.getMessage());
			
			return "cadastro/grupo/form";
		}

		return "redirect:/grupo/list";
	}
}