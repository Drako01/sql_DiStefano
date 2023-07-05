-- Para generar el backup de la base de datos clinica, usar el siguiente comando:

-- Comando: mysqldump -u root -p [clinica] --no-create-info clinica > backup.sql
-- Base de datos: clinica 
-- Archivo: backup.sql
-- Para restaurar la base de datos clinica, usar el siguiente comando:
-- Comando: mysqldump -u root -p  [clinica] < backup.sql

-- Tablas incluidas en la base de datos "clinica":
-- - especialidadmedica
-- - localidad
-- - medico
-- - consultorios
-- - obrasocial
-- - persona
-- - turno
-- - log_medico
-- - log_turno
-- - empleado
-- - vacaciones
-- - vacaciones_medico