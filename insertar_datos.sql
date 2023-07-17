USE clinica;

-- Insetar Datos en algunas Tablas:
-- Inserción de datos en la tabla "especialidadmedica"
INSERT INTO especialidadmedica (nombre, subespecialidad, numero) VALUES
('Cardiología', 'Cardiología Pediátrica', 'ESP-CARD-001'),
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
('Anestesiología', NULL, 'ESP-ANEST-001'),
('Endocrinología', NULL, 'ESP-ENDO-001'),
('Ginecología', NULL, 'ESP-GINE-001'),
('Neurología', NULL, 'ESP-NEURO-001'),
('Radiología', 'Radiología Vascular e Intervencionista', 'ESP-RADIO-001'),
('Cirugía General', NULL, 'ESP-CIR-001'),
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
VALUES ('Ana', 'Gómez', 'Femenino', 35, '98765432', '1988-05-10', 'Avenida Principal 456', 'Argentina', 'anagomez@example.com', '9876543210', '123456789012', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', null, null, null);

-- Inserción de datos en la tabla "empleado"
INSERT INTO empleado (nombre, apellido, sexo, edad, dni, legajo, fecha_nacimiento, direccion, nacionalidad, email, telefono, contacto_fam, n_afiliado, puesto, fecha_ingreso, nivel_estudio, entidad_educativa, estudios_terminados, anio_egreso, localidad_id, obra_social_id)
VALUES ('Pedro', 'López', 'Masculino', 28, '87654321', 'E1234', '1995-10-15', 'Calle Principal 789', 'Argentina', 'pedrolopez@example.com', '0123456789', 'Contacto Familiar', '987654321012', 'Administrativo', '2021-01-01', 'Licenciatura en Administración', 'Universidad ABC', 'Licenciatura en Administración', '2020', null, null);



