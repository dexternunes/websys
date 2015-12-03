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

import br.com.system.websys.business.TerceiroBusiness;
import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.User;

@Controller
@RequestMapping("/usuarios")
public class UserController{
	
	@Autowired
	private UserBusiness userBusiness;
	
	@Autowired
	private TerceiroBusiness terceiroBusiness;

	//Quando clicado no menu.
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String configBases(Model model) {

		model.addAttribute("usersList", userBusiness.getAll());
		return "cadastro/user/user";
	}

	//Quando clicar para adicionar usuario
	@RequestMapping(value = "/cadastro", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(Model model)
			throws Exception {

		List<Terceiro> terceiroList = new ArrayList<Terceiro>(); 
		terceiroList = terceiroBusiness.getAll();
		User usuario = new User();
		model.addAttribute("usuario", usuario);
		model.addAttribute("listaUserRole", Role.values());
		model.addAttribute("listaTerceiros", terceiroList);
		
		
		return "cadastro/user/formulario_user";
	}
	
	//Quando clicar em um usuario listado na tabela
	@RequestMapping(value = "/cadastro/{id}", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(@PathVariable Long id, Model model)
			throws Exception {

		User usuario = userBusiness.get(id);
		

		model.addAttribute("usuario", usuario);
		
		return "cadastro/user/formulario_user";
	}
	
	@RequestMapping(value = "/cadastro/salvar", method = RequestMethod.POST)
	public String salvarBase(@Valid @ModelAttribute("usuario") User usuario,
			BindingResult result, Model model) throws Exception {

		if (result.hasErrors()) {
			
			model.addAttribute("usuario", usuario);
			
			return "cadastro/user/formulario_user";
		}

		try {
			Terceiro t = terceiroBusiness.get(usuario.getTerceiro().getId());
			usuario.setTerceiro(t);
			userBusiness.salvar(usuario);
		} catch (Exception e) {

			model.addAttribute("usuario", usuario);
			model.addAttribute("message", e.getMessage());
			
			return "cadastro/user/formulario_user";
		}

		return "redirect:/usuarios/";
	}

	
}