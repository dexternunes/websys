package br.com.system.websys.formatter;

import java.text.DecimalFormat;
import java.util.Currency;

public class Formatters {
	
	private static DecimalFormat currencyPattern = new DecimalFormat("#,##0.00");
	
	public static String formatCurrency(Double valor){
		Currency.getInstance("BRL"); 
		return currencyPattern.format(valor);
	}

}
