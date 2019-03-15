use PhotoSocial;

SELECT * FROM Pais;

SELECT * FROM Genero ;

SELECT * FROM Utilizador ;

SELECT * FROM Chat;

SELECT * FROM Seguidor;

SELECT * FROM TipoConteudo;

SELECT * FROM Privacidade;

SELECT * FROM Conteudo ;

SELECT * FROM Comentario;

SELECT * FROM TipoLike;

SELECT * FROM LikeDisLike ;

-- Consultas (Views e/ou Procedures):
-- a)  Permitir que um utilizador visualize o seu “espaço” na rede social:

CALL sp_visualizarEspacoUtilizador(3);

-- b)  Permitir consultar todos os conteúdos que sejam públicos. Deve ser apresentada
-- 1. autor,  o  nº  de  likes,  classificação
SELECT * FROM v_listarConteudoPublico;
    
-- c)  Permitir  consultar  todos  os  comentários  associados  a  um  conteúdo,  com  a
    -- identificação do utilizador autor do comentário, ordenados por data.
SELECT * FROM v_listarComentarioAssociadoAoComentario;

-- d)  Permitir  que  um  utilizador  visualize  os  conteúdos  que  foram  partilhados  consigo,
    -- incluindo respetiva data e autor;
CALL sp_listarConteudoPartilhado(3);
    
-- e)  Pode  propor  consultas  adicionais  de  informação  a  disponibilizar  aos  utilizadores,
	-- desde que justifique a sua pertinência. São contudo parte integrante dos requisitos mínimos 
    -- todas as anteriores.
    
-- f)  O gestor da plataforma deve consultar:
-- 1.  Nº total de utilizadores registados;
SELECT * FROM v_totalUtilizadoresRegistados;
    
-- 2.  Nº total de comentários;
SELECT * FROM v_totalComentarios;
    
-- 3.  Nº médio de comentários por conteúdo;
SELECT * FROM v_mediaComentarioPorConteudo;
    
-- 4.  A  média  das  classificações e a média  de  likes  atribuídos aos  conteúdos de um utilizador;
SELECT * FROM v_mediaLikePorConteudo;
            
-- 5.  Ranking de utilizadores de acordo a alínea anterior;
CALL sp_rankingUtilizador();
            
--  6.  Os  conteúdos  públicos  com  a  melhor  classificação  na  semana  anterior  à data atual.
select * from v_listarConteudoPublicoComMaiorClassificacao;
        
-- g)  Pode  propor  consultas  adicionais  de  informação  a  disponibilizar  ao(s)  gestor(es),
-- desde que justifique a sua pertinência. São contudo parte integrante dos requisitos
-- ínimos todas as enumeradas no pontos anterior.

-- Atualizações:

-- b)  Existência de stored procedure para atualizar os dados e.g. utilizadores, conteúdos

CALL sp_atualizar_utilizador(1, "novo nome", 1, 1, "novo username", "nova senha");

CALL sp_atualizar_conteudo(1, 1, 1, "nova descrição", 1, curdate());

-- remover utilizador
CALL sp_remover_utilizador(1);
-- remover conteudo
CALL sp_remover_conteudo(1);
-- remover like
CALL sp_remover_likeDislike(1);
-- remover comentario
CALL sp_remover_comentario(1);



   

