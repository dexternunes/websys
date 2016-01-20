package br.com.system.websys.entities;

import br.com.system.websys.formatter.Formatters;

public class FaturamentoRateioDTO {

	private Terceiro terceiro = new Terceiro();

	private Double valor;
	
	private String valorStr;

	private Double horas;

	public Terceiro getTerceiro() {
		return terceiro;
	}

	public void setTerceiro(Terceiro terceiro) {
		this.terceiro = terceiro;
	}

	public Double getValor() {
		return valor;
	}

	public void setValor(Double valor) {
		this.valorStr = Formatters.formatCurrency(valor);
		this.valor = valor;
	}

	public Double getHoras() {
		return horas;
	}

	public void setHoras(Double horas) {
		this.horas = horas;
	}

	public String getValorStr() {
		return valorStr;
	}

	public void setValorStr(String valorStr) {
		this.valorStr = valorStr;
	}


}
