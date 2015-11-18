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

import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.User;

@Controller
@RequestMapping("/auth")
public class LoginController {

	private static final Logger logger = LogManager.getLogger(LoginController.class);

	@Autowired
	private UserBusiness userBusiness;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String rede(Model model) {

		model.addAttribute("user", new User());

		return "auth/login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginRede(@Valid User user, BindingResult result, Model model) {

		model.addAttribute("user", new User());

		if (result.hasErrors()) {

			for (ObjectError error : result.getAllErrors())
				logger.info("Erro: " + error.toString());

			return "auth/login";
		}

		User userLogin = userBusiness.getByLogin(user.getLogin());

		if (userLogin == null || !userLogin.getSenha().equals(user.getSenha())) {

			model.addAttribute("message", "Login e/ou senha inválidos.");

			return "auth/login";
		}

		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority("ROLE_USER"));

		Authentication auth = new UsernamePasswordAuthenticationToken(user.getLogin(), user.getSenha(), authorities);
		SecurityContextHolder.getContext().setAuthentication(auth);

		
		model.addAttribute("j_username", user.getLogin());
		model.addAttribute("j_password", user.getSenha());
		return "auth/callback";
	}
	
	@RequestMapping(value = "/denied")
	public String getDeniedPage() {	
		return "auth/denied";
	}
}