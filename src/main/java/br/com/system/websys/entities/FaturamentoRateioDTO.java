package br.com.system.websys.entities;

import br.com.system.websys.formatter.Formatters;

public class FaturamentoRateioDTO {

	private Terceiro terceiro = new Terceiro();

	private Double valor;
	
	private String valorStr;

	private Long horas;

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



	public String getValorStr() {
		return valorStr;
	}

	public void setValorStr(String valorStr) {
		this.valorStr = valorStr;
	}

	public Long getHoras() {
		return horas;
	}

	public void setHoras(Long horas) {
		this.horas = horas;
	}


}
