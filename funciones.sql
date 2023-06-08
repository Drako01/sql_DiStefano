USE clinica;

-- Funciones:
-- Función "calcular_edad": Calcula la edad en años a partir de la fecha de nacimiento.
DELIMITER //
CREATE FUNCTION `calcular_edad` (birth_date DATE) RETURNS INT
BEGIN
  DECLARE age INT;
  SET age = TIMESTAMPDIFF(YEAR, birth_date, CURDATE());
  RETURN age;
END//
DELIMITER ;

DELIMITER //-- Función "calcular_promedio_edad": Calcula la edad promedio en años a partir de la fecha de nacimiento de todos los pacientes.
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
