package br.com.system.websys.entities;

import java.util.ArrayList;
import java.util.List;

import br.com.system.websys.formatter.Formatters;

public class FaturamentoDTO {

	private List<FaturamentoRateioDTO> faturamentoRateioLista = new ArrayList<FaturamentoRateioDTO>();

	private Double valorTotal;

	public List<FaturamentoRateioDTO> getFaturamentoRateioLista() {
		return faturamentoRateioLista;
	}

	public void setFaturamentoRateioLista(List<FaturamentoRateioDTO> faturamentoRateioLista) {
		this.faturamentoRateioLista = faturamentoRateioLista;
	}

	public Double getValorTotal() {
		return valorTotal;
	}

	public void setValorTotal(Double valorTotal) {
		this.valorTotal = valorTotal;
	}
	
	public String getValorTotalString(){
		return Formatters.formatCurrency(this.valorTotal);
	}
}
