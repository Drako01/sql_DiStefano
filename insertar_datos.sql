-- Insetar Datos en algunas Tablas:
-- Inserción de datos en la tabla "especialidadmedica"
INSERT INTO especialidadmedica (nombre, subespecialidad, numero) VALUES ('Cardiología', 'Electrofisiología', '001');

-- Inserción de datos en la tabla "localidad"
INSERT INTO localidad (nombre, cp, provincia) VALUES ('Ciudad Autónoma de Buenos Aires', '1000', 'Buenos Aires');

-- Inserción de datos en la tabla "medico"
INSERT INTO medico (nombre, apellido, dni, direccion, nacionalidad, email, telefono, matricula_prov, matricula_nac, especialidad_id, localidad_id)
VALUES ('Juan', 'Pérez', '12345678', 'Calle Falsa 123', 'Argentina', 'juanperez@example.com', '1234567890', 'M12345', 'N54321', 1, 1);

-- Inserción de datos en la tabla "consultorios"
INSERT INTO consultorios (nombre, ocupado, medico_id) VALUES ('Consultorio 1', 0, 1);

-- Inserción de datos en la tabla "obrasocial"
INSERT INTO obrasocial (denominacion, sigla) VALUES ('Obra Social X', 'OSX');

-- Inserción de datos en la tabla "persona"
INSERT INTO persona (nombre, apellido, sexo, edad, dni, fecha_nacimiento, direccion, nacionalidad, email, telefono, n_afiliado, fecha_ingreso, fecha_egreso, motivo_ingreso, motivo_egreso, localidad_id, medico_cabecera_id, obra_social_id)
VALUES ('Ana', 'Gómez', 'Femenino', 35, '98765432', '1988-05-10', 'Avenida Principal 456', 'Argentina', 'anagomez@example.com', '9876543210', '123456789012', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 1, 1, 1);

-- Inserción de datos en la tabla "turno"
INSERT INTO turno (fecha, hora, atendido, doctor_id, paciente_id) VALUES ('2023-05-20', 10, 0, 1, 1);

-- Inserción de datos en la tabla "empleado"
INSERT INTO empleado (nombre, apellido, sexo, edad, dni, legajo, fecha_nacimiento, direccion, nacionalidad, email, telefono, contacto_fam, n_afiliado, puesto, fecha_ingreso, nivel_estudio, entidad_educativa, estudios_terminados, anio_egreso, localidad_id, obra_social_id)
VALUES ('Pedro', 'López', 'Masculino', 28, '87654321', 'E1234', '1995-10-15', 'Calle Principal 789', 'Argentina', 'pedrolopez@example.com', '0123456789', 'Contacto Familiar', '987654321012', 'Administrativo', '2021-01-01', 'Licenciatura en Administración', 'Universidad ABC', 'Licenciatura en Administración', '2020', 1, 1);

-- Inserción de datos en la tabla "vacaciones"
INSERT INTO vacaciones (empleado_id, fecha_inicio, fecha_fin) VALUES (1, '2023-07-01', '2023-07-15');

-- Inserción de datos en la tabla "vacaciones_medico"
INSERT INTO vacaciones_medico (medico_id, fecha_inicio, fecha_fin) VALUES (1, '2023-08-01', '2023-08-15');
