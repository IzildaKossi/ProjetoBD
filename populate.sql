USE PhotoSocial;

CALL sp_criar_pais("Angola", @angola);
CALL sp_criar_pais("Brazil", @brazil);
CALL sp_criar_pais("Cabo Verde", @caboverde);
CALL sp_criar_pais("Dinamarca", @dinamarca);
CALL sp_criar_pais("Espanha", @espanha);
CALL sp_criar_pais("França", @franca);
CALL sp_criar_pais("Grecia", @grecia);
CALL sp_criar_pais("Holanda", @holanda);
CALL sp_criar_pais("Itália", @italia);
CALL sp_criar_pais("Portugal", @portugal);
CALL sp_criar_pais("Africa do Sul", @AfricadoSul);
CALL sp_criar_pais("Namibia", @namibia);
CALL sp_criar_pais("Coreia", @coreia);
CALL sp_criar_pais("China", @china);
CALL sp_criar_pais("Japão", @japao);
CALL sp_criar_pais("Inglaterra", @inglaterra);
CALL sp_criar_pais("Siria", @siria);
CALL sp_criar_pais("Cuba", @cuba);
CALL sp_criar_pais("EUA", @eua);
CALL sp_criar_pais("Alemanha", @alemanha);

CALL sp_criar_genero('M', @masculino);
CALL sp_criar_genero('F', @feminino);

CALL sp_criar_tipo_conteudo("Fotografia", @fotografia);
CALL sp_criar_tipo_conteudo("Video", @video);

CALL sp_criar_tipo_like("gosto", @gosto);
CALL sp_criar_tipo_like("não gosto", @naogosto);
CALL sp_criar_tipo_like("adoro", @adoro);
CALL sp_criar_tipo_like("risos", @risos);
CALL sp_criar_tipo_like("furioso", @furioso);

CALL sp_criar_privacidade("público", @publico);
CALL sp_criar_privacidade("privado", @privado);

CALL sp_criar_utilizador ("Edson Cazanga", @masculino, @angola,"edson@photosocial.com","12345", @utilizador1);
CALL sp_criar_utilizador ("Izilda Kossy", @feminino, @angola,"izilda@photosocial.com","12345", @utilizador2);
CALL sp_criar_utilizador ("Danilson Sanches", @masculino, @caboverde,"dsanches06@photosocial.com","12345", @utilizador3);
CALL sp_criar_utilizador ("Engracia Jungo", @feminino, @angola,"engracia@photosocial.com","12345", @utilizador4);
CALL sp_criar_utilizador ("Cleria Maquiniche", @feminino, @angola,"cleria@photosocial.com","12345", @utilizador5);
CALL sp_criar_utilizador ("Daniela Ramos", @feminino, @italia,"daniela@photosocial.com","12345", @utilizador6);
CALL sp_criar_utilizador ("Teresa Varela", @feminino, @grecia, "teresa@photosocial.com","12345", @utilizador7);
CALL sp_criar_utilizador ("Carlos Veiga", @masculino, @holanda, "cveiga@photosocial.com","12345", @utilizador8);
CALL sp_criar_utilizador ("Rosalina Cardoso", @feminino, @franca, "rosalina@photosocial.com","12345", @utilizador9);
CALL sp_criar_utilizador ("José Albano", @masculino, @angola, "jalbano@photosocial.com","12345", @utilizador10);
CALL sp_criar_utilizador ("José Pereira", @masculino, @portugal, "j.pereira@photosocial.com","12345", @utilizador11);
CALL sp_criar_utilizador ("Manuel Rodrigues", @masculino, @dinamarca, "manuel.rodrigues@photosocial.com","12345", @utilizador12);
CALL sp_criar_utilizador ("Sara Tavares", @feminino, @espanha, "sara@photosocial.com","12345", @utilizador13);
CALL sp_criar_utilizador ("Ivone Sona", @feminino, @grecia, "ivone@photosocial.com","12345", @utilizador14);
CALL sp_criar_utilizador ("Luzy Gabriela", @feminino, @holanda, "luzy@photosocial.com","12345", @utilizador15);
CALL sp_criar_utilizador ("Rosene Maura", @feminino, @cuba, "rosene@photosocial.com","12345", @utilizador16);
CALL sp_criar_utilizador ("Leandro Fernandes", @masculino, @siria, "Leandro@photosocial.com","12345", @utilizador17);
CALL sp_criar_utilizador ("João Pereira", @masculino, @eua, "j.p@photosocial.com","12345", @utilizador18);
CALL sp_criar_utilizador ("Inoc Rodrigues", @masculino, @alemanha, "inoc.rodrigues@photosocial.com","12345", @utilizador19);
CALL sp_criar_utilizador ("Stela Tavares", @feminino, @cuba, "stela@photosocial.com","12345", @utilizador20);

