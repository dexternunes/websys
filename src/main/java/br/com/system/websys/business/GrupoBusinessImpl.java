package br.com.system.websys.business;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.Grupo;
import br.com.system.websys.entities.Manutencao;
import br.com.system.websys.entities.ManutencaoStatus;
import br.com.system.websys.entities.Produto;
import br.com.system.websys.entities.ProdutoStatus;
import br.com.system.websys.entities.Reserva;
import br.com.system.websys.entities.ReservaStatus;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.repository.GrupoRepository;

@Service  
@Transactional(propagation=Propagation.REQUIRED)
class GrupoBusinessImpl extends BusinessBaseRootImpl<Grupo, GrupoRepository> implements GrupoBusiness {
    
	@Autowired
	private ReservaBusiness reservaBusiness;
	
	@Autowired
	private ManutencaoBusiness manutencaoBusiness;
	
	@Autowired
	protected GrupoBusinessImpl(GrupoRepository repository) {
		super(repository, Grupo.class);
	}
	
	@Override
	protected void validateBeforeSave(Grupo entity) throws Exception {
		
	}
	
	@Override
	public Grupo salvar(Grupo grupo) throws Exception{
		
		validaEdicao(grupo);
		
		if(grupo.getId() == null){
			grupoNovo(grupo);
			return super.salvar(grupo);
		}
		else{
			Grupo grupoBD = this.get(grupo.getId());
			grupoBD.setDescricao(grupo.getDescricao());
			grupoBD.setAtivo(grupo.getAtivo());
			grupoBD.setTerceiros(grupo.getTerceiros());
			if(grupoBD.getColor() == null || grupoBD.getColor().isEmpty()){
				StringBuffer sb = new StringBuffer();
				Random randCol = new Random();  
				for(int x = 0 ; x < 3 ; x++){
					for (int i = 0; i < 2; i++) {  
			            sb.append(Integer.toString((Math.abs(randCol.nextInt()) % 8) + 8, 16));  
			        }
				}				
				grupoBD.setColor("#"+sb.toString());				
			}
			return super.salvar(grupoBD);
		}
	}
	
	@Override
	public void grupoNovo(Grupo grupo){
		
		for(Produto produto : grupo.getProdutos()){
			produto.setStatus(ProdutoStatus.DISPONIVEL);
		}
		
		StringBuffer sb = new StringBuffer();
		Random randCol = new Random();  
		for(int x = 0 ; x < 3 ; x++){
			for (int i = 0; i < 2; i++) {  
	            sb.append(Integer.toString(Math.abs((randCol.nextInt()) % 8)+8, 16));  
	        }
		}
		
		grupo.setColor("#"+sb.toString());

	}

	@Override
	public List<Grupo> getAll() {
		return ((GrupoRepository)repository).getAll();
	}

	@Override
	public List<Grupo> findAllByTerceito(Terceiro terceiro) {
		List<Grupo> grupos = ((GrupoRepository)repository).findByTerceiro(terceiro);
		return grupos;
	}

	@Override
	public List<Grupo> findAllByProduto(Produto produto) {
		List<Grupo> grupos = ((GrupoRepository)repository).findByProduto(produto);
		return grupos;
	}
	
	@Override
	public List<Grupo> findAllAtivos() {
		List<Grupo> grupos = ((GrupoRepository)repository).findAllAtivos();
		return grupos;
	}

	@Override
	public List<Grupo> getByTerceiro(Terceiro terceiro) {
		return ((GrupoRepository)repository).getByTerceiro(terceiro);
	}
	
	@Override
	public Grupo delete(Grupo grupo) throws Exception {
		validaExclusao(grupo);
		
		grupo.setExcluido(true);
		
		return super.salvar(grupo);
	}
	
	private void validaEdicao(Grupo grupo) throws Exception{
		
		Grupo grupoBD = this.get(grupo.getId());
		
		List<Terceiro> cotistasRemovidos = new ArrayList<Terceiro>();
		
		for(Terceiro terceiro : grupoBD.getTerceiros()){
			if(!grupo.getTerceiros().contains(terceiro)){
				cotistasRemovidos.add(terceiro);
			}
		}
		
		if(cotistasRemovidos.size() == 0)
			return;
		
		Criteria criteria = reservaBusiness.createCriteria();
		
		criteria
			.add(Restrictions.eq("grupo", grupoBD))
			.add(Restrictions.or(Restrictions.eq("status", ReservaStatus.AGUARDANDO_APROVACAO)
					,Restrictions.eq("status", ReservaStatus.APROVADA)
					,Restrictions.eq("status", ReservaStatus.EM_USO)))
			.add(Restrictions.eq("ativo", true))
			.add(Restrictions.eq("excluido", false))
			.add(Restrictions.in("solicitante", cotistasRemovidos));
		
		@SuppressWarnings("unchecked")
		List<Reserva> reservasParaCotistasExcluidos = criteria.list();
		
		if(reservasParaCotistasExcluidos != null && reservasParaCotistasExcluidos.size() > 0){
			String msgErro = "Um ou mais cotistas não pode ser removido do grupo, pois possui reserva ou solicitação de reserva ativa.";
			throw new Exception(msgErro);
		}
		
	}
	
	private void validaExclusao(Grupo grupo) throws Exception{
		
		Criteria criteriaReservas = reservaBusiness.createCriteria();
		criteriaReservas
		.add(Restrictions.eq("grupo", grupo))
		.add(Restrictions.or(Restrictions.eq("status", ReservaStatus.AGUARDANDO_APROVACAO)
				,Restrictions.eq("status", ReservaStatus.APROVADA)
				,Restrictions.eq("status", ReservaStatus.EM_USO)))
		.add(Restrictions.eq("ativo", true))
		.add(Restrictions.eq("excluido", false));

		@SuppressWarnings("unchecked")
		List<Reserva> reservas = criteriaReservas.list();
		
		String msgErro = "";
		
		if(reservas != null && reservas.size() > 0){
			msgErro = msgErro  + "<li>Existem reservas ou solicitações de reservas ativas</li>";
		}
		
		Criteria criteriaManutencao = manutencaoBusiness.createCriteria();
		criteriaManutencao
		.add(Restrictions.eq("status", ManutencaoStatus.PENDENTE))
		.add(Restrictions.eq("produto", grupo.getProdutos().get(0)));

		@SuppressWarnings("unchecked")
		List<Manutencao> manutencoes = criteriaManutencao.list();
		
		if(manutencoes != null && manutencoes.size() > 0){
			msgErro = msgErro + "<li>Existem manutenções não faturadas</li>";
		}
		
		if(msgErro == "")
			return;
		
		msgErro = "Não é possível excluir este grupo<br />" 
				+ "<lu>" + msgErro + "</lu>"; 
		
		throw new Exception(msgErro);
		
	}
	
}
