CREATE DATABASE javagendatelefonica;
USE  javagendatelefonica;

CREATE TABLE contatos (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    telefone VARCHAR(14) NOT NULL,
    email VARCHAR(40) NOT NULL,
    foto VARCHAR(32) NOT NULL default 'nopicture.png',
    PRIMARY KEY(id),
    UNIQUE(nome)
);