CALL sp_seguir_utilizador(@utilizador1, @utilizador2, @seguir1);
CALL sp_seguir_utilizador(@utilizador3, @utilizador2, @seguir2);
CALL sp_seguir_utilizador(@utilizador1, @utilizador3, @seguir2);
CALL sp_seguir_utilizador(@utilizador3, @utilizador4, @seguir2);
CALL sp_seguir_utilizador(@utilizador13, @utilizador2, @seguir17);
CALL sp_seguir_utilizador(@utilizador2, @utilizador4, @seguir3);
CALL sp_seguir_utilizador(@utilizador3, @utilizador1, @seguir4);
CALL sp_seguir_utilizador(@utilizador5, @utilizador3, @seguir6);
CALL sp_seguir_utilizador(@utilizador3, @utilizador6, @seguir2);
CALL sp_seguir_utilizador(@utilizador16, @utilizador1, @seguir2);
CALL sp_seguir_utilizador(@utilizador12, @utilizador20, @seguir2);
CALL sp_seguir_utilizador(@utilizador13, @utilizador12, @seguir20);
CALL sp_seguir_utilizador(@utilizador17, @utilizador13, @seguir7);
CALL sp_seguir_utilizador(@utilizador3, @utilizador13, @seguir2);
CALL sp_seguir_utilizador(@utilizador19, @utilizador20, @seguir5);
CALL sp_seguir_utilizador(@utilizador20, @utilizador4, @seguir19);
CALL sp_seguir_utilizador(@utilizador20, @utilizador1, @seguir17);
CALL sp_seguir_utilizador(@utilizador5, @utilizador1, @seguir9);
CALL sp_seguir_utilizador(@utilizador3, @utilizador16, @seguir20);
CALL sp_seguir_utilizador(@utilizador1, @utilizador11, @seguir19);
 
CALL sp_criar_conteudo(@video, @utilizador2, 'visita a museu de oriente',@publico, '2018-07-04', @conteudo1);
CALL sp_criar_conteudo(@fotografia, @utilizador1, 'passeio na EST', @publico, '2018-07-04', @conteudo2);
CALL sp_criar_conteudo(@fotografia, @utilizador3, 'férias em cabo verde', @publico, '2018-07-04', @conteudo3);
CALL sp_criar_conteudo(@video, @utilizador3, 'praia mar', @publico, '2018-07-04', @conteudo4);
CALL sp_criar_conteudo(@fotografia, @utilizador4, 'fim de semana em casa', @publico, '2018-07-04', @conteudo5);
CALL sp_criar_conteudo(@video, @utilizador5, 'com amigas', @publico, '2018-07-04', @conteudo6);
CALL sp_criar_conteudo(@fotografia, @utilizador6, 'festa e mais festa', @publico, '2018-07-04', @conteudo7);
CALL sp_criar_conteudo(@video, @utilizador7, 'na semana academica', @publico, '2018-07-04', @conteudo8);
CALL sp_criar_conteudo(@video, @utilizador8, 'no arraial academico', @publico, '2018-07-04', @conteudo9);
CALL sp_criar_conteudo(@fotografia, @utilizador9, 'no ginasio', @publico, '2018-07-04', @conteudo10);
CALL sp_criar_conteudo(@fotografia, @utilizador10, '#verao', @publico, '2018-07-04', @conteudo11);
CALL sp_criar_conteudo(@video, @utilizador20, 'museu de oriente',@publico, '2018-07-04', @conteudo12);
CALL sp_criar_conteudo(@fotografia, @utilizador12, 'passeio na casa da vó', @publico, '2018-07-04', @conteudo13);
CALL sp_criar_conteudo(@fotografia, @utilizador13, '#férias', @publico, '2018-07-04', @conteudo14);
CALL sp_criar_conteudo(@video, @utilizador14, 'Saudades', @publico, '2018-07-04', @conteudo15);
CALL sp_criar_conteudo(@fotografia, @utilizador14, 'fim de semana em casa comendo e dormindo', @publico, '2018-07-04', @conteudo16);
CALL sp_criar_conteudo(@video, @utilizador15, 'com a best', @publico, '2018-07-04', @conteudo17);
CALL sp_criar_conteudo(@fotografia, @utilizador16, 'festa de pijama', @publico, '2018-07-04', @conteudo18);
CALL sp_criar_conteudo(@video, @utilizador17, 'Festival do panda', @publico, '2018-07-04', @conteudo19);
CALL sp_criar_conteudo(@video, @utilizador18, 'no arraial', @publico, '2018-07-04', @conteudo20);

