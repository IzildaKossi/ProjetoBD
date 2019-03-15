USE PhotoSocial;

-- Consultas (Views e/ou Procedures):
-- a)  Permitir que um utilizador visualize o seu “espaço” na rede social:

DROP PROCEDURE IF EXISTS sp_visualizarEspacoUtilizador;
      
DELIMITER $$
CREATE PROCEDURE sp_visualizarEspacoUtilizador(IN id INT)
BEGIN
SELECT  ut.ut_id AS 'ID',
        ut.ut_nome AS 'Nome',
        g.genero_tipo AS 'Genero',
        p.pais_nome AS 'Pais',
        ut.ut_username AS 'Username',
	    ut.ut_password AS 'Password'
    FROM
         utilizador ut 
         INNER JOIN genero g
            ON g.genero_id = ut.ut_genero_id
		 INNER JOIN pais p
            ON p.pais_id = ut.ut_pais_id
        WHERE ut.ut_id = id;
END$$
DELIMITER ;
    
-- b)  Permitir consultar todos os conteúdos que sejam públicos. Deve ser apresentada
-- 1. autor,  o  nº  de  likes,  classificação

CREATE OR REPLACE VIEW v_listarConteudoPublico AS
    SELECT 
        ut.ut_nome AS 'Autor',
        c.cont_descricao AS 'Descrição',
        tp.tipo_conteudo AS 'Tipo',
        COUNT(l.like_id) AS 'Nº de Likes',
        cl.class_valor AS 'Classificação',
        p.priv_tipo AS 'Privacidade'
        
    FROM
        conteudo c
            LEFT JOIN
        utilizador ut ON ut.ut_id = c.cont_ut_id
            LEFT JOIN
        tipoconteudo tp ON tp.tipo_cont_id = c.cont_tipo_id
            LEFT JOIN
        privacidade p ON p.priv_id = c.cont_privacidade_id
            LEFT JOIN
        likedislike l ON c.cont_id = l.like_conteudo_id
          LEFT JOIN
        classificacao cl ON cl.class_cont_id = c.cont_ut_id
    WHERE
        p.priv_tipo = 'público'
    GROUP BY c.cont_id;
     
-- c)  Permitir  consultar  todos  os  comentários  associados  a  um  conteúdo,  com  a
    -- identificação do utilizador autor do comentário, ordenados por data.
    
CREATE OR REPLACE VIEW v_listarComentarioAssociadoAoComentario AS
    SELECT 
        com.comentario_data AS 'Data',
        com.comentario AS 'Comentario',
        tp.tipo_conteudo AS 'Tipo',
        ut.ut_username AS 'Autor do Comentario'
    FROM
        conteudo c
            INNER JOIN
        comentario com ON com.comentario_ut_id = c.cont_ut_id
            INNER JOIN
        utilizador ut ON ut.ut_id = c.cont_ut_id
            INNER JOIN
        tipoconteudo tp ON tp.tipo_cont_id = c.cont_tipo_id
    ORDER BY com.comentario_data;
    
-- d)  Permitir  que  um  utilizador  visualize  os  conteúdos  que  foram  partilhados  consigo,
    -- incluindo respetiva data e autor;
DROP PROCEDURE IF EXISTS sp_listarConteudoPartilhado;
      
DELIMITER $$
CREATE PROCEDURE sp_listarConteudoPartilhado(IN id INT)
BEGIN
SELECT  c.cont_id AS 'Conteudo ID',
        tp.tipo_conteudo AS 'Tipo',
        c.cont_data AS 'Data de Conteudo',
        ut.ut_username AS 'Autor do Conteudo'
    FROM
         utilizador ut 
            INNER JOIN
      conteudo c ON c.cont_ut_id = ut.ut_id
            INNER JOIN
        tipoconteudo tp ON tp.tipo_cont_id = c.cont_tipo_id
        WHERE ut.ut_id = id;
END$$
DELIMITER ;
    
-- e)  Pode  propor  consultas  adicionais  de  informação  a  disponibilizar  aos  utilizadores,
	-- desde que justifique a sua pertinência. São contudo parte integrante dos requisitos mínimos 
    -- todas as anteriores.
    
