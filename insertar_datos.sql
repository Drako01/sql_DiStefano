USE clinica;
SET FOREIGN_KEY_CHECKS = 0;
-- Insetar Datos en algunas Tablas:
-- Inserción de datos en la tabla "especialidadmedica"
INSERT INTO especialidadmedica (nombre, subespecialidad, numero) VALUES
('Cardiología', 'Cardiología', 'ESP-CARD-001'),
('Dermatología', 'Cirugía Dermatológica', 'ESP-DERM-001'),
('Gastroenterología', 'Endoscopia Digestiva', 'ESP-GASTRO-001'),
('Hematología', 'Hemato-Oncología', 'ESP-HEMA-001'),
('Nefrología', 'Nefrología Pediátrica', 'ESP-NEFRO-001'),
('Neumología', 'Neumología Intervencionista', 'ESP-NEUMO-001'),
('Oftalmología', 'Oftalmología Pediátrica', 'ESP-OFTAL-001'),
('Oncología', 'Oncología Médica', 'ESP-ONCO-001'),
('Otorrinolaringología', 'Otorrinolaringología Pediátrica', 'ESP-OTORRINO-001'),
('Pediatría', 'Neonatología', 'ESP-PEDIA-001'),
('Psiquiatría', 'Psiquiatría Forense', 'ESP-PSIQ-001'),
('Reumatología', 'Reumatología Pediátrica', 'ESP-REUMA-001'),
('Traumatología', 'Traumatología Deportiva', 'ESP-TRAUMA-001'),
('Urología', 'Urología Oncológica', 'ESP-UROLO-001'),
('Anestesiología', 'Anestesiología', 'ESP-ANEST-001'),
('Endocrinología', 'Endocrinología', 'ESP-ENDO-001'),
('Ginecología', 'Ginecología', 'ESP-GINE-001'),
('Neurología', 'Neurología', 'ESP-NEURO-001'),
('Radiología', 'Radiología Vascular e Intervencionista', 'ESP-RADIO-001'),
('Cirugía Cardiológica', 'Cardiología', 'ESP-CIR-001'),
('Geriatria', 'Geriatria Oncologica', 'ESP-GERIA-001'),
('Infectologia', 'Infectologia Pediatrica', 'ESP-INFEC-001');


-- Inserción de datos en la tabla "localidad"
INSERT INTO localidad (nombre, cp, provincia) VALUES
('La Plata', '1900', 'Buenos Aires'),
('Quilmes', '1878', 'Buenos Aires'),
('Avellaneda', '1870', 'Buenos Aires'),
('Lanús', '1824', 'Buenos Aires'),
('Banfield', '1828', 'Buenos Aires'),
('Berazategui', '1884', 'Buenos Aires'),
('Florencio Varela', '1888', 'Buenos Aires'),
('San Justo', '1754', 'Buenos Aires'),
('Morón', '1708', 'Buenos Aires'),
('Ituzaingó', '1714', 'Buenos Aires'),
('San Fernando', '1646', 'Buenos Aires'),
('Tigre', '1648', 'Buenos Aires'),
('Pilar', '1629', 'Buenos Aires'),
('Escobar', '1625', 'Buenos Aires'),
('San Miguel', '1663', 'Buenos Aires'),
('San Isidro', '1642', 'Buenos Aires'),
('Vicente López', '1638', 'Buenos Aires'),
('Merlo', '1722', 'Buenos Aires'),
('Ezeiza', '1804', 'Buenos Aires'),
('Adrogué', '1846', 'Buenos Aires'),
('Burzaco', '1852', 'Buenos Aires'),
('General Pacheco', '1617', 'Buenos Aires'),
('Martínez', '1640', 'Buenos Aires'),
('Bernal', '1876', 'Buenos Aires'),
('Ramos Mejía', '1704', 'Buenos Aires'),
('Don Torcuato', '1611', 'Buenos Aires'),
('Temperley', '1834', 'Buenos Aires'),
('Caseros', '1678', 'Buenos Aires'),
('José C. Paz', '1665', 'Buenos Aires'),
('San Vicente', '1865', 'Buenos Aires');


