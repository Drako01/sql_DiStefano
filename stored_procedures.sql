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
