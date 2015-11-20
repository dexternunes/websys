<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<ul class="nav nav-tabs nav-sub-menu">	
	<sec:authorize url="/configuracoes/terceiros"> 
		<li class="active">
			<a href="<c:url value="/configuracoes/terceiros" />"><i class="cicon-create"></i> <span class="label-menu hidden-phone">Terceiros</span></a>
		</li>
	</sec:authorize>
	<sec:authorize url="/configuracoes"> 
		<li class="active">
			<a href="<c:url value="/configuracoes/" />"><i class="cicon-git-compare"></i> <span class="label-menu hidden-phone">Outro Item do Menu</span></a>
		</li>
	</sec:authorize>
</ul>