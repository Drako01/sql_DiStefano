-- Creación de la base de datos "clinica"
CREATE DATABASE IF NOT EXISTS clinica;
-- Seleccionar la base de datos "clinica"
USE clinica;

-- Creación del esquema "historia_clinica"
DROP SCHEMA IF EXISTS historia_clinica;
CREATE SCHEMA IF NOT EXISTS historia_clinica;


-- Creacion de Tablas:
-- Tabla "especialidadmedica": Almacena información sobre las especialidades médicas y subespecialidades.
CREATE TABLE IF NOT EXISTS especialidadmedica (
  id int(20) NOT NULL AUTO_INCREMENT,
  nombre varchar(150) NOT NULL,
  subespecialidad varchar(150) DEFAULT NULL,
  numero varchar(20) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY nombre (nombre),
  UNIQUE KEY numero (numero)
);

-- Tabla "localidad": Almacena información sobre las localidades.
CREATE TABLE IF NOT EXISTS localidad (
  id int(20) NOT NULL AUTO_INCREMENT,
  nombre varchar(50) NOT NULL,
  cp varchar(10) NOT NULL,
  provincia varchar(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY cp (cp)
);

-- Tabla "medico": Almacena información sobre los médicos.
CREATE TABLE IF NOT EXISTS medico (
  id int(20) NOT NULL AUTO_INCREMENT,
  nombre varchar(150) NOT NULL,
  apellido varchar(150) NOT NULL,
  dni varchar(8) NOT NULL,
  direccion varchar(150) NOT NULL,
  nacionalidad varchar(150) DEFAULT NULL,
  email varchar(254) DEFAULT NULL,
  telefono varchar(11) NOT NULL,
  matricula_prov varchar(15) NOT NULL,
  matricula_nac varchar(15) NOT NULL,
  especialidad_id int(20) DEFAULT NULL,
  localidad_id int(20) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY dni (dni),
  UNIQUE KEY matricula_prov (matricula_prov),
  UNIQUE KEY matricula_nac (matricula_nac),
  KEY med_especialidad_id_fk (especialidad_id),
  KEY med_localidad_id_fk (localidad_id),
  CONSTRAINT med_especialidad_id_fk FOREIGN KEY (especialidad_id) REFERENCES especialidadmedica (id),
  CONSTRAINT med_localidad_id_fk FOREIGN KEY (localidad_id) REFERENCES localidad (id)
);


-- Tabla "consultorios": Almacena información sobre los consultorios disponibles.
CREATE TABLE IF NOT EXISTS consultorios (
  id int(20) NOT NULL AUTO_INCREMENT,
  nombre varchar(150) NOT NULL,
  ocupado tinyint(1) NOT NULL,
  medico_id int(20) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY nombre (nombre),
  KEY consultorios_medico_id_fk (medico_id),
  CONSTRAINT consultorios_medico_id_fk FOREIGN KEY (medico_id) REFERENCES medico (id)
);


-- Tabla "obrasocial": Almacena información sobre las obras sociales.
CREATE TABLE IF NOT EXISTS obrasocial (
  id int(20) NOT NULL AUTO_INCREMENT,
  denominacion varchar(150) NOT NULL,
  sigla varchar(150) NOT NULL,
  PRIMARY KEY (id)
);

-- Tabla "persona": Almacena información sobre las personas (pacientes).
CREATE TABLE IF NOT EXISTS persona (
  id int(20) NOT NULL AUTO_INCREMENT,
  nombre varchar(150) NOT NULL,
  apellido varchar(150) NOT NULL,
  sexo varchar(50) DEFAULT NULL,
  edad int(11) DEFAULT NULL,
  dni varchar(8) NOT NULL,
  fecha_nacimiento datetime(6) NOT NULL,
  direccion varchar(150) NOT NULL,
  nacionalidad varchar(150) DEFAULT NULL,
  email varchar(254) DEFAULT NULL,
  telefono varchar(11) NOT NULL,
  n_afiliado varchar(12) NOT NULL,
  fecha_ingreso date DEFAULT NULL,
  fecha_egreso date DEFAULT NULL,
  motivo_ingreso longtext DEFAULT NULL,
  motivo_egreso longtext DEFAULT NULL,
  localidad_id int(20) DEFAULT NULL,
  medico_cabecera_id int(20) DEFAULT NULL,
  obra_social_id int(20) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY dni (dni),
  KEY per_localidad_id_fk (localidad_id),
  KEY per_medico_cabecera_id_fk (medico_cabecera_id),
  KEY per_obra_social_id_fk (obra_social_id),
  CONSTRAINT per_localidad_id_fk FOREIGN KEY (localidad_id) REFERENCES localidad (id),
  CONSTRAINT per_medico_cabecera_id_fk FOREIGN KEY (medico_cabecera_id) REFERENCES medico (id),
  CONSTRAINT per_obra_social_id_fk FOREIGN KEY (obra_social_id) REFERENCES obrasocial (id)
);

-- Tabla "turno": Almacena información sobre los turnos médicos.
CREATE TABLE IF NOT EXISTS turno (
  id int(20) NOT NULL AUTO_INCREMENT,
  fecha date NOT NULL,
  hora int(11) NOT NULL,
  atendido tinyint(1) NOT NULL,
  doctor_id int(20) NOT NULL,
  paciente_id int(20) NOT NULL,
  PRIMARY KEY (id),
  KEY turno_doctor_id_fk (doctor_id),
  KEY turno_paciente_id_fk (paciente_id),
  CONSTRAINT turno_doctor_id_fk FOREIGN KEY (doctor_id) REFERENCES medico (id),
  CONSTRAINT turno_paciente_id_fk FOREIGN KEY (paciente_id) REFERENCES persona (id)
);

-- Tabla "empleado": Almacena información sobre los empleados.
CREATE TABLE empleado (
  id INT(20) NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(150) NOT NULL,
  apellido VARCHAR(150) NOT NULL,
  sexo VARCHAR(50) DEFAULT NULL,
  edad INT(11) DEFAULT NULL,
  dni VARCHAR(8) NOT NULL,
  legajo VARCHAR(10) DEFAULT NULL,
  fecha_nacimiento DATE NOT NULL,
  direccion VARCHAR(150) NOT NULL,
  nacionalidad VARCHAR(150) DEFAULT NULL,
  email VARCHAR(254) DEFAULT NULL,
  telefono VARCHAR(11) NOT NULL,
  contacto_fam VARCHAR(150) NOT NULL,
  n_afiliado VARCHAR(12) NOT NULL,
  puesto VARCHAR(150) DEFAULT NULL,
  fecha_ingreso DATE DEFAULT NULL,
  nivel_estudio VARCHAR(150) DEFAULT NULL,
  entidad_educativa VARCHAR(150) NOT NULL,
  estudios_terminados VARCHAR(150) DEFAULT NULL,
  anio_egreso VARCHAR(4) NOT NULL,
  localidad_id INT(20) DEFAULT NULL,
  obra_social_id INT(20) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY dni (dni),
  KEY empleado_localidad_id_fk (localidad_id),
  KEY empleado_obra_social_id_fk (obra_social_id),
  CONSTRAINT empleado_localidad_id_fk FOREIGN KEY (localidad_id) REFERENCES localidad (id),
  CONSTRAINT empleado_obra_social_id_fk FOREIGN KEY (obra_social_id) REFERENCES obrasocial (id)
);

-- Tabla "vacaciones": Almacena información sobre las vacaciones de los empleados.
CREATE TABLE IF NOT EXISTS vacaciones (
  id int(20) NOT NULL AUTO_INCREMENT,
  empleado_id int(20) NOT NULL,
  fecha_inicio date NOT NULL,
  fecha_fin date NOT NULL,
  PRIMARY KEY (id),
  KEY vacaciones_empleado_id_fk (empleado_id),
  CONSTRAINT vacaciones_empleado_id_fk FOREIGN KEY (empleado_id) REFERENCES empleado (id)
);

-- Tabla "vacaciones_medico": Almacena información sobre las vacaciones de los médicos.
CREATE TABLE IF NOT EXISTS vacaciones_medico (
  id int(20) NOT NULL AUTO_INCREMENT,
  medico_id int(20) NOT NULL,
  fecha_inicio date NOT NULL,
  fecha_fin date NOT NULL,
  PRIMARY KEY (id),
  KEY vacaciones_medico_id_fk (medico_id),
  CONSTRAINT vacaciones_medico_id_fk FOREIGN KEY (medico_id) REFERENCES medico (id)
);

-- Tabla "tratamiento": Almacena información sobre los tratamientos médicos realizados a los pacientes.
CREATE TABLE IF NOT EXISTS tratamiento (
  id int(20) NOT NULL AUTO_INCREMENT,
  nombre varchar(150) NOT NULL,
  descripcion text,
  costo decimal(10, 2) NOT NULL,
  fecha_inicio date NOT NULL,
  fecha_fin date NOT NULL,
  paciente_id int(20) NOT NULL,
  doctor_id int(20) NOT NULL,
  PRIMARY KEY (id),
  KEY tratamiento_paciente_id_fk (paciente_id),
  KEY tratamiento_doctor_id_fk (doctor_id),
  CONSTRAINT tratamiento_paciente_id_fk FOREIGN KEY (paciente_id) REFERENCES persona (id),
  CONSTRAINT tratamiento_doctor_id_fk FOREIGN KEY (doctor_id) REFERENCES medico (id)
);

-- Tabla "diagnostico": Almacena información sobre los diagnósticos realizados a los pacientes.
CREATE TABLE IF NOT EXISTS diagnostico (
  id int(20) NOT NULL AUTO_INCREMENT,
  codigo varchar(20) NOT NULL,
  descripcion text,
  fecha date NOT NULL,
  paciente_id int(20) NOT NULL,
  doctor_id int(20) NOT NULL,
  PRIMARY KEY (id),
  KEY diagnostico_paciente_id_fk (paciente_id),
  KEY diagnostico_doctor_id_fk (doctor_id),
  CONSTRAINT diagnostico_paciente_id_fk FOREIGN KEY (paciente_id) REFERENCES persona (id),
  CONSTRAINT diagnostico_doctor_id_fk FOREIGN KEY (doctor_id) REFERENCES medico (id)
);

-- Tabla "tratamiento_medicamento": Relaciona los tratamientos con los medicamentos recetados en cada uno.
CREATE TABLE IF NOT EXISTS tratamiento_medicamento (
  id int(20) NOT NULL AUTO_INCREMENT,
  tratamiento_id int(20) NOT NULL,
  medicamento varchar(150) NOT NULL,
  dosis varchar(50) NOT NULL,
  PRIMARY KEY (id),
  KEY tratamiento_med_fk (tratamiento_id),
  CONSTRAINT tratamiento_med_fk FOREIGN KEY (tratamiento_id) REFERENCES tratamiento (id)
);

-- Tabla "factura": Almacena información sobre las facturas emitidas a los pacientes por los servicios prestados.
CREATE TABLE IF NOT EXISTS factura (
  id int(20) NOT NULL AUTO_INCREMENT,
  numero_factura varchar(20) NOT NULL,
  fecha_emision date NOT NULL,
  total decimal(10, 2) NOT NULL,
  paciente_id int(20) NOT NULL,
  medico_id int(20) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY numero_factura (numero_factura),
  KEY factura_paciente_id_fk (paciente_id),
  KEY factura_medico_id_fk (medico_id),
  CONSTRAINT factura_paciente_id_fk FOREIGN KEY (paciente_id) REFERENCES persona (id),
  CONSTRAINT factura_medico_id_fk FOREIGN KEY (medico_id) REFERENCES medico (id)
);