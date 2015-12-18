package br.com.system.websys.formatter;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.Formatter;
import org.springframework.stereotype.Component;

import br.com.system.websys.business.GrupoBusiness;
import br.com.system.websys.entities.Grupo;

@Component
public class GrupoFormatter implements Formatter<Grupo> {
	
    @Autowired
    private GrupoBusiness grupoBusiness;

    @Override
    public String print(Grupo grupo, Locale arg1) {
        return grupo.getId().toString();
    }
    
    @Override
	public Grupo parse(String id, Locale arg1){
    	try {
			return grupoBusiness.get(Long.parseLong(id));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}