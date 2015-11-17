package br.com.system.websys.security.api;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class BasicAuthUserAuthorizationInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private UserDetailsService customAuthenticationProvider;
	
	private static final String UNAUTHORIZED_MSG = "You are not logged in.  You must log in or supply an API token.";

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

	    String header = request.getHeader("Authorization");
	    
	    if (header == null || !header.toUpperCase().startsWith("BASIC ")) {  
	    	response.sendError(HttpServletResponse.SC_UNAUTHORIZED, UNAUTHORIZED_MSG);
			return false;
        }  
	    
	    String basicAuthEncoded = header.substring(6);
	    String basicAuthAsString = new String(new Base64().decode(basicAuthEncoded.getBytes()));
		
	    String user = basicAuthAsString.substring(0,basicAuthAsString.indexOf(":"));
	    String password = basicAuthAsString.substring(basicAuthAsString.indexOf(":") + 1);
		
		UserDetails userDetails = customAuthenticationProvider.loadUserByUsername(user);
		
		if(!password.equals(userDetails.getPassword())){  
	    	response.sendError(HttpServletResponse.SC_UNAUTHORIZED, UNAUTHORIZED_MSG);
			return false;
        } 
		
		Authentication auth = new UsernamePasswordAuthenticationToken(userDetails.getUsername(), password, userDetails.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(auth);
		
		return true;
	}
}