CALL sp_criar_likeDisLike(@gosto, @utilizador2, @conteudo1, null, @like1);
CALL sp_criar_likeDisLike(@adoro, @utilizador1, @conteudo1, null, @like3);
CALL sp_criar_likeDisLike(@furioso, @utilizador3, @conteudo1, null, @like5);
CALL sp_criar_likeDisLike(@risos, @utilizador4, @conteudo2, null, @like4);
CALL sp_criar_likeDisLike(@furioso, @utilizador13, @conteudo3, null, @like5);
CALL sp_criar_likeDisLike(@naogosto, @utilizador10, @conteudo2, null, @like2);
CALL sp_criar_likeDisLike(@furioso, @utilizador19, @conteudo4, null, @like5);
CALL sp_criar_likeDisLike(@naogosto, @utilizador20, @conteudo5, null, @like2);
CALL sp_criar_likeDisLike(@gosto, @utilizador12, @conteudo4, null, @like1);
CALL sp_criar_likeDisLike(@gosto, @utilizador18, @conteudo7, null, @like1);
CALL sp_criar_likeDisLike(@adoro, @utilizador14, @conteudo5, null, @like3);
CALL sp_criar_likeDisLike(@gosto, @utilizador16, @conteudo8, null, @like1);
CALL sp_criar_likeDisLike(@risos, @utilizador15, @conteudo10, null, @like4);
CALL sp_criar_likeDisLike(@gosto, @utilizador6, @conteudo11, null, @like1);
CALL sp_criar_likeDisLike(@furioso, @utilizador17, @conteudo12, null, @like5);
CALL sp_criar_likeDisLike(@furioso, @utilizador8, @conteudo12, null, @like5);
CALL sp_criar_likeDisLike(@furioso, @utilizador11, @conteudo12, null, @like5);
CALL sp_criar_likeDisLike(@adoro, @utilizador5, @conteudo19, null, @like3);
CALL sp_criar_likeDisLike(@risos, @utilizador7, @conteudo17, null, @like4);
CALL sp_criar_likeDisLike(@furioso, @utilizador9, @conteudo18, null, @like5);

-- classificação
CALL sp_classificarConteudo(@conteudo1, @utilizador9, 3);
CALL sp_classificarConteudo(@conteudo1, @utilizador19, 2);
CALL sp_classificarConteudo(@conteudo2, @utilizador10, 1);
CALL sp_classificarConteudo(@conteudo4, @utilizador2, 3);
CALL sp_classificarConteudo(@conteudo5, @utilizador1, 4);
CALL sp_classificarConteudo(@conteudo18, @utilizador11, 5);
CALL sp_classificarConteudo(@conteudo12, @utilizador5, 5);
CALL sp_classificarConteudo(@conteudo11, @utilizador3, 3);
CALL sp_classificarConteudo(@conteudo10, @utilizador2, 2);
CALL sp_classificarConteudo(@conteudo14, @utilizador1, 2);
CALL sp_classificarConteudo(@conteudo12, @utilizador2, 1);
CALL sp_classificarConteudo(@conteudo13, @utilizador3, 1);
CALL sp_classificarConteudo(@conteudo2, @utilizador14, 2);
CALL sp_classificarConteudo(@conteudo5, @utilizador13, 1);
CALL sp_classificarConteudo(@conteudo4, @utilizador15, 2);
CALL sp_classificarConteudo(@conteudo7, @utilizador12, 1);
CALL sp_classificarConteudo(@conteudo8, @utilizador20, 2);

