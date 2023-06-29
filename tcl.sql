USE clinica;

-- Sublenguaje TCL:

-- Tabla número 1 - persona:
----------------------------

-- Inserción de registros en la tabla "persona" con una transacción y sentencias de rollback y commit comentadas.
-- Iniciamos una transacción para insertar registros en la tabla "persona" porque no tiene datos.

START TRANSACTION;
-- Temporalmente desactivo la restricción de clave foránea
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO persona (nombre, apellido, sexo, edad, dni, fecha_nacimiento, direccion, nacionalidad, email, telefono, n_afiliado, fecha_ingreso, localidad_id, medico_cabecera_id, obra_social_id)
VALUES
('Juan', 'Pérez', 'M', 30, '12345678', '1993-05-15', 'Calle 123', 'Argentina', 'juan@mimail.com', '1234567890', '000001', '2021-01-01', 1, 1, 1),
('María', 'López', 'F', 28, '98735432', '1995-09-20', 'Avenida 456', 'Argentina', 'maria@mimail.com', '0987654321', '000002', '2021-02-01', 2, 2, 1),
('Carlos', 'García', 'M', 35, '23456789', '1988-07-10', 'Ruta 789', 'Argentina', 'carlos@mimail.com', '5678901234', '000003', '2021-03-01', 3, 3, 2),
('Ana', 'Rodríguez', 'F', 40, '87654321', '1983-12-05', 'Calle Principal', 'Argentina', 'ana@mimail.com', '4321098765', '000004', '2021-04-01', 4, 4, 2),
('Luis', 'Martínez', 'M', 45, '34567890', '1978-11-18', 'Avenida Central', 'Argentina', 'luis@mimail.com', '9012345678', '000005', '2021-05-01', 5, 5, 3);
-- Reactivar la restricción de clave foránea
SET FOREIGN_KEY_CHECKS = 1;
-- Comentamos las sentencias de rollback y commit para evitar la eliminación de los registros.
-- ROLLBACK;
-- COMMIT;

-- Iniciamos una transacción utilizando "START TRANSACTION" para asegurar que las inserciones sean tratadas como una única operación.
-- Luego, utilizamos la sentencia "INSERT INTO" para agregar registros a la tabla "persona". 
-- Se insertan 5 registros con diferentes valores para cada columna.
-- En la línea de ROLLBACK y COMMIT, las sentencias están comentadas para evitar la eliminación de los registros en este momento.


-- Transacción de eliminación de registros en la tabla "persona" con sentencias de rollback y commit comentadas.
-- Iniciamos una transacción para eliminar registros en la tabla "persona".

START TRANSACTION;
DELETE FROM persona WHERE id < 5;

-- Comentamos las sentencias de rollback y commit para evitar la eliminación permanente de los registros.
-- ROLLBACK;
-- COMMIT;

-- Iniciamos una transacción utilizando "START TRANSACTION" para asegurar que las eliminaciones sean tratadas como una única operación.
-- Utilizamos la sentencia "DELETE FROM" para eliminar los registros de la tabla "persona" con un "id" menor a 5.
-- En la línea de ROLLBACK y COMMIT, las sentencias están comentadas para evitar la eliminación permanente de los registros en este momento.



--------------------------------------------------------------------------------------------------------------------------------------------


-- Tabla número 2 - medico: 
----------------------------

-- Inserción de 8 nuevos registros en la tabla "medico" con una nueva transacción, savepoints y eliminación de savepoints.
-- Iniciamos una nueva transacción para insertar registros en la tabla "medico".

START TRANSACTION;
-- Temporalmente desactivo la restricción de clave foránea
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO medico (nombre, apellido, dni, direccion, nacionalidad, email, telefono, matricula_prov, matricula_nac, especialidad_id, localidad_id)
VALUES
('Pedro', 'Gómez', '11111111', 'Calle 1', 'Argentina', 'pedro@mimail.com', '1111111111', 'MP-1111', 'MN-1111', 1, 1),
('Laura', 'Fernández', '22222222', 'Avenida 2', 'Argentina', 'laura@mimail.com', '2222222222', 'MP-2222', 'MN-2222', 2, 2),
('Roberto', 'Sánchez', '33333333', 'Ruta 3', 'Argentina', 'roberto@mimail.com', '3333333333', 'MP-3333', 'MN-3333', 1, 3),
('Marcela', 'González', '44444444', 'Calle 4', 'Argentina', 'marcela@mimail.com', '4444444444', 'MP-4444', 'MN-4444', 2, 4);
-- Agregamos un savepoint después de la inserción del registro número 4.
SAVEPOINT savepoint_medicos_1;
INSERT INTO medico (nombre, apellido, dni, direccion, nacionalidad, email, telefono, matricula_prov, matricula_nac, especialidad_id, localidad_id)
VALUES
('Alejandro', 'López', '55555555', 'Avenida 5', 'Argentina', 'alejandro@mimail.com', '5555555555', 'MP-5555', 'MN-5555', 1, 5),
('Carolina', 'Martínez', '66666666', 'Ruta 6', 'Argentina', 'carolina@mimail.com', '6666666666', 'MP-6666', 'MN-6666', 2, 1),
('Sergio', 'Hernández', '77777777', 'Calle 7', 'Argentina', 'sergio@mimail.com', '7777777777', 'MP-7777', 'MN-7777', 1, 2),
('María', 'López', '88888888', 'Avenida 8', 'Argentina', 'maria@mimail.com', '8888888888', 'MP-8888', 'MN-8888', 2, 3);
-- Agregamos un savepoint después de la inserción del registro número 8.
SAVEPOINT savepoint_medicos_2;
-- Reactivar la restricción de clave foránea
SET FOREIGN_KEY_CHECKS = 1;

-- Comentamos la sentencia de eliminación del savepoint de los primeros 4 registros insertados.
-- ROLLBACK TO savepoint_medicos_1;


-- Iniciamos una nueva transacción utilizando "START TRANSACTION" para asegurar que las inserciones sean tratadas como una única operación.
-- Utilizamos la sentencia "INSERT INTO" para agregar registros a la tabla "medico". 
-- Se insertan 8 registros con diferentes valores para cada columna.
-- Agregamos un savepoint después de la inserción del registro número 4 y otro savepoint después de la inserción del registro número 8,
-- utilizando "SAVEPOINT savepoint_medicos_1" y "SAVEPOINT savepoint_medicos_2" respectivamente.
-- La sentencia de eliminación del savepoint de los primeros 4 registros insertados está comentada para mantenerlos en la transacción actual.