-- f)  O gestor da plataforma deve consultar:
-- 1.  Nº total de utilizadores registados;
CREATE OR REPLACE VIEW v_totalUtilizadoresRegistados AS
    SELECT 
        COUNT(*) AS 'Nº total de utilizadores registados'
    FROM
        utilizador;
        
-- 2.  Nº total de comentários;
CREATE OR REPLACE VIEW v_totalComentarios AS
    SELECT 
        COUNT(*) AS 'Nº total de comentários'
    FROM
        comentario;

-- 3.  Nº médio de comentários por conteúdo;
CREATE OR REPLACE VIEW v_mediaComentarioPorConteudo AS
    SELECT 
        AVG(com.comentario_id) AS 'Nº médio de comentários por conteúdo',
        t.tipo_conteudo AS 'Tipo de Conteudo'
    FROM
        comentario com
            INNER JOIN
        conteudo con ON com.comentario_cont_id = con.cont_id
            INNER JOIN
        tipoconteudo t ON t.tipo_cont_id = con.cont_tipo_id
        GROUP BY t.tipo_conteudo;
    
-- 4.  A  média  das  classificações e a média  de  likes  atribuídos aos  conteúdos de um utilizador;
CREATE OR REPLACE VIEW v_mediaLikePorConteudo AS
    SELECT 
        AVG(cl.class_valor) AS 'média  das  classificações',
        AVG(l.like_conteudo_id) AS 'média de likes atribuídos aos conteúdos',
        tl.tipo_like AS 'Tipo de Like',
        tc.tipo_conteudo AS 'Tipo de Conteudo',
        ut.ut_username AS 'Utilizador'
    FROM
        likedislike l
         INNER JOIN
        tipolike tl ON tl.tipo_like_id = l.like_tipo_id
            INNER JOIN
        conteudo con ON con.cont_id = l.like_conteudo_id
            INNER JOIN
        tipoconteudo tc ON tc.tipo_cont_id = con.cont_tipo_id
            INNER JOIN
        utilizador ut ON ut.ut_id = con.cont_ut_id
          LEFT JOIN
        classificacao cl ON cl.class_cont_id = con.cont_ut_id
    GROUP BY tc.tipo_conteudo;
    
-- 5.  Ranking de utilizadores de acordo a alínea anterior;
DROP PROCEDURE IF EXISTS sp_rankingUtilizador;
      
DELIMITER $$
CREATE PROCEDURE sp_rankingUtilizador()
BEGIN
SET @curRank := 0;
SELECT 
		     ut.ut_username AS 'Utilizador',
             AVG(cl.class_valor) AS 'média  das  classificações',
             AVG(l.like_conteudo_id) AS 'média de likes atribuídos aos conteúdos',
             tl.tipo_like AS 'Tipo de Like',
             tc.tipo_conteudo AS 'Tipo de Conteudo',
		     @curRank := @curRank + 1 AS 'Ranking de utilizadores'

    FROM
        likedislike l
         INNER JOIN
        tipolike tl ON tl.tipo_like_id = l.like_tipo_id
            INNER JOIN
        conteudo con ON con.cont_id = l.like_conteudo_id
            INNER JOIN
        tipoconteudo tc ON tc.tipo_cont_id = con.cont_tipo_id
            INNER JOIN
        utilizador ut ON ut.ut_id = con.cont_ut_id
         LEFT JOIN
        classificacao cl ON cl.class_cont_id = con.cont_ut_id
    GROUP BY con.cont_id;
END$$
DELIMITER ;
    
