-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_tcc
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_tcc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_tcc` DEFAULT CHARACTER SET utf8 ;
USE `db_tcc` ;

-- -----------------------------------------------------
-- Table `db_tcc`.`Grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tcc`.`Grupo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `grupo` VARCHAR(45) NOT NULL,
  `permissoes` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ID_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_tcc`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tcc`.`Usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(110) NOT NULL,
  `ativo` VARCHAR(45) NOT NULL,
  `grupo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ID_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_grupo_id_idx` (`grupo_id` ASC) VISIBLE,
  UNIQUE INDEX `Grupo_ID_UNIQUE` (`grupo_id` ASC) VISIBLE,
  CONSTRAINT `fk_grupo_id`
    FOREIGN KEY (`grupo_id`)
    REFERENCES `db_tcc`.`Grupo` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_tcc`.`Professores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tcc`.`Professores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `cadeira` VARCHAR(200) NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idProfessores_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `pk_usuario_id_idx` (`usuario_id` ASC) VISIBLE,
  UNIQUE INDEX `Usuario_ID_UNIQUE` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_id`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `db_tcc`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_tcc`.`Cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tcc`.`Cursos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_curso` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ID_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `Nome_Curso_UNIQUE` (`nome_curso` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_tcc`.`Turmas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tcc`.`Turmas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `horario` VARCHAR(45) NOT NULL,
  `curso_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ID_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `Curso_ID_UNIQUE` (`curso_id` ASC) VISIBLE,
  CONSTRAINT `fk_curso_id`
    FOREIGN KEY (`curso_id`)
    REFERENCES `db_tcc`.`Cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_tcc`.`Alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tcc`.`Alunos` (
  `id` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  `periodo` VARCHAR(45) NOT NULL,
  `matricula` INT NOT NULL AUTO_INCREMENT,
  `turma_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ID_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `Matricula_UNIQUE` (`matricula` ASC) VISIBLE,
  UNIQUE INDEX `Turma_ID_UNIQUE` (`turma_id` ASC) VISIBLE,
  UNIQUE INDEX `Usuario_ID_UNIQUE` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_turma_id`
    FOREIGN KEY (`turma_id`)
    REFERENCES `db_tcc`.`Turmas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_id`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `db_tcc`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_tcc`.`Evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_tcc`.`Evento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_evento` DATETIME NOT NULL,
  `descricao` TEXT(999) NOT NULL,
  `turma_id` INT NOT NULL,
  `professor_id` INT NOT NULL,
  `data_criacao` DATETIME NOT NULL,
  `data_atualizacao` DATETIME NOT NULL,
  `status_evento` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ID_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `turma_id_UNIQUE` (`turma_id` ASC) VISIBLE,
  UNIQUE INDEX `professor_id_UNIQUE` (`professor_id` ASC) VISIBLE,
  CONSTRAINT `fk_turma_id`
    FOREIGN KEY (`turma_id`)
    REFERENCES `db_tcc`.`Turmas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professor_id`
    FOREIGN KEY (`professor_id`)
    REFERENCES `db_tcc`.`Professores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
