-- Para generar el backup de la base de datos clinica, usar el siguiente comando:

-- Comando: mysqldump -u root -p --no-create-info clinica > backup.sql
-- Base de datos: clinica 
-- Archivo: backup.sql
-- Para restaurar la base de datos clinica, usar el siguiente comando:
-- Comando: mysql -u root -p clinica < backup.sql

-- Tablas incluidas en la base de datos "clinica":
-- - especialidadmedica
-- - localidad
-- - medico
-- - consultorios
-- - obrasocial
-- - persona
-- - turno
-- - empleado
-- - vacaciones
-- - vacaciones_medico
