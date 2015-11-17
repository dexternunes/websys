package br.com.system.websys.security.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.User;

public class SecurityInfoInterceptor implements HandlerInterceptor {

	@Autowired
	private UserBusiness userBusiness;
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
				
		if(SecurityContextHolder.getContext().getAuthentication() == null)
			return; 
		
		if(userBusiness != null && modelAndView != null && userBusiness.getCurrent() != null)
			modelAndView.addObject("currentLoggedUser", userBusiness.getCurrent());
		else {
			
			User user = new User();
			user.setNome("");
			
			modelAndView.addObject("currentLoggedUser", user);
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {		
	}
}
