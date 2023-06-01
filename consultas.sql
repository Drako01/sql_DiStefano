
-- Consultas:
-- Consulta: Muestra las personas cuya edad es mayor a 30 años, ordenadas por apellido.
SELECT * FROM persona WHERE edad > 30 ORDER BY apellido;

-- Consulta: Muestra los nombres, apellidos y especialidades de los pacientes con médico cabecera.
SELECT p.nombre, p.apellido, m.especialidad_id
FROM persona p
INNER JOIN medico m ON p.medico_cabecera_id = m.id;

-- Consultacon GROUP BY:: 
SELECT especialidad_id, COUNT(*) AS cantidad_medicos
FROM medico
GROUP BY especialidad_id;

-- Consulta con JOIN:
SELECT p.nombre, m.nombre AS medico
FROM persona p
JOIN medico m ON p.medico_cabecera_id = m.id;

-- Consulta con UNION:
SELECT nombre, apellido
FROM persona
UNION
SELECT nombre, apellido
FROM medico;

-- Consulta con subconsulta:
SELECT nombre, apellido, especialidad_id 
FROM medico 
WHERE especialidad_id IN (
  SELECT id 
  FROM especialidadmedica 
  WHERE nombre = 'Cardiología'
) 
LIMIT 0, 1000;



-- Eliminar Tablas
-- Eliminar tablas usando DROP TABLE o TRUNCATE
DROP TABLE tabla_prueba;
DROP TABLE IF EXISTS tabla_inexistente;
TRUNCATE TABLE prueba_truncate;

