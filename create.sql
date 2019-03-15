USE mysql;

DROP DATABASE  IF EXISTS PhotoSocial;

CREATE DATABASE PhotoSocial;

USE PhotoSocial;


CREATE TABLE Pais (
    pais_id INT AUTO_INCREMENT,
    pais_nome VARCHAR(40) NOT NULL,
    PRIMARY KEY (pais_id)
);

CREATE TABLE Genero (
    genero_id INT AUTO_INCREMENT,
    genero_tipo CHAR(1) NOT NULL,
    PRIMARY KEY (genero_id)
);

CREATE TABLE Utilizador (
    ut_id INT AUTO_INCREMENT,
    ut_nome VARCHAR(50) NOT NULL,
    ut_genero_id INT,
    ut_pais_id INT NOT NULL,
    ut_username VARCHAR(50) NOT NULL UNIQUE,
    ut_password VARCHAR(50) NOT NULL,
    PRIMARY KEY (ut_id , ut_username)
);

CREATE TABLE Chat (
    chat_id INT AUTO_INCREMENT,
    chat_envia_ut_id INT NOT NULL,
    chat_mensagem VARCHAR(100) NOT NULL,
    chat_recebe_ut_id INT NOT NULL,
    PRIMARY KEY (chat_id)
);

CREATE TABLE Seguidor (
    seguidor_id INT AUTO_INCREMENT,
    seguidor_ut_id INT NOT NULL,
    seguir_ut_id INT NOT NULL,
    PRIMARY KEY (seguidor_id)
);

CREATE TABLE TipoConteudo (
    tipo_cont_id INT AUTO_INCREMENT,
    tipo_conteudo VARCHAR(40) NOT NULL,
    PRIMARY KEY (tipo_cont_id)
);

CREATE TABLE Privacidade (
    priv_id INT AUTO_INCREMENT,
    priv_tipo VARCHAR(40) NOT NULL,
    PRIMARY KEY (priv_id)
);

CREATE TABLE Conteudo (
    cont_id INT AUTO_INCREMENT,
	cont_ut_id INT NOT NULL,
    cont_tipo_id INT NOT NULL,
    cont_descricao VARCHAR(100) NOT NULL,
    cont_privacidade_id INT NOT NULL,
    cont_data DATE NOT NULL,
    PRIMARY KEY (cont_id)
);

CREATE TABLE Classificacao (
    class_id INT AUTO_INCREMENT,
	class_cont_id INT NOT NULL,
    class_uti_id INT NOT NULL,
    class_valor INT NOT NULL,
    PRIMARY KEY (class_id)
);

CREATE TABLE Comentario (
    comentario_id INT AUTO_INCREMENT,
    comentario VARCHAR(100) NOT NULL,
    comentario_ut_id INT NOT NULL,
    comentario_cont_id INT NOT NULL,
	comentario_resposta_id INT,
    comentario_data DATE NOT NULL,
    PRIMARY KEY (comentario_id)
);

CREATE TABLE TipoLike (
    tipo_like_id INT AUTO_INCREMENT,
    tipo_like VARCHAR(40) NOT NULL,
    PRIMARY KEY (tipo_like_id)
);

CREATE TABLE LikeDisLike (
    like_id INT AUTO_INCREMENT,
    like_tipo_id INT NOT NULL,
    like_ut_id INT NOT NULL,
    like_conteudo_id INT,
    like_comentario_id INT,
    PRIMARY KEY (like_id)
);

-- Chaves estrangeiras
ALTER TABLE Utilizador ADD CONSTRAINT utilizador_fk_Pais FOREIGN KEY (ut_pais_id) 
REFERENCES Pais(pais_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Utilizador ADD CONSTRAINT utilizador_fk_genero FOREIGN KEY (ut_genero_id) 
REFERENCES Genero(genero_id) 
ON DELETE CASCADE ON UPDATE CASCADE;
 
ALTER TABLE Chat ADD CONSTRAINT chat_fk_utilizador_envia FOREIGN KEY (chat_envia_ut_id)
REFERENCES Utilizador (ut_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Chat ADD CONSTRAINT chat_fk_utilizador_recebe FOREIGN KEY (chat_recebe_ut_id)
REFERENCES Utilizador (ut_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Seguidor ADD CONSTRAINT seguidor_fk_utilizador FOREIGN KEY (seguidor_ut_id)
REFERENCES Utilizador (ut_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Seguidor ADD CONSTRAINT seguir_fk_utilizador FOREIGN KEY (seguir_ut_id)
REFERENCES Utilizador (ut_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Conteudo ADD CONSTRAINT conteudo_fk_tipo FOREIGN KEY (cont_tipo_id)
REFERENCES TipoConteudo (tipo_cont_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Conteudo ADD CONSTRAINT conteudo_fk_ut FOREIGN KEY ( cont_ut_id)
REFERENCES Utilizador (ut_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Classificacao ADD CONSTRAINT classificacao_fk_conteudo FOREIGN KEY (class_cont_id)
REFERENCES Conteudo (cont_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Classificacao ADD CONSTRAINT classificacao_fk_utilizador FOREIGN KEY (class_uti_id)
REFERENCES Utilizador (ut_id)
ON DELETE CASCADE ON UPDATE CASCADE;
        	
ALTER TABLE LikeDisLike ADD CONSTRAINT like_fk_Tipo FOREIGN KEY (like_tipo_id)
REFERENCES TipoLike (tipo_like_id)
ON DELETE CASCADE ON UPDATE CASCADE;
            
ALTER TABLE LikeDisLike ADD CONSTRAINT like_fk_utilizador FOREIGN KEY (like_ut_id)
REFERENCES Utilizador (ut_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE LikeDisLike ADD CONSTRAINT like_fk_conteudo FOREIGN KEY (like_conteudo_id)
REFERENCES Conteudo (cont_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE LikeDisLike ADD CONSTRAINT like_fk_comentario FOREIGN KEY (like_comentario_id)
REFERENCES Comentario (comentario_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Conteudo ADD CONSTRAINT conteudo_fk_privacidade FOREIGN KEY (cont_privacidade_id)
REFERENCES Privacidade (priv_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Comentario ADD CONSTRAINT comentario_fk_utilizador FOREIGN KEY (comentario_ut_id)
REFERENCES Utilizador (ut_id)
ON DELETE CASCADE ON UPDATE CASCADE;
 
ALTER TABLE Comentario ADD CONSTRAINT comentario_fk_conteudo FOREIGN KEY (comentario_cont_id)
REFERENCES Conteudo (cont_id)
ON DELETE CASCADE ON UPDATE CASCADE;

 