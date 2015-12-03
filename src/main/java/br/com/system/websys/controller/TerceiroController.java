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

import br.com.system.websys.business.TerceiroBusiness;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.TerceiroEndereco;
import br.com.system.websys.entities.TerceiroTipo;

@Controller
@RequestMapping("/terceiro")
public class TerceiroController {

	private static final Logger logger = LoggerFactory
			.getLogger(TerceiroController.class);

	@Autowired
	private TerceiroBusiness terceiroBusiness;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String configHome() {
		
		return "redirect:/terceiro/terceiros";
	}
	
	@RequestMapping(value = "/terceiros", method = RequestMethod.GET)
	public String configBases(Model model) {

		model.addAttribute("terceiros", terceiroBusiness.getAll());

		return "cadastro/terceiro/terceiros";
	}
	
	@RequestMapping(value = "/cadastro", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(Model model)
			throws Exception {

		Terceiro terceiro = new Terceiro();
		terceiro.getEnderecos().add(new TerceiroEndereco());

		model.addAttribute("listaTerceiroTipo", TerceiroTipo.values());
		model.addAttribute("terceiro", terceiro);
		
		
		return "cadastro/terceiro/formulario_terceiro";
	}
	
	@RequestMapping(value = "/cadastro/{id}", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(@PathVariable Long id, Model model)
			throws Exception {

		Terceiro terceiro = terceiroBusiness.get(id);
		
		if(terceiro.getEnderecos().size() ==0){
			terceiro.getEnderecos().add(new TerceiroEndereco());
		}
		
		model.addAttribute("listaTerceiroTipo", TerceiroTipo.values());
		model.addAttribute("terceiro", terceiro);
		
		return "cadastro/terceiro/formulario_terceiro";
	}
	
	@RequestMapping(value = "/cadastro/salvar", method = RequestMethod.POST)
	public String salvarBase(@Valid @ModelAttribute("terceiro") Terceiro terceiro,
			BindingResult result, Model model) throws Exception {

		if (result.hasErrors()) {

			for (ObjectError error : result.getAllErrors())
				logger.info("Erro: " + error.toString());
			
			model.addAttribute("listaTerceiroTipo", TerceiroTipo.values());
			model.addAttribute("terceiro", terceiro);
			
			return "cadastro/terceiro/formulario_terceiro";
		}

		try {
			terceiroBusiness.salvar(terceiro);
		} catch (Exception e) {

			model.addAttribute("terceiros", terceiro);
			model.addAttribute("message", e.getMessage());
			
			return "cadastro/terceiro/formulario_terceiro";
		}

		return "redirect:/terceiro/terceiros";
	}
}