INSERT INTO `websys`.`terceiro` (`id_terceiro`, `created`, `updated`, `ativo`, `documento`, `nome`, `excluido`) VALUES ('1', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', '000.000.000-00', 'Teste', 0);
INSERT INTO `websys`.`user` (`id_user`, `created`, `updated`, `login`, `senha`, `id_terceiro`, `role`, `excluido`, `ativo`) VALUES ('1', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'teste@teste.com.br', 'teste', '1', 'ROLE_ADMIN', 0, 1);