--  6.  Os  conteúdos  públicos  com  a  melhor  classificação  na  semana  anterior  à data atual.
CREATE OR REPLACE VIEW v_listarConteudoPublicoComMaiorClassificacao AS
     SELECT 
        ut.ut_nome AS 'Autor',
		c.cont_data AS 'Data',
        c.cont_descricao AS 'Descrição',
        tp.tipo_conteudo AS 'Tipo',
        COUNT(l.like_id) AS 'Nº de Likes',
        MAX(cl.class_valor) AS 'Classificação',
        p.priv_tipo AS 'Privacidade'
        
    FROM
        conteudo c
            LEFT JOIN
        utilizador ut ON ut.ut_id = c.cont_ut_id
            LEFT JOIN
        tipoconteudo tp ON tp.tipo_cont_id = c.cont_tipo_id
            LEFT JOIN
        privacidade p ON p.priv_id = c.cont_privacidade_id
            LEFT JOIN
        likedislike l ON c.cont_id = l.like_conteudo_id
          LEFT JOIN
        classificacao cl ON cl.class_cont_id = c.cont_ut_id
    WHERE
        p.priv_tipo = 'público'
    group by cl.class_valor desc;
    
-- g)  Pode  propor  consultas  adicionais  de  informação  a  disponibilizar  ao(s)  gestor(es),
-- desde que justifique a sua pertinência. São contudo parte integrante dos requisitos
-- ínimos todas as enumeradas no pontos anterior.


-- Inserções/Atualizações:
-- a)  Existência de stored procedures para inserção de dados em cada uma das tabelas
       -- existentes 
       
DROP PROCEDURE IF EXISTS sp_criar_pais;

DELIMITER $$
CREATE PROCEDURE sp_criar_pais(IN nome VARCHAR(40), OUT pais_id INT)
BEGIN
    IF 
	 EXISTS (SELECT 1 FROM pais WHERE pais_nome = nome) 
	 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Este pais já existe!';
    ELSE 
       INSERT INTO pais(pais_nome) VALUES(nome);
       -- obter id do pais
       SET pais_id := LAST_INSERT_ID();
END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_criar_genero;

DELIMITER $$
CREATE PROCEDURE sp_criar_genero(IN tipo VARCHAR(40), OUT genero_id INT)
BEGIN
    IF 
	 EXISTS (SELECT 1 FROM genero WHERE genero_tipo = tipo) 
	 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Este tipo de genero já existe!';
    ELSE 
       INSERT INTO genero(genero_tipo) VALUES(tipo);
       -- obter id do pais
       SET genero_id := LAST_INSERT_ID();
END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_criar_utilizador;

DELIMITER $$
CREATE PROCEDURE sp_criar_utilizador(
 IN  nome VARCHAR(50),
 IN	 genero CHAR(1),
 IN  pais INT,
 IN  username VARCHAR(50),
 IN  senha VARCHAR(50),
 OUT ut_id INT)
BEGIN
    IF 
	 EXISTS (SELECT 1 FROM utilizador WHERE ut_username = username) 
	 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Já existe utilizador com este username!!!';
    ELSE 
    INSERT INTO Utilizador(ut_nome, ut_genero_id, ut_pais_id, ut_username, ut_password) 
    VALUES(nome, genero, pais, username, senha);
       -- obter id do utilizador
       SET ut_id := LAST_INSERT_ID();
END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_criar_mensagem;

DELIMITER $$
CREATE PROCEDURE sp_criar_mensagem(
 IN  ut_envia INT,
 IN  mensagem VARCHAR(50),
 IN  ut_recebe INT)
BEGIN
    INSERT INTO chat(chat_envia_ut_id, chat_mensagem, chat_recebe_ut_id) VALUES(ut_envia, mensagem, ut_recebe);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_seguir_utilizador;

DELIMITER $$
CREATE PROCEDURE sp_seguir_utilizador(
 IN  seguidor INT,
 IN  seguir INT,
 OUT seguidor_id INT)
BEGIN
    IF 
	 EXISTS (SELECT 1 FROM seguidor WHERE seguidor_ut_id = seguidor AND seguir_ut_id  = seguir) 
	 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Este utilizador já se encontra na sua lista de seguidores!!!';
    ELSE 
    INSERT INTO seguidor(seguidor_ut_id, seguir_ut_id) VALUES(seguidor, seguir);
     -- obter id 
       SET seguidor_id := LAST_INSERT_ID();
END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_criar_tipo_conteudo;

DELIMITER $$
CREATE PROCEDURE sp_criar_tipo_conteudo(
 IN  tipo VARCHAR(40),
 OUT tipo_cont_id INT)
