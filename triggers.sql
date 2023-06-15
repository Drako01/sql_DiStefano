USE clinica;

-- Tabla de registro de actividades para la tabla "medico":
-- Esta tabla registra las actividades realizadas en la tabla "medico". 
-- Guarda información sobre el usuario que realizó la operación, la fecha y la hora.
CREATE TABLE IF NOT EXISTS log_medico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(150) NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    accion VARCHAR(150) NOT NULL
);


-- Trigger BEFORE para la tabla "medico":
-- Este trigger registra la actividad antes de que se realice una operación en la tabla "medico". 
-- Registra el usuario que realiza la operación, la fecha y la hora actual, junto con una descripción de la acción que se realizará.
DELIMITER //

CREATE TRIGGER tr_before_medico
BEFORE INSERT ON medico
FOR EACH ROW
BEGIN
    INSERT INTO log_medico (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se va a insertar un nuevo registro en la tabla medico.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripción de la acción que se realizará.
END//

DELIMITER ;


-- Trigger AFTER para la tabla "medico":
-- Este trigger registra la actividad después de que se haya realizado una operación en la tabla "medico". 
-- Registra el usuario que realizó la operación, la fecha y la hora actual, junto con una descripción de la acción que se realizó.
DELIMITER //

CREATE TRIGGER tr_after_medico
AFTER INSERT ON medico
FOR EACH ROW
BEGIN
    INSERT INTO log_medico (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se ha insertado un nuevo registro en la tabla medico.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripción de la acción que se realizó.
END//

DELIMITER ;


-- Tabla de registro de actividades para la tabla "turno":
-- Esta tabla registra las actividades realizadas en la tabla "turno". 
-- También guarda información sobre el usuario que realizó la operación, la fecha y la hora.
CREATE TABLE IF NOT EXISTS log_turno (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(150) NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    accion VARCHAR(150) NOT NULL
);


-- Trigger BEFORE para la tabla "turno":
-- Este trigger registra la actividad antes de que se realice una operación en la tabla "turno". 
-- Registra el usuario que realiza la operación, la fecha y la hora actual, junto con una descripción de la acción que se realizará.
DELIMITER //

CREATE TRIGGER tr_before_turno
BEFORE DELETE ON turno
FOR EACH ROW
BEGIN
    INSERT INTO log_turno (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se va a eliminar un registro de la tabla turno.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripción de la acción que se realizará.
END//

DELIMITER ;


-- Trigger AFTER para la tabla "turno":
-- Este trigger registra la actividad después de que se haya realizado una operación en la tabla "turno". 
-- Registra el usuario que realizó la operación, la fecha y la hora actual, junto con una descripción de la acción que se realizó.
DELIMITER //

CREATE TRIGGER tr_after_turno
AFTER DELETE ON turno
FOR EACH ROW
BEGIN
    INSERT INTO log_turno (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se ha eliminado un registro de la tabla turno.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripción de la acción que se realizó.
END//

DELIMITER ;


