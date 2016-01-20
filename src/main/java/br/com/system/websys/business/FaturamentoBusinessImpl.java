package br.com.system.websys.business;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Faturamento;
import br.com.system.websys.entities.FaturamentoRateio;
import br.com.system.websys.entities.Manutencao;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.repository.FaturamentoRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class FaturamentoBusinessImpl extends BusinessBaseRootImpl<Faturamento, FaturamentoRepository> implements FaturamentoBusiness {
    
	@Autowired
	private GrupoBusiness GrupoBusiness;
	
	@Autowired
	protected FaturamentoBusinessImpl(FaturamentoRepository repository) {
		super(repository, Faturamento.class);
	}

	@Override
	protected void validateBeforeSave(Faturamento entity) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public List<Faturamento> getAll() {
		return ((FaturamentoRepository)repository).findAll();
	}
	
	//@Override
	//public List<Produto> getAllByTipoAndStatus(ProdutoTipo tipo, List<ProdutoStatus>status) {
	//	return ((ProdutoRepository)repository).findAllByTipoAndStatus(tipo, status);
	//}
	
	
	@Override
	public Faturamento calcularFaturamento(List<Manutencao> listaManutencao){
		Faturamento faturamento = new Faturamento();
		
		//Calcula Valor total da manutencao:
		 Double valorTotal= new Double(0); 
		
		for (Manutencao m:listaManutencao){
			valorTotal = valorTotal + m.getValor();
		}
		

		//Seta uns valores na entidade
		faturamento.setValor(valorTotal);
		faturamento.setManutencoes(listaManutencao);
		faturamento.setGrupo(GrupoBusiness.findAllByProduto(listaManutencao.get(0).getProduto()).get(0));
		
		
		//50% do valor Total de manutenca é dividido entre os cotistas
		Double valorRateio= new Double(0); 
		
		
		//Determina o valor para cada cotista, sendo 50% + (os outro 50% proporcionais as horas utilizadas)

		List<FaturamentoRateio> listaFaturamentoRateio = new ArrayList<FaturamentoRateio>();
		
		for (Terceiro t:faturamento.getGrupo().getTerceiros()){
			//%Y = (100 x HY)/TOTALHOras -->Porcentagem de horas que o terceiro usou
			//x = (V50% X %Y)/100 --> valor em reais pela porcentagem de horas que o terceiro usou
			//Horas motor é obrigado a escolher.
			//Manutencao, se nao for selecionada nenhuma, nao gera valor, e zera as horas motor selecionadas.
			
			FaturamentoRateio faturamentoRateio = new FaturamentoRateio();
			faturamentoRateio.setFaturamento(faturamento);
			faturamentoRateio.setTerceiro(t);
			valorRateio = ((valorTotal/2)/faturamento.getGrupo().getTerceiros().size()) + 20;
			faturamentoRateio.setValor(valorRateio);
			listaFaturamentoRateio.add(faturamentoRateio);
			
		}
		
		faturamento.setFaturamentoRateios(listaFaturamentoRateio);
		
		//faturamento.setReservas(listaReservas);
		
		return faturamento;
		
	}

}
