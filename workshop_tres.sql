-- Workshop DCL y TCL
-- Consignas:

-- - Crear 3 usuarios
-- - Al 1ro establecerle permisos de lectura sobre determinadas Tablas (usuario 1)
-- - Al 2do establecerle permisos de lectura y escritura  sobre todas lasTablas (usuario 2)
-- - Al 3ro establecerle permisos de lectura y eliminación sobre todas lasTablas (usuario 3)

-- - Probar permisos otorgados mediante operaciones DML
-- - Eliminar usuario 3 y pasarle los permisos de este a usuario 2
-- - Integrar el uso de TCL al momento de realizar las operaciones DML anterioriormente mensionadas


-- Crear los usuarios:
CREATE USER 'usuario1'@'localhost' IDENTIFIED BY 'contraseña1';
CREATE USER 'usuario2'@'localhost' IDENTIFIED BY 'contraseña2';
CREATE USER 'usuario3'@'localhost' IDENTIFIED BY 'contraseña3';

-- Asignar permisos de lectura al usuario1 sobre determinadas tablas:
GRANT SELECT ON obrasocial TO 'usuario1'@'localhost';
GRANT SELECT ON consultorios TO 'usuario1'@'localhost';

-- Asignar permisos de lectura y escritura al usuario2 sobre todas las tablas:
GRANT SELECT, INSERT, UPDATE ON clinica.* TO 'usuario2'@'localhost';

-- Asignar permisos de lectura y eliminación al usuario3 sobre todas las tablas:
GRANT SELECT, DELETE ON clinica.* TO 'usuario3'@'localhost';

-- Probar los permisos otorgados mediante operaciones DML:
-- Usuario1 (permisos de lectura)
SELECT * FROM obrasocial;

-- Usuario2 (permisos de lectura y escritura)
BEGIN;
INSERT INTO obrasocial (denominacion, sigla) VALUES ('Obra Social B', 'OSB');
UPDATE consultorios SET ocupado = 1 WHERE id = 3;
DELETE FROM obrasocial WHERE id = 2;
COMMIT;

-- Usuario3 (permisos de lectura y eliminación)
BEGIN;
SELECT * FROM consultorios;
DELETE FROM consultorios WHERE id = 4;
COMMIT;

-- Eliminar usuario3 y transferir los permisos a usuario2:
BEGIN;
REVOKE ALL PRIVILEGES ON clinica.* FROM 'usuario3'@'localhost';
DROP USER 'usuario3'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON clinica.* TO 'usuario2'@'localhost';
COMMIT;
