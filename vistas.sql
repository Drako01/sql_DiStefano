-- Vistas:
-- Vista "vista_pacientes": Muestra información de los pacientes sin médico cabecera.
CREATE VIEW vista_pacientes AS
SELECT p.id, p.nombre, p.apellido, p.edad, o.denominacion AS obra_social
FROM persona p
INNER JOIN obrasocial o ON p.obra_social_id = o.id
WHERE p.medico_cabecera_id IS NULL;

-- Vista "vista_empleados": Muestra información de los empleados y su localidad.
CREATE VIEW vista_empleados AS
SELECT e.id, e.nombre, e.apellido, e.puesto, l.nombre AS localidad
FROM empleado e
INNER JOIN localidad l ON e.localidad_id = l.id; 

-- Vista "vista_turnos": Muestra información de los turnos, pacientes y médicos asociados.
CREATE VIEW vista_turnos AS
SELECT t.id, t.fecha, t.hora, t.atendido, p.nombre AS paciente, m.nombre AS medico
FROM turno t
INNER JOIN persona p ON t.paciente_id = p.id
INNER JOIN medico m ON t.doctor_id = m.id;

-- Vista "vista_consultorios_disponibles": Muestra información de los consultorios disponibles y médicos asociados.
CREATE VIEW vista_consultorios_disponibles AS
SELECT c.id, c.nombre, c.ocupado, m.nombre AS medico
FROM consultorios c
LEFT JOIN medico m ON c.medico_id = m.id
WHERE c.ocupado = 0 OR c.ocupado IS NULL;

-- Vista "vista_especialidades_medicas": Muestra información de las especialidades médicas y subespecialidades junto con la cantidad de médicos asociados a cada una.
CREATE VIEW vista_especialidades_medicas AS
SELECT em.id, em.nombre, em.subespecialidad, COUNT(m.id) AS cantidad_medicos
FROM especialidadmedica em
LEFT JOIN medico m ON em.id = m.especialidad_id
GROUP BY em.id, em.nombre, em.subespecialidad;

-- Vista "vista_pacientes_obrasociales": Muestra información de los pacientes junto con la obra social a la que pertenecen y la cantidad de pacientes asociados a cada obra social.
CREATE VIEW vista_pacientes_obrasociales AS
SELECT p.id, p.nombre, p.apellido, o.denominacion AS obra_social, COUNT(p.id) AS cantidad_pacientes
FROM persona p
INNER JOIN obrasocial o ON p.obra_social_id = o.id
GROUP BY p.id, p.nombre, p.apellido, o.denominacion;
