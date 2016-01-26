package br.com.system.websys.entities;

import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import br.com.system.websys.formatter.Formatters;

@JsonIgnoreProperties(ignoreUnknown=true)
public class FaturamentoDTO {

	private List<FaturamentoRateioDTO> faturamentoRateioLista = new ArrayList<FaturamentoRateioDTO>();
	
	private List<Long> idsManutencao = new ArrayList<Long>();
	
	private List<Long> idsHoraMotor = new ArrayList<Long>();

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

	public List<Long> getIdsManutencao() {
		return idsManutencao;
	}

	public void setIdsManutencao(List<Long> idsManutencao) {
		this.idsManutencao = idsManutencao;
	}

	public List<Long> getIdsHoraMotor() {
		return idsHoraMotor;
	}

	public void setIdsHoraMotor(List<Long> idsHoraMotor) {
		this.idsHoraMotor = idsHoraMotor;
	}
}
