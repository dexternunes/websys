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

import br.com.system.websys.business.GrupoBusiness;
import br.com.system.websys.business.ProdutoBusiness;
import br.com.system.websys.business.TerceiroBusiness;
import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.ProdutoStatus;
import br.com.system.websys.entities.ProdutoTipo;
import br.com.system.websys.entities.TerceiroTipo;

@Controller
@RequestMapping("/grupo")
@Transactional
public class GrupoController {

	@Autowired
	private GrupoBusiness grupoBusiness;
	
	@Autowired
	private TerceiroBusiness terceiroBusiness;
	
	@Autowired
	private ProdutoBusiness produtoBusiness;

	@RequestMapping(value = "/", method = RequestMethod.GET)
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
		status.add(ProdutoStatus.DISPONIVEL);
		
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
		
		List<ProdutoStatus> status = new ArrayList<ProdutoStatus>();
		status.add(ProdutoStatus.DISPONIVEL);
		
		model.addAttribute("readonly", true);
		model.addAttribute("listTerceiros", terceiroBusiness.getAllByTipo(TerceiroTipo.CLIENTE));
		model.addAttribute("grupo", grupo);
		
		return "cadastro/grupo/form";
	}
	
	@RequestMapping(value = "/cadastro/salvar", method = RequestMethod.POST)
	public String grupoSalvar(@Valid @ModelAttribute("grupo") Grupo grupo,
			BindingResult result, Model model) throws Exception {

		if (result.hasErrors()) {

			List<ProdutoStatus> status = new ArrayList<ProdutoStatus>();
			status.add(ProdutoStatus.DISPONIVEL);
			
			model.addAttribute("listTerceiros", terceiroBusiness.getAllByTipo(TerceiroTipo.CLIENTE));
			model.addAttribute("listProdutos", produtoBusiness.getAllByTipoAndStatus(ProdutoTipo.EMBARCACAO, status));
			model.addAttribute("grupo", grupo);
			
			return "cadastro/grupo/form";
		}

		try {
			grupoBusiness.salvar(grupo);
		} catch (Exception e) {

			List<ProdutoStatus> status = new ArrayList<ProdutoStatus>();
			status.add(ProdutoStatus.DISPONIVEL);
			
			model.addAttribute("listTerceiros", terceiroBusiness.getAllByTipo(TerceiroTipo.CLIENTE));
			model.addAttribute("listProdutos", produtoBusiness.getAllByTipoAndStatus(ProdutoTipo.EMBARCACAO, status));
			model.addAttribute("grupo", grupo);
			model.addAttribute("message", e.getMessage());
			
			return "cadastro/grupo/form";
		}

		return "redirect:/grupo/";
	}
	
	@RequestMapping(value = "/cadastro/excluir/{id}", method = RequestMethod.GET)
	public String grupoexcluir(@PathVariable Long id, Model model) throws Exception {

		Grupo grupo = grupoBusiness.get(id);
		
		try {
			grupoBusiness.delete(grupo);
		} catch (Exception e) {

			List<ProdutoStatus> status = new ArrayList<ProdutoStatus>();
			status.add(ProdutoStatus.DISPONIVEL);
			
			model.addAttribute("listTerceiros", terceiroBusiness.getAllByTipo(TerceiroTipo.CLIENTE));
			model.addAttribute("listProdutos", produtoBusiness.getAllByTipoAndStatus(ProdutoTipo.EMBARCACAO, status));
			model.addAttribute("grupo", grupo);
			model.addAttribute("message", e.getMessage());
			
			return "cadastro/grupo/form";
		}

		return "redirect:/grupo/";
	}
}
