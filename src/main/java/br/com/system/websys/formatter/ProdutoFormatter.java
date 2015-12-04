package br.com.system.websys.formatter;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.Formatter;
import org.springframework.stereotype.Component;

import br.com.system.websys.business.ProdutoBusiness;
import br.com.system.websys.entities.Produto;

@Component
public class ProdutoFormatter implements Formatter<Produto> {
	
    @Autowired
    private ProdutoBusiness produtoBusiness;

    @Override
    public String print(Produto produto, Locale arg1) {
        return produto.getId().toString();
    }
    
    @Override
	public Produto parse(String id, Locale arg1){
    	try {
			return produtoBusiness.get(Long.parseLong(id));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}