-- Inserción de datos en la tabla "obrasocial"
INSERT INTO obrasocial (denominacion, sigla) VALUES
('Obra Social del Trabajador', 'OST'),
('Salud Segura', 'SSA'),
('Cobertura Médica Integral', 'CMI'),
('Seguro de Salud Argentino', 'SSA'),
('Asistencia Médica Previsional', 'AMP'),
('Salud Protegida', 'SP'),
('Asistencia Integral Médica', 'AIM'),
('Cuidado Saludable', 'CS'),
('Protección Médica', 'PM'),
('Asistencia Sanitaria Nacional', 'ASN'),
('Cobertura de Salud Integral', 'CSI'),
('Seguridad Médica', 'SM'),
('Bienestar Médico', 'BM'),
('Salud Comunitaria', 'SC'),
('Cobertura Médica Nacional', 'CMN'),
('Asistencia Social Saludable', 'ASS'),
('Seguro Médico Argentino', 'SMA'),
('Asistencia Médica Nacional', 'AMN'),
('Protección Sanitaria', 'PS'),
('Cobertura de Salud Familiar', 'CSF');


-- Inserción de datos en la tabla "persona"
INSERT INTO persona (nombre, apellido, sexo, edad, dni, fecha_nacimiento, direccion, nacionalidad, email, telefono, n_afiliado, fecha_ingreso, fecha_egreso, motivo_ingreso, motivo_egreso, localidad_id, medico_cabecera_id, obra_social_id)
VALUES 
    ('Ana', 'Gómez', 'Femenino', 35, '98222992', '1988-05-10', 'Avenida Principal 456', 'Argentina', 'anagomez@example.com', '9876543210', '123456789012', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 3, 3, 4),
    ('Juan', 'Pérez', 'M', 30, '12345678', '1992-05-10', 'Calle A, #123', 'Argentina', 'juan.perez@example.com', '1234567890', 'A123456789', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 3, 5, 3),
    ('María', 'Gómez', 'F', 35, '98762432', '1987-12-15', 'Avenida B, #456', 'Argentina', 'maria.gomez@example.com', '0987654321', 'B987654321', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 2, 2, 5),
    ('Carlos', 'Rodríguez', 'M', 40, '45678901', '1982-08-20', 'Calle C, #789', 'Argentina', 'carlos.rodriguez@example.com', '1122334455', 'C112233445', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 2, 6, 1),
    ('Laura', 'López', 'F', 25, '21098765', '1997-03-25', 'Avenida D, #987', 'Argentina', 'laura.lopez@example.com', '5544332211', 'D554433221', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 4, 6, 1),
    ('Pedro', 'Hernández', 'M', 50, '54321678', '1973-06-30', 'Calle E, #654', 'Argentina', 'pedro.hernandez@example.com', '6677889900', 'E667788990', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 5, 6, 7),
    ('Ana', 'Torres', 'F', 28, '87659321', '1995-11-05', 'Avenida F, #321', 'Argentina', 'ana.torres@example.com', '9988776655', 'F998877665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 4, 1, 3),
    ('Luis', 'García', 'M', 33, '23456789', '1989-02-15', 'Calle G, #654', 'Argentina', 'luis.garcia@example.com', '5544667788', 'G554466778', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 6, 3, 2),
    ('Sofía', 'Martínez', 'F', 42, '95555432', '1981-09-10', 'Avenida H, #321', 'Argentina', 'sofia.martinez@example.com', '7788996655', 'H778899665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 5, 2, 6),
    ('Andrés', 'Jiménez', 'M', 38, '67890123', '1985-07-20', 'Calle I, #987', 'Argentina', 'andres.jimenez@example.com', '4433221188', 'I443322118', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 22, 3, 5),
    ('Fernanda', 'Díaz', 'F', 23, '34567890', '1999-04-05', 'Avenida J, #654', 'Argentina', 'fernanda.diaz@example.com', '9988776655', 'J998877665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 2, 2, 2),
    ('Roberto', 'Sánchez', 'M', 31, '09876543', '1992-01-15', 'Calle K, #123', 'Argentina', 'roberto.sanchez@example.com', '6655443322', 'K665544332', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 5, 5, 6),
    ('Mariana', 'Ramírez', 'F', 37, '53789012', '1986-10-20', 'Avenida L, #456', 'Argentina', 'mariana.ramirez@example.com', '4433221188', 'L443322118', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 6, 3, 3),
    ('José', 'Reyes', 'M', 45, '87159321', '1978-07-25', 'Calle M, #789', 'Argentina', 'jose.reyes@example.com', '8899776655', 'M889977665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 6, 4, 3),
    ('Gabriela', 'Fernández', 'F', 26, '43210987', '1997-02-28', 'Avenida N, #987', 'Argentina', 'gabriela.fernandez@example.com', '4455667788', 'N445566778', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 4, 6, 7),
    ('Daniel', 'Chávez', 'M', 32, '10987654', '1991-09-10', 'Calle O, #654', 'Argentina', 'daniel.chavez@example.com', '9988776655', 'O998877665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 3, 3, 3),
    ('Valentina', 'Rojas', 'F', 24, '56789012', '1999-06-15', 'Avenida P, #321', 'Argentina', 'valentina.rojas@example.com', '5544332211', 'P554433221', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 1, 3, 3),
    ('Javier', 'Gutiérrez', 'M', 39, '32109876', '1984-03-20', 'Calle Q, #987', 'Argentina', 'javier.gutierrez@example.com', '6677889900', 'Q667788990', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 1, 3, 6),
    ('Paola', 'Ortega', 'F', 29, '89012345', '1994-12-25', 'Avenida R, #654', 'Argentina', 'paola.ortega@example.com', '9988776655', 'R998877665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 6, 7, 8),
    ('Eduardo', 'Navarro', 'M', 27, '65432109', '1996-09-30', 'Calle S, #321', 'Argentina', 'eduardo.navarro@example.com', '7788996655', 'S778899665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 9, 9, 9),
    ('Natalia', 'Vargas', 'F', 22, '01234567', '2001-04-05', 'Avenida T, #987', 'Argentina', 'natalia.vargas@example.com', '5544667788', 'T554466778', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 6, 4, 6);


-- Inserción de datos en la tabla "empleado"
INSERT INTO empleado (nombre, apellido, sexo, edad, dni, legajo, fecha_nacimiento, direccion, nacionalidad, email, telefono, contacto_fam, n_afiliado, puesto, fecha_ingreso, nivel_estudio, entidad_educativa, estudios_terminados, anio_egreso, localidad_id, obra_social_id)
VALUES 
('Pedro', 'López', 'Masculino', 28, '87659921', 'E1234', '1995-10-15', 'Calle Principal 789', 'Argentina', 'pedrolopez@example.com', '0123456789', 'Contacto Familiar', '987654321012', 'Administrativo', '2021-01-01', 'Licenciatura en Administración', 'Universidad ABC', 'Licenciatura en Administración', '2020', 3, 1),
('Ana', 'Fernández', 'Femenino', 25, '34567890', 'E3456', '1998-09-05', 'Avenida Principal 456', 'Argentina', 'anafernandez@example.com', '1234567890', 'Contacto Familiar', '345678901234', 'Operario', '2021-04-01', 'Técnico en Informática', 'Instituto XYZ', 'Técnico en Informática', '2019', 23, 1),
    ('Carlos', 'López', 'Masculino', 35, '45678901', 'E7890', '1986-12-15', 'Calle Secundaria 789', 'Argentina', 'carloslopez@example.com', '0987654321', 'Contacto Familiar', '456789012345', 'Administrativo', '2021-05-01', 'Licenciatura en Economía', 'Universidad ABC', 'Licenciatura en Economía', '2017', 12, 2),
    ('Laura', 'Martínez', 'Femenino', 29, '56789012', 'E1235', '1992-03-25', 'Avenida Principal 789', 'Argentina', 'lauramartinez@example.com', '6789012345', 'Contacto Familiar', '567890123456', 'Operario', '2021-06-01', 'Técnico en Mecánica', 'Instituto XYZ', 'Técnico en Mecánica', '2018', 11, 3),
    ('Mario', 'García', 'Masculino', 33, '67890123', 'E5679', '1988-08-10', 'Calle Secundaria 123', 'Argentina', 'mariogarcia@example.com', '3456789012', 'Contacto Familiar', '678901234567', 'Administrativo', '2021-07-01', 'Licenciatura en Marketing', 'Universidad ABC', 'Licenciatura en Marketing', '2016', 5, 4),
    ('Sofía', 'Rodríguez', 'Femenino', 26, '78901234', 'E9013', '1995-05-15', 'Avenida Principal 456', 'Argentina', 'sofiarodriguez@example.com', '8901234567', 'Contacto Familiar', '789012345678', 'Operario', '2021-08-01', 'Técnico en Diseño Gráfico', 'Instituto XYZ', 'Técnico en Diseño Gráfico', '2019', 1, 5),
    ('Fernando', 'López', 'Masculino', 31, '89012345', 'E1236', '1990-02-20', 'Calle Secundaria 789', 'Argentina', 'fernandolopez@example.com', '9012345678', 'Contacto Familiar', '890123456789', 'Administrativo', '2021-09-01', 'Licenciatura en Comunicación', 'Universidad ABC', 'Licenciatura en Comunicación', '2017', 1, 5),
    ('Ana', 'Gómez', 'Femenino', 27, '90123456', 'E5671', '1996-09-25', 'Avenida Principal 123', 'Argentina', 'anagomez@example.com', '0123456789', 'Contacto Familiar', '901234567890', 'Operario', '2021-10-01', 'Técnico en Contabilidad', 'Instituto XYZ', 'Técnico en Contabilidad', '2018', 2, 5),
    ('Gabriel', 'Pérez', 'Masculino', 29, '01234567', 'E9014', '1992-06-30', 'Calle Secundaria 456', 'Argentina', 'gabrielperez@example.com', '1234567890', 'Contacto Familiar', '012345678901', 'Administrativo', '2021-11-01', 'Licenciatura en Recursos Humanos', 'Universidad ABC', 'Licenciatura en Recursos Humanos', '2020', 4, 4),
    ('María', 'González', 'Femenino', 32, '98765432', 'E1237', '1989-03-05', 'Avenida Principal 789', 'Argentina', 'mariagonzalez@example.com', '2345678901', 'Contacto Familiar', '987654321098', 'Operario', '2021-12-01', 'Técnico en Electricidad', 'Instituto XYZ', 'Técnico en Electricidad', '2017', 6, 5),
    ('Carlos', 'López', 'Masculino', 28, '87654321', 'E9015', '1993-10-10', 'Calle Secundaria 123', 'Argentina', 'carloslopez@example.com', '3456789012', 'Contacto Familiar', '876543210987', 'Administrativo', '2022-01-01', 'Licenciatura en Ingeniería Civil', 'Universidad ABC', 'Licenciatura en Ingeniería Civil', '2019', 7, 7),
    ('Laura', 'Martínez', 'Femenino', 30, '76543210', 'E1238', '1991-07-15', 'Avenida Principal 456', 'Argentina', 'lauramartinez@example.com', '4567890123', 'Contacto Familiar', '765432109876', 'Operario', '2022-02-01', 'Técnico en Programación', 'Instituto XYZ', 'Técnico en Programación', '2018', 5, 8),
    ('Mario', 'García', 'Masculino', 33, '65432109', 'E9016', '1989-04-20', 'Calle Secundaria 789', 'Argentina', 'mariogarcia@example.com', '5678901234', 'Contacto Familiar', '654321098765', 'Administrativo', '2022-03-01', 'Licenciatura en Psicología', 'Universidad ABC', 'Licenciatura en Psicología', '2016', 2, 8),
    ('Sofía', 'Rodríguez', 'Femenino', 26, '54321098', 'E1239', '1996-11-25', 'Avenida Principal 123', 'Argentina', 'sofiarodriguez@example.com', '6789012345', 'Contacto Familiar', '543210987654', 'Operario', '2022-04-01', 'Técnico en Enfermería', 'Instituto XYZ', 'Técnico en Enfermería', '2019', 12, 6),
    ('Fernando', 'López', 'Masculino', 31, '43210987', 'E9010', '1991-08-30', 'Calle Secundaria 456', 'Argentina', 'fernandolopez@example.com', '7890123456', 'Contacto Familiar', '432109876543', 'Administrativo', '2022-05-01', 'Licenciatura en Derecho', 'Universidad ABC', 'Licenciatura en Derecho', '2017', 14, 5),
    ('Ana', 'Gómez', 'Femenino', 27, '32109876', 'E9011', '1996-05-05', 'Avenida Principal 789', 'Argentina', 'anagomez@example.com', '8901234567', 'Contacto Familiar', '321098765432', 'Operario', '2022-06-01', 'Técnico en Marketing Digital', 'Instituto XYZ', 'Técnico en Marketing Digital', '2018', 15, 12),
    ('Juan', 'Pérez', 'Masculino', 32, '12345678', 'E5678', '1990-05-20', 'Avenida Principal 123', 'Argentina', 'juanperez@example.com', '9876543210', 'Contacto Familiar', '123456789012', 'Operario', '2021-02-01', 'Técnico en Electrónica', 'Instituto XYZ', 'Técnico en Electrónica', '2018', 12, 3),
    ('María', 'González', 'Femenino', 30, '23456789', 'E9012', '1991-07-12', 'Calle Secundaria 456', 'Argentina', 'mariagonzalez@example.com', '0123456789', 'Contacto Familiar', '234567890123', 'Administrativo', '2021-03-01', 'Licenciatura en Administración', 'Universidad ABC', 'Licenciatura en Administración', '2020', 1, 5);


INSERT INTO medico (nombre, apellido, dni, direccion, nacionalidad, email, telefono, matricula_prov, matricula_nac, especialidad_id, localidad_id)
VALUES
    ('Médico 1', 'Apellido 1', '12345678', 'Calle Principal 1', 'Argentina', 'medico1@example.com', '1234567890', 'MP123456', 'MN123456', 1, 22),
    ('Médico 2', 'Apellido 2', '23456789', 'Calle Principal 2', 'Argentina', 'medico2@example.com', '2345678901', 'MP234567', 'MN234567', 2, 10),
    ('Médico 3', 'Apellido 3', '34567890', 'Calle Principal 3', 'Argentina', 'medico3@example.com', '3456789012', 'MP345678', 'MN345678', 3, 4),
    ('Médico 4', 'Apellido 4', '45678901', 'Calle Principal 4', 'Argentina', 'medico4@example.com', '4567890123', 'MP456789', 'MN456789', 4, 4),
    ('Médico 5', 'Apellido 5', '56789012', 'Calle Principal 5', 'Argentina', 'medico5@example.com', '5678901234', 'MP567890', 'MN567890', 5, 3),
    ('Médico 6', 'Apellido 6', '67890123', 'Calle Principal 6', 'Argentina', 'medico6@example.com', '6789012345', 'MP678901', 'MN678901', 6, 2),
    ('Médico 7', 'Apellido 7', '78901234', 'Calle Principal 7', 'Argentina', 'medico7@example.com', '7890123456', 'MP789012', 'MN789012', 18, 12),
    ('Médico 8', 'Apellido 8', '89012345', 'Calle Principal 8', 'Argentina', 'medico8@example.com', '8901234567', 'MP890123', 'MN890123', 12, 15),
    ('Médico 9', 'Apellido 9', '90123456', 'Calle Principal 9', 'Argentina', 'medico9@example.com', '9012345678', 'MP901234', 'MN901234', 4, 18),
    ('Médico 10', 'Apellido 10', '01234567', 'Calle Principal 10', 'Argentina', 'medico10@example.com', '0123456789', 'MP012345', 'MN012345', 18, 15);

-- Inserción de datos en la tabla "turno"
INSERT INTO turno (fecha, hora, atendido, doctor_id, paciente_id)
SELECT
    CURDATE() + INTERVAL FLOOR(RAND() * 30) DAY AS fecha,
    FLOOR(RAND() * 24) AS hora,
    FLOOR(RAND() * 2) AS atendido,
    doctor.id AS doctor_id,
    paciente.id AS paciente_id
FROM
    (SELECT 1 AS num UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
    UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8
    UNION SELECT 9 UNION SELECT 10) AS numbers
JOIN
    (SELECT medico.id
    FROM medico
    ORDER BY RAND()
    LIMIT 10) AS doctor ON numbers.num = doctor.id
JOIN
    (SELECT persona.id
    FROM persona
    ORDER BY RAND()
    LIMIT 10) AS paciente ON numbers.num = paciente.id;


-- Insertar 10 consultorios ficticios
INSERT INTO consultorios (nombre, ocupado, medico_id)
SELECT
    CONCAT('Consultorio ', c.number) AS nombre,
    FLOOR(RAND() * 2) AS ocupado,
    m.id AS medico_id
FROM
    (SELECT 1 AS number UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8
     UNION SELECT 9 UNION SELECT 10) AS c
LEFT JOIN
    (SELECT id
     FROM medico
     ORDER BY RAND()
     LIMIT 10) AS m ON c.number = m.id;


-- Insertar 10 tratamientos ficticios
INSERT INTO tratamiento (nombre, descripcion, costo, fecha_inicio, fecha_fin, paciente_id, doctor_id)
SELECT
    CONCAT('Tratamiento ', t.number) AS nombre,
    CONCAT('Descripción del tratamiento ', t.number) AS descripcion,
    ROUND(RAND() * 1000, 2) AS costo,
    DATE_ADD(CURDATE(), INTERVAL t.number DAY) AS fecha_inicio,
    DATE_ADD(CURDATE(), INTERVAL t.number + 7 DAY) AS fecha_fin,
    p.id AS paciente_id,
    m.id AS doctor_id
FROM
    (SELECT 1 AS number UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
    UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8
    UNION SELECT 9 UNION SELECT 10) AS t
CROSS JOIN
    (SELECT id
    FROM persona
    WHERE medico_cabecera_id IS NOT NULL
    ORDER BY RAND()
    LIMIT 10) AS p
CROSS JOIN
    (SELECT id
    FROM medico
    ORDER BY RAND()
    LIMIT 10) AS m;

SET FOREIGN_KEY_CHECKS = 1;