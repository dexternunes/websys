package br.com.system.websys.formatter;

import java.text.ParseException;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.Formatter;
import org.springframework.stereotype.Component;

import br.com.system.websys.business.UserBusiness;
import br.com.system.websys.entities.User;

@Component
public class UserFormatter implements Formatter<User> {
	
    @Autowired
    private UserBusiness userBusiness;

    @Override
    public String print(User user, Locale arg1) {
    	return user.getLogin().toString();
    }
    
    @Override
    public User parse(String id, Locale arg1) throws ParseException {
    	return userBusiness.get(Long.parseLong(id));
    }
}