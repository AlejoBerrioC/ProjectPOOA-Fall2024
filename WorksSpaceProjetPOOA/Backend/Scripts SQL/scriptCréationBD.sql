CREATE USER gestionGarderie IDENTIFIED BY 12345;

GRANT DBA TO gestionGarderie;

ALTER SESSION SET CURRENT_SCHEMA = gestionGarderie;

-- Création de la table Parent
CREATE TABLE Parent (
    idParent NUMBER PRIMARY KEY,
    numTel VARCHAR2(10) UNIQUE,
    nomPar VARCHAR2(50) NOT NULL,
    prePar VARCHAR2(50) NOT NULL
);

-- Création de la table Garderie
CREATE TABLE Garderie (
    nomGard VARCHAR2(50) PRIMARY KEY,
    capGard NUMBER CHECK (capGard > 50)
);

-- Création de la table Employe
CREATE TABLE Employe (
    numEmp NUMBER PRIMARY KEY,
    nomEmp VARCHAR2(50) NOT NULL,
    preEmp VARCHAR2(50) NOT NULL,
    password VARCHAR2(50) DEFAULT '12345',
    nomGard VARCHAR2(50),
    typeEmp VARCHAR2(30) CHECK (typeEmp IN ('PersonnelAdministratif', 'Educatrice')),
    numTel VARCHAR2(10) UNIQUE NULL,
    emailProf VARCHAR2(100) UNIQUE NULL,
    diplome VARCHAR2(50) NULL,
    nbEnfant NUMBER NULL,
    FOREIGN KEY (nomGard) REFERENCES Garderie(nomGard)
);

-- Création de la table Enfant
CREATE TABLE Enfant (
    numEnf NUMBER PRIMARY KEY,
    nomEnf VARCHAR2(50) NOT NULL,
    prenEnf VARCHAR2(50) NOT NULL,
    ageEnf NUMBER NOT NULL,
    idParent NUMBER,
    nomGard VARCHAR2(50),
    FOREIGN KEY (idParent) REFERENCES Parent(idParent),
    FOREIGN KEY (nomGard) REFERENCES Garderie(nomGard)
);

-- Création de la table Inscription
CREATE TABLE Inscription (
    numEnf NUMBER,
    numEmp NUMBER,
    dateInscription DATE DEFAULT SYSDATE,
    PRIMARY KEY (numEnf, numEmp),
    FOREIGN KEY (numEnf) REFERENCES Enfant(numEnf),
    FOREIGN KEY (numEmp) REFERENCES Employe(numEmp)
);

-- Création des séquences d'auto increment pour id des tables enfants et parent 
CREATE SEQUENCE enfant_seq
    MINVALUE = 1
    MAXVALUE = 999999999
    START WITH 1;
    INCREMENT by 1;
    CACHE 20;
CREATE SEQUENCE parent_seq
    MINVALUE = 1
    MAXVALUE = 999999999
    START WITH 1;
    INCREMENT by 1;
    CACHE 20;

-- Création des trigger d'insertion des sequences d'auto increment pour id des tables enfants et parent
CREATE TRIGGER enfant_trg BEFORE INSERT ON Enfant
    FOR EACH ROW
    BEGIN
        :NEW.numEnf := enfant_seq.nextval;
    END;

CREATE TRIGGER parent_trg BEFORE INSERT ON PARENT
    FOR EACH ROW
    BEGIN
        :NEW.idParent := parent_seq.nextval;
    END;
