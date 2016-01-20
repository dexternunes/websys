package br.com.system.websys.business;

import java.util.List;

import br.com.system.websys.entities.Faturamento;
import br.com.system.websys.entities.Manutencao;
import br.com.system.websys.repository.FaturamentoRepository;

public interface FaturamentoBusiness extends BusinessBaseRoot<Faturamento, FaturamentoRepository> {
	
	public List<Faturamento> getAll();

	public Faturamento calcularFaturamento(List<Manutencao> listaManutencao);

}
