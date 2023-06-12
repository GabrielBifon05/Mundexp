-- Active: 1677248782109@@127.0.0.1@3306@Aluno
-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql - banco local - ambiente de desenvolvimento
*/
DROP DATABASE mundexp;

CREATE DATABASE mundexp;

USE mundexp;

CREATE TABLE tbUsuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nomeUsuario VARCHAR(50),
	emailUsuario VARCHAR(50),
	senhaUsuario VARCHAR(50)
);

CREATE TABLE aviso (
	idAviso INT AUTO_INCREMENT NOT NULL,
	tituloAviso VARCHAR(100),
	descricaoAviso VARCHAR(150),
	fk_usuario INT,
	FOREIGN KEY (fk_usuario) REFERENCES tbUsuario(idUsuario),
	PRIMARY KEY (idAviso, fk_usuario)
);

create table tbPais (
	idPais INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nomePais VARCHAR(45)
);

SELECT*FROM tbUsuario;	
/* esta tabela deve estar de acordo com o que está em INSERT de sua API do arduino - dat-acqu-ino */

create table medida (
	idMedida INT AUTO_INCREMENT NOT NULL,
	temepraturaMedida DECIMAL(4,2),
	poder_compraMedida DECIMAL(4,2),
	religiososMedida DECIMAL(4,2),
	multiculturaMedida DECIMAL(4,2),
	inflacaoMedida DECIMAL(4,2),
	fk_pais INT,
	FOREIGN KEY (fk_pais) REFERENCES tbPais(idPais),
	PRIMARY KEY (idMedida, fk_pais)
);

INSERT INTO tbPais VALUES (NULL, 'Canadá'),
						  (NULL, 'Estados Unidos'),
						  (NULL, 'Alemanha'),
						  (NULL, 'Emirados Árabes Unidos');

INSERT INTO medida VALUES (NULL, -12.7, 45, 76, 21.3, 3.8, 1),
							(NULL, 13.9, 54.6, 71, 15.4, 5.9, 2),
							(NULL, 10.6, 46.4, 72, 15.7, 2.7, 3),
							(NULL, 25, 67.7, 99, 87.9, 3.9, 4);

select 
        temepraturaMedida as temperatura, 
        poder_compraMedida as poder_compra,  
        religiososMedida as religiosidade,
        multiculturaMedida as multicultura,
        inflacaoMedida as inflacao
                    from medida
                    where fk_pais = ${idPais}
                    order by idMedida desc limit ${limite_linhas};

					SELECT*FROM tbPais;
/*
comando para sql server - banco remoto - ambiente de produção
*/

-- CREATE TABLE usuario (
-- 	id INT PRIMARY KEY IDENTITY(1,1),
-- 	nome VARCHAR(50),
-- 	email VARCHAR(50),
-- 	senha VARCHAR(50),
-- );

-- CREATE TABLE aviso (
-- 	id INT PRIMARY KEY IDENTITY(1,1),
-- 	titulo VARCHAR(100),
-- 	descricao VARCHAR(150),
-- 	fk_usuario INT FOREIGN KEY REFERENCES usuario(id)
-- );

-- create table aquario (
-- /* em nossa regra de negócio, um aquario tem apenas um sensor */
-- 	id INT PRIMARY KEY IDENTITY(1,1),
-- 	descricao VARCHAR(300)
-- );

-- /* esta tabela deve estar de acordo com o que está em INSERT de sua API do arduino - dat-acqu-ino */

-- CREATE TABLE medida (
-- 	id INT PRIMARY KEY IDENTITY(1,1),
-- 	dht11_umidade DECIMAL,
-- 	dht11_temperatura DECIMAL,
-- 	luminosidade DECIMAL,
-- 	lm35_temperatura DECIMAL,
-- 	chave TINYINT,
-- 	momento DATETIME,
-- 	fk_aquario INT FOREIGN KEY REFERENCES aquario(id)
-- );

/*
comandos para criar usuário em banco de dados azure, sqlserver,
com permissão de insert + update + delete + select
*/

-- CREATE USER [usuarioParaAPIWebDataViz_datawriter_datareader]
-- WITH PASSWORD = '#Gf_senhaParaAPIWebDataViz',
-- DEFAULT_SCHEMA = dbo;

-- EXEC sys.sp_addrolemember @rolename = N'db_datawriter',
-- @membername = N'usuarioParaAPIWebDataViz_datawriter_datareader';

-- EXEC sys.sp_addrolemember @rolename = N'db_datareader',
-- @membername = N'usuarioParaAPIWebDataViz_datawriter_datareader';
