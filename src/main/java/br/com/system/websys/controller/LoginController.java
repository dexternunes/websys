package br.com.system.websys.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.com.system.websys.business.RedeBusiness;
import br.com.system.websys.entities.Rede;

@Controller
@RequestMapping("/auth")
public class LoginController {

	private static final Logger logger = LogManager.getLogger(LoginController.class);

	@Autowired
	RedeBusiness redeBusiness;

	@RequestMapping(value = "/rede", method = RequestMethod.GET)
	public String franqueadora(Model model) {

		model.addAttribute("rede", new Rede());

		return "auth/login";
	}

	@RequestMapping(value = "/rede/login", method = RequestMethod.POST)
	public String loginFranqueadora(@Valid Rede rede, BindingResult result, Model model) {

		model.addAttribute("rede", new Rede());

		if (result.hasErrors()) {

			for (ObjectError error : result.getAllErrors())
				logger.info("Erro: " + error.toString());

			return "auth/login";
		}

		Rede redeLogin = redeBusiness.getByLoginName(rede.getLogin());

		if (redeLogin == null || !redeLogin.getSenha().equals(rede.getSenha())) {

			model.addAttribute("message", "Login e/ou senha inválidos.");

			return "auth/login";
		}

		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority("ROLE_USER"));

		Authentication auth = new UsernamePasswordAuthenticationToken(rede.getLogin(), rede.getSenha(), authorities);
		SecurityContextHolder.getContext().setAuthentication(auth);

		return "redirect:/home";
	}
}