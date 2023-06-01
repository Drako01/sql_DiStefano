USE clinica;

-- Insetar Datos en algunas Tablas:
-- Inserción de datos en la tabla "especialidadmedica"
INSERT INTO especialidadmedica (nombre, subespecialidad, numero) VALUES ('Cardiología', 'Electrofisiología', '001');

-- Inserción de datos en la tabla "localidad"
INSERT INTO localidad (nombre, cp, provincia) VALUES ('Ciudad Autónoma de Buenos Aires', '1000', 'Buenos Aires');

-- Inserción de datos en la tabla "obrasocial"
INSERT INTO obrasocial (denominacion, sigla) VALUES ('Obra Social X', 'OSX');

-- Inserción de datos en la tabla "persona"
INSERT INTO persona (nombre, apellido, sexo, edad, dni, fecha_nacimiento, direccion, nacionalidad, email, telefono, n_afiliado, fecha_ingreso, fecha_egreso, motivo_ingreso, motivo_egreso, localidad_id, medico_cabecera_id, obra_social_id)
VALUES ('Ana', 'Gómez', 'Femenino', 35, '98765432', '1988-05-10', 'Avenida Principal 456', 'Argentina', 'anagomez@example.com', '9876543210', '123456789012', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', null, null, null);

-- Inserción de datos en la tabla "empleado"
INSERT INTO empleado (nombre, apellido, sexo, edad, dni, legajo, fecha_nacimiento, direccion, nacionalidad, email, telefono, contacto_fam, n_afiliado, puesto, fecha_ingreso, nivel_estudio, entidad_educativa, estudios_terminados, anio_egreso, localidad_id, obra_social_id)
VALUES ('Pedro', 'López', 'Masculino', 28, '87654321', 'E1234', '1995-10-15', 'Calle Principal 789', 'Argentina', 'pedrolopez@example.com', '0123456789', 'Contacto Familiar', '987654321012', 'Administrativo', '2021-01-01', 'Licenciatura en Administración', 'Universidad ABC', 'Licenciatura en Administración', '2020', null, null);


-- Inserción de datos en la tabla "medico" mediante importación de datos desde un archivo CSV
-- Temporalmente desactivar la restricción de clave foránea
SET FOREIGN_KEY_CHECKS = 0;

LOAD DATA INFILE './medicos.csv' -- La ruta puede variar dependiendo de donde se guarde el Archivo.
INTO TABLE medico
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, nombre, apellido, dni, direccion, nacionalidad, email, telefono, matricula_prov, matricula_nac, especialidad_id, localidad_id);

-- Reactivar la restricción de clave foránea
SET FOREIGN_KEY_CHECKS = 1;

-- Visualizar la Tabla luego de la carga de datos:
SELECT * FROM medico;

