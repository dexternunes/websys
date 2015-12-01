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

import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.User;

@Controller
@RequestMapping("/usuarios")
public class UserController{
	
	private static final Logger logger = LoggerFactory
			.getLogger(ConfiguracoesController.class);
	
	@Autowired
	private UserBusiness userBusiness;

	//Quando clicado no menu.
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String configBases(Model model) {

		model.addAttribute("usersList", userBusiness.getAll());
		return "user/user";
	}

	//Quando clicar para adicionar usuario
	@RequestMapping(value = "/cadastro", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(Model model)
			throws Exception {

		User usuario = new User();
		model.addAttribute("usuario", usuario);
		
		
		return "user/formulario_user";
	}
	
	//Quando clicar em um usuario listado na tabela
	@RequestMapping(value = "/cadastro/{id}", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(@PathVariable Long id, Model model)
			throws Exception {

		User usuario = userBusiness.get(id);
		

		model.addAttribute("usuario", usuario);
		
		return "user/formulario_user";
	}
	
	@RequestMapping(value = "/cadastro/salvar", method = RequestMethod.POST)
	public String salvarBase(@Valid @ModelAttribute("usuario") User usuario,
			BindingResult result, Model model) throws Exception {

		if (result.hasErrors()) {

			for (ObjectError error : result.getAllErrors())
				logger.info("Erro: " + error.toString());
			
			model.addAttribute("usuario", usuario);
			
			return "user/formulario_user";
		}

		try {
			userBusiness.salvar(usuario);
		} catch (Exception e) {

			model.addAttribute("usuario", usuario);
			model.addAttribute("message", e.getMessage());
			
			return "user/formulario_user";
		}

		return "redirect:/user/user";
	}

	
}