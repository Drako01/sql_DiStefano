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
