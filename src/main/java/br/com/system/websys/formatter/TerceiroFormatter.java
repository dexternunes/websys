package br.com.system.websys.formatter;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.Formatter;
import org.springframework.stereotype.Component;

import br.com.system.websys.business.TerceiroBusiness;
import br.com.system.websys.entities.Terceiro;

@Component
public class TerceiroFormatter implements Formatter<Terceiro> {
	
    @Autowired
    private TerceiroBusiness terceiroBusiness;

    @Override
    public String print(Terceiro terceiro, Locale arg1) {
        return terceiro.getId().toString();
    }
    
    @Override
	public Terceiro parse(String id, Locale arg1){
    	try {
			return terceiroBusiness.get(Long.parseLong(id));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}