CALL sp_criar_comentario("Bom Passeio", @utilizador3, @conteudo1, '2018-07-04', null, @comentario1);
CALL sp_criar_likeDisLike(@risos, @utilizador3, null, @comentario1, @like4);

CALL sp_criar_comentario("Boa foto", @utilizador1, @conteudo1, '2018-07-03', null, @comentario2);
CALL sp_criar_likeDisLike(@adoro, @utilizador1, null, @comentario2, @like3);

-- criar mensagem de utilizador 1
CALL sp_criar_comentario("Divirta-se", @utilizador2, @conteudo2, '2018-07-01', null, @comentario3);
-- utilizador 3 a dar like no conteudo do utilizador 2
CALL sp_criar_likeDisLike(@gosto, @utilizador2, null, @comentario3, @like1);

-- criar mensagem de utilizador 2
 CALL sp_criar_comentario("#Passeio", @utilizador2, @conteudo3, '2018-04-04', null, @comentario4);
 CALL sp_criar_likeDisLike(@risos, @utilizador2, null, @comentario4, @like4);

-- criar mensagem de utilizador 4
 CALL sp_criar_comentario("#Mae", @utilizador4, @conteudo4, '2018-04-04', null, @comentario5);
 CALL sp_criar_likeDisLike(@risos, @utilizador4, null, @comentario5, @like4);

-- criar mensagem de utilizador 5
 CALL sp_criar_comentario("Com fome", @utilizador5, @conteudo5, '2018-04-04', null, @comentario6);
 CALL sp_criar_likeDisLike(@risos, @utilizador5, null, @comentario6, @like4);

 CALL sp_criar_comentario("A sentir-se feliz", @utilizador6, @conteudo7, '2018-04-04', null, @comentario7);
 CALL sp_criar_likeDisLike(@risos, @utilizador6, null, @comentario7, @like4);

 CALL sp_criar_comentario("olá", @utilizador7, @conteudo10, '2018-04-04', null, @comentario8);
 CALL sp_criar_likeDisLike(@risos, @utilizador7, null, @comentario8, @like4);

 CALL sp_criar_comentario("Muito frio", @utilizador8, @conteudo11, '2018-04-04', null, @comentario9);
 CALL sp_criar_likeDisLike(@naogosto, @utilizador8, null, @comentario9, @like2);

 CALL sp_criar_comentario("Que seja para sempre", @utilizador9, @conteudo19, '2018-04-04', null, @comentario10);
 CALL sp_criar_likeDisLike(@risos, @utilizador9, null, @comentario10, @like3);

 CALL sp_criar_comentario("simmmmm", @utilizador10, @conteudo15, '2018-04-04', null, @comentario11);
 CALL sp_criar_likeDisLike(@adoro, @utilizador10, null, @comentario11, @like3);

 CALL sp_criar_comentario("Mandem vir", @utilizador11, @conteudo16, '2018-06-04', null, @comentario12);
 CALL sp_criar_likeDisLike(@furioso, @utilizador11, null, @comentario12, @like5);

 CALL sp_criar_comentario("Coração valente", @utilizador12, @conteudo12, '2018-06-04', null, @comentario13);
 CALL sp_criar_likeDisLike(@adoro, @utilizador12, null, @comentario13, @like3);

 CALL sp_criar_comentario("Normalmente", @utilizador13, @conteudo10, '2018-06-04', null, @comentario14);
 CALL sp_criar_likeDisLike(@gosto, @utilizador13, null, @comentario14, @like1);

 CALL sp_criar_comentario("Agora vai", @utilizador14, @conteudo11, '2018-06-04', null, @comentario15);
 CALL sp_criar_likeDisLike(@naogosto, @utilizador14, null, @comentario15, @like2);

 CALL sp_criar_comentario("Vidas opostas", @utilizador15, @conteudo9, '2018-06-04',null,  @comentario16);
 CALL sp_criar_likeDisLike(@furioso, @utilizador15, null, @comentario16, @like5);

 CALL sp_criar_comentario("Vida longa", @utilizador16, @conteudo1, '2018-06-04', null, @comentario17);
 CALL sp_criar_likeDisLike(@adoro, @utilizador16, null, @comentario17, @like3);

 CALL sp_criar_comentario("Risos", @utilizador17, @conteudo2, '2018-06-04', null, @comentario18);
 CALL sp_criar_likeDisLike(@adoro, @utilizador17, null, @comentario18, @like3);

 CALL sp_criar_comentario("Vou deixar a vida me levar", @utilizador18, @conteudo5, '2018-06-04', null, @comentario19);
 CALL sp_criar_likeDisLike(@gosto, @utilizador18, null, @comentario19, @like1);

 CALL sp_criar_comentario("Vou deixar...", @utilizador19, @conteudo4, '2018-06-04', null, @comentario20);
 CALL sp_criar_likeDisLike(@furioso, @utilizador19, null, @comentario20, @like5);

 CALL sp_criar_comentario("#comer é bom", @utilizador20, @conteudo4, '2018-06-28', null, @comentario21);
 CALL sp_criar_likeDisLike(@adoro, @utilizador20, null, @comentario21, @like3);

