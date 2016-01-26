package br.com.system.websys.security.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.User;
import br.com.system.websys.entities.UserDTO;

public class SecurityInfoInterceptor implements HandlerInterceptor {

	@Autowired
	private UserBusiness userBusiness;
	
	private UserDTO userDTO = new UserDTO();
	
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
		
		User user = userBusiness.getCurrent();
		
		if(user != null && modelAndView != null && user.getTerceiro() != null){
				userDTO.setNome(user.getTerceiro().getNome());
				userDTO.setIdTerceiro(user.getTerceiro().getId());
				userDTO.setIdUser(user.getId());

				modelAndView.addObject("user", userDTO);
		}
		else {			
			user = new User();			
			modelAndView.addObject("user", user);
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {		
	}
}
