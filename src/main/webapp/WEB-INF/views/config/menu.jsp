<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<ul class="nav nav-tabs nav-sub-menu">	
	<sec:authorize url="/configuracoes/pontos"> 
		<li class="active">
			<a href="<c:url value="/configuracoes/pontos" />"><i class="cicon-create"></i> <span class="label-menu hidden-phone">Pontos</span></a>
		</li>
	</sec:authorize>
	<sec:authorize url="/configuracoes/redes"> 
		<li class="active">
			<a href="<c:url value="/configuracoes/redes" />"><i class="cicon-git-compare"></i> <span class="label-menu hidden-phone">Redes</span></a>
		</li>
	</sec:authorize>
</ul>