-- criar chat 
-- conversa entre o utilizador 1 e o utilizador 2
CALL sp_criar_mensagem(@utilizador1, 'Olá, tudo bem?', @utilizador2);
CALL sp_criar_mensagem(@utilizador2, 'Olá, tá tudo bem comigo, e tu como estás', @utilizador1);
CALL sp_criar_mensagem(@utilizador1, 'também estou obrigado', @utilizador2);
CALL sp_criar_mensagem(@utilizador2, 'ok ok isso é importante', @utilizador1);
-- conversa entre o utilizador 3 e o utilizador 8
CALL sp_criar_mensagem(@utilizador3, 'Mekie Carlos! tudo tranquilo?', @utilizador8);
CALL sp_criar_mensagem(@utilizador8, 'yha mr danilson. tá tudo tranquilo', @utilizador3);
CALL sp_criar_mensagem(@utilizador3, 'boa. e então novidades?', @utilizador8);
CALL sp_criar_mensagem(@utilizador8, 'epa, de momento não há nada em especial', @utilizador3);
CALL sp_criar_mensagem(@utilizador3, 'e do teu há alguma?', @utilizador8);
CALL sp_criar_mensagem(@utilizador8, 'népias, também está tudo na mesma', @utilizador3);
CALL sp_criar_mensagem(@utilizador3, 'ham ok ok', @utilizador8);
-- conversa entre o utilizador 10 e o utilizador 13
CALL sp_criar_mensagem(@utilizador10, 'Olá Sara, tudo bem?', @utilizador13);
CALL sp_criar_mensagem(@utilizador13, 'Oi José, está tudo bem comigo', @utilizador10);
CALL sp_criar_mensagem(@utilizador10, 'e tu como estás', @utilizador13);
CALL sp_criar_mensagem(@utilizador13, 'também estou bem', @utilizador10);
CALL sp_criar_mensagem(@utilizador10, 'a propósito, gostei muito da tua publicação', @utilizador13);
CALL sp_criar_mensagem(@utilizador13, 'Oh sério?', @utilizador10);
CALL sp_criar_mensagem(@utilizador10, 'ya sério', @utilizador13);
-- conversa entre o utilizador 19 e o utilizador 20
CALL sp_criar_mensagem(@utilizador19, 'Olá, tudo bem?', @utilizador20);
CALL sp_criar_mensagem(@utilizador20, 'tudo, e tu?', @utilizador19);

