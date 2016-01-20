package br.com.system.websys.formatter;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Currency;
import java.util.Date;

public class Formatters {
	
	private static SimpleDateFormat patternDate = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
	
	private static DecimalFormat currencyPattern = new DecimalFormat("#,##0.00");
	
	public static String formatDate (Date date) {
		if(date == null)
			return " - ";
		return patternDate.format(date);
	}
	
	public static String formatCurrency(Double valor){
		Currency.getInstance("BRL"); 
		return currencyPattern.format(valor);
	}

}