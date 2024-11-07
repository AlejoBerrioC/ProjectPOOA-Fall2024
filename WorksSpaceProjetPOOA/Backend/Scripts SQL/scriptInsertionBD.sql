CONNECT SYS AS SYSDBA;
CONNECT gestionGarderie/12345;
ALTER SESSION SET CURRENT_SCHEMA = gestionGarderie;

INSERT INTO Parent (numTel, nomPar, prePar) VALUES
 (4503485674, "Deslandes", "Pierre-Yves"),
 (4506742345, "Cordier", "Nathalie"),
 (3674589090, "Leclair", "Eric");

INSERT INTO Garderie (nomGard, capGard) VALUES ("Little nakamas", 60);

INSERT INTO Enfant (nomEnf, prenEnf, ageEnf, idParent, nomGard) VALUES 
 ("Deslandes", "Théodore", 8, 1, "Little nakamas"),
 ("Ducartier", "Jane", 6, 2, "Little nakamas"),
 ("Leclair", "Jérémie", 5, 3, "Little nakamas");

INSERT INTO Employe (numEmp, nomEmp, preEmp, nomGard, typeEmp, numTel, emailProf, diplome, nbEnfant) VALUES
 (2024001, "Tremblay", "Jonathan", "Little nakamas", "PersonnelAdministratif", 4503215692, "jonathantremblay@gmail.com", NULL, NULL),
 (2024002, "Ducartier", "Jean", "Little nakamas", "Educatrice", NULL, NULL, "AEC Education de l'enfance", 2);

INSERT INTO Inscription (numEnf, numEmp) VALUES 
 (1, 2024001),
 (2, 2024002),
 (3, 2024002);