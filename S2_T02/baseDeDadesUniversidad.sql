-- Base de dades Universidad
-- Si us plau, descàrrega la base de dades del fitxer schema_universidad.sql, visualitza el diagrama E-R en un editor i efectua les següents consultes:

-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT DISTINCT persona.apellido1, persona.apellido2, persona.nombre FROM universidad.persona INNER JOIN alumno_se_matricula_asignatura ON persona.id=alumno_se_matricula_asignatura.id_alumno ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
    
-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT persona.nombre, persona.apellido1, persona.apellido2 FROM universidad.persona WHERE persona.tipo LIKE "alumno" AND persona.telefono IS NULL;
    
-- 3. Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM universidad.persona WHERE YEAR(fecha_nacimiento) = 1999;
    
-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM universidad.persona WHERE persona.tipo LIKE "profesor" AND persona.telefono IS NULL AND SUBSTRING(persona.nif, -1) LIKE "K";
    
-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM universidad.asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
    
-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre FROM persona INNER JOIN profesor ON persona.id=id_profesor JOIN departamento ON profesor.id_departamento=departamento.id ORDER BY persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;
    
-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM curso_escolar INNER JOIN asignatura ON curso_escolar.id=asignatura.curso JOIN alumno_se_matricula_asignatura ON asignatura.id=alumno_se_matricula_asignatura.id_asignatura JOIN persona ON alumno_se_matricula_asignatura.id_alumno=persona.id WHERE persona.nif LIKE "26902806M";

-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT departamento.nombre FROM universidad.departamento INNER JOIN profesor ON departamento.id=profesor.id_departamento JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor JOIN grado ON asignatura.id_grado=grado.id WHERE grado.nombre LIKE "%Informatica%2015%";

-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT persona.* FROM universidad.persona INNER JOIN alumno_se_matricula_asignatura ON persona.id=alumno_se_matricula_asignatura.id_alumno JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura=asignatura.id JOIN curso_escolar ON asignatura.curso=curso_escolar.id WHERE anyo_inicio=2018 AND anyo_fin=2019;


-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
-- 1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT departamento.nombre AS `departamento`, persona.apellido1, persona.apellido2, persona.nombre FROM universidad.departamento LEFT JOIN profesor ON departamento.id=profesor.id_departamento LEFT JOIN persona ON profesor.id_profesor=persona.id ORDER BY departamento.nombre ASC, persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;
    
-- 2. Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM universidad.persona WHERE tipo LIKE "profesor" AND id NOT IN (SELECT id_profesor FROM profesor LEFT JOIN departamento ON profesor.id_departamento=departamento.id);
    
-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT departamento.nombre FROM universidad.departamento WHERE id NOT IN (SELECT id_departamento FROM profesor LEFT JOIN departamento ON profesor.id_departamento=departamento.id);

-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT persona.nombre, persona.apellido1, persona.apellido2 FROM universidad.persona WHERE tipo LIKE "profesor" AND id NOT IN (SELECT DISTINCT profesor.id_profesor FROM profesor RIGHT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE profesor.id_profesor IS NOT NULL);
  
-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT * FROM asignatura WHERE id_profesor IS NULL;
    
-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT * FROM universidad.departamento WHERE id NOT IN (SELECT DISTINCT departamento.id FROM departamento LEFT JOIN profesor ON departamento.id=profesor.id_departamento LEFT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE asignatura.curso IS NOT NULL);


-- Consultes resum:
-- 1. Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(id) AS `total d'alumnes` FROM persona WHERE tipo LIKE "alumno";
    
-- 2. Calcula quants alumnes van néixer en 1999.
SELECT COUNT(id) AS `total d'alumnes nascuts en 1999` FROM persona WHERE tipo LIKE "alumno" AND YEAR(fecha_nacimiento) = 1999;

-- 3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT departamento.nombre AS `nom departament`, COUNT(id_profesor) AS `total professors/es associats` FROM profesor INNER JOIN departamento ON profesor.id_departamento=departamento.id GROUP BY id_departamento ORDER BY `total professors/es associats` DESC, `nom departament` ASC;
    
-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT departamento.nombre AS `nom departament`, COUNT(id_profesor) AS `total professors/es associats` FROM profesor RIGHT JOIN departamento ON profesor.id_departamento=departamento.id GROUP BY `nom departament`  ORDER BY `total professors/es associats` DESC, `nom departament` ASC;

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT grado.nombre AS `nom del grau`, COUNT(asignatura.id) AS `nombre d'assignatures` FROM asignatura RIGHT JOIN grado ON asignatura.id_grado=grado.id GROUP BY `nom del grau` ORDER BY `nombre d'assignatures` DESC;
    
-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT grado.nombre AS `nom del grau`,COUNT(asignatura.id) AS `nombre d'assignatures` FROM asignatura RIGHT JOIN grado ON asignatura.id_grado=grado.id GROUP BY grado.nombre HAVING COUNT(asignatura.id) > 40;
    
-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT DISTINCT grado.nombre AS `nom del grau`, asignatura.tipo AS `tipus d'assignatura`, SUM(asignatura.creditos) AS `suma de crèdits`FROM asignatura RIGHT JOIN grado ON asignatura.id_grado=grado.id GROUP BY grado.nombre, asignatura.tipo;
    
-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT DISTINCT curso_escolar.anyo_inicio AS `any d'inici`, COUNT(DISTINCT id_alumno) AS `nombre alumnes matriculats` FROM alumno_se_matricula_asignatura LEFT JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar=curso_escolar.id GROUP BY anyo_inicio;
    
-- 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT persona.id, persona.nombre AS `nom`, apellido1 AS `primer cognom`, apellido2 AS `segon cognom`, COUNT(asignatura.id) AS `nombre d'assignatures` FROM persona RIGHT JOIN profesor ON persona.id=profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor GROUP BY persona.id, persona.nombre, apellido1, apellido2 ORDER BY `nombre d'assignatures` DESC;
    
-- 10. Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM persona WHERE tipo LIKE "alumno" GROUP BY persona.id HAVING fecha_nacimiento=(SELECT MAX(fecha_nacimiento) FROM persona WHERE tipo LIKE "alumno");
    
-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT * FROM persona INNER JOIN profesor ON persona.id=profesor.id_profesor WHERE tipo LIKE "profesor" AND id_profesor NOT IN (SELECT DISTINCT profesor.id_profesor FROM profesor RIGHT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE profesor.id_profesor IS NOT NULL) ORDER BY id_profesor;