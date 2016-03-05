package br.com.system.websys.business;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.system.websys.entities.DefinirNovaSenhaDTO;
import br.com.system.websys.entities.Imagem;
import br.com.system.websys.entities.RecuperarSenhaDTO;
import br.com.system.websys.entities.Role;
import br.com.system.websys.entities.Terceiro;
import br.com.system.websys.entities.User;
import br.com.system.websys.repository.UserRepository;

@Service
@Transactional(propagation = Propagation.REQUIRED)
class UserBusinessImpl implements UserBusiness {

	@Autowired
	private UserRepository userRepository;

	@Value("#{appProperties.primary_role}")
	private String primaryRole;

	@Autowired
	private MailBusiness mailBusiness;

	@Override
	@Transactional(readOnly = true)
	public synchronized User getCurrent() {

		org.springframework.security.core.userdetails.User springUser;

		try {
			springUser = (org.springframework.security.core.userdetails.User) SecurityContextHolder.getContext()
					.getAuthentication().getPrincipal();
		} catch (ClassCastException e) {
			return null;
		} catch (NullPointerException e) {
			return null;
		}

		return getByLogin(springUser.getUsername());
	}

	private void validateBeforeSave(User entity) throws Exception {
		User userDB = userRepository.findByLogin(entity.getLogin());

		if (userDB == null)
			return;

		throw new Exception("Login já existe!");

	}

	@Override
	public void excluirUser(User user) throws Exception {

		User currentUser = this.getCurrent();

		if (currentUser.equals(user))
			throw new Exception("Não é possível excluir o usuário logado.");

		user.setExcluido(true);
		this.salvar(user);
	}

	@Override
	public void salvar(User user) throws Exception {

		if (user.getId() == null){
			validateBeforeSave(user);
			enviarEmailNovoUsuario(user);
		}

		if (user.getRole() == null)
			user.setRole(Role.valueOf(primaryRole));

		userRepository.save(user);
		
	}

	@Override
	public User getUid(String uid) {
		return userRepository.findByUid(uid);
	}

	@Override
	@Transactional(readOnly = true)
	public User get(Long id) {
		return userRepository.findOne(id);
	}

	@Override
	@Transactional(readOnly = true)
	public User getByLogin(String login) {
		return userRepository.findByLoginAtivo(login);
	}

	@Override
	public List<User> getAll() {
		return ((UserRepository) userRepository).getAll();
	}

	public Boolean enviarEmailNovoUsuario(User user) throws Exception {

		String texto = "<div align='center' style='background-color:rgb(28,60,106)'></br></br>"
				+ "<div align='center' style='background-color:rgb(28,60,106)'>"
				+ "	<img width='98' height='130' alt='Logo' src='http://primeshareclub.com.br/files-upload/primeshare.png'  />"
				+ "</div>" + "</br></br><font color='white'>"
				+ "	<h3>Foi criado um usuário para acesso ao Prime Share System </h3>" 
				+ "<br> " 
				+ "<br>Login: "	+ user.getLogin() 
				+ "<br>Senha: " + user.getSenha()
				+ "<br>Esta senha é provisória, acesse o sistema e altere a sua senha." 
				+ "<br /><br />Att,<br /> "
				+ "	</font>" + "	<div>"
				+ "		<h2><font color='white'> <i style='font-size: 26px;'></i> EQUIPE PRIME SHARE CLUB </font></h2>"
				+ "		<p><font color='white'>©2015 All Rights Reserved.</font></p>" + "	</div> "
				+ "</br></br></div>";

		mailBusiness.sendMail("websys@primeshareclub.com.br", new String[] { user.getTerceiro().getEmails() },
				"Prime Share Club - Usuário Criado", texto);

		return true;

	}

	@Override
	public Boolean enviarEmailRecuperarSenha(RecuperarSenhaDTO recuperarSenha, String server) throws Exception {
		User user = ((UserRepository) userRepository).findByLogin(recuperarSenha.getLogin());

		if (user != null && user.getTerceiro().getEmails().equals(recuperarSenha.getEmail())) {

			String uid = UUID.randomUUID().toString();
			user.setUidRecurerarSenha(uid);
			this.salvar(user);

			String link = server + "/websys/usuarios/recuperarsenha/" + uid;
			
			String texto = "<div align='center' style='background-color:rgb(28,60,106)'></br></br>"
					+ "<div align='center' style='background-color:rgb(28,60,106)'>"
					+ "	<img width='98' height='130' alt='Logo' src='http://primeshareclub.com.br/files-upload/primeshare.png'  />"
					+ "</div>" + "</br></br><font color='white'>"
					+ "	<h3>Você solicitou a recuperação do acesso ao Prime Share System </h3>" 
					+ "<br><br> " + "Clique <a href='"
					+ link + "'>aqui</a> para cadastrar uma nova senha."					
					+ "<br /><br />Att,<br /> "
					+ "	</font>" + "	<div>"
					+ "		<h2><font color='white'> <i style='font-size: 26px;'></i> EQUIPE PRIME SHARE CLUB </font></h2>"
					+ "		<p><font color='white'>©2015 All Rights Reserved.</font></p>" + "	</div> "
					+ "</br></br></div>";

			mailBusiness.sendMail("websys@primeshareclub.com.br", new String[] { user.getTerceiro().getEmails() },
					"Prime Share Club - Recuperação de Senha", texto);

			return true;
		}

		return false;
	}

	@Override
	public Boolean redefinirSenha(DefinirNovaSenhaDTO definirNovaSenhaDTO) throws Exception {
		User user = this.getUid(definirNovaSenhaDTO.getUid());

		if (user.getId().equals(definirNovaSenhaDTO.getIdUser())) {
			if (definirNovaSenhaDTO.getSenha().equals(definirNovaSenhaDTO.getRepetirSenha())) {
				user.setSenha(definirNovaSenhaDTO.getSenha());
				user.setUidRecurerarSenha(null);
				this.salvar(user);
				return true;
			}
		}

		return false;
	}

	@Override
	public List<User> getByRoles(List<Role> roles) {
		return userRepository.findByRoles(roles);
	}

	@Override
	public User addImagem(User user, Imagem imagem) throws Exception {
		user.setImage(imagem.getUrl());
		salvar(user);
		return user;
	}

	@Override
	public User getUserByTerceiro(Terceiro terceiro) {
		return ((UserRepository) userRepository).getUserByTerceiro(terceiro);
	}
}
