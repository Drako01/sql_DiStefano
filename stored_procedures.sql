USE clinica;


-- Stored procedure para ordenar una tabla:
-- Este stored procedure permite indicar el campo de ordenamiento de una tabla y si el ordenamiento debe ser ascendente (ASC) o descendente (DESC).
DELIMITER //

CREATE PROCEDURE sp_OrdenarTabla(
    IN p_tabla VARCHAR(150),
    IN p_campoOrden VARCHAR(150),
    IN p_orden VARCHAR(4)
)
BEGIN
    SET @query = CONCAT('SELECT * FROM ', p_tabla, ' ORDER BY ', p_campoOrden, ' ', p_orden, ';');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//

DELIMITER ;


-- Stored procedure para insertar y eliminar registros:
-- Este stored procedure permite insertar registros en una tabla especificada y eliminar un registro específico de la misma tabla.
DELIMITER //

CREATE PROCEDURE sp_InsertarEliminarRegistro(
    IN p_tabla VARCHAR(150),
    IN p_operacion VARCHAR(10),
    IN p_valores TEXT,
    IN p_condicion VARCHAR(150)
)
BEGIN
    IF p_operacion = 'INSERT' THEN
        SET @query = CONCAT('INSERT INTO ', p_tabla, ' VALUES (', p_valores, ');');
    ELSEIF p_operacion = 'DELETE' THEN
        SET @query = CONCAT('DELETE FROM ', p_tabla, ' WHERE ', p_condicion, ';');
    END IF;
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//

DELIMITER ;


-- Stored procedure usando extra:
-- stored procedure que busca pacientes en función de su especialidad médica.
DELIMITER //

CREATE PROCEDURE sp_BuscarPacientesPorEspecialidad(
    IN p_especialidad VARCHAR(150)
)
BEGIN
    SET @query = CONCAT('SELECT p.nombre, p.apellido
                        FROM persona p
                        JOIN medico m ON p.medico_cabecera_id = m.id
                        JOIN especialidadmedica em ON m.especialidad_id = em.id
                        WHERE em.nombre = ''', p_especialidad, ''';');
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//

DELIMITER ;


-- Stored procedure para actualizar registros:
DELIMITER //

CREATE PROCEDURE sp_ActualizarRegistro(
    IN p_tabla VARCHAR(150),
    IN p_valores TEXT,
    IN p_condicion VARCHAR(150)
)
BEGIN
    SET @query = CONCAT('UPDATE ', p_tabla, ' SET ', p_valores, ' WHERE ', p_condicion, ';');
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//

DELIMITER ;

-- Stored procedure para obtener el total de pacientes por especialidad:
-- Este stored procedure mostrará el número total de pacientes asignados a cada especialidad médica.
DELIMITER //

CREATE PROCEDURE sp_TotalPacientesPorEspecialidad()
BEGIN
    SET @query = 'SELECT em.nombre AS especialidad, COUNT(p.id) AS total_pacientes
                FROM especialidadmedica em
                LEFT JOIN medico m ON em.id = m.especialidad_id
                LEFT JOIN persona p ON m.id = p.medico_cabecera_id
                GROUP BY em.nombre;';
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//

DELIMITER ;

-- Stored procedure para calcular el costo total de tratamientos por paciente:
-- Este stored procedure calculará el costo total de todos los tratamientos realizados a un paciente específico.
DELIMITER //

CREATE PROCEDURE sp_CalcularCostoTratamientosPorPaciente(
    IN p_paciente_id INT(20)
)
BEGIN
    SET @query = CONCAT('SELECT SUM(t.costo) AS costo_total
                        FROM tratamiento t
                        WHERE t.paciente_id = ', p_paciente_id, ';');
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//

DELIMITER ;


-- Stored procedure para obtener los consultorios ocupados por un médico:
-- Este stored procedure mostrará los consultorios ocupados por un médico específico.
DELIMITER //

CREATE PROCEDURE sp_ConsultoriosOcupadosPorMedico(
    IN p_medico_id INT(20)
)
BEGIN
    SET @query = CONCAT('SELECT c.nombre AS consultorio
                        FROM consultorios c
                        WHERE c.medico_id = ', p_medico_id, ';');
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//

DELIMITER ;

