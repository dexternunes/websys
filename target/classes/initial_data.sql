INSERT INTO role (name, created, updated) VALUES('ROLE_USER', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO role (name, created, updated) VALUES('ROLE_ADMIN', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

INSERT INTO `websys`.`terceiro` (`id_terceiro`, `created`, `updated`, `ativo`, `documento`, `nome`) VALUES ('1', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', '000.000.000-00', 'Teste');
INSERT INTO `websys`.`user` (`id_user`, `created`, `updated`, `admin`, `auth_code`, `login`, `nome`, `senha`, `access_token`, `id_terceiro`) VALUES ('1', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', '', 'teste@teste.com.br', 'Teste', 'teste', '', '1');
INSERT INTO `websys`.`terceiro_has_roles` (`id_terceiro`, `id_role`) VALUES ('1', '1');
