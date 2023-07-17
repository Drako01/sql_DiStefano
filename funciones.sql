USE clinica;

-- Función "calcular_edad": Calcula la edad en años a partir de la fecha de nacimiento.
DELIMITER //
CREATE FUNCTION `calcular_edad` (birth_date DATE) RETURNS INT
BEGIN
  DECLARE age INT;
  SET age = TIMESTAMPDIFF(YEAR, birth_date, CURDATE());
  RETURN age;
END//
DELIMITER ;

-- Función "calcular_promedio_edad": Calcula la edad promedio en años a partir de la fecha de nacimiento de todos los pacientes.
DELIMITER //
CREATE FUNCTION calcular_promedio_edad() RETURNS DECIMAL(10,2)
BEGIN
  DECLARE total_edad INT;
  DECLARE cantidad_pacientes INT;
  DECLARE promedio_edad DECIMAL(10,2);

  SELECT SUM(edad), COUNT(*) INTO total_edad, cantidad_pacientes
  FROM persona;

  IF cantidad_pacientes > 0 THEN
    SET promedio_edad = total_edad / cantidad_pacientes;
  ELSE
    SET promedio_edad = 0;
  END IF;

  RETURN promedio_edad;
END//
DELIMITER ;

-- Función contar_medicos_subespecialidad: Cuenta la cantidad de médicos que tienen una subespecialidad determinada.
DELIMITER //
CREATE FUNCTION contar_medicos_subespecialidad(subespecialidad_nombre VARCHAR(150)) RETURNS INT
BEGIN
  DECLARE contador INT;
  SELECT COUNT(*) INTO contador
  FROM medico m
  INNER JOIN especialidadmedica e ON m.especialidad_id = e.id
  WHERE e.subespecialidad = subespecialidad_nombre;
  
  RETURN contador;
END //
DELIMITER ;

-- Función calcular_costo_total_tratamientos_paciente: Calcula el costo total de los tratamientos realizados a un paciente.
DELIMITER //
CREATE FUNCTION calcular_costo_total_tratamientos_paciente(paciente_id INT) RETURNS DECIMAL(10, 2)
BEGIN
  DECLARE total_costo DECIMAL(10, 2);
  SELECT SUM(costo) INTO total_costo
  FROM tratamiento
  WHERE paciente_id = paciente_id;
  
  RETURN total_costo;
END //
DELIMITER ;

-- Función buscar_pacientes_por_medico: Devuelve una lista de pacientes asociados a un médico.
DELIMITER //
CREATE FUNCTION buscar_pacientes_por_medico(medico_id INT) RETURNS TEXT
BEGIN
  DECLARE lista_pacientes TEXT;
  SELECT GROUP_CONCAT(nombre, ' ', apellido) INTO lista_pacientes
  FROM persona
  WHERE medico_cabecera_id = medico_id;
  
  RETURN lista_pacientes;
END //
DELIMITER ;
