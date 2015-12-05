package br.com.system.websys.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	 @RequestMapping(value = "/", method = RequestMethod.GET)
	 public String root() {
		 return "redirect:/home";
	 }

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(HttpServletRequest request, Locale locale, Model model) {
		
		
		return "home";
	}
}