BEGIN
    IF 
	 EXISTS (SELECT 1 FROM tipoconteudo WHERE tipo_conteudo = tipo) 
	 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Este tipo de conteúdo já existe!!!';
    ELSE 
     INSERT INTO tipoconteudo(tipo_conteudo) VALUES(tipo);
     -- obter id 
       SET tipo_cont_id := LAST_INSERT_ID();
END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_criar_privacidade;

DELIMITER $$
CREATE PROCEDURE sp_criar_privacidade(
 IN  tipo VARCHAR(40),
 OUT priv_id INT)
BEGIN
    IF 
	 EXISTS (SELECT 1 FROM privacidade WHERE priv_tipo = tipo) 
	 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Este tipo de privacidade já existe!!!';
    ELSE 
     INSERT INTO privacidade(priv_tipo) VALUES(tipo);
     -- obter id 
       SET priv_id := LAST_INSERT_ID();
END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_criar_tipo_like;

DELIMITER $$
CREATE PROCEDURE sp_criar_tipo_like(
 IN  tipo VARCHAR(40),
 OUT tipo_like_id INT)
BEGIN
    IF 
	 EXISTS (SELECT 1 FROM tipolike WHERE tipo_like = tipo) 
	 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Este tipo de like já existe!!!';
    ELSE 
      INSERT INTO tipolike(tipo_like) VALUES(tipo);
     -- obter id 
       SET tipo_like_id := LAST_INSERT_ID();
END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_criar_conteudo;

DELIMITER $$
CREATE PROCEDURE sp_criar_conteudo(
  IN tipo_id INT,
  IN ut_id INT,
  IN descricao VARCHAR(100),
  IN privacidade_id INT,
  IN dataConteudo DATE,
 OUT conteudo_id INT)
BEGIN
    INSERT INTO conteudo(cont_tipo_id, cont_ut_id, cont_descricao, cont_privacidade_id, cont_data) 
    VALUES(tipo_id, ut_id, descricao, privacidade_id, dataConteudo);
       -- obter id 
       SET conteudo_id := LAST_INSERT_ID();
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_classificarConteudo;

DELIMITER $$
CREATE PROCEDURE sp_classificarConteudo(
  IN conteudo_id INT,
  IN ut_id INT,
  IN valor INT)
BEGIN
    INSERT INTO classificacao(class_cont_id, class_uti_id, class_valor) VALUES(conteudo_id, ut_id, valor);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_criar_comentario;

DELIMITER $$
CREATE PROCEDURE sp_criar_comentario(
 IN  ut_comentario VARCHAR(100),
 IN  ut_id INT,
 IN  conteudo_id INT,
 IN  dataComentario DATE,
 IN  resposta_comentario_id INT,
 OUT comentario_id INT)
BEGIN
    INSERT INTO comentario(comentario, comentario_ut_id, comentario_cont_id, comentario_resposta_id, comentario_data) 
    VALUES(ut_comentario, ut_id, conteudo_id, resposta_comentario_id, dataComentario);
       -- obter id 
       SET comentario_id := LAST_INSERT_ID();
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_criar_likeDisLike;

DELIMITER $$
CREATE PROCEDURE sp_criar_likeDisLike(
 IN tipo_id INT,
 IN ut_id INT,
 IN like_conteudo INT,
 IN like_comentario INT,
 OUT like_id INT)
BEGIN
IF 
	 EXISTS (SELECT 1 FROM likedislike WHERE (like_ut_id = ut_id AND like_conteudo_id  = like_conteudo) OR (like_ut_id = ut_id AND like_comentario_id = like_comentario)) 
	 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Já deu like neste conteudo ou comentario!!!';
    ELSE 
    INSERT INTO likedislike(like_tipo_id, like_ut_id, like_conteudo_id, like_comentario_id) 
    VALUES(tipo_id, ut_id, like_conteudo, like_comentario);
     -- obter id 
       SET like_id := LAST_INSERT_ID();
END IF;
END$$
DELIMITER ;
       
-- b)  Existência de stored procedure para atualizar os dados e.g. utilizadores, conteúdos
DROP PROCEDURE IF EXISTS sp_atualizar_utilizador;

