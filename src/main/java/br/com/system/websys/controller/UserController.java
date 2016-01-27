package br.com.system.websys.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import br.com.system.websys.entities.DefinirNovaSenhaDTO;
import br.com.system.websys.entities.RecuperarSenhaDTO;
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

		User user = userBusiness.getCurrent();
		
		if(user.getRole().equals(Role.ROLE_COTISTA) || user.getRole().equals(Role.ROLE_MARINHEIRO)){
			return "redirect:/home";
		}
		
		List<Role> roles = new ArrayList<Role>();
		
		if(user.getRole().equals(Role.ROLE_ROOT)){
			roles.add(Role.ROLE_ROOT);
		}
		
		roles.add(Role.ROLE_ADMIN);
		roles.add(Role.ROLE_COTISTA);
		roles.add(Role.ROLE_MARINHEIRO);
		
		model.addAttribute("usersList", userBusiness.getByRoles(roles));
		return "cadastro/user/user";
	}

	//Quando clicar para adicionar usuario
	@RequestMapping(value = "/cadastro", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(Model model)
			throws Exception {

		addAtributes(model, new User());
		return "cadastro/user/formulario_user";
	}
	
	//Quando clicar para adicionar usuario
	@RequestMapping(value = "/recuperarsenha", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String recuperarSenha(Model model)
			throws Exception {

		model.addAttribute("recuperarSenhaDTO", new RecuperarSenhaDTO());
		return "auth/recuperarSenha";
	}
	
	@RequestMapping(value = "/recuperarsenha/submit", method = RequestMethod.POST)
	public String recuperarSenha(@ModelAttribute("recuperarSenhaDTO") RecuperarSenhaDTO recuperarSenhaDTO,
			BindingResult result, Model model, HttpServletRequest request) throws Exception {
		
		String server;
		if(request.getServerPort() == 80)
			server = "http://" + request.getServerName();
		else
			server = "http://" + request.getServerName() + ":" + request.getServerPort();
		
		if(userBusiness.enviarEmailRecuperarSenha(recuperarSenhaDTO, server)){
			model.addAttribute("messageOk", "Um e-mail foi enviado para " + recuperarSenhaDTO.getEmail());
		}
		else{
			model.addAttribute("message", "Login e/ou e-mail inválidos!");
		}
		
		model.addAttribute("recuperarSenhaDTO", recuperarSenhaDTO);
		return "auth/recuperarSenha";
	}
	
	@RequestMapping(value = "/recuperarsenha/submitnova", method = RequestMethod.POST)
	public String setNovaSenha(@ModelAttribute("definirNovaSenhaDTO") DefinirNovaSenhaDTO definirNovaSenhaDTO,
			BindingResult result, Model model, HttpServletRequest request) throws Exception {
		
		if(!definirNovaSenhaDTO.getSenha().equals(definirNovaSenhaDTO.getRepetirSenha())){
			model.addAttribute("definirNovaSenhaDTO", definirNovaSenhaDTO);
			model.addAttribute("message", "Os dois campos de senha precisam ser iguais");
			return "auth/novaSenha";
		}
		
		if(!userBusiness.redefinirSenha(definirNovaSenhaDTO)){
			model.addAttribute("definirNovaSenhaDTO", definirNovaSenhaDTO);
			model.addAttribute("message", "Não foi possível redefinir a senha");
			return "auth/novaSenha";
		}
		
		return "auth/login";
	}

	@RequestMapping(value = "/recuperarsenha/{uid}", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String validaRecuperSenha(@PathVariable String uid, Model model)
			throws Exception {

		User usuario = userBusiness.getUid(uid);
		
		if(usuario != null){
			DefinirNovaSenhaDTO definirNovaSenhaDTO = new DefinirNovaSenhaDTO();
			definirNovaSenhaDTO.setIdUser(usuario.getId());
			definirNovaSenhaDTO.setUid(uid);
			model.addAttribute("definirNovaSenhaDTO", definirNovaSenhaDTO);
		}
		else{
			return "auth/login";
		}
		
		return "auth/novaSenha";
	}
	
	//Quando clicar em um usuario listado na tabela
	@RequestMapping(value = "/cadastro/{id}", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String cadastroBase(@PathVariable Long id, Model model)
			throws Exception {

		User usuario = userBusiness.get(id);
		
		addAtributes(model, usuario);
		
		return "cadastro/user/formulario_user";
	}
	
	//Quando clicar em um usuario listado na tabela
	@RequestMapping(value = "/alterarSenha/{id}", method = RequestMethod.GET)
	@Transactional(readOnly = true)
	public String alterarSenhaBase(@PathVariable Long id, Model model)
			throws Exception {

		User usuario = userBusiness.get(id);
		
		addAtributes(model, usuario);
		
		return "cadastro/user/formulario_user";
	}
	
	@RequestMapping(value = "/cadastro/salvar", method = RequestMethod.POST)
	public String salvarBase(@Valid @ModelAttribute("usuario") User usuario,
			BindingResult result, Model model) throws Exception {

		if (result.hasErrors()) {
			addAtributes(model, usuario);
			return "cadastro/user/formulario_user";
		}

		try {
			
			if(usuario.getSenha() == null || usuario.getSenha().isEmpty()){
				User uBanco = userBusiness.get(usuario.getId());
				usuario.setSenha(uBanco.getSenha());
			}
			
			else if(!usuario.getSenha().equals(usuario.getConfirmarSenha())){
				addAtributes(model, usuario);
				model.addAttribute("message", "Senhas não conferem");
				
				return "cadastro/user/formulario_user";
			}

			userBusiness.salvar(usuario);
		} catch (Exception e) {

			addAtributes(model, usuario);
			model.addAttribute("message", e.getMessage());
			
			return "cadastro/user/formulario_user";
		}

		return "redirect:/usuarios/";
	}
	
	public void addAtributes(Model model, User usuario){
		
		List<Role> roles = new ArrayList<Role>();
		
		if(usuario.getRole().equals(Role.ROLE_ROOT)){
			roles.add(Role.ROLE_ROOT);
		}
		
		roles.add(Role.ROLE_ADMIN);
		roles.add(Role.ROLE_COTISTA);
		roles.add(Role.ROLE_MARINHEIRO);
		
		User userCurrent = userBusiness.getCurrent();
		List<Terceiro> terceiroList = terceiroBusiness.getAll();
		model.addAttribute("usuario", usuario);
		model.addAttribute("listaUserRole", roles);
		model.addAttribute("listaTerceiros", terceiroList);
		if(userCurrent.getRole().equals(Role.ROLE_COTISTA) || userCurrent.getRole().equals(Role.ROLE_MARINHEIRO))
			model.addAttribute("readonly", true);
		
		
	}

	
}