DELIMITER $$
CREATE PROCEDURE sp_atualizar_utilizador(
 IN  id INT,
 IN  nome VARCHAR(50),
 IN	 genero CHAR(1),
 IN  pais INT,
 IN  username VARCHAR(50),
 IN  senha VARCHAR(50))
BEGIN
 UPDATE utilizador SET ut_nome = nome, ut_genero_id = genero,
                      ut_pais_id = pais, ut_username = username, 
                      ut_password = senha 
 WHERE ut_id = id;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_atualizar_conteudo;

DELIMITER $$
CREATE PROCEDURE sp_atualizar_conteudo(
  IN id INT,
  IN tipo_id INT,
  IN ut_id INT,
  IN descricao VARCHAR(100),
  IN privacidade_id INT,
  IN dataConteudo DATE)
BEGIN
    UPDATE conteudo SET cont_tipo_id = tipo_id, 
                        cont_ut_id = ut_id, 
                        cont_descricao = descricao, 
                        cont_privacidade_id = privacidade_id, 
                        cont_data = dataConteudo 
    WHERE cont_id = id;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_atualizar_likeDisLike;

DELIMITER $$
CREATE PROCEDURE sp_atualizar_likeDisLike(
 IN id INT,
 IN tipo_id INT,
 IN ut_id INT,
 IN like_conteudo INT,
 IN like_comentario INT)
BEGIN
    UPDATE likedislike SET like_tipo_id = tipo_id, like_ut_id = ut_id,
                           like_conteudo_id = like_conteudo, 
                           like_comentario_id = like_comentario
    WHERE like_id = id;
END$$

DROP PROCEDURE IF EXISTS sp_atualizar_comentario;

DELIMITER $$
CREATE PROCEDURE sp_atualizar_comentario(
 IN  id INT,
 IN  ut_comentario VARCHAR(100),
 IN  ut_id INT,
 IN  conteudo_id INT,
 IN  dataComentario DATE,
 IN  resposta_comentario_id INT)
BEGIN
    UPDATE comentario SET comentario = ut_comentario, 
						  comentario_ut_id = ut_id,
                          comentario_cont_id = conteudo_id, 
                          comentario_resposta_id = resposta_comentario_id,
                          comentario_data = dataComentario
    WHERE comentario_id = id;
DELIMITER ;
-- Remoções:
-- a)  A  remoção  de  dados  deve  ser  encarada  com  a  sensibilidade  de  manter  a
       -- integridade  referencial  dos  dados  já  existentes  
       -- (não  devem  ser  utilizadas  chaves estrangeiras  com  a  opção delete  cascade). 
       -- Na  sequência  disto,  devem  ser desenvolvidos  os  stored  procedures  considerados 
       -- apropriados  para  remoção  de dados assegurando integridade referencial.

-- remover utilizador
DROP PROCEDURE IF EXISTS sp_remover_utilizador;

DELIMITER $$
CREATE PROCEDURE sp_remover_utilizador(IN id INT)
BEGIN
	DELETE FROM utilizador WHERE ut_id = id;
END$$
DELIMITER ;

-- remover conteudo
DROP PROCEDURE IF EXISTS sp_remover_conteudo;

DELIMITER $$
CREATE PROCEDURE sp_remover_conteudo(IN id INT)
BEGIN
	DELETE FROM conteudo WHERE cont_id = id;
END$$
DELIMITER ;

-- remover like
DROP PROCEDURE IF EXISTS sp_remover_likeDislike;

DELIMITER $$
CREATE PROCEDURE sp_remover_likeDislike(IN id INT)
BEGIN
	DELETE FROM likedislike WHERE like_id = id;
END$$
DELIMITER ;

-- remover comentario
DROP PROCEDURE IF EXISTS sp_remover_comentario;

DELIMITER $$
CREATE PROCEDURE sp_remover_comentario(IN id INT)
BEGIN
	DELETE FROM comentario WHERE comentario_id = id;
END$$
DELIMITER ;

-- Funções:
-- Ao  critério  do  grupo  de  trabalho,  respeitando  o  número  mínimo  descrito
   -- anteriormente e considerando os requisitos do projeto.
   
   