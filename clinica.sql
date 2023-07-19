-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-07-2023 a las 23:40:51
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `clinica`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarRegistro` (IN `p_tabla` VARCHAR(150), IN `p_valores` TEXT, IN `p_condicion` VARCHAR(150))   BEGIN
    SET @query = CONCAT('UPDATE ', p_tabla, ' SET ', p_valores, ' WHERE ', p_condicion, ';');
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_BuscarPacientesPorEspecialidad` (IN `p_especialidad` VARCHAR(150))   BEGIN
    SET @query = CONCAT('SELECT p.nombre, p.apellido
                        FROM persona p
                        JOIN medico m ON p.medico_cabecera_id = m.id
                        JOIN especialidadmedica em ON m.especialidad_id = em.id
                        WHERE em.nombre = ''', p_especialidad, ''';');
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CalcularCostoTratamientosPorPaciente` (IN `p_paciente_id` INT(20))   BEGIN
    SET @query = CONCAT('SELECT SUM(t.costo) AS costo_total
                        FROM tratamiento t
                        WHERE t.paciente_id = ', p_paciente_id, ';');
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultoriosOcupadosPorMedico` (IN `p_medico_id` INT(20))   BEGIN
    SET @query = CONCAT('SELECT c.nombre AS consultorio
                        FROM consultorios c
                        WHERE c.medico_id = ', p_medico_id, ';');
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarEliminarRegistro` (IN `p_tabla` VARCHAR(150), IN `p_operacion` VARCHAR(10), IN `p_valores` TEXT, IN `p_condicion` VARCHAR(150))   BEGIN
    IF p_operacion = 'INSERT' THEN
        SET @query = CONCAT('INSERT INTO ', p_tabla, ' VALUES (', p_valores, ');');
    ELSEIF p_operacion = 'DELETE' THEN
        SET @query = CONCAT('DELETE FROM ', p_tabla, ' WHERE ', p_condicion, ';');
    END IF;
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_OrdenarTabla` (IN `p_tabla` VARCHAR(150), IN `p_campoOrden` VARCHAR(150), IN `p_orden` VARCHAR(4))   BEGIN
    SET @query = CONCAT('SELECT * FROM ', p_tabla, ' ORDER BY ', p_campoOrden, ' ', p_orden, ';');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_TotalPacientesPorEspecialidad` ()   BEGIN
    SET @query = 'SELECT em.nombre AS especialidad, COUNT(p.id) AS total_pacientes
                FROM especialidadmedica em
                LEFT JOIN medico m ON em.id = m.especialidad_id
                LEFT JOIN persona p ON m.id = p.medico_cabecera_id
                GROUP BY em.nombre;';
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `buscar_pacientes_por_medico` (`medico_id` INT) RETURNS TEXT CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
  DECLARE lista_pacientes TEXT;
  SELECT GROUP_CONCAT(nombre, ' ', apellido) INTO lista_pacientes
  FROM persona
  WHERE medico_cabecera_id = medico_id;
  
  RETURN lista_pacientes;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_costo_total_tratamientos_paciente` (`paciente_id` INT) RETURNS DECIMAL(10,2)  BEGIN
  DECLARE total_costo DECIMAL(10, 2);
  SELECT SUM(costo) INTO total_costo
  FROM tratamiento
  WHERE paciente_id = paciente_id;
  
  RETURN total_costo;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_edad` (`birth_date` DATE) RETURNS INT(11)  BEGIN
  DECLARE age INT;
  SET age = TIMESTAMPDIFF(YEAR, birth_date, CURDATE());
  RETURN age;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_promedio_edad` () RETURNS DECIMAL(10,2)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `contar_medicos_subespecialidad` (`subespecialidad_nombre` VARCHAR(150)) RETURNS INT(11)  BEGIN
  DECLARE contador INT;
  SELECT COUNT(*) INTO contador
  FROM medico m
  INNER JOIN especialidadmedica e ON m.especialidad_id = e.id
  WHERE e.subespecialidad = subespecialidad_nombre;
  
  RETURN contador;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultorios`
--

CREATE TABLE `consultorios` (
  `id` int(20) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `ocupado` tinyint(1) NOT NULL,
  `medico_id` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `consultorios`
--

INSERT INTO `consultorios` (`id`, `nombre`, `ocupado`, `medico_id`) VALUES
(1, 'Consultorio 1', 0, 1),
(2, 'Consultorio 2', 0, 2),
(3, 'Consultorio 3', 1, 3),
(4, 'Consultorio 4', 1, 4),
(5, 'Consultorio 5', 1, 5),
(6, 'Consultorio 6', 1, 6),
(7, 'Consultorio 7', 0, 7),
(8, 'Consultorio 8', 1, 8),
(9, 'Consultorio 9', 0, 9),
(10, 'Consultorio 10', 1, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `diagnostico`
--

CREATE TABLE `diagnostico` (
  `id` int(20) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha` date NOT NULL,
  `paciente_id` int(20) NOT NULL,
  `doctor_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id` int(20) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `apellido` varchar(150) NOT NULL,
  `sexo` varchar(50) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `dni` varchar(8) NOT NULL,
  `legajo` varchar(10) DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `direccion` varchar(150) NOT NULL,
  `nacionalidad` varchar(150) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `telefono` varchar(11) NOT NULL,
  `contacto_fam` varchar(150) NOT NULL,
  `n_afiliado` varchar(12) NOT NULL,
  `puesto` varchar(150) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `nivel_estudio` varchar(150) DEFAULT NULL,
  `entidad_educativa` varchar(150) NOT NULL,
  `estudios_terminados` varchar(150) DEFAULT NULL,
  `anio_egreso` varchar(4) NOT NULL,
  `localidad_id` int(20) DEFAULT NULL,
  `obra_social_id` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id`, `nombre`, `apellido`, `sexo`, `edad`, `dni`, `legajo`, `fecha_nacimiento`, `direccion`, `nacionalidad`, `email`, `telefono`, `contacto_fam`, `n_afiliado`, `puesto`, `fecha_ingreso`, `nivel_estudio`, `entidad_educativa`, `estudios_terminados`, `anio_egreso`, `localidad_id`, `obra_social_id`) VALUES
(1, 'Pedro', 'López', 'Masculino', 28, '87659921', 'E1234', '1995-10-15', 'Calle Principal 789', 'Argentina', 'pedrolopez@example.com', '0123456789', 'Contacto Familiar', '987654321012', 'Administrativo', '2021-01-01', 'Licenciatura en Administración', 'Universidad ABC', 'Licenciatura en Administración', '2020', 3, 1),
(2, 'Ana', 'Fernández', 'Femenino', 25, '34567890', 'E3456', '1998-09-05', 'Avenida Principal 456', 'Argentina', 'anafernandez@example.com', '1234567890', 'Contacto Familiar', '345678901234', 'Operario', '2021-04-01', 'Técnico en Informática', 'Instituto XYZ', 'Técnico en Informática', '2019', 23, 1),
(3, 'Carlos', 'López', 'Masculino', 35, '45678901', 'E7890', '1986-12-15', 'Calle Secundaria 789', 'Argentina', 'carloslopez@example.com', '0987654321', 'Contacto Familiar', '456789012345', 'Administrativo', '2021-05-01', 'Licenciatura en Economía', 'Universidad ABC', 'Licenciatura en Economía', '2017', 12, 2),
(4, 'Laura', 'Martínez', 'Femenino', 29, '56789012', 'E1235', '1992-03-25', 'Avenida Principal 789', 'Argentina', 'lauramartinez@example.com', '6789012345', 'Contacto Familiar', '567890123456', 'Operario', '2021-06-01', 'Técnico en Mecánica', 'Instituto XYZ', 'Técnico en Mecánica', '2018', 11, 3),
(5, 'Mario', 'García', 'Masculino', 33, '67890123', 'E5679', '1988-08-10', 'Calle Secundaria 123', 'Argentina', 'mariogarcia@example.com', '3456789012', 'Contacto Familiar', '678901234567', 'Administrativo', '2021-07-01', 'Licenciatura en Marketing', 'Universidad ABC', 'Licenciatura en Marketing', '2016', 5, 4),
(6, 'Sofía', 'Rodríguez', 'Femenino', 26, '78901234', 'E9013', '1995-05-15', 'Avenida Principal 456', 'Argentina', 'sofiarodriguez@example.com', '8901234567', 'Contacto Familiar', '789012345678', 'Operario', '2021-08-01', 'Técnico en Diseño Gráfico', 'Instituto XYZ', 'Técnico en Diseño Gráfico', '2019', 1, 5),
(7, 'Fernando', 'López', 'Masculino', 31, '89012345', 'E1236', '1990-02-20', 'Calle Secundaria 789', 'Argentina', 'fernandolopez@example.com', '9012345678', 'Contacto Familiar', '890123456789', 'Administrativo', '2021-09-01', 'Licenciatura en Comunicación', 'Universidad ABC', 'Licenciatura en Comunicación', '2017', 1, 5),
(8, 'Ana', 'Gómez', 'Femenino', 27, '90123456', 'E5671', '1996-09-25', 'Avenida Principal 123', 'Argentina', 'anagomez@example.com', '0123456789', 'Contacto Familiar', '901234567890', 'Operario', '2021-10-01', 'Técnico en Contabilidad', 'Instituto XYZ', 'Técnico en Contabilidad', '2018', 2, 5),
(9, 'Gabriel', 'Pérez', 'Masculino', 29, '01234567', 'E9014', '1992-06-30', 'Calle Secundaria 456', 'Argentina', 'gabrielperez@example.com', '1234567890', 'Contacto Familiar', '012345678901', 'Administrativo', '2021-11-01', 'Licenciatura en Recursos Humanos', 'Universidad ABC', 'Licenciatura en Recursos Humanos', '2020', 4, 4),
(10, 'María', 'González', 'Femenino', 32, '98765432', 'E1237', '1989-03-05', 'Avenida Principal 789', 'Argentina', 'mariagonzalez@example.com', '2345678901', 'Contacto Familiar', '987654321098', 'Operario', '2021-12-01', 'Técnico en Electricidad', 'Instituto XYZ', 'Técnico en Electricidad', '2017', 6, 5),
(11, 'Carlos', 'López', 'Masculino', 28, '87654321', 'E9015', '1993-10-10', 'Calle Secundaria 123', 'Argentina', 'carloslopez@example.com', '3456789012', 'Contacto Familiar', '876543210987', 'Administrativo', '2022-01-01', 'Licenciatura en Ingeniería Civil', 'Universidad ABC', 'Licenciatura en Ingeniería Civil', '2019', 7, 7),
(12, 'Laura', 'Martínez', 'Femenino', 30, '76543210', 'E1238', '1991-07-15', 'Avenida Principal 456', 'Argentina', 'lauramartinez@example.com', '4567890123', 'Contacto Familiar', '765432109876', 'Operario', '2022-02-01', 'Técnico en Programación', 'Instituto XYZ', 'Técnico en Programación', '2018', 5, 8),
(13, 'Mario', 'García', 'Masculino', 33, '65432109', 'E9016', '1989-04-20', 'Calle Secundaria 789', 'Argentina', 'mariogarcia@example.com', '5678901234', 'Contacto Familiar', '654321098765', 'Administrativo', '2022-03-01', 'Licenciatura en Psicología', 'Universidad ABC', 'Licenciatura en Psicología', '2016', 2, 8),
(14, 'Sofía', 'Rodríguez', 'Femenino', 26, '54321098', 'E1239', '1996-11-25', 'Avenida Principal 123', 'Argentina', 'sofiarodriguez@example.com', '6789012345', 'Contacto Familiar', '543210987654', 'Operario', '2022-04-01', 'Técnico en Enfermería', 'Instituto XYZ', 'Técnico en Enfermería', '2019', 12, 6),
(15, 'Fernando', 'López', 'Masculino', 31, '43210987', 'E9010', '1991-08-30', 'Calle Secundaria 456', 'Argentina', 'fernandolopez@example.com', '7890123456', 'Contacto Familiar', '432109876543', 'Administrativo', '2022-05-01', 'Licenciatura en Derecho', 'Universidad ABC', 'Licenciatura en Derecho', '2017', 14, 5),
(16, 'Ana', 'Gómez', 'Femenino', 27, '32109876', 'E9011', '1996-05-05', 'Avenida Principal 789', 'Argentina', 'anagomez@example.com', '8901234567', 'Contacto Familiar', '321098765432', 'Operario', '2022-06-01', 'Técnico en Marketing Digital', 'Instituto XYZ', 'Técnico en Marketing Digital', '2018', 15, 12),
(17, 'Juan', 'Pérez', 'Masculino', 32, '12345678', 'E5678', '1990-05-20', 'Avenida Principal 123', 'Argentina', 'juanperez@example.com', '9876543210', 'Contacto Familiar', '123456789012', 'Operario', '2021-02-01', 'Técnico en Electrónica', 'Instituto XYZ', 'Técnico en Electrónica', '2018', 12, 3),
(18, 'María', 'González', 'Femenino', 30, '23456789', 'E9012', '1991-07-12', 'Calle Secundaria 456', 'Argentina', 'mariagonzalez@example.com', '0123456789', 'Contacto Familiar', '234567890123', 'Administrativo', '2021-03-01', 'Licenciatura en Administración', 'Universidad ABC', 'Licenciatura en Administración', '2020', 1, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidadmedica`
--

CREATE TABLE `especialidadmedica` (
  `id` int(20) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `subespecialidad` varchar(150) DEFAULT NULL,
  `numero` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidadmedica`
--

INSERT INTO `especialidadmedica` (`id`, `nombre`, `subespecialidad`, `numero`) VALUES
(1, 'Cardiología', 'Cardiología Pediátrica', 'ESP-CARD-001'),
(2, 'Dermatología', 'Cirugía Dermatológica', 'ESP-DERM-001'),
(3, 'Gastroenterología', 'Endoscopia Digestiva', 'ESP-GASTRO-001'),
(4, 'Hematología', 'Hemato-Oncología', 'ESP-HEMA-001'),
(5, 'Nefrología', 'Nefrología Pediátrica', 'ESP-NEFRO-001'),
(6, 'Neumología', 'Neumología Intervencionista', 'ESP-NEUMO-001'),
(7, 'Oftalmología', 'Oftalmología Pediátrica', 'ESP-OFTAL-001'),
(8, 'Oncología', 'Oncología Médica', 'ESP-ONCO-001'),
(9, 'Otorrinolaringología', 'Otorrinolaringología Pediátrica', 'ESP-OTORRINO-001'),
(10, 'Pediatría', 'Neonatología', 'ESP-PEDIA-001'),
(11, 'Psiquiatría', 'Psiquiatría Forense', 'ESP-PSIQ-001'),
(12, 'Reumatología', 'Reumatología Pediátrica', 'ESP-REUMA-001'),
(13, 'Traumatología', 'Traumatología Deportiva', 'ESP-TRAUMA-001'),
(14, 'Urología', 'Urología Oncológica', 'ESP-UROLO-001'),
(15, 'Anestesiología', NULL, 'ESP-ANEST-001'),
(16, 'Endocrinología', NULL, 'ESP-ENDO-001'),
(17, 'Ginecología', NULL, 'ESP-GINE-001'),
(18, 'Neurología', NULL, 'ESP-NEURO-001'),
(19, 'Radiología', 'Radiología Vascular e Intervencionista', 'ESP-RADIO-001'),
(20, 'Cirugía General', NULL, 'ESP-CIR-001'),
(21, 'Geriatria', 'Geriatria Oncologica', 'ESP-GERIA-001'),
(22, 'Infectologia', 'Infectologia Pediatrica', 'ESP-INFEC-001');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id` int(20) NOT NULL,
  `numero_factura` varchar(20) NOT NULL,
  `fecha_emision` date NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `paciente_id` int(20) NOT NULL,
  `medico_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidad`
--

CREATE TABLE `localidad` (
  `id` int(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `cp` varchar(10) NOT NULL,
  `provincia` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `localidad`
--

INSERT INTO `localidad` (`id`, `nombre`, `cp`, `provincia`) VALUES
(1, 'La Plata', '1900', 'Buenos Aires'),
(2, 'Quilmes', '1878', 'Buenos Aires'),
(3, 'Avellaneda', '1870', 'Buenos Aires'),
(4, 'Lanús', '1824', 'Buenos Aires'),
(5, 'Banfield', '1828', 'Buenos Aires'),
(6, 'Berazategui', '1884', 'Buenos Aires'),
(7, 'Florencio Varela', '1888', 'Buenos Aires'),
(8, 'San Justo', '1754', 'Buenos Aires'),
(9, 'Morón', '1708', 'Buenos Aires'),
(10, 'Ituzaingó', '1714', 'Buenos Aires'),
(11, 'San Fernando', '1646', 'Buenos Aires'),
(12, 'Tigre', '1648', 'Buenos Aires'),
(13, 'Pilar', '1629', 'Buenos Aires'),
(14, 'Escobar', '1625', 'Buenos Aires'),
(15, 'San Miguel', '1663', 'Buenos Aires'),
(16, 'San Isidro', '1642', 'Buenos Aires'),
(17, 'Vicente López', '1638', 'Buenos Aires'),
(18, 'Merlo', '1722', 'Buenos Aires'),
(19, 'Ezeiza', '1804', 'Buenos Aires'),
(20, 'Adrogué', '1846', 'Buenos Aires'),
(21, 'Burzaco', '1852', 'Buenos Aires'),
(22, 'General Pacheco', '1617', 'Buenos Aires'),
(23, 'Martínez', '1640', 'Buenos Aires'),
(24, 'Bernal', '1876', 'Buenos Aires'),
(25, 'Ramos Mejía', '1704', 'Buenos Aires'),
(26, 'Don Torcuato', '1611', 'Buenos Aires'),
(27, 'Temperley', '1834', 'Buenos Aires'),
(28, 'Caseros', '1678', 'Buenos Aires'),
(29, 'José C. Paz', '1665', 'Buenos Aires'),
(30, 'San Vicente', '1865', 'Buenos Aires');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_medico`
--

CREATE TABLE `log_medico` (
  `id` int(11) NOT NULL,
  `usuario` varchar(150) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `accion` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_turno`
--

CREATE TABLE `log_turno` (
  `id` int(11) NOT NULL,
  `usuario` varchar(150) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `accion` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medico`
--

CREATE TABLE `medico` (
  `id` int(20) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `apellido` varchar(150) NOT NULL,
  `dni` varchar(8) NOT NULL,
  `direccion` varchar(150) NOT NULL,
  `nacionalidad` varchar(150) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `telefono` varchar(11) NOT NULL,
  `matricula_prov` varchar(15) NOT NULL,
  `matricula_nac` varchar(15) NOT NULL,
  `especialidad_id` int(20) DEFAULT NULL,
  `localidad_id` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medico`
--

INSERT INTO `medico` (`id`, `nombre`, `apellido`, `dni`, `direccion`, `nacionalidad`, `email`, `telefono`, `matricula_prov`, `matricula_nac`, `especialidad_id`, `localidad_id`) VALUES
(1, 'Médico 1', 'Apellido 1', '12345678', 'Calle Principal 1', 'Argentina', 'medico1@example.com', '1234567890', 'MP123456', 'MN123456', 1, 22),
(2, 'Médico 2', 'Apellido 2', '23456789', 'Calle Principal 2', 'Argentina', 'medico2@example.com', '2345678901', 'MP234567', 'MN234567', 2, 10),
(3, 'Médico 3', 'Apellido 3', '34567890', 'Calle Principal 3', 'Argentina', 'medico3@example.com', '3456789012', 'MP345678', 'MN345678', 3, 4),
(4, 'Médico 4', 'Apellido 4', '45678901', 'Calle Principal 4', 'Argentina', 'medico4@example.com', '4567890123', 'MP456789', 'MN456789', 4, 4),
(5, 'Médico 5', 'Apellido 5', '56789012', 'Calle Principal 5', 'Argentina', 'medico5@example.com', '5678901234', 'MP567890', 'MN567890', 5, 3),
(6, 'Médico 6', 'Apellido 6', '67890123', 'Calle Principal 6', 'Argentina', 'medico6@example.com', '6789012345', 'MP678901', 'MN678901', 6, 2),
(7, 'Médico 7', 'Apellido 7', '78901234', 'Calle Principal 7', 'Argentina', 'medico7@example.com', '7890123456', 'MP789012', 'MN789012', 18, 12),
(8, 'Médico 8', 'Apellido 8', '89012345', 'Calle Principal 8', 'Argentina', 'medico8@example.com', '8901234567', 'MP890123', 'MN890123', 12, 15),
(9, 'Médico 9', 'Apellido 9', '90123456', 'Calle Principal 9', 'Argentina', 'medico9@example.com', '9012345678', 'MP901234', 'MN901234', 4, 18),
(10, 'Médico 10', 'Apellido 10', '01234567', 'Calle Principal 10', 'Argentina', 'medico10@example.com', '0123456789', 'MP012345', 'MN012345', 18, 15),
(11, 'Pedro', 'Gómez', '11111111', 'Calle 1', 'Argentina', 'pedro@mimail.com', '1111111111', 'MP-1111', 'MN-1111', 1, 1),
(12, 'Laura', 'Fernández', '22222222', 'Avenida 2', 'Argentina', 'laura@mimail.com', '2222222222', 'MP-2222', 'MN-2222', 2, 2),
(13, 'Roberto', 'Sánchez', '33333333', 'Ruta 3', 'Argentina', 'roberto@mimail.com', '3333333333', 'MP-3333', 'MN-3333', 1, 3),
(14, 'Marcela', 'González', '44444444', 'Calle 4', 'Argentina', 'marcela@mimail.com', '4444444444', 'MP-4444', 'MN-4444', 2, 4),
(15, 'Alejandro', 'López', '55555555', 'Avenida 5', 'Argentina', 'alejandro@mimail.com', '5555555555', 'MP-5555', 'MN-5555', 1, 5),
(16, 'Carolina', 'Martínez', '66666666', 'Ruta 6', 'Argentina', 'carolina@mimail.com', '6666666666', 'MP-6666', 'MN-6666', 2, 1),
(17, 'Sergio', 'Hernández', '77777777', 'Calle 7', 'Argentina', 'sergio@mimail.com', '7777777777', 'MP-7777', 'MN-7777', 1, 2),
(18, 'María', 'López', '88888888', 'Avenida 8', 'Argentina', 'maria@mimail.com', '8888888888', 'MP-8888', 'MN-8888', 2, 3);

--
-- Disparadores `medico`
--
DELIMITER $$
CREATE TRIGGER `tr_after_medico` AFTER INSERT ON `medico` FOR EACH ROW BEGIN
    INSERT INTO log_medico (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se ha insertado un nuevo registro en la tabla medico.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripción de la acción que se realizó.
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_before_medico` BEFORE INSERT ON `medico` FOR EACH ROW BEGIN
    INSERT INTO log_medico (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se va a insertar un nuevo registro en la tabla medico.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripción de la acción que se realizará.
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `obrasocial`
--

CREATE TABLE `obrasocial` (
  `id` int(20) NOT NULL,
  `denominacion` varchar(150) NOT NULL,
  `sigla` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `obrasocial`
--

INSERT INTO `obrasocial` (`id`, `denominacion`, `sigla`) VALUES
(1, 'Obra Social del Trabajador', 'OST'),
(2, 'Salud Segura', 'SSA'),
(3, 'Cobertura Médica Integral', 'CMI'),
(4, 'Seguro de Salud Argentino', 'SSA'),
(5, 'Asistencia Médica Previsional', 'AMP'),
(6, 'Salud Protegida', 'SP'),
(7, 'Asistencia Integral Médica', 'AIM'),
(8, 'Cuidado Saludable', 'CS'),
(9, 'Protección Médica', 'PM'),
(10, 'Asistencia Sanitaria Nacional', 'ASN'),
(11, 'Cobertura de Salud Integral', 'CSI'),
(12, 'Seguridad Médica', 'SM'),
(13, 'Bienestar Médico', 'BM'),
(14, 'Salud Comunitaria', 'SC'),
(15, 'Cobertura Médica Nacional', 'CMN'),
(16, 'Asistencia Social Saludable', 'ASS'),
(17, 'Seguro Médico Argentino', 'SMA'),
(18, 'Asistencia Médica Nacional', 'AMN'),
(19, 'Protección Sanitaria', 'PS'),
(20, 'Cobertura de Salud Familiar', 'CSF');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `id` int(20) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `apellido` varchar(150) NOT NULL,
  `sexo` varchar(50) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `dni` varchar(8) NOT NULL,
  `fecha_nacimiento` datetime(6) NOT NULL,
  `direccion` varchar(150) NOT NULL,
  `nacionalidad` varchar(150) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `telefono` varchar(11) NOT NULL,
  `n_afiliado` varchar(12) NOT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `fecha_egreso` date DEFAULT NULL,
  `motivo_ingreso` longtext DEFAULT NULL,
  `motivo_egreso` longtext DEFAULT NULL,
  `localidad_id` int(20) DEFAULT NULL,
  `medico_cabecera_id` int(20) DEFAULT NULL,
  `obra_social_id` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id`, `nombre`, `apellido`, `sexo`, `edad`, `dni`, `fecha_nacimiento`, `direccion`, `nacionalidad`, `email`, `telefono`, `n_afiliado`, `fecha_ingreso`, `fecha_egreso`, `motivo_ingreso`, `motivo_egreso`, `localidad_id`, `medico_cabecera_id`, `obra_social_id`) VALUES
(5, 'Laura', 'López', 'F', 25, '21098765', '1997-03-25 00:00:00.000000', 'Avenida D, #987', 'Argentina', 'laura.lopez@example.com', '5544332211', 'D554433221', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 4, 6, 1),
(6, 'Pedro', 'Hernández', 'M', 50, '54321678', '1973-06-30 00:00:00.000000', 'Calle E, #654', 'Argentina', 'pedro.hernandez@example.com', '6677889900', 'E667788990', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 5, 6, 7),
(7, 'Ana', 'Torres', 'F', 28, '87659321', '1995-11-05 00:00:00.000000', 'Avenida F, #321', 'Argentina', 'ana.torres@example.com', '9988776655', 'F998877665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 4, 1, 3),
(8, 'Luis', 'García', 'M', 33, '23456789', '1989-02-15 00:00:00.000000', 'Calle G, #654', 'Argentina', 'luis.garcia@example.com', '5544667788', 'G554466778', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 6, 3, 2),
(9, 'Sofía', 'Martínez', 'F', 42, '95555432', '1981-09-10 00:00:00.000000', 'Avenida H, #321', 'Argentina', 'sofia.martinez@example.com', '7788996655', 'H778899665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 5, 2, 6),
(10, 'Andrés', 'Jiménez', 'M', 38, '67890123', '1985-07-20 00:00:00.000000', 'Calle I, #987', 'Argentina', 'andres.jimenez@example.com', '4433221188', 'I443322118', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 22, 3, 5),
(11, 'Fernanda', 'Díaz', 'F', 23, '34567890', '1999-04-05 00:00:00.000000', 'Avenida J, #654', 'Argentina', 'fernanda.diaz@example.com', '9988776655', 'J998877665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 2, 2, 2),
(12, 'Roberto', 'Sánchez', 'M', 31, '09876543', '1992-01-15 00:00:00.000000', 'Calle K, #123', 'Argentina', 'roberto.sanchez@example.com', '6655443322', 'K665544332', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 5, 5, 6),
(13, 'Mariana', 'Ramírez', 'F', 37, '53789012', '1986-10-20 00:00:00.000000', 'Avenida L, #456', 'Argentina', 'mariana.ramirez@example.com', '4433221188', 'L443322118', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 6, 3, 3),
(14, 'José', 'Reyes', 'M', 45, '87159321', '1978-07-25 00:00:00.000000', 'Calle M, #789', 'Argentina', 'jose.reyes@example.com', '8899776655', 'M889977665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 6, 4, 3),
(15, 'Gabriela', 'Fernández', 'F', 26, '43210987', '1997-02-28 00:00:00.000000', 'Avenida N, #987', 'Argentina', 'gabriela.fernandez@example.com', '4455667788', 'N445566778', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 4, 6, 7),
(16, 'Daniel', 'Chávez', 'M', 32, '10987654', '1991-09-10 00:00:00.000000', 'Calle O, #654', 'Argentina', 'daniel.chavez@example.com', '9988776655', 'O998877665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 3, 3, 3),
(17, 'Valentina', 'Rojas', 'F', 24, '56789012', '1999-06-15 00:00:00.000000', 'Avenida P, #321', 'Argentina', 'valentina.rojas@example.com', '5544332211', 'P554433221', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 1, 3, 3),
(18, 'Javier', 'Gutiérrez', 'M', 39, '32109876', '1984-03-20 00:00:00.000000', 'Calle Q, #987', 'Argentina', 'javier.gutierrez@example.com', '6677889900', 'Q667788990', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 1, 3, 6),
(19, 'Paola', 'Ortega', 'F', 29, '89012345', '1994-12-25 00:00:00.000000', 'Avenida R, #654', 'Argentina', 'paola.ortega@example.com', '9988776655', 'R998877665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 6, 7, 8),
(20, 'Eduardo', 'Navarro', 'M', 27, '65432109', '1996-09-30 00:00:00.000000', 'Calle S, #321', 'Argentina', 'eduardo.navarro@example.com', '7788996655', 'S778899665', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 9, 9, 9),
(21, 'Natalia', 'Vargas', 'F', 22, '01234567', '2001-04-05 00:00:00.000000', 'Avenida T, #987', 'Argentina', 'natalia.vargas@example.com', '5544667788', 'T554466778', '2022-01-01', '2022-02-28', 'Motivo de ingreso', 'Motivo de egreso', 6, 4, 6),
(32, 'Juan', 'Pérez', 'M', 30, '12366678', '1993-05-15 00:00:00.000000', 'Calle 123', 'Argentina', 'juan@mimail.com', '1234567890', '000001', '2021-01-01', NULL, NULL, NULL, 1, 1, 1),
(33, 'María', 'López', 'F', 28, '98665432', '1995-09-20 00:00:00.000000', 'Avenida 456', 'Argentina', 'maria@mimail.com', '0987654321', '000002', '2021-02-01', NULL, NULL, NULL, 2, 2, 1),
(34, 'Carlos', 'García', 'M', 35, '23116789', '1988-07-10 00:00:00.000000', 'Ruta 789', 'Argentina', 'carlos@mimail.com', '5678901234', '000003', '2021-03-01', NULL, NULL, NULL, 3, 3, 2),
(35, 'Ana', 'Rodríguez', 'F', 40, '87654321', '1983-12-05 00:00:00.000000', 'Calle Principal', 'Argentina', 'ana@mimail.com', '4321098765', '000004', '2021-04-01', NULL, NULL, NULL, 4, 4, 2),
(36, 'Luis', 'Martínez', 'M', 45, '34117890', '1978-11-18 00:00:00.000000', 'Avenida Central', 'Argentina', 'luis@mimail.com', '9012345678', '000005', '2021-05-01', NULL, NULL, NULL, 5, 5, 3);

--
-- Disparadores `persona`
--
DELIMITER $$
CREATE TRIGGER `tr_before_persona` BEFORE INSERT ON `persona` FOR EACH ROW BEGIN
    INSERT INTO log_persona (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se va a insertar un nuevo registro en la tabla persona.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripción de la acción que se realizará.
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_before_update_persona` BEFORE UPDATE ON `persona` FOR EACH ROW BEGIN
    INSERT INTO log_persona (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se va a actualizar un registro en la tabla persona.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripción de la acción que se realizará.
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamiento`
--

CREATE TABLE `tratamiento` (
  `id` int(20) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `costo` decimal(10,2) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `paciente_id` int(20) NOT NULL,
  `doctor_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tratamiento`
--

INSERT INTO `tratamiento` (`id`, `nombre`, `descripcion`, `costo`, `fecha_inicio`, `fecha_fin`, `paciente_id`, `doctor_id`) VALUES
(1, 'Tratamiento 1', 'Descripción del tratamiento 1', 997.10, '2023-07-20', '2023-07-27', 2, 1),
(2, 'Tratamiento 2', 'Descripción del tratamiento 2', 574.94, '2023-07-21', '2023-07-28', 2, 1),
(3, 'Tratamiento 3', 'Descripción del tratamiento 3', 883.39, '2023-07-22', '2023-07-29', 2, 1),
(4, 'Tratamiento 4', 'Descripción del tratamiento 4', 692.14, '2023-07-23', '2023-07-30', 2, 1),
(5, 'Tratamiento 5', 'Descripción del tratamiento 5', 810.51, '2023-07-24', '2023-07-31', 2, 1),
(6, 'Tratamiento 6', 'Descripción del tratamiento 6', 976.15, '2023-07-25', '2023-08-01', 2, 1),
(7, 'Tratamiento 7', 'Descripción del tratamiento 7', 449.21, '2023-07-26', '2023-08-02', 2, 1),
(8, 'Tratamiento 8', 'Descripción del tratamiento 8', 317.62, '2023-07-27', '2023-08-03', 2, 1),
(9, 'Tratamiento 9', 'Descripción del tratamiento 9', 240.46, '2023-07-28', '2023-08-04', 2, 1),
(10, 'Tratamiento 10', 'Descripción del tratamiento 10', 249.43, '2023-07-29', '2023-08-05', 2, 1),
(11, 'Tratamiento 1', 'Descripción del tratamiento 1', 525.76, '2023-07-20', '2023-07-27', 3, 1),
(12, 'Tratamiento 2', 'Descripción del tratamiento 2', 880.51, '2023-07-21', '2023-07-28', 3, 1),
(13, 'Tratamiento 3', 'Descripción del tratamiento 3', 825.28, '2023-07-22', '2023-07-29', 3, 1),
(14, 'Tratamiento 4', 'Descripción del tratamiento 4', 484.85, '2023-07-23', '2023-07-30', 3, 1),
(15, 'Tratamiento 5', 'Descripción del tratamiento 5', 948.44, '2023-07-24', '2023-07-31', 3, 1),
(16, 'Tratamiento 6', 'Descripción del tratamiento 6', 287.63, '2023-07-25', '2023-08-01', 3, 1),
(17, 'Tratamiento 7', 'Descripción del tratamiento 7', 592.81, '2023-07-26', '2023-08-02', 3, 1),
(18, 'Tratamiento 8', 'Descripción del tratamiento 8', 101.20, '2023-07-27', '2023-08-03', 3, 1),
(19, 'Tratamiento 9', 'Descripción del tratamiento 9', 727.55, '2023-07-28', '2023-08-04', 3, 1),
(20, 'Tratamiento 10', 'Descripción del tratamiento 10', 334.15, '2023-07-29', '2023-08-05', 3, 1),
(21, 'Tratamiento 1', 'Descripción del tratamiento 1', 488.10, '2023-07-20', '2023-07-27', 13, 1),
(22, 'Tratamiento 2', 'Descripción del tratamiento 2', 438.03, '2023-07-21', '2023-07-28', 13, 1),
(23, 'Tratamiento 3', 'Descripción del tratamiento 3', 725.87, '2023-07-22', '2023-07-29', 13, 1),
(24, 'Tratamiento 4', 'Descripción del tratamiento 4', 315.25, '2023-07-23', '2023-07-30', 13, 1),
(25, 'Tratamiento 5', 'Descripción del tratamiento 5', 398.65, '2023-07-24', '2023-07-31', 13, 1),
(26, 'Tratamiento 6', 'Descripción del tratamiento 6', 47.51, '2023-07-25', '2023-08-01', 13, 1),
(27, 'Tratamiento 7', 'Descripción del tratamiento 7', 41.60, '2023-07-26', '2023-08-02', 13, 1),
(28, 'Tratamiento 8', 'Descripción del tratamiento 8', 65.46, '2023-07-27', '2023-08-03', 13, 1),
(29, 'Tratamiento 9', 'Descripción del tratamiento 9', 202.51, '2023-07-28', '2023-08-04', 13, 1),
(30, 'Tratamiento 10', 'Descripción del tratamiento 10', 816.18, '2023-07-29', '2023-08-05', 13, 1),
(31, 'Tratamiento 1', 'Descripción del tratamiento 1', 473.36, '2023-07-20', '2023-07-27', 10, 1),
(32, 'Tratamiento 2', 'Descripción del tratamiento 2', 918.25, '2023-07-21', '2023-07-28', 10, 1),
(33, 'Tratamiento 3', 'Descripción del tratamiento 3', 171.17, '2023-07-22', '2023-07-29', 10, 1),
(34, 'Tratamiento 4', 'Descripción del tratamiento 4', 101.10, '2023-07-23', '2023-07-30', 10, 1),
(35, 'Tratamiento 5', 'Descripción del tratamiento 5', 991.99, '2023-07-24', '2023-07-31', 10, 1),
(36, 'Tratamiento 6', 'Descripción del tratamiento 6', 656.67, '2023-07-25', '2023-08-01', 10, 1),
(37, 'Tratamiento 7', 'Descripción del tratamiento 7', 307.37, '2023-07-26', '2023-08-02', 10, 1),
(38, 'Tratamiento 8', 'Descripción del tratamiento 8', 566.83, '2023-07-27', '2023-08-03', 10, 1),
(39, 'Tratamiento 9', 'Descripción del tratamiento 9', 912.03, '2023-07-28', '2023-08-04', 10, 1),
(40, 'Tratamiento 10', 'Descripción del tratamiento 10', 859.65, '2023-07-29', '2023-08-05', 10, 1),
(41, 'Tratamiento 1', 'Descripción del tratamiento 1', 562.19, '2023-07-20', '2023-07-27', 17, 1),
(42, 'Tratamiento 2', 'Descripción del tratamiento 2', 231.99, '2023-07-21', '2023-07-28', 17, 1),
(43, 'Tratamiento 3', 'Descripción del tratamiento 3', 473.38, '2023-07-22', '2023-07-29', 17, 1),
(44, 'Tratamiento 4', 'Descripción del tratamiento 4', 670.91, '2023-07-23', '2023-07-30', 17, 1),
(45, 'Tratamiento 5', 'Descripción del tratamiento 5', 934.44, '2023-07-24', '2023-07-31', 17, 1),
(46, 'Tratamiento 6', 'Descripción del tratamiento 6', 659.47, '2023-07-25', '2023-08-01', 17, 1),
(47, 'Tratamiento 7', 'Descripción del tratamiento 7', 494.02, '2023-07-26', '2023-08-02', 17, 1),
(48, 'Tratamiento 8', 'Descripción del tratamiento 8', 491.69, '2023-07-27', '2023-08-03', 17, 1),
(49, 'Tratamiento 9', 'Descripción del tratamiento 9', 976.40, '2023-07-28', '2023-08-04', 17, 1),
(50, 'Tratamiento 10', 'Descripción del tratamiento 10', 406.94, '2023-07-29', '2023-08-05', 17, 1),
(51, 'Tratamiento 1', 'Descripción del tratamiento 1', 105.48, '2023-07-20', '2023-07-27', 16, 1),
(52, 'Tratamiento 2', 'Descripción del tratamiento 2', 306.59, '2023-07-21', '2023-07-28', 16, 1),
(53, 'Tratamiento 3', 'Descripción del tratamiento 3', 216.50, '2023-07-22', '2023-07-29', 16, 1),
(54, 'Tratamiento 4', 'Descripción del tratamiento 4', 162.75, '2023-07-23', '2023-07-30', 16, 1),
(55, 'Tratamiento 5', 'Descripción del tratamiento 5', 164.23, '2023-07-24', '2023-07-31', 16, 1),
(56, 'Tratamiento 6', 'Descripción del tratamiento 6', 332.90, '2023-07-25', '2023-08-01', 16, 1),
(57, 'Tratamiento 7', 'Descripción del tratamiento 7', 171.82, '2023-07-26', '2023-08-02', 16, 1),
(58, 'Tratamiento 8', 'Descripción del tratamiento 8', 860.39, '2023-07-27', '2023-08-03', 16, 1),
(59, 'Tratamiento 9', 'Descripción del tratamiento 9', 786.47, '2023-07-28', '2023-08-04', 16, 1),
(60, 'Tratamiento 10', 'Descripción del tratamiento 10', 351.21, '2023-07-29', '2023-08-05', 16, 1),
(61, 'Tratamiento 1', 'Descripción del tratamiento 1', 396.65, '2023-07-20', '2023-07-27', 12, 1),
(62, 'Tratamiento 2', 'Descripción del tratamiento 2', 929.59, '2023-07-21', '2023-07-28', 12, 1),
(63, 'Tratamiento 3', 'Descripción del tratamiento 3', 458.00, '2023-07-22', '2023-07-29', 12, 1),
(64, 'Tratamiento 4', 'Descripción del tratamiento 4', 501.24, '2023-07-23', '2023-07-30', 12, 1),
(65, 'Tratamiento 5', 'Descripción del tratamiento 5', 132.18, '2023-07-24', '2023-07-31', 12, 1),
(66, 'Tratamiento 6', 'Descripción del tratamiento 6', 157.20, '2023-07-25', '2023-08-01', 12, 1),
(67, 'Tratamiento 7', 'Descripción del tratamiento 7', 389.46, '2023-07-26', '2023-08-02', 12, 1),
(68, 'Tratamiento 8', 'Descripción del tratamiento 8', 475.71, '2023-07-27', '2023-08-03', 12, 1),
(69, 'Tratamiento 9', 'Descripción del tratamiento 9', 210.15, '2023-07-28', '2023-08-04', 12, 1),
(70, 'Tratamiento 10', 'Descripción del tratamiento 10', 623.63, '2023-07-29', '2023-08-05', 12, 1),
(71, 'Tratamiento 1', 'Descripción del tratamiento 1', 487.68, '2023-07-20', '2023-07-27', 19, 1),
(72, 'Tratamiento 2', 'Descripción del tratamiento 2', 567.53, '2023-07-21', '2023-07-28', 19, 1),
(73, 'Tratamiento 3', 'Descripción del tratamiento 3', 374.58, '2023-07-22', '2023-07-29', 19, 1),
(74, 'Tratamiento 4', 'Descripción del tratamiento 4', 170.35, '2023-07-23', '2023-07-30', 19, 1),
(75, 'Tratamiento 5', 'Descripción del tratamiento 5', 727.97, '2023-07-24', '2023-07-31', 19, 1),
(76, 'Tratamiento 6', 'Descripción del tratamiento 6', 128.83, '2023-07-25', '2023-08-01', 19, 1),
(77, 'Tratamiento 7', 'Descripción del tratamiento 7', 460.25, '2023-07-26', '2023-08-02', 19, 1),
(78, 'Tratamiento 8', 'Descripción del tratamiento 8', 914.73, '2023-07-27', '2023-08-03', 19, 1),
(79, 'Tratamiento 9', 'Descripción del tratamiento 9', 192.91, '2023-07-28', '2023-08-04', 19, 1),
(80, 'Tratamiento 10', 'Descripción del tratamiento 10', 220.34, '2023-07-29', '2023-08-05', 19, 1),
(81, 'Tratamiento 1', 'Descripción del tratamiento 1', 523.00, '2023-07-20', '2023-07-27', 20, 1),
(82, 'Tratamiento 2', 'Descripción del tratamiento 2', 953.99, '2023-07-21', '2023-07-28', 20, 1),
(83, 'Tratamiento 3', 'Descripción del tratamiento 3', 200.94, '2023-07-22', '2023-07-29', 20, 1),
(84, 'Tratamiento 4', 'Descripción del tratamiento 4', 142.71, '2023-07-23', '2023-07-30', 20, 1),
(85, 'Tratamiento 5', 'Descripción del tratamiento 5', 110.73, '2023-07-24', '2023-07-31', 20, 1),
(86, 'Tratamiento 6', 'Descripción del tratamiento 6', 125.52, '2023-07-25', '2023-08-01', 20, 1),
(87, 'Tratamiento 7', 'Descripción del tratamiento 7', 295.41, '2023-07-26', '2023-08-02', 20, 1),
(88, 'Tratamiento 8', 'Descripción del tratamiento 8', 100.50, '2023-07-27', '2023-08-03', 20, 1),
(89, 'Tratamiento 9', 'Descripción del tratamiento 9', 616.25, '2023-07-28', '2023-08-04', 20, 1),
(90, 'Tratamiento 10', 'Descripción del tratamiento 10', 779.76, '2023-07-29', '2023-08-05', 20, 1),
(91, 'Tratamiento 1', 'Descripción del tratamiento 1', 50.07, '2023-07-20', '2023-07-27', 5, 1),
(92, 'Tratamiento 2', 'Descripción del tratamiento 2', 911.04, '2023-07-21', '2023-07-28', 5, 1),
(93, 'Tratamiento 3', 'Descripción del tratamiento 3', 405.00, '2023-07-22', '2023-07-29', 5, 1),
(94, 'Tratamiento 4', 'Descripción del tratamiento 4', 291.89, '2023-07-23', '2023-07-30', 5, 1),
(95, 'Tratamiento 5', 'Descripción del tratamiento 5', 244.45, '2023-07-24', '2023-07-31', 5, 1),
(96, 'Tratamiento 6', 'Descripción del tratamiento 6', 346.59, '2023-07-25', '2023-08-01', 5, 1),
(97, 'Tratamiento 7', 'Descripción del tratamiento 7', 999.57, '2023-07-26', '2023-08-02', 5, 1),
(98, 'Tratamiento 8', 'Descripción del tratamiento 8', 958.09, '2023-07-27', '2023-08-03', 5, 1),
(99, 'Tratamiento 9', 'Descripción del tratamiento 9', 791.76, '2023-07-28', '2023-08-04', 5, 1),
(100, 'Tratamiento 10', 'Descripción del tratamiento 10', 84.50, '2023-07-29', '2023-08-05', 5, 1),
(101, 'Tratamiento 1', 'Descripción del tratamiento 1', 47.22, '2023-07-20', '2023-07-27', 2, 10),
(102, 'Tratamiento 2', 'Descripción del tratamiento 2', 982.60, '2023-07-21', '2023-07-28', 2, 10),
(103, 'Tratamiento 3', 'Descripción del tratamiento 3', 771.36, '2023-07-22', '2023-07-29', 2, 10),
(104, 'Tratamiento 4', 'Descripción del tratamiento 4', 908.99, '2023-07-23', '2023-07-30', 2, 10),
(105, 'Tratamiento 5', 'Descripción del tratamiento 5', 230.87, '2023-07-24', '2023-07-31', 2, 10),
(106, 'Tratamiento 6', 'Descripción del tratamiento 6', 427.40, '2023-07-25', '2023-08-01', 2, 10),
(107, 'Tratamiento 7', 'Descripción del tratamiento 7', 444.38, '2023-07-26', '2023-08-02', 2, 10),
(108, 'Tratamiento 8', 'Descripción del tratamiento 8', 939.71, '2023-07-27', '2023-08-03', 2, 10),
(109, 'Tratamiento 9', 'Descripción del tratamiento 9', 365.41, '2023-07-28', '2023-08-04', 2, 10),
(110, 'Tratamiento 10', 'Descripción del tratamiento 10', 7.91, '2023-07-29', '2023-08-05', 2, 10),
(111, 'Tratamiento 1', 'Descripción del tratamiento 1', 943.33, '2023-07-20', '2023-07-27', 3, 10),
(112, 'Tratamiento 2', 'Descripción del tratamiento 2', 692.92, '2023-07-21', '2023-07-28', 3, 10),
(113, 'Tratamiento 3', 'Descripción del tratamiento 3', 634.62, '2023-07-22', '2023-07-29', 3, 10),
(114, 'Tratamiento 4', 'Descripción del tratamiento 4', 94.33, '2023-07-23', '2023-07-30', 3, 10),
(115, 'Tratamiento 5', 'Descripción del tratamiento 5', 567.78, '2023-07-24', '2023-07-31', 3, 10),
(116, 'Tratamiento 6', 'Descripción del tratamiento 6', 555.91, '2023-07-25', '2023-08-01', 3, 10),
(117, 'Tratamiento 7', 'Descripción del tratamiento 7', 76.23, '2023-07-26', '2023-08-02', 3, 10),
(118, 'Tratamiento 8', 'Descripción del tratamiento 8', 713.43, '2023-07-27', '2023-08-03', 3, 10),
(119, 'Tratamiento 9', 'Descripción del tratamiento 9', 338.44, '2023-07-28', '2023-08-04', 3, 10),
(120, 'Tratamiento 10', 'Descripción del tratamiento 10', 551.92, '2023-07-29', '2023-08-05', 3, 10),
(121, 'Tratamiento 1', 'Descripción del tratamiento 1', 744.26, '2023-07-20', '2023-07-27', 13, 10),
(122, 'Tratamiento 2', 'Descripción del tratamiento 2', 65.56, '2023-07-21', '2023-07-28', 13, 10),
(123, 'Tratamiento 3', 'Descripción del tratamiento 3', 95.03, '2023-07-22', '2023-07-29', 13, 10),
(124, 'Tratamiento 4', 'Descripción del tratamiento 4', 278.46, '2023-07-23', '2023-07-30', 13, 10),
(125, 'Tratamiento 5', 'Descripción del tratamiento 5', 107.22, '2023-07-24', '2023-07-31', 13, 10),
(126, 'Tratamiento 6', 'Descripción del tratamiento 6', 700.69, '2023-07-25', '2023-08-01', 13, 10),
(127, 'Tratamiento 7', 'Descripción del tratamiento 7', 181.81, '2023-07-26', '2023-08-02', 13, 10),
(128, 'Tratamiento 8', 'Descripción del tratamiento 8', 806.99, '2023-07-27', '2023-08-03', 13, 10),
(129, 'Tratamiento 9', 'Descripción del tratamiento 9', 489.51, '2023-07-28', '2023-08-04', 13, 10),
(130, 'Tratamiento 10', 'Descripción del tratamiento 10', 26.59, '2023-07-29', '2023-08-05', 13, 10),
(131, 'Tratamiento 1', 'Descripción del tratamiento 1', 664.41, '2023-07-20', '2023-07-27', 10, 10),
(132, 'Tratamiento 2', 'Descripción del tratamiento 2', 242.29, '2023-07-21', '2023-07-28', 10, 10),
(133, 'Tratamiento 3', 'Descripción del tratamiento 3', 218.22, '2023-07-22', '2023-07-29', 10, 10),
(134, 'Tratamiento 4', 'Descripción del tratamiento 4', 364.24, '2023-07-23', '2023-07-30', 10, 10),
(135, 'Tratamiento 5', 'Descripción del tratamiento 5', 166.54, '2023-07-24', '2023-07-31', 10, 10),
(136, 'Tratamiento 6', 'Descripción del tratamiento 6', 739.98, '2023-07-25', '2023-08-01', 10, 10),
(137, 'Tratamiento 7', 'Descripción del tratamiento 7', 200.26, '2023-07-26', '2023-08-02', 10, 10),
(138, 'Tratamiento 8', 'Descripción del tratamiento 8', 781.36, '2023-07-27', '2023-08-03', 10, 10),
(139, 'Tratamiento 9', 'Descripción del tratamiento 9', 306.03, '2023-07-28', '2023-08-04', 10, 10),
(140, 'Tratamiento 10', 'Descripción del tratamiento 10', 186.09, '2023-07-29', '2023-08-05', 10, 10),
(141, 'Tratamiento 1', 'Descripción del tratamiento 1', 12.34, '2023-07-20', '2023-07-27', 17, 10),
(142, 'Tratamiento 2', 'Descripción del tratamiento 2', 503.45, '2023-07-21', '2023-07-28', 17, 10),
(143, 'Tratamiento 3', 'Descripción del tratamiento 3', 480.21, '2023-07-22', '2023-07-29', 17, 10),
(144, 'Tratamiento 4', 'Descripción del tratamiento 4', 890.69, '2023-07-23', '2023-07-30', 17, 10),
(145, 'Tratamiento 5', 'Descripción del tratamiento 5', 12.82, '2023-07-24', '2023-07-31', 17, 10),
(146, 'Tratamiento 6', 'Descripción del tratamiento 6', 392.03, '2023-07-25', '2023-08-01', 17, 10),
(147, 'Tratamiento 7', 'Descripción del tratamiento 7', 921.68, '2023-07-26', '2023-08-02', 17, 10),
(148, 'Tratamiento 8', 'Descripción del tratamiento 8', 432.32, '2023-07-27', '2023-08-03', 17, 10),
(149, 'Tratamiento 9', 'Descripción del tratamiento 9', 396.58, '2023-07-28', '2023-08-04', 17, 10),
(150, 'Tratamiento 10', 'Descripción del tratamiento 10', 685.92, '2023-07-29', '2023-08-05', 17, 10),
(151, 'Tratamiento 1', 'Descripción del tratamiento 1', 239.87, '2023-07-20', '2023-07-27', 16, 10),
(152, 'Tratamiento 2', 'Descripción del tratamiento 2', 141.57, '2023-07-21', '2023-07-28', 16, 10),
(153, 'Tratamiento 3', 'Descripción del tratamiento 3', 988.26, '2023-07-22', '2023-07-29', 16, 10),
(154, 'Tratamiento 4', 'Descripción del tratamiento 4', 516.60, '2023-07-23', '2023-07-30', 16, 10),
(155, 'Tratamiento 5', 'Descripción del tratamiento 5', 618.20, '2023-07-24', '2023-07-31', 16, 10),
(156, 'Tratamiento 6', 'Descripción del tratamiento 6', 541.21, '2023-07-25', '2023-08-01', 16, 10),
(157, 'Tratamiento 7', 'Descripción del tratamiento 7', 851.46, '2023-07-26', '2023-08-02', 16, 10),
(158, 'Tratamiento 8', 'Descripción del tratamiento 8', 633.64, '2023-07-27', '2023-08-03', 16, 10),
(159, 'Tratamiento 9', 'Descripción del tratamiento 9', 613.85, '2023-07-28', '2023-08-04', 16, 10),
(160, 'Tratamiento 10', 'Descripción del tratamiento 10', 168.31, '2023-07-29', '2023-08-05', 16, 10),
(161, 'Tratamiento 1', 'Descripción del tratamiento 1', 1000.00, '2023-07-20', '2023-07-27', 12, 10),
(162, 'Tratamiento 2', 'Descripción del tratamiento 2', 495.07, '2023-07-21', '2023-07-28', 12, 10),
(163, 'Tratamiento 3', 'Descripción del tratamiento 3', 475.34, '2023-07-22', '2023-07-29', 12, 10),
(164, 'Tratamiento 4', 'Descripción del tratamiento 4', 891.50, '2023-07-23', '2023-07-30', 12, 10),
(165, 'Tratamiento 5', 'Descripción del tratamiento 5', 31.50, '2023-07-24', '2023-07-31', 12, 10),
(166, 'Tratamiento 6', 'Descripción del tratamiento 6', 482.98, '2023-07-25', '2023-08-01', 12, 10),
(167, 'Tratamiento 7', 'Descripción del tratamiento 7', 320.41, '2023-07-26', '2023-08-02', 12, 10),
(168, 'Tratamiento 8', 'Descripción del tratamiento 8', 153.11, '2023-07-27', '2023-08-03', 12, 10),
(169, 'Tratamiento 9', 'Descripción del tratamiento 9', 804.31, '2023-07-28', '2023-08-04', 12, 10),
(170, 'Tratamiento 10', 'Descripción del tratamiento 10', 562.25, '2023-07-29', '2023-08-05', 12, 10),
(171, 'Tratamiento 1', 'Descripción del tratamiento 1', 398.28, '2023-07-20', '2023-07-27', 19, 10),
(172, 'Tratamiento 2', 'Descripción del tratamiento 2', 304.68, '2023-07-21', '2023-07-28', 19, 10),
(173, 'Tratamiento 3', 'Descripción del tratamiento 3', 328.53, '2023-07-22', '2023-07-29', 19, 10),
(174, 'Tratamiento 4', 'Descripción del tratamiento 4', 728.62, '2023-07-23', '2023-07-30', 19, 10),
(175, 'Tratamiento 5', 'Descripción del tratamiento 5', 657.51, '2023-07-24', '2023-07-31', 19, 10),
(176, 'Tratamiento 6', 'Descripción del tratamiento 6', 101.69, '2023-07-25', '2023-08-01', 19, 10),
(177, 'Tratamiento 7', 'Descripción del tratamiento 7', 535.91, '2023-07-26', '2023-08-02', 19, 10),
(178, 'Tratamiento 8', 'Descripción del tratamiento 8', 374.47, '2023-07-27', '2023-08-03', 19, 10),
(179, 'Tratamiento 9', 'Descripción del tratamiento 9', 264.65, '2023-07-28', '2023-08-04', 19, 10),
(180, 'Tratamiento 10', 'Descripción del tratamiento 10', 199.83, '2023-07-29', '2023-08-05', 19, 10),
(181, 'Tratamiento 1', 'Descripción del tratamiento 1', 205.18, '2023-07-20', '2023-07-27', 20, 10),
(182, 'Tratamiento 2', 'Descripción del tratamiento 2', 426.42, '2023-07-21', '2023-07-28', 20, 10),
(183, 'Tratamiento 3', 'Descripción del tratamiento 3', 516.55, '2023-07-22', '2023-07-29', 20, 10),
(184, 'Tratamiento 4', 'Descripción del tratamiento 4', 303.48, '2023-07-23', '2023-07-30', 20, 10),
(185, 'Tratamiento 5', 'Descripción del tratamiento 5', 967.75, '2023-07-24', '2023-07-31', 20, 10),
(186, 'Tratamiento 6', 'Descripción del tratamiento 6', 928.32, '2023-07-25', '2023-08-01', 20, 10),
(187, 'Tratamiento 7', 'Descripción del tratamiento 7', 738.37, '2023-07-26', '2023-08-02', 20, 10),
(188, 'Tratamiento 8', 'Descripción del tratamiento 8', 906.86, '2023-07-27', '2023-08-03', 20, 10),
(189, 'Tratamiento 9', 'Descripción del tratamiento 9', 319.19, '2023-07-28', '2023-08-04', 20, 10),
(190, 'Tratamiento 10', 'Descripción del tratamiento 10', 875.38, '2023-07-29', '2023-08-05', 20, 10),
(191, 'Tratamiento 1', 'Descripción del tratamiento 1', 419.34, '2023-07-20', '2023-07-27', 5, 10),
(192, 'Tratamiento 2', 'Descripción del tratamiento 2', 470.57, '2023-07-21', '2023-07-28', 5, 10),
(193, 'Tratamiento 3', 'Descripción del tratamiento 3', 94.82, '2023-07-22', '2023-07-29', 5, 10),
(194, 'Tratamiento 4', 'Descripción del tratamiento 4', 62.40, '2023-07-23', '2023-07-30', 5, 10),
(195, 'Tratamiento 5', 'Descripción del tratamiento 5', 27.55, '2023-07-24', '2023-07-31', 5, 10),
(196, 'Tratamiento 6', 'Descripción del tratamiento 6', 950.53, '2023-07-25', '2023-08-01', 5, 10),
(197, 'Tratamiento 7', 'Descripción del tratamiento 7', 670.01, '2023-07-26', '2023-08-02', 5, 10),
(198, 'Tratamiento 8', 'Descripción del tratamiento 8', 498.44, '2023-07-27', '2023-08-03', 5, 10),
(199, 'Tratamiento 9', 'Descripción del tratamiento 9', 482.20, '2023-07-28', '2023-08-04', 5, 10),
(200, 'Tratamiento 10', 'Descripción del tratamiento 10', 915.68, '2023-07-29', '2023-08-05', 5, 10),
(201, 'Tratamiento 1', 'Descripción del tratamiento 1', 131.79, '2023-07-20', '2023-07-27', 2, 9),
(202, 'Tratamiento 2', 'Descripción del tratamiento 2', 911.90, '2023-07-21', '2023-07-28', 2, 9),
(203, 'Tratamiento 3', 'Descripción del tratamiento 3', 164.12, '2023-07-22', '2023-07-29', 2, 9),
(204, 'Tratamiento 4', 'Descripción del tratamiento 4', 84.90, '2023-07-23', '2023-07-30', 2, 9),
(205, 'Tratamiento 5', 'Descripción del tratamiento 5', 932.16, '2023-07-24', '2023-07-31', 2, 9),
(206, 'Tratamiento 6', 'Descripción del tratamiento 6', 406.09, '2023-07-25', '2023-08-01', 2, 9),
(207, 'Tratamiento 7', 'Descripción del tratamiento 7', 233.96, '2023-07-26', '2023-08-02', 2, 9),
(208, 'Tratamiento 8', 'Descripción del tratamiento 8', 951.52, '2023-07-27', '2023-08-03', 2, 9),
(209, 'Tratamiento 9', 'Descripción del tratamiento 9', 55.75, '2023-07-28', '2023-08-04', 2, 9),
(210, 'Tratamiento 10', 'Descripción del tratamiento 10', 424.18, '2023-07-29', '2023-08-05', 2, 9),
(211, 'Tratamiento 1', 'Descripción del tratamiento 1', 953.65, '2023-07-20', '2023-07-27', 3, 9),
(212, 'Tratamiento 2', 'Descripción del tratamiento 2', 495.70, '2023-07-21', '2023-07-28', 3, 9),
(213, 'Tratamiento 3', 'Descripción del tratamiento 3', 617.57, '2023-07-22', '2023-07-29', 3, 9),
(214, 'Tratamiento 4', 'Descripción del tratamiento 4', 600.72, '2023-07-23', '2023-07-30', 3, 9),
(215, 'Tratamiento 5', 'Descripción del tratamiento 5', 150.92, '2023-07-24', '2023-07-31', 3, 9),
(216, 'Tratamiento 6', 'Descripción del tratamiento 6', 952.43, '2023-07-25', '2023-08-01', 3, 9),
(217, 'Tratamiento 7', 'Descripción del tratamiento 7', 309.40, '2023-07-26', '2023-08-02', 3, 9),
(218, 'Tratamiento 8', 'Descripción del tratamiento 8', 689.71, '2023-07-27', '2023-08-03', 3, 9),
(219, 'Tratamiento 9', 'Descripción del tratamiento 9', 520.36, '2023-07-28', '2023-08-04', 3, 9),
(220, 'Tratamiento 10', 'Descripción del tratamiento 10', 532.64, '2023-07-29', '2023-08-05', 3, 9),
(221, 'Tratamiento 1', 'Descripción del tratamiento 1', 102.14, '2023-07-20', '2023-07-27', 13, 9),
(222, 'Tratamiento 2', 'Descripción del tratamiento 2', 912.77, '2023-07-21', '2023-07-28', 13, 9),
(223, 'Tratamiento 3', 'Descripción del tratamiento 3', 257.42, '2023-07-22', '2023-07-29', 13, 9),
(224, 'Tratamiento 4', 'Descripción del tratamiento 4', 548.79, '2023-07-23', '2023-07-30', 13, 9),
(225, 'Tratamiento 5', 'Descripción del tratamiento 5', 971.69, '2023-07-24', '2023-07-31', 13, 9),
(226, 'Tratamiento 6', 'Descripción del tratamiento 6', 212.10, '2023-07-25', '2023-08-01', 13, 9),
(227, 'Tratamiento 7', 'Descripción del tratamiento 7', 145.43, '2023-07-26', '2023-08-02', 13, 9),
(228, 'Tratamiento 8', 'Descripción del tratamiento 8', 90.83, '2023-07-27', '2023-08-03', 13, 9),
(229, 'Tratamiento 9', 'Descripción del tratamiento 9', 17.85, '2023-07-28', '2023-08-04', 13, 9),
(230, 'Tratamiento 10', 'Descripción del tratamiento 10', 816.79, '2023-07-29', '2023-08-05', 13, 9),
(231, 'Tratamiento 1', 'Descripción del tratamiento 1', 30.39, '2023-07-20', '2023-07-27', 10, 9),
(232, 'Tratamiento 2', 'Descripción del tratamiento 2', 701.59, '2023-07-21', '2023-07-28', 10, 9),
(233, 'Tratamiento 3', 'Descripción del tratamiento 3', 416.79, '2023-07-22', '2023-07-29', 10, 9),
(234, 'Tratamiento 4', 'Descripción del tratamiento 4', 979.16, '2023-07-23', '2023-07-30', 10, 9),
(235, 'Tratamiento 5', 'Descripción del tratamiento 5', 645.42, '2023-07-24', '2023-07-31', 10, 9),
(236, 'Tratamiento 6', 'Descripción del tratamiento 6', 289.63, '2023-07-25', '2023-08-01', 10, 9),
(237, 'Tratamiento 7', 'Descripción del tratamiento 7', 511.91, '2023-07-26', '2023-08-02', 10, 9),
(238, 'Tratamiento 8', 'Descripción del tratamiento 8', 690.65, '2023-07-27', '2023-08-03', 10, 9),
(239, 'Tratamiento 9', 'Descripción del tratamiento 9', 917.52, '2023-07-28', '2023-08-04', 10, 9),
(240, 'Tratamiento 10', 'Descripción del tratamiento 10', 515.63, '2023-07-29', '2023-08-05', 10, 9),
(241, 'Tratamiento 1', 'Descripción del tratamiento 1', 825.59, '2023-07-20', '2023-07-27', 17, 9),
(242, 'Tratamiento 2', 'Descripción del tratamiento 2', 581.08, '2023-07-21', '2023-07-28', 17, 9),
(243, 'Tratamiento 3', 'Descripción del tratamiento 3', 428.62, '2023-07-22', '2023-07-29', 17, 9),
(244, 'Tratamiento 4', 'Descripción del tratamiento 4', 399.87, '2023-07-23', '2023-07-30', 17, 9),
(245, 'Tratamiento 5', 'Descripción del tratamiento 5', 713.50, '2023-07-24', '2023-07-31', 17, 9),
(246, 'Tratamiento 6', 'Descripción del tratamiento 6', 367.87, '2023-07-25', '2023-08-01', 17, 9),
(247, 'Tratamiento 7', 'Descripción del tratamiento 7', 698.84, '2023-07-26', '2023-08-02', 17, 9),
(248, 'Tratamiento 8', 'Descripción del tratamiento 8', 390.60, '2023-07-27', '2023-08-03', 17, 9),
(249, 'Tratamiento 9', 'Descripción del tratamiento 9', 856.48, '2023-07-28', '2023-08-04', 17, 9),
(250, 'Tratamiento 10', 'Descripción del tratamiento 10', 110.58, '2023-07-29', '2023-08-05', 17, 9),
(251, 'Tratamiento 1', 'Descripción del tratamiento 1', 983.49, '2023-07-20', '2023-07-27', 16, 9),
(252, 'Tratamiento 2', 'Descripción del tratamiento 2', 585.70, '2023-07-21', '2023-07-28', 16, 9),
(253, 'Tratamiento 3', 'Descripción del tratamiento 3', 978.04, '2023-07-22', '2023-07-29', 16, 9),
(254, 'Tratamiento 4', 'Descripción del tratamiento 4', 133.07, '2023-07-23', '2023-07-30', 16, 9),
(255, 'Tratamiento 5', 'Descripción del tratamiento 5', 731.26, '2023-07-24', '2023-07-31', 16, 9),
(256, 'Tratamiento 6', 'Descripción del tratamiento 6', 257.10, '2023-07-25', '2023-08-01', 16, 9),
(257, 'Tratamiento 7', 'Descripción del tratamiento 7', 91.71, '2023-07-26', '2023-08-02', 16, 9),
(258, 'Tratamiento 8', 'Descripción del tratamiento 8', 687.24, '2023-07-27', '2023-08-03', 16, 9),
(259, 'Tratamiento 9', 'Descripción del tratamiento 9', 161.09, '2023-07-28', '2023-08-04', 16, 9),
(260, 'Tratamiento 10', 'Descripción del tratamiento 10', 743.70, '2023-07-29', '2023-08-05', 16, 9),
(261, 'Tratamiento 1', 'Descripción del tratamiento 1', 235.26, '2023-07-20', '2023-07-27', 12, 9),
(262, 'Tratamiento 2', 'Descripción del tratamiento 2', 945.20, '2023-07-21', '2023-07-28', 12, 9),
(263, 'Tratamiento 3', 'Descripción del tratamiento 3', 20.23, '2023-07-22', '2023-07-29', 12, 9),
(264, 'Tratamiento 4', 'Descripción del tratamiento 4', 265.54, '2023-07-23', '2023-07-30', 12, 9),
(265, 'Tratamiento 5', 'Descripción del tratamiento 5', 267.01, '2023-07-24', '2023-07-31', 12, 9),
(266, 'Tratamiento 6', 'Descripción del tratamiento 6', 538.42, '2023-07-25', '2023-08-01', 12, 9),
(267, 'Tratamiento 7', 'Descripción del tratamiento 7', 891.06, '2023-07-26', '2023-08-02', 12, 9),
(268, 'Tratamiento 8', 'Descripción del tratamiento 8', 840.04, '2023-07-27', '2023-08-03', 12, 9),
(269, 'Tratamiento 9', 'Descripción del tratamiento 9', 527.02, '2023-07-28', '2023-08-04', 12, 9),
(270, 'Tratamiento 10', 'Descripción del tratamiento 10', 114.97, '2023-07-29', '2023-08-05', 12, 9),
(271, 'Tratamiento 1', 'Descripción del tratamiento 1', 993.82, '2023-07-20', '2023-07-27', 19, 9),
(272, 'Tratamiento 2', 'Descripción del tratamiento 2', 624.18, '2023-07-21', '2023-07-28', 19, 9),
(273, 'Tratamiento 3', 'Descripción del tratamiento 3', 139.42, '2023-07-22', '2023-07-29', 19, 9),
(274, 'Tratamiento 4', 'Descripción del tratamiento 4', 824.56, '2023-07-23', '2023-07-30', 19, 9),
(275, 'Tratamiento 5', 'Descripción del tratamiento 5', 704.54, '2023-07-24', '2023-07-31', 19, 9),
(276, 'Tratamiento 6', 'Descripción del tratamiento 6', 49.04, '2023-07-25', '2023-08-01', 19, 9),
(277, 'Tratamiento 7', 'Descripción del tratamiento 7', 131.59, '2023-07-26', '2023-08-02', 19, 9),
(278, 'Tratamiento 8', 'Descripción del tratamiento 8', 510.81, '2023-07-27', '2023-08-03', 19, 9),
(279, 'Tratamiento 9', 'Descripción del tratamiento 9', 159.27, '2023-07-28', '2023-08-04', 19, 9),
(280, 'Tratamiento 10', 'Descripción del tratamiento 10', 263.94, '2023-07-29', '2023-08-05', 19, 9),
(281, 'Tratamiento 1', 'Descripción del tratamiento 1', 841.89, '2023-07-20', '2023-07-27', 20, 9),
(282, 'Tratamiento 2', 'Descripción del tratamiento 2', 417.63, '2023-07-21', '2023-07-28', 20, 9),
(283, 'Tratamiento 3', 'Descripción del tratamiento 3', 562.49, '2023-07-22', '2023-07-29', 20, 9),
(284, 'Tratamiento 4', 'Descripción del tratamiento 4', 559.54, '2023-07-23', '2023-07-30', 20, 9),
(285, 'Tratamiento 5', 'Descripción del tratamiento 5', 110.25, '2023-07-24', '2023-07-31', 20, 9),
(286, 'Tratamiento 6', 'Descripción del tratamiento 6', 872.64, '2023-07-25', '2023-08-01', 20, 9),
(287, 'Tratamiento 7', 'Descripción del tratamiento 7', 32.42, '2023-07-26', '2023-08-02', 20, 9),
(288, 'Tratamiento 8', 'Descripción del tratamiento 8', 544.17, '2023-07-27', '2023-08-03', 20, 9),
(289, 'Tratamiento 9', 'Descripción del tratamiento 9', 623.62, '2023-07-28', '2023-08-04', 20, 9),
(290, 'Tratamiento 10', 'Descripción del tratamiento 10', 485.59, '2023-07-29', '2023-08-05', 20, 9),
(291, 'Tratamiento 1', 'Descripción del tratamiento 1', 557.09, '2023-07-20', '2023-07-27', 5, 9),
(292, 'Tratamiento 2', 'Descripción del tratamiento 2', 328.68, '2023-07-21', '2023-07-28', 5, 9),
(293, 'Tratamiento 3', 'Descripción del tratamiento 3', 972.12, '2023-07-22', '2023-07-29', 5, 9),
(294, 'Tratamiento 4', 'Descripción del tratamiento 4', 874.58, '2023-07-23', '2023-07-30', 5, 9),
(295, 'Tratamiento 5', 'Descripción del tratamiento 5', 456.53, '2023-07-24', '2023-07-31', 5, 9),
(296, 'Tratamiento 6', 'Descripción del tratamiento 6', 658.90, '2023-07-25', '2023-08-01', 5, 9),
(297, 'Tratamiento 7', 'Descripción del tratamiento 7', 924.93, '2023-07-26', '2023-08-02', 5, 9),
(298, 'Tratamiento 8', 'Descripción del tratamiento 8', 647.95, '2023-07-27', '2023-08-03', 5, 9),
(299, 'Tratamiento 9', 'Descripción del tratamiento 9', 464.97, '2023-07-28', '2023-08-04', 5, 9),
(300, 'Tratamiento 10', 'Descripción del tratamiento 10', 381.01, '2023-07-29', '2023-08-05', 5, 9),
(301, 'Tratamiento 1', 'Descripción del tratamiento 1', 510.11, '2023-07-20', '2023-07-27', 2, 8),
(302, 'Tratamiento 2', 'Descripción del tratamiento 2', 407.53, '2023-07-21', '2023-07-28', 2, 8),
(303, 'Tratamiento 3', 'Descripción del tratamiento 3', 507.33, '2023-07-22', '2023-07-29', 2, 8),
(304, 'Tratamiento 4', 'Descripción del tratamiento 4', 314.06, '2023-07-23', '2023-07-30', 2, 8),
(305, 'Tratamiento 5', 'Descripción del tratamiento 5', 48.31, '2023-07-24', '2023-07-31', 2, 8),
(306, 'Tratamiento 6', 'Descripción del tratamiento 6', 299.37, '2023-07-25', '2023-08-01', 2, 8),
(307, 'Tratamiento 7', 'Descripción del tratamiento 7', 351.91, '2023-07-26', '2023-08-02', 2, 8),
(308, 'Tratamiento 8', 'Descripción del tratamiento 8', 861.43, '2023-07-27', '2023-08-03', 2, 8),
(309, 'Tratamiento 9', 'Descripción del tratamiento 9', 251.43, '2023-07-28', '2023-08-04', 2, 8),
(310, 'Tratamiento 10', 'Descripción del tratamiento 10', 672.85, '2023-07-29', '2023-08-05', 2, 8),
(311, 'Tratamiento 1', 'Descripción del tratamiento 1', 609.99, '2023-07-20', '2023-07-27', 3, 8),
(312, 'Tratamiento 2', 'Descripción del tratamiento 2', 31.37, '2023-07-21', '2023-07-28', 3, 8),
(313, 'Tratamiento 3', 'Descripción del tratamiento 3', 326.87, '2023-07-22', '2023-07-29', 3, 8),
(314, 'Tratamiento 4', 'Descripción del tratamiento 4', 540.26, '2023-07-23', '2023-07-30', 3, 8),
(315, 'Tratamiento 5', 'Descripción del tratamiento 5', 720.71, '2023-07-24', '2023-07-31', 3, 8),
(316, 'Tratamiento 6', 'Descripción del tratamiento 6', 982.73, '2023-07-25', '2023-08-01', 3, 8),
(317, 'Tratamiento 7', 'Descripción del tratamiento 7', 751.55, '2023-07-26', '2023-08-02', 3, 8),
(318, 'Tratamiento 8', 'Descripción del tratamiento 8', 809.54, '2023-07-27', '2023-08-03', 3, 8),
(319, 'Tratamiento 9', 'Descripción del tratamiento 9', 793.07, '2023-07-28', '2023-08-04', 3, 8),
(320, 'Tratamiento 10', 'Descripción del tratamiento 10', 536.71, '2023-07-29', '2023-08-05', 3, 8),
(321, 'Tratamiento 1', 'Descripción del tratamiento 1', 304.34, '2023-07-20', '2023-07-27', 13, 8),
(322, 'Tratamiento 2', 'Descripción del tratamiento 2', 911.59, '2023-07-21', '2023-07-28', 13, 8),
(323, 'Tratamiento 3', 'Descripción del tratamiento 3', 644.90, '2023-07-22', '2023-07-29', 13, 8),
(324, 'Tratamiento 4', 'Descripción del tratamiento 4', 489.74, '2023-07-23', '2023-07-30', 13, 8),
(325, 'Tratamiento 5', 'Descripción del tratamiento 5', 514.02, '2023-07-24', '2023-07-31', 13, 8),
(326, 'Tratamiento 6', 'Descripción del tratamiento 6', 100.88, '2023-07-25', '2023-08-01', 13, 8),
(327, 'Tratamiento 7', 'Descripción del tratamiento 7', 962.31, '2023-07-26', '2023-08-02', 13, 8),
(328, 'Tratamiento 8', 'Descripción del tratamiento 8', 508.93, '2023-07-27', '2023-08-03', 13, 8),
(329, 'Tratamiento 9', 'Descripción del tratamiento 9', 657.72, '2023-07-28', '2023-08-04', 13, 8),
(330, 'Tratamiento 10', 'Descripción del tratamiento 10', 761.79, '2023-07-29', '2023-08-05', 13, 8),
(331, 'Tratamiento 1', 'Descripción del tratamiento 1', 835.79, '2023-07-20', '2023-07-27', 10, 8),
(332, 'Tratamiento 2', 'Descripción del tratamiento 2', 893.60, '2023-07-21', '2023-07-28', 10, 8),
(333, 'Tratamiento 3', 'Descripción del tratamiento 3', 960.62, '2023-07-22', '2023-07-29', 10, 8),
(334, 'Tratamiento 4', 'Descripción del tratamiento 4', 122.30, '2023-07-23', '2023-07-30', 10, 8),
(335, 'Tratamiento 5', 'Descripción del tratamiento 5', 729.64, '2023-07-24', '2023-07-31', 10, 8),
(336, 'Tratamiento 6', 'Descripción del tratamiento 6', 281.29, '2023-07-25', '2023-08-01', 10, 8),
(337, 'Tratamiento 7', 'Descripción del tratamiento 7', 217.53, '2023-07-26', '2023-08-02', 10, 8),
(338, 'Tratamiento 8', 'Descripción del tratamiento 8', 243.80, '2023-07-27', '2023-08-03', 10, 8),
(339, 'Tratamiento 9', 'Descripción del tratamiento 9', 566.38, '2023-07-28', '2023-08-04', 10, 8),
(340, 'Tratamiento 10', 'Descripción del tratamiento 10', 100.53, '2023-07-29', '2023-08-05', 10, 8),
(341, 'Tratamiento 1', 'Descripción del tratamiento 1', 803.50, '2023-07-20', '2023-07-27', 17, 8),
(342, 'Tratamiento 2', 'Descripción del tratamiento 2', 715.89, '2023-07-21', '2023-07-28', 17, 8),
(343, 'Tratamiento 3', 'Descripción del tratamiento 3', 168.97, '2023-07-22', '2023-07-29', 17, 8),
(344, 'Tratamiento 4', 'Descripción del tratamiento 4', 697.16, '2023-07-23', '2023-07-30', 17, 8),
(345, 'Tratamiento 5', 'Descripción del tratamiento 5', 978.92, '2023-07-24', '2023-07-31', 17, 8),
(346, 'Tratamiento 6', 'Descripción del tratamiento 6', 803.10, '2023-07-25', '2023-08-01', 17, 8),
(347, 'Tratamiento 7', 'Descripción del tratamiento 7', 78.75, '2023-07-26', '2023-08-02', 17, 8),
(348, 'Tratamiento 8', 'Descripción del tratamiento 8', 984.43, '2023-07-27', '2023-08-03', 17, 8),
(349, 'Tratamiento 9', 'Descripción del tratamiento 9', 685.93, '2023-07-28', '2023-08-04', 17, 8),
(350, 'Tratamiento 10', 'Descripción del tratamiento 10', 476.33, '2023-07-29', '2023-08-05', 17, 8),
(351, 'Tratamiento 1', 'Descripción del tratamiento 1', 323.88, '2023-07-20', '2023-07-27', 16, 8),
(352, 'Tratamiento 2', 'Descripción del tratamiento 2', 190.38, '2023-07-21', '2023-07-28', 16, 8),
(353, 'Tratamiento 3', 'Descripción del tratamiento 3', 980.29, '2023-07-22', '2023-07-29', 16, 8),
(354, 'Tratamiento 4', 'Descripción del tratamiento 4', 330.31, '2023-07-23', '2023-07-30', 16, 8),
(355, 'Tratamiento 5', 'Descripción del tratamiento 5', 710.68, '2023-07-24', '2023-07-31', 16, 8),
(356, 'Tratamiento 6', 'Descripción del tratamiento 6', 562.47, '2023-07-25', '2023-08-01', 16, 8),
(357, 'Tratamiento 7', 'Descripción del tratamiento 7', 680.33, '2023-07-26', '2023-08-02', 16, 8),
(358, 'Tratamiento 8', 'Descripción del tratamiento 8', 714.21, '2023-07-27', '2023-08-03', 16, 8),
(359, 'Tratamiento 9', 'Descripción del tratamiento 9', 530.05, '2023-07-28', '2023-08-04', 16, 8),
(360, 'Tratamiento 10', 'Descripción del tratamiento 10', 507.65, '2023-07-29', '2023-08-05', 16, 8),
(361, 'Tratamiento 1', 'Descripción del tratamiento 1', 948.11, '2023-07-20', '2023-07-27', 12, 8),
(362, 'Tratamiento 2', 'Descripción del tratamiento 2', 217.57, '2023-07-21', '2023-07-28', 12, 8),
(363, 'Tratamiento 3', 'Descripción del tratamiento 3', 243.55, '2023-07-22', '2023-07-29', 12, 8),
(364, 'Tratamiento 4', 'Descripción del tratamiento 4', 565.03, '2023-07-23', '2023-07-30', 12, 8),
(365, 'Tratamiento 5', 'Descripción del tratamiento 5', 94.49, '2023-07-24', '2023-07-31', 12, 8),
(366, 'Tratamiento 6', 'Descripción del tratamiento 6', 777.36, '2023-07-25', '2023-08-01', 12, 8),
(367, 'Tratamiento 7', 'Descripción del tratamiento 7', 603.32, '2023-07-26', '2023-08-02', 12, 8),
(368, 'Tratamiento 8', 'Descripción del tratamiento 8', 684.51, '2023-07-27', '2023-08-03', 12, 8),
(369, 'Tratamiento 9', 'Descripción del tratamiento 9', 612.60, '2023-07-28', '2023-08-04', 12, 8),
(370, 'Tratamiento 10', 'Descripción del tratamiento 10', 9.47, '2023-07-29', '2023-08-05', 12, 8),
(371, 'Tratamiento 1', 'Descripción del tratamiento 1', 209.54, '2023-07-20', '2023-07-27', 19, 8),
(372, 'Tratamiento 2', 'Descripción del tratamiento 2', 19.31, '2023-07-21', '2023-07-28', 19, 8),
(373, 'Tratamiento 3', 'Descripción del tratamiento 3', 467.91, '2023-07-22', '2023-07-29', 19, 8),
(374, 'Tratamiento 4', 'Descripción del tratamiento 4', 281.62, '2023-07-23', '2023-07-30', 19, 8),
(375, 'Tratamiento 5', 'Descripción del tratamiento 5', 4.37, '2023-07-24', '2023-07-31', 19, 8),
(376, 'Tratamiento 6', 'Descripción del tratamiento 6', 176.98, '2023-07-25', '2023-08-01', 19, 8),
(377, 'Tratamiento 7', 'Descripción del tratamiento 7', 871.81, '2023-07-26', '2023-08-02', 19, 8),
(378, 'Tratamiento 8', 'Descripción del tratamiento 8', 828.11, '2023-07-27', '2023-08-03', 19, 8),
(379, 'Tratamiento 9', 'Descripción del tratamiento 9', 525.11, '2023-07-28', '2023-08-04', 19, 8),
(380, 'Tratamiento 10', 'Descripción del tratamiento 10', 141.21, '2023-07-29', '2023-08-05', 19, 8),
(381, 'Tratamiento 1', 'Descripción del tratamiento 1', 130.71, '2023-07-20', '2023-07-27', 20, 8),
(382, 'Tratamiento 2', 'Descripción del tratamiento 2', 229.94, '2023-07-21', '2023-07-28', 20, 8),
(383, 'Tratamiento 3', 'Descripción del tratamiento 3', 757.59, '2023-07-22', '2023-07-29', 20, 8),
(384, 'Tratamiento 4', 'Descripción del tratamiento 4', 98.10, '2023-07-23', '2023-07-30', 20, 8),
(385, 'Tratamiento 5', 'Descripción del tratamiento 5', 217.74, '2023-07-24', '2023-07-31', 20, 8),
(386, 'Tratamiento 6', 'Descripción del tratamiento 6', 794.40, '2023-07-25', '2023-08-01', 20, 8),
(387, 'Tratamiento 7', 'Descripción del tratamiento 7', 318.80, '2023-07-26', '2023-08-02', 20, 8),
(388, 'Tratamiento 8', 'Descripción del tratamiento 8', 210.77, '2023-07-27', '2023-08-03', 20, 8),
(389, 'Tratamiento 9', 'Descripción del tratamiento 9', 97.47, '2023-07-28', '2023-08-04', 20, 8),
(390, 'Tratamiento 10', 'Descripción del tratamiento 10', 855.04, '2023-07-29', '2023-08-05', 20, 8),
(391, 'Tratamiento 1', 'Descripción del tratamiento 1', 982.77, '2023-07-20', '2023-07-27', 5, 8),
(392, 'Tratamiento 2', 'Descripción del tratamiento 2', 348.75, '2023-07-21', '2023-07-28', 5, 8),
(393, 'Tratamiento 3', 'Descripción del tratamiento 3', 795.45, '2023-07-22', '2023-07-29', 5, 8),
(394, 'Tratamiento 4', 'Descripción del tratamiento 4', 930.99, '2023-07-23', '2023-07-30', 5, 8),
(395, 'Tratamiento 5', 'Descripción del tratamiento 5', 268.62, '2023-07-24', '2023-07-31', 5, 8),
(396, 'Tratamiento 6', 'Descripción del tratamiento 6', 550.11, '2023-07-25', '2023-08-01', 5, 8),
(397, 'Tratamiento 7', 'Descripción del tratamiento 7', 944.68, '2023-07-26', '2023-08-02', 5, 8),
(398, 'Tratamiento 8', 'Descripción del tratamiento 8', 73.09, '2023-07-27', '2023-08-03', 5, 8),
(399, 'Tratamiento 9', 'Descripción del tratamiento 9', 531.42, '2023-07-28', '2023-08-04', 5, 8),
(400, 'Tratamiento 10', 'Descripción del tratamiento 10', 437.83, '2023-07-29', '2023-08-05', 5, 8),
(401, 'Tratamiento 1', 'Descripción del tratamiento 1', 594.86, '2023-07-20', '2023-07-27', 2, 3),
(402, 'Tratamiento 2', 'Descripción del tratamiento 2', 660.84, '2023-07-21', '2023-07-28', 2, 3),
(403, 'Tratamiento 3', 'Descripción del tratamiento 3', 519.63, '2023-07-22', '2023-07-29', 2, 3),
(404, 'Tratamiento 4', 'Descripción del tratamiento 4', 615.60, '2023-07-23', '2023-07-30', 2, 3),
(405, 'Tratamiento 5', 'Descripción del tratamiento 5', 519.11, '2023-07-24', '2023-07-31', 2, 3),
(406, 'Tratamiento 6', 'Descripción del tratamiento 6', 748.76, '2023-07-25', '2023-08-01', 2, 3),
(407, 'Tratamiento 7', 'Descripción del tratamiento 7', 186.49, '2023-07-26', '2023-08-02', 2, 3),
(408, 'Tratamiento 8', 'Descripción del tratamiento 8', 686.13, '2023-07-27', '2023-08-03', 2, 3),
(409, 'Tratamiento 9', 'Descripción del tratamiento 9', 871.21, '2023-07-28', '2023-08-04', 2, 3),
(410, 'Tratamiento 10', 'Descripción del tratamiento 10', 297.67, '2023-07-29', '2023-08-05', 2, 3),
(411, 'Tratamiento 1', 'Descripción del tratamiento 1', 874.71, '2023-07-20', '2023-07-27', 3, 3),
(412, 'Tratamiento 2', 'Descripción del tratamiento 2', 480.52, '2023-07-21', '2023-07-28', 3, 3),
(413, 'Tratamiento 3', 'Descripción del tratamiento 3', 778.49, '2023-07-22', '2023-07-29', 3, 3),
(414, 'Tratamiento 4', 'Descripción del tratamiento 4', 450.90, '2023-07-23', '2023-07-30', 3, 3),
(415, 'Tratamiento 5', 'Descripción del tratamiento 5', 919.02, '2023-07-24', '2023-07-31', 3, 3),
(416, 'Tratamiento 6', 'Descripción del tratamiento 6', 242.38, '2023-07-25', '2023-08-01', 3, 3),
(417, 'Tratamiento 7', 'Descripción del tratamiento 7', 454.87, '2023-07-26', '2023-08-02', 3, 3),
(418, 'Tratamiento 8', 'Descripción del tratamiento 8', 547.21, '2023-07-27', '2023-08-03', 3, 3),
(419, 'Tratamiento 9', 'Descripción del tratamiento 9', 371.45, '2023-07-28', '2023-08-04', 3, 3),
(420, 'Tratamiento 10', 'Descripción del tratamiento 10', 215.59, '2023-07-29', '2023-08-05', 3, 3),
(421, 'Tratamiento 1', 'Descripción del tratamiento 1', 963.60, '2023-07-20', '2023-07-27', 13, 3),
(422, 'Tratamiento 2', 'Descripción del tratamiento 2', 171.26, '2023-07-21', '2023-07-28', 13, 3),
(423, 'Tratamiento 3', 'Descripción del tratamiento 3', 965.47, '2023-07-22', '2023-07-29', 13, 3),
(424, 'Tratamiento 4', 'Descripción del tratamiento 4', 313.57, '2023-07-23', '2023-07-30', 13, 3),
(425, 'Tratamiento 5', 'Descripción del tratamiento 5', 671.44, '2023-07-24', '2023-07-31', 13, 3),
(426, 'Tratamiento 6', 'Descripción del tratamiento 6', 416.51, '2023-07-25', '2023-08-01', 13, 3),
(427, 'Tratamiento 7', 'Descripción del tratamiento 7', 68.20, '2023-07-26', '2023-08-02', 13, 3),
(428, 'Tratamiento 8', 'Descripción del tratamiento 8', 91.48, '2023-07-27', '2023-08-03', 13, 3),
(429, 'Tratamiento 9', 'Descripción del tratamiento 9', 252.82, '2023-07-28', '2023-08-04', 13, 3),
(430, 'Tratamiento 10', 'Descripción del tratamiento 10', 989.66, '2023-07-29', '2023-08-05', 13, 3),
(431, 'Tratamiento 1', 'Descripción del tratamiento 1', 189.83, '2023-07-20', '2023-07-27', 10, 3),
(432, 'Tratamiento 2', 'Descripción del tratamiento 2', 980.19, '2023-07-21', '2023-07-28', 10, 3),
(433, 'Tratamiento 3', 'Descripción del tratamiento 3', 331.45, '2023-07-22', '2023-07-29', 10, 3),
(434, 'Tratamiento 4', 'Descripción del tratamiento 4', 716.69, '2023-07-23', '2023-07-30', 10, 3),
(435, 'Tratamiento 5', 'Descripción del tratamiento 5', 589.11, '2023-07-24', '2023-07-31', 10, 3),
(436, 'Tratamiento 6', 'Descripción del tratamiento 6', 795.45, '2023-07-25', '2023-08-01', 10, 3),
(437, 'Tratamiento 7', 'Descripción del tratamiento 7', 209.91, '2023-07-26', '2023-08-02', 10, 3),
(438, 'Tratamiento 8', 'Descripción del tratamiento 8', 663.23, '2023-07-27', '2023-08-03', 10, 3),
(439, 'Tratamiento 9', 'Descripción del tratamiento 9', 686.42, '2023-07-28', '2023-08-04', 10, 3),
(440, 'Tratamiento 10', 'Descripción del tratamiento 10', 442.38, '2023-07-29', '2023-08-05', 10, 3),
(441, 'Tratamiento 1', 'Descripción del tratamiento 1', 152.68, '2023-07-20', '2023-07-27', 17, 3),
(442, 'Tratamiento 2', 'Descripción del tratamiento 2', 436.23, '2023-07-21', '2023-07-28', 17, 3),
(443, 'Tratamiento 3', 'Descripción del tratamiento 3', 723.12, '2023-07-22', '2023-07-29', 17, 3),
(444, 'Tratamiento 4', 'Descripción del tratamiento 4', 306.91, '2023-07-23', '2023-07-30', 17, 3),
(445, 'Tratamiento 5', 'Descripción del tratamiento 5', 365.18, '2023-07-24', '2023-07-31', 17, 3),
(446, 'Tratamiento 6', 'Descripción del tratamiento 6', 905.19, '2023-07-25', '2023-08-01', 17, 3),
(447, 'Tratamiento 7', 'Descripción del tratamiento 7', 430.42, '2023-07-26', '2023-08-02', 17, 3),
(448, 'Tratamiento 8', 'Descripción del tratamiento 8', 436.50, '2023-07-27', '2023-08-03', 17, 3),
(449, 'Tratamiento 9', 'Descripción del tratamiento 9', 891.26, '2023-07-28', '2023-08-04', 17, 3),
(450, 'Tratamiento 10', 'Descripción del tratamiento 10', 146.80, '2023-07-29', '2023-08-05', 17, 3),
(451, 'Tratamiento 1', 'Descripción del tratamiento 1', 60.20, '2023-07-20', '2023-07-27', 16, 3),
(452, 'Tratamiento 2', 'Descripción del tratamiento 2', 860.59, '2023-07-21', '2023-07-28', 16, 3),
(453, 'Tratamiento 3', 'Descripción del tratamiento 3', 122.37, '2023-07-22', '2023-07-29', 16, 3),
(454, 'Tratamiento 4', 'Descripción del tratamiento 4', 30.08, '2023-07-23', '2023-07-30', 16, 3),
(455, 'Tratamiento 5', 'Descripción del tratamiento 5', 783.28, '2023-07-24', '2023-07-31', 16, 3),
(456, 'Tratamiento 6', 'Descripción del tratamiento 6', 826.15, '2023-07-25', '2023-08-01', 16, 3),
(457, 'Tratamiento 7', 'Descripción del tratamiento 7', 780.91, '2023-07-26', '2023-08-02', 16, 3),
(458, 'Tratamiento 8', 'Descripción del tratamiento 8', 426.12, '2023-07-27', '2023-08-03', 16, 3),
(459, 'Tratamiento 9', 'Descripción del tratamiento 9', 787.86, '2023-07-28', '2023-08-04', 16, 3),
(460, 'Tratamiento 10', 'Descripción del tratamiento 10', 660.96, '2023-07-29', '2023-08-05', 16, 3),
(461, 'Tratamiento 1', 'Descripción del tratamiento 1', 941.21, '2023-07-20', '2023-07-27', 12, 3),
(462, 'Tratamiento 2', 'Descripción del tratamiento 2', 723.15, '2023-07-21', '2023-07-28', 12, 3),
(463, 'Tratamiento 3', 'Descripción del tratamiento 3', 792.15, '2023-07-22', '2023-07-29', 12, 3),
(464, 'Tratamiento 4', 'Descripción del tratamiento 4', 791.30, '2023-07-23', '2023-07-30', 12, 3),
(465, 'Tratamiento 5', 'Descripción del tratamiento 5', 580.05, '2023-07-24', '2023-07-31', 12, 3),
(466, 'Tratamiento 6', 'Descripción del tratamiento 6', 526.32, '2023-07-25', '2023-08-01', 12, 3),
(467, 'Tratamiento 7', 'Descripción del tratamiento 7', 891.48, '2023-07-26', '2023-08-02', 12, 3),
(468, 'Tratamiento 8', 'Descripción del tratamiento 8', 878.43, '2023-07-27', '2023-08-03', 12, 3),
(469, 'Tratamiento 9', 'Descripción del tratamiento 9', 717.70, '2023-07-28', '2023-08-04', 12, 3),
(470, 'Tratamiento 10', 'Descripción del tratamiento 10', 953.23, '2023-07-29', '2023-08-05', 12, 3),
(471, 'Tratamiento 1', 'Descripción del tratamiento 1', 613.06, '2023-07-20', '2023-07-27', 19, 3),
(472, 'Tratamiento 2', 'Descripción del tratamiento 2', 205.60, '2023-07-21', '2023-07-28', 19, 3),
(473, 'Tratamiento 3', 'Descripción del tratamiento 3', 188.83, '2023-07-22', '2023-07-29', 19, 3),
(474, 'Tratamiento 4', 'Descripción del tratamiento 4', 327.34, '2023-07-23', '2023-07-30', 19, 3),
(475, 'Tratamiento 5', 'Descripción del tratamiento 5', 70.19, '2023-07-24', '2023-07-31', 19, 3),
(476, 'Tratamiento 6', 'Descripción del tratamiento 6', 368.95, '2023-07-25', '2023-08-01', 19, 3),
(477, 'Tratamiento 7', 'Descripción del tratamiento 7', 634.18, '2023-07-26', '2023-08-02', 19, 3),
(478, 'Tratamiento 8', 'Descripción del tratamiento 8', 64.04, '2023-07-27', '2023-08-03', 19, 3),
(479, 'Tratamiento 9', 'Descripción del tratamiento 9', 417.68, '2023-07-28', '2023-08-04', 19, 3),
(480, 'Tratamiento 10', 'Descripción del tratamiento 10', 896.27, '2023-07-29', '2023-08-05', 19, 3),
(481, 'Tratamiento 1', 'Descripción del tratamiento 1', 228.32, '2023-07-20', '2023-07-27', 20, 3),
(482, 'Tratamiento 2', 'Descripción del tratamiento 2', 452.79, '2023-07-21', '2023-07-28', 20, 3),
(483, 'Tratamiento 3', 'Descripción del tratamiento 3', 579.00, '2023-07-22', '2023-07-29', 20, 3),
(484, 'Tratamiento 4', 'Descripción del tratamiento 4', 536.62, '2023-07-23', '2023-07-30', 20, 3),
(485, 'Tratamiento 5', 'Descripción del tratamiento 5', 946.08, '2023-07-24', '2023-07-31', 20, 3),
(486, 'Tratamiento 6', 'Descripción del tratamiento 6', 120.56, '2023-07-25', '2023-08-01', 20, 3),
(487, 'Tratamiento 7', 'Descripción del tratamiento 7', 764.57, '2023-07-26', '2023-08-02', 20, 3),
(488, 'Tratamiento 8', 'Descripción del tratamiento 8', 461.16, '2023-07-27', '2023-08-03', 20, 3),
(489, 'Tratamiento 9', 'Descripción del tratamiento 9', 12.07, '2023-07-28', '2023-08-04', 20, 3),
(490, 'Tratamiento 10', 'Descripción del tratamiento 10', 676.88, '2023-07-29', '2023-08-05', 20, 3),
(491, 'Tratamiento 1', 'Descripción del tratamiento 1', 348.21, '2023-07-20', '2023-07-27', 5, 3),
(492, 'Tratamiento 2', 'Descripción del tratamiento 2', 710.40, '2023-07-21', '2023-07-28', 5, 3),
(493, 'Tratamiento 3', 'Descripción del tratamiento 3', 507.37, '2023-07-22', '2023-07-29', 5, 3),
(494, 'Tratamiento 4', 'Descripción del tratamiento 4', 405.64, '2023-07-23', '2023-07-30', 5, 3),
(495, 'Tratamiento 5', 'Descripción del tratamiento 5', 506.10, '2023-07-24', '2023-07-31', 5, 3),
(496, 'Tratamiento 6', 'Descripción del tratamiento 6', 313.56, '2023-07-25', '2023-08-01', 5, 3),
(497, 'Tratamiento 7', 'Descripción del tratamiento 7', 49.51, '2023-07-26', '2023-08-02', 5, 3),
(498, 'Tratamiento 8', 'Descripción del tratamiento 8', 306.88, '2023-07-27', '2023-08-03', 5, 3),
(499, 'Tratamiento 9', 'Descripción del tratamiento 9', 385.88, '2023-07-28', '2023-08-04', 5, 3),
(500, 'Tratamiento 10', 'Descripción del tratamiento 10', 8.75, '2023-07-29', '2023-08-05', 5, 3),
(501, 'Tratamiento 1', 'Descripción del tratamiento 1', 886.12, '2023-07-20', '2023-07-27', 2, 7),
(502, 'Tratamiento 2', 'Descripción del tratamiento 2', 404.35, '2023-07-21', '2023-07-28', 2, 7),
(503, 'Tratamiento 3', 'Descripción del tratamiento 3', 363.40, '2023-07-22', '2023-07-29', 2, 7),
(504, 'Tratamiento 4', 'Descripción del tratamiento 4', 603.94, '2023-07-23', '2023-07-30', 2, 7),
(505, 'Tratamiento 5', 'Descripción del tratamiento 5', 929.50, '2023-07-24', '2023-07-31', 2, 7),
(506, 'Tratamiento 6', 'Descripción del tratamiento 6', 835.69, '2023-07-25', '2023-08-01', 2, 7),
(507, 'Tratamiento 7', 'Descripción del tratamiento 7', 389.93, '2023-07-26', '2023-08-02', 2, 7),
(508, 'Tratamiento 8', 'Descripción del tratamiento 8', 442.60, '2023-07-27', '2023-08-03', 2, 7),
(509, 'Tratamiento 9', 'Descripción del tratamiento 9', 43.22, '2023-07-28', '2023-08-04', 2, 7),
(510, 'Tratamiento 10', 'Descripción del tratamiento 10', 888.28, '2023-07-29', '2023-08-05', 2, 7);
INSERT INTO `tratamiento` (`id`, `nombre`, `descripcion`, `costo`, `fecha_inicio`, `fecha_fin`, `paciente_id`, `doctor_id`) VALUES
(511, 'Tratamiento 1', 'Descripción del tratamiento 1', 311.77, '2023-07-20', '2023-07-27', 3, 7),
(512, 'Tratamiento 2', 'Descripción del tratamiento 2', 893.98, '2023-07-21', '2023-07-28', 3, 7),
(513, 'Tratamiento 3', 'Descripción del tratamiento 3', 534.60, '2023-07-22', '2023-07-29', 3, 7),
(514, 'Tratamiento 4', 'Descripción del tratamiento 4', 991.05, '2023-07-23', '2023-07-30', 3, 7),
(515, 'Tratamiento 5', 'Descripción del tratamiento 5', 351.45, '2023-07-24', '2023-07-31', 3, 7),
(516, 'Tratamiento 6', 'Descripción del tratamiento 6', 784.10, '2023-07-25', '2023-08-01', 3, 7),
(517, 'Tratamiento 7', 'Descripción del tratamiento 7', 866.14, '2023-07-26', '2023-08-02', 3, 7),
(518, 'Tratamiento 8', 'Descripción del tratamiento 8', 978.40, '2023-07-27', '2023-08-03', 3, 7),
(519, 'Tratamiento 9', 'Descripción del tratamiento 9', 293.58, '2023-07-28', '2023-08-04', 3, 7),
(520, 'Tratamiento 10', 'Descripción del tratamiento 10', 532.69, '2023-07-29', '2023-08-05', 3, 7),
(521, 'Tratamiento 1', 'Descripción del tratamiento 1', 782.73, '2023-07-20', '2023-07-27', 13, 7),
(522, 'Tratamiento 2', 'Descripción del tratamiento 2', 315.59, '2023-07-21', '2023-07-28', 13, 7),
(523, 'Tratamiento 3', 'Descripción del tratamiento 3', 229.75, '2023-07-22', '2023-07-29', 13, 7),
(524, 'Tratamiento 4', 'Descripción del tratamiento 4', 201.96, '2023-07-23', '2023-07-30', 13, 7),
(525, 'Tratamiento 5', 'Descripción del tratamiento 5', 320.57, '2023-07-24', '2023-07-31', 13, 7),
(526, 'Tratamiento 6', 'Descripción del tratamiento 6', 996.95, '2023-07-25', '2023-08-01', 13, 7),
(527, 'Tratamiento 7', 'Descripción del tratamiento 7', 23.04, '2023-07-26', '2023-08-02', 13, 7),
(528, 'Tratamiento 8', 'Descripción del tratamiento 8', 124.37, '2023-07-27', '2023-08-03', 13, 7),
(529, 'Tratamiento 9', 'Descripción del tratamiento 9', 552.72, '2023-07-28', '2023-08-04', 13, 7),
(530, 'Tratamiento 10', 'Descripción del tratamiento 10', 390.47, '2023-07-29', '2023-08-05', 13, 7),
(531, 'Tratamiento 1', 'Descripción del tratamiento 1', 294.22, '2023-07-20', '2023-07-27', 10, 7),
(532, 'Tratamiento 2', 'Descripción del tratamiento 2', 299.67, '2023-07-21', '2023-07-28', 10, 7),
(533, 'Tratamiento 3', 'Descripción del tratamiento 3', 615.70, '2023-07-22', '2023-07-29', 10, 7),
(534, 'Tratamiento 4', 'Descripción del tratamiento 4', 179.50, '2023-07-23', '2023-07-30', 10, 7),
(535, 'Tratamiento 5', 'Descripción del tratamiento 5', 50.39, '2023-07-24', '2023-07-31', 10, 7),
(536, 'Tratamiento 6', 'Descripción del tratamiento 6', 713.46, '2023-07-25', '2023-08-01', 10, 7),
(537, 'Tratamiento 7', 'Descripción del tratamiento 7', 416.13, '2023-07-26', '2023-08-02', 10, 7),
(538, 'Tratamiento 8', 'Descripción del tratamiento 8', 940.26, '2023-07-27', '2023-08-03', 10, 7),
(539, 'Tratamiento 9', 'Descripción del tratamiento 9', 452.93, '2023-07-28', '2023-08-04', 10, 7),
(540, 'Tratamiento 10', 'Descripción del tratamiento 10', 443.86, '2023-07-29', '2023-08-05', 10, 7),
(541, 'Tratamiento 1', 'Descripción del tratamiento 1', 860.52, '2023-07-20', '2023-07-27', 17, 7),
(542, 'Tratamiento 2', 'Descripción del tratamiento 2', 971.02, '2023-07-21', '2023-07-28', 17, 7),
(543, 'Tratamiento 3', 'Descripción del tratamiento 3', 273.52, '2023-07-22', '2023-07-29', 17, 7),
(544, 'Tratamiento 4', 'Descripción del tratamiento 4', 454.56, '2023-07-23', '2023-07-30', 17, 7),
(545, 'Tratamiento 5', 'Descripción del tratamiento 5', 452.23, '2023-07-24', '2023-07-31', 17, 7),
(546, 'Tratamiento 6', 'Descripción del tratamiento 6', 897.49, '2023-07-25', '2023-08-01', 17, 7),
(547, 'Tratamiento 7', 'Descripción del tratamiento 7', 130.76, '2023-07-26', '2023-08-02', 17, 7),
(548, 'Tratamiento 8', 'Descripción del tratamiento 8', 961.31, '2023-07-27', '2023-08-03', 17, 7),
(549, 'Tratamiento 9', 'Descripción del tratamiento 9', 414.26, '2023-07-28', '2023-08-04', 17, 7),
(550, 'Tratamiento 10', 'Descripción del tratamiento 10', 187.39, '2023-07-29', '2023-08-05', 17, 7),
(551, 'Tratamiento 1', 'Descripción del tratamiento 1', 694.16, '2023-07-20', '2023-07-27', 16, 7),
(552, 'Tratamiento 2', 'Descripción del tratamiento 2', 908.63, '2023-07-21', '2023-07-28', 16, 7),
(553, 'Tratamiento 3', 'Descripción del tratamiento 3', 460.66, '2023-07-22', '2023-07-29', 16, 7),
(554, 'Tratamiento 4', 'Descripción del tratamiento 4', 577.41, '2023-07-23', '2023-07-30', 16, 7),
(555, 'Tratamiento 5', 'Descripción del tratamiento 5', 505.05, '2023-07-24', '2023-07-31', 16, 7),
(556, 'Tratamiento 6', 'Descripción del tratamiento 6', 793.06, '2023-07-25', '2023-08-01', 16, 7),
(557, 'Tratamiento 7', 'Descripción del tratamiento 7', 450.13, '2023-07-26', '2023-08-02', 16, 7),
(558, 'Tratamiento 8', 'Descripción del tratamiento 8', 871.48, '2023-07-27', '2023-08-03', 16, 7),
(559, 'Tratamiento 9', 'Descripción del tratamiento 9', 7.02, '2023-07-28', '2023-08-04', 16, 7),
(560, 'Tratamiento 10', 'Descripción del tratamiento 10', 420.65, '2023-07-29', '2023-08-05', 16, 7),
(561, 'Tratamiento 1', 'Descripción del tratamiento 1', 82.18, '2023-07-20', '2023-07-27', 12, 7),
(562, 'Tratamiento 2', 'Descripción del tratamiento 2', 148.95, '2023-07-21', '2023-07-28', 12, 7),
(563, 'Tratamiento 3', 'Descripción del tratamiento 3', 498.21, '2023-07-22', '2023-07-29', 12, 7),
(564, 'Tratamiento 4', 'Descripción del tratamiento 4', 44.18, '2023-07-23', '2023-07-30', 12, 7),
(565, 'Tratamiento 5', 'Descripción del tratamiento 5', 726.31, '2023-07-24', '2023-07-31', 12, 7),
(566, 'Tratamiento 6', 'Descripción del tratamiento 6', 498.98, '2023-07-25', '2023-08-01', 12, 7),
(567, 'Tratamiento 7', 'Descripción del tratamiento 7', 315.98, '2023-07-26', '2023-08-02', 12, 7),
(568, 'Tratamiento 8', 'Descripción del tratamiento 8', 82.96, '2023-07-27', '2023-08-03', 12, 7),
(569, 'Tratamiento 9', 'Descripción del tratamiento 9', 466.85, '2023-07-28', '2023-08-04', 12, 7),
(570, 'Tratamiento 10', 'Descripción del tratamiento 10', 85.38, '2023-07-29', '2023-08-05', 12, 7),
(571, 'Tratamiento 1', 'Descripción del tratamiento 1', 26.37, '2023-07-20', '2023-07-27', 19, 7),
(572, 'Tratamiento 2', 'Descripción del tratamiento 2', 875.69, '2023-07-21', '2023-07-28', 19, 7),
(573, 'Tratamiento 3', 'Descripción del tratamiento 3', 299.34, '2023-07-22', '2023-07-29', 19, 7),
(574, 'Tratamiento 4', 'Descripción del tratamiento 4', 869.63, '2023-07-23', '2023-07-30', 19, 7),
(575, 'Tratamiento 5', 'Descripción del tratamiento 5', 450.15, '2023-07-24', '2023-07-31', 19, 7),
(576, 'Tratamiento 6', 'Descripción del tratamiento 6', 641.84, '2023-07-25', '2023-08-01', 19, 7),
(577, 'Tratamiento 7', 'Descripción del tratamiento 7', 858.77, '2023-07-26', '2023-08-02', 19, 7),
(578, 'Tratamiento 8', 'Descripción del tratamiento 8', 368.32, '2023-07-27', '2023-08-03', 19, 7),
(579, 'Tratamiento 9', 'Descripción del tratamiento 9', 265.27, '2023-07-28', '2023-08-04', 19, 7),
(580, 'Tratamiento 10', 'Descripción del tratamiento 10', 221.41, '2023-07-29', '2023-08-05', 19, 7),
(581, 'Tratamiento 1', 'Descripción del tratamiento 1', 311.24, '2023-07-20', '2023-07-27', 20, 7),
(582, 'Tratamiento 2', 'Descripción del tratamiento 2', 891.97, '2023-07-21', '2023-07-28', 20, 7),
(583, 'Tratamiento 3', 'Descripción del tratamiento 3', 526.15, '2023-07-22', '2023-07-29', 20, 7),
(584, 'Tratamiento 4', 'Descripción del tratamiento 4', 954.80, '2023-07-23', '2023-07-30', 20, 7),
(585, 'Tratamiento 5', 'Descripción del tratamiento 5', 195.58, '2023-07-24', '2023-07-31', 20, 7),
(586, 'Tratamiento 6', 'Descripción del tratamiento 6', 113.50, '2023-07-25', '2023-08-01', 20, 7),
(587, 'Tratamiento 7', 'Descripción del tratamiento 7', 980.74, '2023-07-26', '2023-08-02', 20, 7),
(588, 'Tratamiento 8', 'Descripción del tratamiento 8', 563.23, '2023-07-27', '2023-08-03', 20, 7),
(589, 'Tratamiento 9', 'Descripción del tratamiento 9', 873.91, '2023-07-28', '2023-08-04', 20, 7),
(590, 'Tratamiento 10', 'Descripción del tratamiento 10', 679.88, '2023-07-29', '2023-08-05', 20, 7),
(591, 'Tratamiento 1', 'Descripción del tratamiento 1', 777.66, '2023-07-20', '2023-07-27', 5, 7),
(592, 'Tratamiento 2', 'Descripción del tratamiento 2', 848.66, '2023-07-21', '2023-07-28', 5, 7),
(593, 'Tratamiento 3', 'Descripción del tratamiento 3', 910.33, '2023-07-22', '2023-07-29', 5, 7),
(594, 'Tratamiento 4', 'Descripción del tratamiento 4', 5.65, '2023-07-23', '2023-07-30', 5, 7),
(595, 'Tratamiento 5', 'Descripción del tratamiento 5', 297.25, '2023-07-24', '2023-07-31', 5, 7),
(596, 'Tratamiento 6', 'Descripción del tratamiento 6', 469.31, '2023-07-25', '2023-08-01', 5, 7),
(597, 'Tratamiento 7', 'Descripción del tratamiento 7', 454.79, '2023-07-26', '2023-08-02', 5, 7),
(598, 'Tratamiento 8', 'Descripción del tratamiento 8', 866.04, '2023-07-27', '2023-08-03', 5, 7),
(599, 'Tratamiento 9', 'Descripción del tratamiento 9', 965.84, '2023-07-28', '2023-08-04', 5, 7),
(600, 'Tratamiento 10', 'Descripción del tratamiento 10', 231.08, '2023-07-29', '2023-08-05', 5, 7),
(601, 'Tratamiento 1', 'Descripción del tratamiento 1', 257.87, '2023-07-20', '2023-07-27', 2, 5),
(602, 'Tratamiento 2', 'Descripción del tratamiento 2', 596.12, '2023-07-21', '2023-07-28', 2, 5),
(603, 'Tratamiento 3', 'Descripción del tratamiento 3', 206.99, '2023-07-22', '2023-07-29', 2, 5),
(604, 'Tratamiento 4', 'Descripción del tratamiento 4', 246.58, '2023-07-23', '2023-07-30', 2, 5),
(605, 'Tratamiento 5', 'Descripción del tratamiento 5', 611.92, '2023-07-24', '2023-07-31', 2, 5),
(606, 'Tratamiento 6', 'Descripción del tratamiento 6', 319.87, '2023-07-25', '2023-08-01', 2, 5),
(607, 'Tratamiento 7', 'Descripción del tratamiento 7', 763.61, '2023-07-26', '2023-08-02', 2, 5),
(608, 'Tratamiento 8', 'Descripción del tratamiento 8', 858.43, '2023-07-27', '2023-08-03', 2, 5),
(609, 'Tratamiento 9', 'Descripción del tratamiento 9', 1.31, '2023-07-28', '2023-08-04', 2, 5),
(610, 'Tratamiento 10', 'Descripción del tratamiento 10', 431.24, '2023-07-29', '2023-08-05', 2, 5),
(611, 'Tratamiento 1', 'Descripción del tratamiento 1', 152.31, '2023-07-20', '2023-07-27', 3, 5),
(612, 'Tratamiento 2', 'Descripción del tratamiento 2', 467.81, '2023-07-21', '2023-07-28', 3, 5),
(613, 'Tratamiento 3', 'Descripción del tratamiento 3', 882.10, '2023-07-22', '2023-07-29', 3, 5),
(614, 'Tratamiento 4', 'Descripción del tratamiento 4', 7.10, '2023-07-23', '2023-07-30', 3, 5),
(615, 'Tratamiento 5', 'Descripción del tratamiento 5', 389.20, '2023-07-24', '2023-07-31', 3, 5),
(616, 'Tratamiento 6', 'Descripción del tratamiento 6', 924.69, '2023-07-25', '2023-08-01', 3, 5),
(617, 'Tratamiento 7', 'Descripción del tratamiento 7', 455.86, '2023-07-26', '2023-08-02', 3, 5),
(618, 'Tratamiento 8', 'Descripción del tratamiento 8', 505.20, '2023-07-27', '2023-08-03', 3, 5),
(619, 'Tratamiento 9', 'Descripción del tratamiento 9', 158.45, '2023-07-28', '2023-08-04', 3, 5),
(620, 'Tratamiento 10', 'Descripción del tratamiento 10', 276.65, '2023-07-29', '2023-08-05', 3, 5),
(621, 'Tratamiento 1', 'Descripción del tratamiento 1', 907.88, '2023-07-20', '2023-07-27', 13, 5),
(622, 'Tratamiento 2', 'Descripción del tratamiento 2', 709.44, '2023-07-21', '2023-07-28', 13, 5),
(623, 'Tratamiento 3', 'Descripción del tratamiento 3', 823.59, '2023-07-22', '2023-07-29', 13, 5),
(624, 'Tratamiento 4', 'Descripción del tratamiento 4', 989.62, '2023-07-23', '2023-07-30', 13, 5),
(625, 'Tratamiento 5', 'Descripción del tratamiento 5', 477.34, '2023-07-24', '2023-07-31', 13, 5),
(626, 'Tratamiento 6', 'Descripción del tratamiento 6', 417.83, '2023-07-25', '2023-08-01', 13, 5),
(627, 'Tratamiento 7', 'Descripción del tratamiento 7', 657.14, '2023-07-26', '2023-08-02', 13, 5),
(628, 'Tratamiento 8', 'Descripción del tratamiento 8', 32.19, '2023-07-27', '2023-08-03', 13, 5),
(629, 'Tratamiento 9', 'Descripción del tratamiento 9', 189.55, '2023-07-28', '2023-08-04', 13, 5),
(630, 'Tratamiento 10', 'Descripción del tratamiento 10', 851.16, '2023-07-29', '2023-08-05', 13, 5),
(631, 'Tratamiento 1', 'Descripción del tratamiento 1', 687.15, '2023-07-20', '2023-07-27', 10, 5),
(632, 'Tratamiento 2', 'Descripción del tratamiento 2', 882.27, '2023-07-21', '2023-07-28', 10, 5),
(633, 'Tratamiento 3', 'Descripción del tratamiento 3', 349.90, '2023-07-22', '2023-07-29', 10, 5),
(634, 'Tratamiento 4', 'Descripción del tratamiento 4', 102.71, '2023-07-23', '2023-07-30', 10, 5),
(635, 'Tratamiento 5', 'Descripción del tratamiento 5', 463.83, '2023-07-24', '2023-07-31', 10, 5),
(636, 'Tratamiento 6', 'Descripción del tratamiento 6', 11.01, '2023-07-25', '2023-08-01', 10, 5),
(637, 'Tratamiento 7', 'Descripción del tratamiento 7', 663.59, '2023-07-26', '2023-08-02', 10, 5),
(638, 'Tratamiento 8', 'Descripción del tratamiento 8', 284.89, '2023-07-27', '2023-08-03', 10, 5),
(639, 'Tratamiento 9', 'Descripción del tratamiento 9', 433.71, '2023-07-28', '2023-08-04', 10, 5),
(640, 'Tratamiento 10', 'Descripción del tratamiento 10', 313.86, '2023-07-29', '2023-08-05', 10, 5),
(641, 'Tratamiento 1', 'Descripción del tratamiento 1', 268.16, '2023-07-20', '2023-07-27', 17, 5),
(642, 'Tratamiento 2', 'Descripción del tratamiento 2', 399.21, '2023-07-21', '2023-07-28', 17, 5),
(643, 'Tratamiento 3', 'Descripción del tratamiento 3', 191.60, '2023-07-22', '2023-07-29', 17, 5),
(644, 'Tratamiento 4', 'Descripción del tratamiento 4', 760.38, '2023-07-23', '2023-07-30', 17, 5),
(645, 'Tratamiento 5', 'Descripción del tratamiento 5', 227.08, '2023-07-24', '2023-07-31', 17, 5),
(646, 'Tratamiento 6', 'Descripción del tratamiento 6', 854.25, '2023-07-25', '2023-08-01', 17, 5),
(647, 'Tratamiento 7', 'Descripción del tratamiento 7', 590.02, '2023-07-26', '2023-08-02', 17, 5),
(648, 'Tratamiento 8', 'Descripción del tratamiento 8', 387.33, '2023-07-27', '2023-08-03', 17, 5),
(649, 'Tratamiento 9', 'Descripción del tratamiento 9', 166.61, '2023-07-28', '2023-08-04', 17, 5),
(650, 'Tratamiento 10', 'Descripción del tratamiento 10', 671.07, '2023-07-29', '2023-08-05', 17, 5),
(651, 'Tratamiento 1', 'Descripción del tratamiento 1', 855.49, '2023-07-20', '2023-07-27', 16, 5),
(652, 'Tratamiento 2', 'Descripción del tratamiento 2', 264.27, '2023-07-21', '2023-07-28', 16, 5),
(653, 'Tratamiento 3', 'Descripción del tratamiento 3', 754.85, '2023-07-22', '2023-07-29', 16, 5),
(654, 'Tratamiento 4', 'Descripción del tratamiento 4', 981.45, '2023-07-23', '2023-07-30', 16, 5),
(655, 'Tratamiento 5', 'Descripción del tratamiento 5', 642.71, '2023-07-24', '2023-07-31', 16, 5),
(656, 'Tratamiento 6', 'Descripción del tratamiento 6', 269.18, '2023-07-25', '2023-08-01', 16, 5),
(657, 'Tratamiento 7', 'Descripción del tratamiento 7', 417.80, '2023-07-26', '2023-08-02', 16, 5),
(658, 'Tratamiento 8', 'Descripción del tratamiento 8', 281.44, '2023-07-27', '2023-08-03', 16, 5),
(659, 'Tratamiento 9', 'Descripción del tratamiento 9', 153.82, '2023-07-28', '2023-08-04', 16, 5),
(660, 'Tratamiento 10', 'Descripción del tratamiento 10', 924.76, '2023-07-29', '2023-08-05', 16, 5),
(661, 'Tratamiento 1', 'Descripción del tratamiento 1', 162.34, '2023-07-20', '2023-07-27', 12, 5),
(662, 'Tratamiento 2', 'Descripción del tratamiento 2', 37.43, '2023-07-21', '2023-07-28', 12, 5),
(663, 'Tratamiento 3', 'Descripción del tratamiento 3', 700.13, '2023-07-22', '2023-07-29', 12, 5),
(664, 'Tratamiento 4', 'Descripción del tratamiento 4', 388.36, '2023-07-23', '2023-07-30', 12, 5),
(665, 'Tratamiento 5', 'Descripción del tratamiento 5', 841.39, '2023-07-24', '2023-07-31', 12, 5),
(666, 'Tratamiento 6', 'Descripción del tratamiento 6', 41.89, '2023-07-25', '2023-08-01', 12, 5),
(667, 'Tratamiento 7', 'Descripción del tratamiento 7', 685.26, '2023-07-26', '2023-08-02', 12, 5),
(668, 'Tratamiento 8', 'Descripción del tratamiento 8', 300.64, '2023-07-27', '2023-08-03', 12, 5),
(669, 'Tratamiento 9', 'Descripción del tratamiento 9', 447.41, '2023-07-28', '2023-08-04', 12, 5),
(670, 'Tratamiento 10', 'Descripción del tratamiento 10', 335.13, '2023-07-29', '2023-08-05', 12, 5),
(671, 'Tratamiento 1', 'Descripción del tratamiento 1', 333.42, '2023-07-20', '2023-07-27', 19, 5),
(672, 'Tratamiento 2', 'Descripción del tratamiento 2', 661.70, '2023-07-21', '2023-07-28', 19, 5),
(673, 'Tratamiento 3', 'Descripción del tratamiento 3', 308.25, '2023-07-22', '2023-07-29', 19, 5),
(674, 'Tratamiento 4', 'Descripción del tratamiento 4', 556.16, '2023-07-23', '2023-07-30', 19, 5),
(675, 'Tratamiento 5', 'Descripción del tratamiento 5', 856.06, '2023-07-24', '2023-07-31', 19, 5),
(676, 'Tratamiento 6', 'Descripción del tratamiento 6', 611.79, '2023-07-25', '2023-08-01', 19, 5),
(677, 'Tratamiento 7', 'Descripción del tratamiento 7', 490.79, '2023-07-26', '2023-08-02', 19, 5),
(678, 'Tratamiento 8', 'Descripción del tratamiento 8', 618.57, '2023-07-27', '2023-08-03', 19, 5),
(679, 'Tratamiento 9', 'Descripción del tratamiento 9', 620.48, '2023-07-28', '2023-08-04', 19, 5),
(680, 'Tratamiento 10', 'Descripción del tratamiento 10', 246.71, '2023-07-29', '2023-08-05', 19, 5),
(681, 'Tratamiento 1', 'Descripción del tratamiento 1', 372.08, '2023-07-20', '2023-07-27', 20, 5),
(682, 'Tratamiento 2', 'Descripción del tratamiento 2', 120.27, '2023-07-21', '2023-07-28', 20, 5),
(683, 'Tratamiento 3', 'Descripción del tratamiento 3', 485.13, '2023-07-22', '2023-07-29', 20, 5),
(684, 'Tratamiento 4', 'Descripción del tratamiento 4', 64.83, '2023-07-23', '2023-07-30', 20, 5),
(685, 'Tratamiento 5', 'Descripción del tratamiento 5', 868.77, '2023-07-24', '2023-07-31', 20, 5),
(686, 'Tratamiento 6', 'Descripción del tratamiento 6', 149.36, '2023-07-25', '2023-08-01', 20, 5),
(687, 'Tratamiento 7', 'Descripción del tratamiento 7', 140.47, '2023-07-26', '2023-08-02', 20, 5),
(688, 'Tratamiento 8', 'Descripción del tratamiento 8', 254.30, '2023-07-27', '2023-08-03', 20, 5),
(689, 'Tratamiento 9', 'Descripción del tratamiento 9', 850.08, '2023-07-28', '2023-08-04', 20, 5),
(690, 'Tratamiento 10', 'Descripción del tratamiento 10', 487.52, '2023-07-29', '2023-08-05', 20, 5),
(691, 'Tratamiento 1', 'Descripción del tratamiento 1', 887.33, '2023-07-20', '2023-07-27', 5, 5),
(692, 'Tratamiento 2', 'Descripción del tratamiento 2', 974.12, '2023-07-21', '2023-07-28', 5, 5),
(693, 'Tratamiento 3', 'Descripción del tratamiento 3', 208.59, '2023-07-22', '2023-07-29', 5, 5),
(694, 'Tratamiento 4', 'Descripción del tratamiento 4', 120.59, '2023-07-23', '2023-07-30', 5, 5),
(695, 'Tratamiento 5', 'Descripción del tratamiento 5', 977.18, '2023-07-24', '2023-07-31', 5, 5),
(696, 'Tratamiento 6', 'Descripción del tratamiento 6', 524.13, '2023-07-25', '2023-08-01', 5, 5),
(697, 'Tratamiento 7', 'Descripción del tratamiento 7', 689.11, '2023-07-26', '2023-08-02', 5, 5),
(698, 'Tratamiento 8', 'Descripción del tratamiento 8', 873.16, '2023-07-27', '2023-08-03', 5, 5),
(699, 'Tratamiento 9', 'Descripción del tratamiento 9', 298.47, '2023-07-28', '2023-08-04', 5, 5),
(700, 'Tratamiento 10', 'Descripción del tratamiento 10', 872.88, '2023-07-29', '2023-08-05', 5, 5),
(701, 'Tratamiento 1', 'Descripción del tratamiento 1', 468.98, '2023-07-20', '2023-07-27', 2, 4),
(702, 'Tratamiento 2', 'Descripción del tratamiento 2', 726.26, '2023-07-21', '2023-07-28', 2, 4),
(703, 'Tratamiento 3', 'Descripción del tratamiento 3', 224.38, '2023-07-22', '2023-07-29', 2, 4),
(704, 'Tratamiento 4', 'Descripción del tratamiento 4', 943.11, '2023-07-23', '2023-07-30', 2, 4),
(705, 'Tratamiento 5', 'Descripción del tratamiento 5', 42.41, '2023-07-24', '2023-07-31', 2, 4),
(706, 'Tratamiento 6', 'Descripción del tratamiento 6', 382.70, '2023-07-25', '2023-08-01', 2, 4),
(707, 'Tratamiento 7', 'Descripción del tratamiento 7', 786.29, '2023-07-26', '2023-08-02', 2, 4),
(708, 'Tratamiento 8', 'Descripción del tratamiento 8', 783.34, '2023-07-27', '2023-08-03', 2, 4),
(709, 'Tratamiento 9', 'Descripción del tratamiento 9', 557.83, '2023-07-28', '2023-08-04', 2, 4),
(710, 'Tratamiento 10', 'Descripción del tratamiento 10', 439.13, '2023-07-29', '2023-08-05', 2, 4),
(711, 'Tratamiento 1', 'Descripción del tratamiento 1', 522.14, '2023-07-20', '2023-07-27', 3, 4),
(712, 'Tratamiento 2', 'Descripción del tratamiento 2', 293.34, '2023-07-21', '2023-07-28', 3, 4),
(713, 'Tratamiento 3', 'Descripción del tratamiento 3', 900.27, '2023-07-22', '2023-07-29', 3, 4),
(714, 'Tratamiento 4', 'Descripción del tratamiento 4', 621.33, '2023-07-23', '2023-07-30', 3, 4),
(715, 'Tratamiento 5', 'Descripción del tratamiento 5', 405.86, '2023-07-24', '2023-07-31', 3, 4),
(716, 'Tratamiento 6', 'Descripción del tratamiento 6', 165.30, '2023-07-25', '2023-08-01', 3, 4),
(717, 'Tratamiento 7', 'Descripción del tratamiento 7', 608.92, '2023-07-26', '2023-08-02', 3, 4),
(718, 'Tratamiento 8', 'Descripción del tratamiento 8', 548.68, '2023-07-27', '2023-08-03', 3, 4),
(719, 'Tratamiento 9', 'Descripción del tratamiento 9', 916.66, '2023-07-28', '2023-08-04', 3, 4),
(720, 'Tratamiento 10', 'Descripción del tratamiento 10', 937.24, '2023-07-29', '2023-08-05', 3, 4),
(721, 'Tratamiento 1', 'Descripción del tratamiento 1', 936.21, '2023-07-20', '2023-07-27', 13, 4),
(722, 'Tratamiento 2', 'Descripción del tratamiento 2', 869.35, '2023-07-21', '2023-07-28', 13, 4),
(723, 'Tratamiento 3', 'Descripción del tratamiento 3', 538.12, '2023-07-22', '2023-07-29', 13, 4),
(724, 'Tratamiento 4', 'Descripción del tratamiento 4', 82.53, '2023-07-23', '2023-07-30', 13, 4),
(725, 'Tratamiento 5', 'Descripción del tratamiento 5', 798.32, '2023-07-24', '2023-07-31', 13, 4),
(726, 'Tratamiento 6', 'Descripción del tratamiento 6', 744.01, '2023-07-25', '2023-08-01', 13, 4),
(727, 'Tratamiento 7', 'Descripción del tratamiento 7', 325.09, '2023-07-26', '2023-08-02', 13, 4),
(728, 'Tratamiento 8', 'Descripción del tratamiento 8', 393.42, '2023-07-27', '2023-08-03', 13, 4),
(729, 'Tratamiento 9', 'Descripción del tratamiento 9', 991.82, '2023-07-28', '2023-08-04', 13, 4),
(730, 'Tratamiento 10', 'Descripción del tratamiento 10', 778.83, '2023-07-29', '2023-08-05', 13, 4),
(731, 'Tratamiento 1', 'Descripción del tratamiento 1', 918.71, '2023-07-20', '2023-07-27', 10, 4),
(732, 'Tratamiento 2', 'Descripción del tratamiento 2', 257.04, '2023-07-21', '2023-07-28', 10, 4),
(733, 'Tratamiento 3', 'Descripción del tratamiento 3', 529.09, '2023-07-22', '2023-07-29', 10, 4),
(734, 'Tratamiento 4', 'Descripción del tratamiento 4', 874.34, '2023-07-23', '2023-07-30', 10, 4),
(735, 'Tratamiento 5', 'Descripción del tratamiento 5', 784.43, '2023-07-24', '2023-07-31', 10, 4),
(736, 'Tratamiento 6', 'Descripción del tratamiento 6', 299.13, '2023-07-25', '2023-08-01', 10, 4),
(737, 'Tratamiento 7', 'Descripción del tratamiento 7', 142.34, '2023-07-26', '2023-08-02', 10, 4),
(738, 'Tratamiento 8', 'Descripción del tratamiento 8', 814.34, '2023-07-27', '2023-08-03', 10, 4),
(739, 'Tratamiento 9', 'Descripción del tratamiento 9', 644.65, '2023-07-28', '2023-08-04', 10, 4),
(740, 'Tratamiento 10', 'Descripción del tratamiento 10', 780.23, '2023-07-29', '2023-08-05', 10, 4),
(741, 'Tratamiento 1', 'Descripción del tratamiento 1', 967.19, '2023-07-20', '2023-07-27', 17, 4),
(742, 'Tratamiento 2', 'Descripción del tratamiento 2', 495.27, '2023-07-21', '2023-07-28', 17, 4),
(743, 'Tratamiento 3', 'Descripción del tratamiento 3', 574.77, '2023-07-22', '2023-07-29', 17, 4),
(744, 'Tratamiento 4', 'Descripción del tratamiento 4', 388.05, '2023-07-23', '2023-07-30', 17, 4),
(745, 'Tratamiento 5', 'Descripción del tratamiento 5', 215.95, '2023-07-24', '2023-07-31', 17, 4),
(746, 'Tratamiento 6', 'Descripción del tratamiento 6', 915.58, '2023-07-25', '2023-08-01', 17, 4),
(747, 'Tratamiento 7', 'Descripción del tratamiento 7', 930.06, '2023-07-26', '2023-08-02', 17, 4),
(748, 'Tratamiento 8', 'Descripción del tratamiento 8', 903.58, '2023-07-27', '2023-08-03', 17, 4),
(749, 'Tratamiento 9', 'Descripción del tratamiento 9', 727.70, '2023-07-28', '2023-08-04', 17, 4),
(750, 'Tratamiento 10', 'Descripción del tratamiento 10', 927.76, '2023-07-29', '2023-08-05', 17, 4),
(751, 'Tratamiento 1', 'Descripción del tratamiento 1', 455.70, '2023-07-20', '2023-07-27', 16, 4),
(752, 'Tratamiento 2', 'Descripción del tratamiento 2', 495.21, '2023-07-21', '2023-07-28', 16, 4),
(753, 'Tratamiento 3', 'Descripción del tratamiento 3', 108.96, '2023-07-22', '2023-07-29', 16, 4),
(754, 'Tratamiento 4', 'Descripción del tratamiento 4', 59.15, '2023-07-23', '2023-07-30', 16, 4),
(755, 'Tratamiento 5', 'Descripción del tratamiento 5', 968.88, '2023-07-24', '2023-07-31', 16, 4),
(756, 'Tratamiento 6', 'Descripción del tratamiento 6', 666.97, '2023-07-25', '2023-08-01', 16, 4),
(757, 'Tratamiento 7', 'Descripción del tratamiento 7', 428.18, '2023-07-26', '2023-08-02', 16, 4),
(758, 'Tratamiento 8', 'Descripción del tratamiento 8', 140.02, '2023-07-27', '2023-08-03', 16, 4),
(759, 'Tratamiento 9', 'Descripción del tratamiento 9', 415.53, '2023-07-28', '2023-08-04', 16, 4),
(760, 'Tratamiento 10', 'Descripción del tratamiento 10', 657.61, '2023-07-29', '2023-08-05', 16, 4),
(761, 'Tratamiento 1', 'Descripción del tratamiento 1', 41.44, '2023-07-20', '2023-07-27', 12, 4),
(762, 'Tratamiento 2', 'Descripción del tratamiento 2', 234.37, '2023-07-21', '2023-07-28', 12, 4),
(763, 'Tratamiento 3', 'Descripción del tratamiento 3', 47.52, '2023-07-22', '2023-07-29', 12, 4),
(764, 'Tratamiento 4', 'Descripción del tratamiento 4', 534.50, '2023-07-23', '2023-07-30', 12, 4),
(765, 'Tratamiento 5', 'Descripción del tratamiento 5', 529.92, '2023-07-24', '2023-07-31', 12, 4),
(766, 'Tratamiento 6', 'Descripción del tratamiento 6', 46.12, '2023-07-25', '2023-08-01', 12, 4),
(767, 'Tratamiento 7', 'Descripción del tratamiento 7', 640.85, '2023-07-26', '2023-08-02', 12, 4),
(768, 'Tratamiento 8', 'Descripción del tratamiento 8', 65.87, '2023-07-27', '2023-08-03', 12, 4),
(769, 'Tratamiento 9', 'Descripción del tratamiento 9', 406.79, '2023-07-28', '2023-08-04', 12, 4),
(770, 'Tratamiento 10', 'Descripción del tratamiento 10', 836.34, '2023-07-29', '2023-08-05', 12, 4),
(771, 'Tratamiento 1', 'Descripción del tratamiento 1', 961.33, '2023-07-20', '2023-07-27', 19, 4),
(772, 'Tratamiento 2', 'Descripción del tratamiento 2', 297.65, '2023-07-21', '2023-07-28', 19, 4),
(773, 'Tratamiento 3', 'Descripción del tratamiento 3', 604.25, '2023-07-22', '2023-07-29', 19, 4),
(774, 'Tratamiento 4', 'Descripción del tratamiento 4', 128.28, '2023-07-23', '2023-07-30', 19, 4),
(775, 'Tratamiento 5', 'Descripción del tratamiento 5', 828.66, '2023-07-24', '2023-07-31', 19, 4),
(776, 'Tratamiento 6', 'Descripción del tratamiento 6', 758.46, '2023-07-25', '2023-08-01', 19, 4),
(777, 'Tratamiento 7', 'Descripción del tratamiento 7', 306.32, '2023-07-26', '2023-08-02', 19, 4),
(778, 'Tratamiento 8', 'Descripción del tratamiento 8', 256.21, '2023-07-27', '2023-08-03', 19, 4),
(779, 'Tratamiento 9', 'Descripción del tratamiento 9', 362.11, '2023-07-28', '2023-08-04', 19, 4),
(780, 'Tratamiento 10', 'Descripción del tratamiento 10', 41.93, '2023-07-29', '2023-08-05', 19, 4),
(781, 'Tratamiento 1', 'Descripción del tratamiento 1', 123.30, '2023-07-20', '2023-07-27', 20, 4),
(782, 'Tratamiento 2', 'Descripción del tratamiento 2', 490.71, '2023-07-21', '2023-07-28', 20, 4),
(783, 'Tratamiento 3', 'Descripción del tratamiento 3', 83.66, '2023-07-22', '2023-07-29', 20, 4),
(784, 'Tratamiento 4', 'Descripción del tratamiento 4', 946.15, '2023-07-23', '2023-07-30', 20, 4),
(785, 'Tratamiento 5', 'Descripción del tratamiento 5', 479.79, '2023-07-24', '2023-07-31', 20, 4),
(786, 'Tratamiento 6', 'Descripción del tratamiento 6', 560.47, '2023-07-25', '2023-08-01', 20, 4),
(787, 'Tratamiento 7', 'Descripción del tratamiento 7', 363.01, '2023-07-26', '2023-08-02', 20, 4),
(788, 'Tratamiento 8', 'Descripción del tratamiento 8', 133.62, '2023-07-27', '2023-08-03', 20, 4),
(789, 'Tratamiento 9', 'Descripción del tratamiento 9', 579.06, '2023-07-28', '2023-08-04', 20, 4),
(790, 'Tratamiento 10', 'Descripción del tratamiento 10', 494.46, '2023-07-29', '2023-08-05', 20, 4),
(791, 'Tratamiento 1', 'Descripción del tratamiento 1', 735.10, '2023-07-20', '2023-07-27', 5, 4),
(792, 'Tratamiento 2', 'Descripción del tratamiento 2', 192.11, '2023-07-21', '2023-07-28', 5, 4),
(793, 'Tratamiento 3', 'Descripción del tratamiento 3', 755.26, '2023-07-22', '2023-07-29', 5, 4),
(794, 'Tratamiento 4', 'Descripción del tratamiento 4', 199.98, '2023-07-23', '2023-07-30', 5, 4),
(795, 'Tratamiento 5', 'Descripción del tratamiento 5', 734.13, '2023-07-24', '2023-07-31', 5, 4),
(796, 'Tratamiento 6', 'Descripción del tratamiento 6', 70.69, '2023-07-25', '2023-08-01', 5, 4),
(797, 'Tratamiento 7', 'Descripción del tratamiento 7', 151.07, '2023-07-26', '2023-08-02', 5, 4),
(798, 'Tratamiento 8', 'Descripción del tratamiento 8', 543.26, '2023-07-27', '2023-08-03', 5, 4),
(799, 'Tratamiento 9', 'Descripción del tratamiento 9', 263.12, '2023-07-28', '2023-08-04', 5, 4),
(800, 'Tratamiento 10', 'Descripción del tratamiento 10', 685.82, '2023-07-29', '2023-08-05', 5, 4),
(801, 'Tratamiento 1', 'Descripción del tratamiento 1', 639.75, '2023-07-20', '2023-07-27', 2, 6),
(802, 'Tratamiento 2', 'Descripción del tratamiento 2', 141.27, '2023-07-21', '2023-07-28', 2, 6),
(803, 'Tratamiento 3', 'Descripción del tratamiento 3', 787.12, '2023-07-22', '2023-07-29', 2, 6),
(804, 'Tratamiento 4', 'Descripción del tratamiento 4', 511.78, '2023-07-23', '2023-07-30', 2, 6),
(805, 'Tratamiento 5', 'Descripción del tratamiento 5', 197.53, '2023-07-24', '2023-07-31', 2, 6),
(806, 'Tratamiento 6', 'Descripción del tratamiento 6', 452.30, '2023-07-25', '2023-08-01', 2, 6),
(807, 'Tratamiento 7', 'Descripción del tratamiento 7', 668.91, '2023-07-26', '2023-08-02', 2, 6),
(808, 'Tratamiento 8', 'Descripción del tratamiento 8', 987.64, '2023-07-27', '2023-08-03', 2, 6),
(809, 'Tratamiento 9', 'Descripción del tratamiento 9', 931.50, '2023-07-28', '2023-08-04', 2, 6),
(810, 'Tratamiento 10', 'Descripción del tratamiento 10', 694.57, '2023-07-29', '2023-08-05', 2, 6),
(811, 'Tratamiento 1', 'Descripción del tratamiento 1', 678.33, '2023-07-20', '2023-07-27', 3, 6),
(812, 'Tratamiento 2', 'Descripción del tratamiento 2', 307.95, '2023-07-21', '2023-07-28', 3, 6),
(813, 'Tratamiento 3', 'Descripción del tratamiento 3', 504.75, '2023-07-22', '2023-07-29', 3, 6),
(814, 'Tratamiento 4', 'Descripción del tratamiento 4', 599.92, '2023-07-23', '2023-07-30', 3, 6),
(815, 'Tratamiento 5', 'Descripción del tratamiento 5', 485.34, '2023-07-24', '2023-07-31', 3, 6),
(816, 'Tratamiento 6', 'Descripción del tratamiento 6', 626.95, '2023-07-25', '2023-08-01', 3, 6),
(817, 'Tratamiento 7', 'Descripción del tratamiento 7', 678.72, '2023-07-26', '2023-08-02', 3, 6),
(818, 'Tratamiento 8', 'Descripción del tratamiento 8', 512.76, '2023-07-27', '2023-08-03', 3, 6),
(819, 'Tratamiento 9', 'Descripción del tratamiento 9', 527.62, '2023-07-28', '2023-08-04', 3, 6),
(820, 'Tratamiento 10', 'Descripción del tratamiento 10', 99.82, '2023-07-29', '2023-08-05', 3, 6),
(821, 'Tratamiento 1', 'Descripción del tratamiento 1', 916.24, '2023-07-20', '2023-07-27', 13, 6),
(822, 'Tratamiento 2', 'Descripción del tratamiento 2', 281.75, '2023-07-21', '2023-07-28', 13, 6),
(823, 'Tratamiento 3', 'Descripción del tratamiento 3', 660.04, '2023-07-22', '2023-07-29', 13, 6),
(824, 'Tratamiento 4', 'Descripción del tratamiento 4', 454.94, '2023-07-23', '2023-07-30', 13, 6),
(825, 'Tratamiento 5', 'Descripción del tratamiento 5', 294.58, '2023-07-24', '2023-07-31', 13, 6),
(826, 'Tratamiento 6', 'Descripción del tratamiento 6', 108.08, '2023-07-25', '2023-08-01', 13, 6),
(827, 'Tratamiento 7', 'Descripción del tratamiento 7', 656.66, '2023-07-26', '2023-08-02', 13, 6),
(828, 'Tratamiento 8', 'Descripción del tratamiento 8', 959.06, '2023-07-27', '2023-08-03', 13, 6),
(829, 'Tratamiento 9', 'Descripción del tratamiento 9', 825.30, '2023-07-28', '2023-08-04', 13, 6),
(830, 'Tratamiento 10', 'Descripción del tratamiento 10', 249.34, '2023-07-29', '2023-08-05', 13, 6),
(831, 'Tratamiento 1', 'Descripción del tratamiento 1', 770.78, '2023-07-20', '2023-07-27', 10, 6),
(832, 'Tratamiento 2', 'Descripción del tratamiento 2', 105.89, '2023-07-21', '2023-07-28', 10, 6),
(833, 'Tratamiento 3', 'Descripción del tratamiento 3', 217.10, '2023-07-22', '2023-07-29', 10, 6),
(834, 'Tratamiento 4', 'Descripción del tratamiento 4', 767.84, '2023-07-23', '2023-07-30', 10, 6),
(835, 'Tratamiento 5', 'Descripción del tratamiento 5', 187.90, '2023-07-24', '2023-07-31', 10, 6),
(836, 'Tratamiento 6', 'Descripción del tratamiento 6', 635.97, '2023-07-25', '2023-08-01', 10, 6),
(837, 'Tratamiento 7', 'Descripción del tratamiento 7', 616.17, '2023-07-26', '2023-08-02', 10, 6),
(838, 'Tratamiento 8', 'Descripción del tratamiento 8', 172.94, '2023-07-27', '2023-08-03', 10, 6),
(839, 'Tratamiento 9', 'Descripción del tratamiento 9', 16.20, '2023-07-28', '2023-08-04', 10, 6),
(840, 'Tratamiento 10', 'Descripción del tratamiento 10', 562.17, '2023-07-29', '2023-08-05', 10, 6),
(841, 'Tratamiento 1', 'Descripción del tratamiento 1', 762.26, '2023-07-20', '2023-07-27', 17, 6),
(842, 'Tratamiento 2', 'Descripción del tratamiento 2', 124.77, '2023-07-21', '2023-07-28', 17, 6),
(843, 'Tratamiento 3', 'Descripción del tratamiento 3', 337.07, '2023-07-22', '2023-07-29', 17, 6),
(844, 'Tratamiento 4', 'Descripción del tratamiento 4', 311.06, '2023-07-23', '2023-07-30', 17, 6),
(845, 'Tratamiento 5', 'Descripción del tratamiento 5', 544.10, '2023-07-24', '2023-07-31', 17, 6),
(846, 'Tratamiento 6', 'Descripción del tratamiento 6', 787.30, '2023-07-25', '2023-08-01', 17, 6),
(847, 'Tratamiento 7', 'Descripción del tratamiento 7', 304.19, '2023-07-26', '2023-08-02', 17, 6),
(848, 'Tratamiento 8', 'Descripción del tratamiento 8', 159.08, '2023-07-27', '2023-08-03', 17, 6),
(849, 'Tratamiento 9', 'Descripción del tratamiento 9', 882.80, '2023-07-28', '2023-08-04', 17, 6),
(850, 'Tratamiento 10', 'Descripción del tratamiento 10', 936.77, '2023-07-29', '2023-08-05', 17, 6),
(851, 'Tratamiento 1', 'Descripción del tratamiento 1', 35.46, '2023-07-20', '2023-07-27', 16, 6),
(852, 'Tratamiento 2', 'Descripción del tratamiento 2', 366.99, '2023-07-21', '2023-07-28', 16, 6),
(853, 'Tratamiento 3', 'Descripción del tratamiento 3', 728.56, '2023-07-22', '2023-07-29', 16, 6),
(854, 'Tratamiento 4', 'Descripción del tratamiento 4', 541.82, '2023-07-23', '2023-07-30', 16, 6),
(855, 'Tratamiento 5', 'Descripción del tratamiento 5', 523.42, '2023-07-24', '2023-07-31', 16, 6),
(856, 'Tratamiento 6', 'Descripción del tratamiento 6', 991.66, '2023-07-25', '2023-08-01', 16, 6),
(857, 'Tratamiento 7', 'Descripción del tratamiento 7', 388.01, '2023-07-26', '2023-08-02', 16, 6),
(858, 'Tratamiento 8', 'Descripción del tratamiento 8', 965.09, '2023-07-27', '2023-08-03', 16, 6),
(859, 'Tratamiento 9', 'Descripción del tratamiento 9', 661.41, '2023-07-28', '2023-08-04', 16, 6),
(860, 'Tratamiento 10', 'Descripción del tratamiento 10', 411.80, '2023-07-29', '2023-08-05', 16, 6),
(861, 'Tratamiento 1', 'Descripción del tratamiento 1', 74.78, '2023-07-20', '2023-07-27', 12, 6),
(862, 'Tratamiento 2', 'Descripción del tratamiento 2', 138.47, '2023-07-21', '2023-07-28', 12, 6),
(863, 'Tratamiento 3', 'Descripción del tratamiento 3', 468.00, '2023-07-22', '2023-07-29', 12, 6),
(864, 'Tratamiento 4', 'Descripción del tratamiento 4', 924.60, '2023-07-23', '2023-07-30', 12, 6),
(865, 'Tratamiento 5', 'Descripción del tratamiento 5', 219.02, '2023-07-24', '2023-07-31', 12, 6),
(866, 'Tratamiento 6', 'Descripción del tratamiento 6', 321.27, '2023-07-25', '2023-08-01', 12, 6),
(867, 'Tratamiento 7', 'Descripción del tratamiento 7', 949.30, '2023-07-26', '2023-08-02', 12, 6),
(868, 'Tratamiento 8', 'Descripción del tratamiento 8', 782.70, '2023-07-27', '2023-08-03', 12, 6),
(869, 'Tratamiento 9', 'Descripción del tratamiento 9', 65.61, '2023-07-28', '2023-08-04', 12, 6),
(870, 'Tratamiento 10', 'Descripción del tratamiento 10', 979.95, '2023-07-29', '2023-08-05', 12, 6),
(871, 'Tratamiento 1', 'Descripción del tratamiento 1', 702.93, '2023-07-20', '2023-07-27', 19, 6),
(872, 'Tratamiento 2', 'Descripción del tratamiento 2', 574.79, '2023-07-21', '2023-07-28', 19, 6),
(873, 'Tratamiento 3', 'Descripción del tratamiento 3', 765.16, '2023-07-22', '2023-07-29', 19, 6),
(874, 'Tratamiento 4', 'Descripción del tratamiento 4', 101.43, '2023-07-23', '2023-07-30', 19, 6),
(875, 'Tratamiento 5', 'Descripción del tratamiento 5', 211.66, '2023-07-24', '2023-07-31', 19, 6),
(876, 'Tratamiento 6', 'Descripción del tratamiento 6', 754.02, '2023-07-25', '2023-08-01', 19, 6),
(877, 'Tratamiento 7', 'Descripción del tratamiento 7', 135.13, '2023-07-26', '2023-08-02', 19, 6),
(878, 'Tratamiento 8', 'Descripción del tratamiento 8', 413.60, '2023-07-27', '2023-08-03', 19, 6),
(879, 'Tratamiento 9', 'Descripción del tratamiento 9', 662.59, '2023-07-28', '2023-08-04', 19, 6),
(880, 'Tratamiento 10', 'Descripción del tratamiento 10', 72.15, '2023-07-29', '2023-08-05', 19, 6),
(881, 'Tratamiento 1', 'Descripción del tratamiento 1', 372.98, '2023-07-20', '2023-07-27', 20, 6),
(882, 'Tratamiento 2', 'Descripción del tratamiento 2', 648.44, '2023-07-21', '2023-07-28', 20, 6),
(883, 'Tratamiento 3', 'Descripción del tratamiento 3', 123.25, '2023-07-22', '2023-07-29', 20, 6),
(884, 'Tratamiento 4', 'Descripción del tratamiento 4', 670.95, '2023-07-23', '2023-07-30', 20, 6),
(885, 'Tratamiento 5', 'Descripción del tratamiento 5', 984.98, '2023-07-24', '2023-07-31', 20, 6),
(886, 'Tratamiento 6', 'Descripción del tratamiento 6', 912.05, '2023-07-25', '2023-08-01', 20, 6),
(887, 'Tratamiento 7', 'Descripción del tratamiento 7', 605.32, '2023-07-26', '2023-08-02', 20, 6),
(888, 'Tratamiento 8', 'Descripción del tratamiento 8', 290.43, '2023-07-27', '2023-08-03', 20, 6),
(889, 'Tratamiento 9', 'Descripción del tratamiento 9', 636.22, '2023-07-28', '2023-08-04', 20, 6),
(890, 'Tratamiento 10', 'Descripción del tratamiento 10', 309.78, '2023-07-29', '2023-08-05', 20, 6),
(891, 'Tratamiento 1', 'Descripción del tratamiento 1', 640.27, '2023-07-20', '2023-07-27', 5, 6),
(892, 'Tratamiento 2', 'Descripción del tratamiento 2', 271.99, '2023-07-21', '2023-07-28', 5, 6),
(893, 'Tratamiento 3', 'Descripción del tratamiento 3', 439.14, '2023-07-22', '2023-07-29', 5, 6),
(894, 'Tratamiento 4', 'Descripción del tratamiento 4', 379.72, '2023-07-23', '2023-07-30', 5, 6),
(895, 'Tratamiento 5', 'Descripción del tratamiento 5', 581.18, '2023-07-24', '2023-07-31', 5, 6),
(896, 'Tratamiento 6', 'Descripción del tratamiento 6', 766.73, '2023-07-25', '2023-08-01', 5, 6),
(897, 'Tratamiento 7', 'Descripción del tratamiento 7', 90.12, '2023-07-26', '2023-08-02', 5, 6),
(898, 'Tratamiento 8', 'Descripción del tratamiento 8', 150.40, '2023-07-27', '2023-08-03', 5, 6),
(899, 'Tratamiento 9', 'Descripción del tratamiento 9', 481.65, '2023-07-28', '2023-08-04', 5, 6),
(900, 'Tratamiento 10', 'Descripción del tratamiento 10', 957.03, '2023-07-29', '2023-08-05', 5, 6),
(901, 'Tratamiento 1', 'Descripción del tratamiento 1', 340.23, '2023-07-20', '2023-07-27', 2, 2),
(902, 'Tratamiento 2', 'Descripción del tratamiento 2', 830.06, '2023-07-21', '2023-07-28', 2, 2),
(903, 'Tratamiento 3', 'Descripción del tratamiento 3', 129.58, '2023-07-22', '2023-07-29', 2, 2),
(904, 'Tratamiento 4', 'Descripción del tratamiento 4', 157.74, '2023-07-23', '2023-07-30', 2, 2),
(905, 'Tratamiento 5', 'Descripción del tratamiento 5', 399.96, '2023-07-24', '2023-07-31', 2, 2),
(906, 'Tratamiento 6', 'Descripción del tratamiento 6', 526.57, '2023-07-25', '2023-08-01', 2, 2),
(907, 'Tratamiento 7', 'Descripción del tratamiento 7', 432.99, '2023-07-26', '2023-08-02', 2, 2),
(908, 'Tratamiento 8', 'Descripción del tratamiento 8', 585.25, '2023-07-27', '2023-08-03', 2, 2),
(909, 'Tratamiento 9', 'Descripción del tratamiento 9', 627.26, '2023-07-28', '2023-08-04', 2, 2),
(910, 'Tratamiento 10', 'Descripción del tratamiento 10', 380.55, '2023-07-29', '2023-08-05', 2, 2),
(911, 'Tratamiento 1', 'Descripción del tratamiento 1', 20.98, '2023-07-20', '2023-07-27', 3, 2),
(912, 'Tratamiento 2', 'Descripción del tratamiento 2', 963.25, '2023-07-21', '2023-07-28', 3, 2),
(913, 'Tratamiento 3', 'Descripción del tratamiento 3', 753.30, '2023-07-22', '2023-07-29', 3, 2),
(914, 'Tratamiento 4', 'Descripción del tratamiento 4', 876.76, '2023-07-23', '2023-07-30', 3, 2),
(915, 'Tratamiento 5', 'Descripción del tratamiento 5', 123.91, '2023-07-24', '2023-07-31', 3, 2),
(916, 'Tratamiento 6', 'Descripción del tratamiento 6', 989.28, '2023-07-25', '2023-08-01', 3, 2),
(917, 'Tratamiento 7', 'Descripción del tratamiento 7', 574.66, '2023-07-26', '2023-08-02', 3, 2),
(918, 'Tratamiento 8', 'Descripción del tratamiento 8', 905.46, '2023-07-27', '2023-08-03', 3, 2),
(919, 'Tratamiento 9', 'Descripción del tratamiento 9', 803.30, '2023-07-28', '2023-08-04', 3, 2),
(920, 'Tratamiento 10', 'Descripción del tratamiento 10', 300.12, '2023-07-29', '2023-08-05', 3, 2),
(921, 'Tratamiento 1', 'Descripción del tratamiento 1', 90.71, '2023-07-20', '2023-07-27', 13, 2),
(922, 'Tratamiento 2', 'Descripción del tratamiento 2', 553.18, '2023-07-21', '2023-07-28', 13, 2),
(923, 'Tratamiento 3', 'Descripción del tratamiento 3', 493.78, '2023-07-22', '2023-07-29', 13, 2),
(924, 'Tratamiento 4', 'Descripción del tratamiento 4', 809.37, '2023-07-23', '2023-07-30', 13, 2),
(925, 'Tratamiento 5', 'Descripción del tratamiento 5', 565.51, '2023-07-24', '2023-07-31', 13, 2),
(926, 'Tratamiento 6', 'Descripción del tratamiento 6', 399.46, '2023-07-25', '2023-08-01', 13, 2),
(927, 'Tratamiento 7', 'Descripción del tratamiento 7', 300.73, '2023-07-26', '2023-08-02', 13, 2),
(928, 'Tratamiento 8', 'Descripción del tratamiento 8', 305.29, '2023-07-27', '2023-08-03', 13, 2),
(929, 'Tratamiento 9', 'Descripción del tratamiento 9', 624.25, '2023-07-28', '2023-08-04', 13, 2),
(930, 'Tratamiento 10', 'Descripción del tratamiento 10', 205.37, '2023-07-29', '2023-08-05', 13, 2),
(931, 'Tratamiento 1', 'Descripción del tratamiento 1', 154.11, '2023-07-20', '2023-07-27', 10, 2),
(932, 'Tratamiento 2', 'Descripción del tratamiento 2', 154.44, '2023-07-21', '2023-07-28', 10, 2),
(933, 'Tratamiento 3', 'Descripción del tratamiento 3', 309.86, '2023-07-22', '2023-07-29', 10, 2),
(934, 'Tratamiento 4', 'Descripción del tratamiento 4', 85.97, '2023-07-23', '2023-07-30', 10, 2),
(935, 'Tratamiento 5', 'Descripción del tratamiento 5', 500.26, '2023-07-24', '2023-07-31', 10, 2),
(936, 'Tratamiento 6', 'Descripción del tratamiento 6', 243.42, '2023-07-25', '2023-08-01', 10, 2),
(937, 'Tratamiento 7', 'Descripción del tratamiento 7', 716.31, '2023-07-26', '2023-08-02', 10, 2),
(938, 'Tratamiento 8', 'Descripción del tratamiento 8', 851.28, '2023-07-27', '2023-08-03', 10, 2),
(939, 'Tratamiento 9', 'Descripción del tratamiento 9', 107.49, '2023-07-28', '2023-08-04', 10, 2),
(940, 'Tratamiento 10', 'Descripción del tratamiento 10', 983.61, '2023-07-29', '2023-08-05', 10, 2),
(941, 'Tratamiento 1', 'Descripción del tratamiento 1', 595.58, '2023-07-20', '2023-07-27', 17, 2),
(942, 'Tratamiento 2', 'Descripción del tratamiento 2', 27.06, '2023-07-21', '2023-07-28', 17, 2),
(943, 'Tratamiento 3', 'Descripción del tratamiento 3', 348.56, '2023-07-22', '2023-07-29', 17, 2),
(944, 'Tratamiento 4', 'Descripción del tratamiento 4', 661.60, '2023-07-23', '2023-07-30', 17, 2),
(945, 'Tratamiento 5', 'Descripción del tratamiento 5', 262.35, '2023-07-24', '2023-07-31', 17, 2),
(946, 'Tratamiento 6', 'Descripción del tratamiento 6', 326.94, '2023-07-25', '2023-08-01', 17, 2),
(947, 'Tratamiento 7', 'Descripción del tratamiento 7', 847.64, '2023-07-26', '2023-08-02', 17, 2),
(948, 'Tratamiento 8', 'Descripción del tratamiento 8', 257.40, '2023-07-27', '2023-08-03', 17, 2),
(949, 'Tratamiento 9', 'Descripción del tratamiento 9', 744.06, '2023-07-28', '2023-08-04', 17, 2),
(950, 'Tratamiento 10', 'Descripción del tratamiento 10', 948.09, '2023-07-29', '2023-08-05', 17, 2),
(951, 'Tratamiento 1', 'Descripción del tratamiento 1', 508.27, '2023-07-20', '2023-07-27', 16, 2),
(952, 'Tratamiento 2', 'Descripción del tratamiento 2', 697.10, '2023-07-21', '2023-07-28', 16, 2),
(953, 'Tratamiento 3', 'Descripción del tratamiento 3', 960.67, '2023-07-22', '2023-07-29', 16, 2),
(954, 'Tratamiento 4', 'Descripción del tratamiento 4', 712.04, '2023-07-23', '2023-07-30', 16, 2),
(955, 'Tratamiento 5', 'Descripción del tratamiento 5', 678.22, '2023-07-24', '2023-07-31', 16, 2),
(956, 'Tratamiento 6', 'Descripción del tratamiento 6', 254.95, '2023-07-25', '2023-08-01', 16, 2),
(957, 'Tratamiento 7', 'Descripción del tratamiento 7', 240.09, '2023-07-26', '2023-08-02', 16, 2),
(958, 'Tratamiento 8', 'Descripción del tratamiento 8', 435.63, '2023-07-27', '2023-08-03', 16, 2),
(959, 'Tratamiento 9', 'Descripción del tratamiento 9', 457.85, '2023-07-28', '2023-08-04', 16, 2),
(960, 'Tratamiento 10', 'Descripción del tratamiento 10', 982.35, '2023-07-29', '2023-08-05', 16, 2),
(961, 'Tratamiento 1', 'Descripción del tratamiento 1', 538.22, '2023-07-20', '2023-07-27', 12, 2),
(962, 'Tratamiento 2', 'Descripción del tratamiento 2', 744.06, '2023-07-21', '2023-07-28', 12, 2),
(963, 'Tratamiento 3', 'Descripción del tratamiento 3', 105.63, '2023-07-22', '2023-07-29', 12, 2),
(964, 'Tratamiento 4', 'Descripción del tratamiento 4', 295.99, '2023-07-23', '2023-07-30', 12, 2),
(965, 'Tratamiento 5', 'Descripción del tratamiento 5', 163.03, '2023-07-24', '2023-07-31', 12, 2),
(966, 'Tratamiento 6', 'Descripción del tratamiento 6', 927.17, '2023-07-25', '2023-08-01', 12, 2),
(967, 'Tratamiento 7', 'Descripción del tratamiento 7', 146.78, '2023-07-26', '2023-08-02', 12, 2),
(968, 'Tratamiento 8', 'Descripción del tratamiento 8', 952.38, '2023-07-27', '2023-08-03', 12, 2),
(969, 'Tratamiento 9', 'Descripción del tratamiento 9', 321.57, '2023-07-28', '2023-08-04', 12, 2),
(970, 'Tratamiento 10', 'Descripción del tratamiento 10', 750.70, '2023-07-29', '2023-08-05', 12, 2),
(971, 'Tratamiento 1', 'Descripción del tratamiento 1', 788.78, '2023-07-20', '2023-07-27', 19, 2),
(972, 'Tratamiento 2', 'Descripción del tratamiento 2', 691.80, '2023-07-21', '2023-07-28', 19, 2),
(973, 'Tratamiento 3', 'Descripción del tratamiento 3', 92.66, '2023-07-22', '2023-07-29', 19, 2),
(974, 'Tratamiento 4', 'Descripción del tratamiento 4', 387.90, '2023-07-23', '2023-07-30', 19, 2),
(975, 'Tratamiento 5', 'Descripción del tratamiento 5', 661.51, '2023-07-24', '2023-07-31', 19, 2),
(976, 'Tratamiento 6', 'Descripción del tratamiento 6', 143.85, '2023-07-25', '2023-08-01', 19, 2),
(977, 'Tratamiento 7', 'Descripción del tratamiento 7', 734.73, '2023-07-26', '2023-08-02', 19, 2),
(978, 'Tratamiento 8', 'Descripción del tratamiento 8', 242.09, '2023-07-27', '2023-08-03', 19, 2),
(979, 'Tratamiento 9', 'Descripción del tratamiento 9', 6.27, '2023-07-28', '2023-08-04', 19, 2),
(980, 'Tratamiento 10', 'Descripción del tratamiento 10', 305.10, '2023-07-29', '2023-08-05', 19, 2),
(981, 'Tratamiento 1', 'Descripción del tratamiento 1', 506.66, '2023-07-20', '2023-07-27', 20, 2),
(982, 'Tratamiento 2', 'Descripción del tratamiento 2', 618.02, '2023-07-21', '2023-07-28', 20, 2),
(983, 'Tratamiento 3', 'Descripción del tratamiento 3', 570.11, '2023-07-22', '2023-07-29', 20, 2),
(984, 'Tratamiento 4', 'Descripción del tratamiento 4', 996.49, '2023-07-23', '2023-07-30', 20, 2),
(985, 'Tratamiento 5', 'Descripción del tratamiento 5', 272.13, '2023-07-24', '2023-07-31', 20, 2),
(986, 'Tratamiento 6', 'Descripción del tratamiento 6', 371.16, '2023-07-25', '2023-08-01', 20, 2),
(987, 'Tratamiento 7', 'Descripción del tratamiento 7', 39.40, '2023-07-26', '2023-08-02', 20, 2),
(988, 'Tratamiento 8', 'Descripción del tratamiento 8', 83.53, '2023-07-27', '2023-08-03', 20, 2),
(989, 'Tratamiento 9', 'Descripción del tratamiento 9', 299.45, '2023-07-28', '2023-08-04', 20, 2),
(990, 'Tratamiento 10', 'Descripción del tratamiento 10', 246.66, '2023-07-29', '2023-08-05', 20, 2),
(991, 'Tratamiento 1', 'Descripción del tratamiento 1', 334.96, '2023-07-20', '2023-07-27', 5, 2),
(992, 'Tratamiento 2', 'Descripción del tratamiento 2', 934.83, '2023-07-21', '2023-07-28', 5, 2),
(993, 'Tratamiento 3', 'Descripción del tratamiento 3', 669.28, '2023-07-22', '2023-07-29', 5, 2),
(994, 'Tratamiento 4', 'Descripción del tratamiento 4', 541.89, '2023-07-23', '2023-07-30', 5, 2),
(995, 'Tratamiento 5', 'Descripción del tratamiento 5', 701.60, '2023-07-24', '2023-07-31', 5, 2),
(996, 'Tratamiento 6', 'Descripción del tratamiento 6', 882.36, '2023-07-25', '2023-08-01', 5, 2),
(997, 'Tratamiento 7', 'Descripción del tratamiento 7', 306.97, '2023-07-26', '2023-08-02', 5, 2),
(998, 'Tratamiento 8', 'Descripción del tratamiento 8', 887.77, '2023-07-27', '2023-08-03', 5, 2),
(999, 'Tratamiento 9', 'Descripción del tratamiento 9', 517.94, '2023-07-28', '2023-08-04', 5, 2),
(1000, 'Tratamiento 10', 'Descripción del tratamiento 10', 926.38, '2023-07-29', '2023-08-05', 5, 2);

--
-- Disparadores `tratamiento`
--
DELIMITER $$
CREATE TRIGGER `tr_after_tratamiento` AFTER INSERT ON `tratamiento` FOR EACH ROW BEGIN
    INSERT INTO log_tratamiento (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se ha insertado un nuevo registro en la tabla tratamiento.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripción de la acción que se realizó.
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_after_update_tratamiento` AFTER UPDATE ON `tratamiento` FOR EACH ROW BEGIN
    INSERT INTO log_tratamiento (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se ha actualizado un registro en la tabla tratamiento.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripción de la acción que se realizó.
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamiento_medicamento`
--

CREATE TABLE `tratamiento_medicamento` (
  `id` int(20) NOT NULL,
  `tratamiento_id` int(20) NOT NULL,
  `medicamento` varchar(150) NOT NULL,
  `dosis` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno`
--

CREATE TABLE `turno` (
  `id` int(20) NOT NULL,
  `fecha` date NOT NULL,
  `hora` int(11) NOT NULL,
  `atendido` tinyint(1) NOT NULL,
  `doctor_id` int(20) NOT NULL,
  `paciente_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `turno`
--

INSERT INTO `turno` (`id`, `fecha`, `hora`, `atendido`, `doctor_id`, `paciente_id`) VALUES
(1, '2023-08-03', 18, 0, 3, 3),
(2, '2023-08-07', 23, 0, 4, 4),
(3, '2023-07-24', 19, 1, 6, 6),
(4, '2023-07-25', 10, 1, 7, 7),
(5, '2023-08-03', 21, 0, 9, 9),
(6, '2023-07-28', 11, 0, 10, 10);

--
-- Disparadores `turno`
--
DELIMITER $$
CREATE TRIGGER `tr_after_turno` AFTER DELETE ON `turno` FOR EACH ROW BEGIN
    INSERT INTO log_turno (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se ha eliminado un registro de la tabla turno.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripción de la acción que se realizó.
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_before_turno` BEFORE DELETE ON `turno` FOR EACH ROW BEGIN
    INSERT INTO log_turno (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se va a eliminar un registro de la tabla turno.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripción de la acción que se realizará.
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vacaciones`
--

CREATE TABLE `vacaciones` (
  `id` int(20) NOT NULL,
  `empleado_id` int(20) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vacaciones_medico`
--

CREATE TABLE `vacaciones_medico` (
  `id` int(20) NOT NULL,
  `medico_id` int(20) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_consultas_medico`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_consultas_medico` (
`turno_id` int(20)
,`fecha` date
,`hora` int(11)
,`atendido` tinyint(1)
,`paciente` varchar(150)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_consultorios_disponibles`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_consultorios_disponibles` (
`id` int(20)
,`nombre` varchar(150)
,`ocupado` tinyint(1)
,`medico` varchar(150)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_diagnosticos_paciente`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_diagnosticos_paciente` (
`diagnostico_id` int(20)
,`codigo_diagnostico` varchar(20)
,`descripcion` text
,`fecha` date
,`paciente` varchar(150)
,`medico` varchar(150)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_empleados`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_empleados` (
`id` int(20)
,`nombre` varchar(150)
,`apellido` varchar(150)
,`puesto` varchar(150)
,`localidad` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_empleados_con_vacaciones`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_empleados_con_vacaciones` (
`empleado_id` int(20)
,`nombre` varchar(150)
,`apellido` varchar(150)
,`fecha_inicio` date
,`fecha_fin` date
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_especialidades_medicas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_especialidades_medicas` (
`id` int(20)
,`nombre` varchar(150)
,`subespecialidad` varchar(150)
,`cantidad_medicos` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_pacientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_pacientes` (
`id` int(20)
,`nombre` varchar(150)
,`apellido` varchar(150)
,`edad` int(11)
,`obra_social` varchar(150)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_pacientes_obrasociales`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_pacientes_obrasociales` (
`id` int(20)
,`nombre` varchar(150)
,`apellido` varchar(150)
,`obra_social` varchar(150)
,`cantidad_pacientes` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_tratamientos_paciente`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_tratamientos_paciente` (
`tratamiento_id` int(20)
,`tratamiento` varchar(150)
,`descripcion` text
,`costo` decimal(10,2)
,`fecha_inicio` date
,`fecha_fin` date
,`paciente` varchar(150)
,`medico` varchar(150)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_turnos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_turnos` (
`id` int(20)
,`fecha` date
,`hora` int(11)
,`atendido` tinyint(1)
,`paciente` varchar(150)
,`medico` varchar(150)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_consultas_medico`
--
DROP TABLE IF EXISTS `vista_consultas_medico`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_consultas_medico`  AS SELECT `t`.`id` AS `turno_id`, `t`.`fecha` AS `fecha`, `t`.`hora` AS `hora`, `t`.`atendido` AS `atendido`, `p`.`nombre` AS `paciente` FROM (`turno` `t` join `persona` `p` on(`t`.`paciente_id` = `p`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_consultorios_disponibles`
--
DROP TABLE IF EXISTS `vista_consultorios_disponibles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_consultorios_disponibles`  AS SELECT `c`.`id` AS `id`, `c`.`nombre` AS `nombre`, `c`.`ocupado` AS `ocupado`, `m`.`nombre` AS `medico` FROM (`consultorios` `c` left join `medico` `m` on(`c`.`medico_id` = `m`.`id`)) WHERE `c`.`ocupado` = 0 OR `c`.`ocupado` is null ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_diagnosticos_paciente`
--
DROP TABLE IF EXISTS `vista_diagnosticos_paciente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_diagnosticos_paciente`  AS SELECT `d`.`id` AS `diagnostico_id`, `d`.`codigo` AS `codigo_diagnostico`, `d`.`descripcion` AS `descripcion`, `d`.`fecha` AS `fecha`, `p`.`nombre` AS `paciente`, `m`.`nombre` AS `medico` FROM ((`diagnostico` `d` join `persona` `p` on(`d`.`paciente_id` = `p`.`id`)) join `medico` `m` on(`d`.`doctor_id` = `m`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_empleados`
--
DROP TABLE IF EXISTS `vista_empleados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_empleados`  AS SELECT `e`.`id` AS `id`, `e`.`nombre` AS `nombre`, `e`.`apellido` AS `apellido`, `e`.`puesto` AS `puesto`, `l`.`nombre` AS `localidad` FROM (`empleado` `e` join `localidad` `l` on(`e`.`localidad_id` = `l`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_empleados_con_vacaciones`
--
DROP TABLE IF EXISTS `vista_empleados_con_vacaciones`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_empleados_con_vacaciones`  AS SELECT `e`.`id` AS `empleado_id`, `e`.`nombre` AS `nombre`, `e`.`apellido` AS `apellido`, `v`.`fecha_inicio` AS `fecha_inicio`, `v`.`fecha_fin` AS `fecha_fin` FROM (`empleado` `e` join `vacaciones` `v` on(`e`.`id` = `v`.`empleado_id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_especialidades_medicas`
--
DROP TABLE IF EXISTS `vista_especialidades_medicas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_especialidades_medicas`  AS SELECT `em`.`id` AS `id`, `em`.`nombre` AS `nombre`, `em`.`subespecialidad` AS `subespecialidad`, count(`m`.`id`) AS `cantidad_medicos` FROM (`especialidadmedica` `em` left join `medico` `m` on(`em`.`id` = `m`.`especialidad_id`)) GROUP BY `em`.`id`, `em`.`nombre`, `em`.`subespecialidad` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_pacientes`
--
DROP TABLE IF EXISTS `vista_pacientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_pacientes`  AS SELECT `p`.`id` AS `id`, `p`.`nombre` AS `nombre`, `p`.`apellido` AS `apellido`, `p`.`edad` AS `edad`, `o`.`denominacion` AS `obra_social` FROM (`persona` `p` join `obrasocial` `o` on(`p`.`obra_social_id` = `o`.`id`)) WHERE `p`.`medico_cabecera_id` is null ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_pacientes_obrasociales`
--
DROP TABLE IF EXISTS `vista_pacientes_obrasociales`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_pacientes_obrasociales`  AS SELECT `p`.`id` AS `id`, `p`.`nombre` AS `nombre`, `p`.`apellido` AS `apellido`, `o`.`denominacion` AS `obra_social`, count(`p`.`id`) AS `cantidad_pacientes` FROM (`persona` `p` join `obrasocial` `o` on(`p`.`obra_social_id` = `o`.`id`)) GROUP BY `p`.`id`, `p`.`nombre`, `p`.`apellido`, `o`.`denominacion` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_tratamientos_paciente`
--
DROP TABLE IF EXISTS `vista_tratamientos_paciente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_tratamientos_paciente`  AS SELECT `t`.`id` AS `tratamiento_id`, `t`.`nombre` AS `tratamiento`, `t`.`descripcion` AS `descripcion`, `t`.`costo` AS `costo`, `t`.`fecha_inicio` AS `fecha_inicio`, `t`.`fecha_fin` AS `fecha_fin`, `p`.`nombre` AS `paciente`, `m`.`nombre` AS `medico` FROM ((`tratamiento` `t` join `persona` `p` on(`t`.`paciente_id` = `p`.`id`)) join `medico` `m` on(`t`.`doctor_id` = `m`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_turnos`
--
DROP TABLE IF EXISTS `vista_turnos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_turnos`  AS SELECT `t`.`id` AS `id`, `t`.`fecha` AS `fecha`, `t`.`hora` AS `hora`, `t`.`atendido` AS `atendido`, `p`.`nombre` AS `paciente`, `m`.`nombre` AS `medico` FROM ((`turno` `t` join `persona` `p` on(`t`.`paciente_id` = `p`.`id`)) join `medico` `m` on(`t`.`doctor_id` = `m`.`id`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `consultorios`
--
ALTER TABLE `consultorios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD KEY `consultorios_medico_id_fk` (`medico_id`);

--
-- Indices de la tabla `diagnostico`
--
ALTER TABLE `diagnostico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `diagnostico_paciente_id_fk` (`paciente_id`),
  ADD KEY `diagnostico_doctor_id_fk` (`doctor_id`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`),
  ADD KEY `empleado_localidad_id_fk` (`localidad_id`),
  ADD KEY `empleado_obra_social_id_fk` (`obra_social_id`);

--
-- Indices de la tabla `especialidadmedica`
--
ALTER TABLE `especialidadmedica`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD UNIQUE KEY `numero` (`numero`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_factura` (`numero_factura`),
  ADD KEY `factura_paciente_id_fk` (`paciente_id`),
  ADD KEY `factura_medico_id_fk` (`medico_id`);

--
-- Indices de la tabla `localidad`
--
ALTER TABLE `localidad`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cp` (`cp`);

--
-- Indices de la tabla `log_medico`
--
ALTER TABLE `log_medico`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `log_turno`
--
ALTER TABLE `log_turno`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`),
  ADD UNIQUE KEY `matricula_prov` (`matricula_prov`),
  ADD UNIQUE KEY `matricula_nac` (`matricula_nac`),
  ADD KEY `med_especialidad_id_fk` (`especialidad_id`),
  ADD KEY `med_localidad_id_fk` (`localidad_id`);

--
-- Indices de la tabla `obrasocial`
--
ALTER TABLE `obrasocial`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`),
  ADD KEY `per_localidad_id_fk` (`localidad_id`),
  ADD KEY `per_medico_cabecera_id_fk` (`medico_cabecera_id`),
  ADD KEY `per_obra_social_id_fk` (`obra_social_id`);

--
-- Indices de la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tratamiento_paciente_id_fk` (`paciente_id`),
  ADD KEY `tratamiento_doctor_id_fk` (`doctor_id`);

--
-- Indices de la tabla `tratamiento_medicamento`
--
ALTER TABLE `tratamiento_medicamento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tratamiento_med_fk` (`tratamiento_id`);

--
-- Indices de la tabla `turno`
--
ALTER TABLE `turno`
  ADD PRIMARY KEY (`id`),
  ADD KEY `turno_doctor_id_fk` (`doctor_id`),
  ADD KEY `turno_paciente_id_fk` (`paciente_id`);

--
-- Indices de la tabla `vacaciones`
--
ALTER TABLE `vacaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vacaciones_empleado_id_fk` (`empleado_id`);

--
-- Indices de la tabla `vacaciones_medico`
--
ALTER TABLE `vacaciones_medico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vacaciones_medico_id_fk` (`medico_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `consultorios`
--
ALTER TABLE `consultorios`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `diagnostico`
--
ALTER TABLE `diagnostico`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `especialidadmedica`
--
ALTER TABLE `especialidadmedica`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `localidad`
--
ALTER TABLE `localidad`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `log_medico`
--
ALTER TABLE `log_medico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `log_turno`
--
ALTER TABLE `log_turno`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `medico`
--
ALTER TABLE `medico`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `obrasocial`
--
ALTER TABLE `obrasocial`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1024;

--
-- AUTO_INCREMENT de la tabla `tratamiento_medicamento`
--
ALTER TABLE `tratamiento_medicamento`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `turno`
--
ALTER TABLE `turno`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `vacaciones`
--
ALTER TABLE `vacaciones`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `vacaciones_medico`
--
ALTER TABLE `vacaciones_medico`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `consultorios`
--
ALTER TABLE `consultorios`
  ADD CONSTRAINT `consultorios_medico_id_fk` FOREIGN KEY (`medico_id`) REFERENCES `medico` (`id`);

--
-- Filtros para la tabla `diagnostico`
--
ALTER TABLE `diagnostico`
  ADD CONSTRAINT `diagnostico_doctor_id_fk` FOREIGN KEY (`doctor_id`) REFERENCES `medico` (`id`),
  ADD CONSTRAINT `diagnostico_paciente_id_fk` FOREIGN KEY (`paciente_id`) REFERENCES `persona` (`id`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_localidad_id_fk` FOREIGN KEY (`localidad_id`) REFERENCES `localidad` (`id`),
  ADD CONSTRAINT `empleado_obra_social_id_fk` FOREIGN KEY (`obra_social_id`) REFERENCES `obrasocial` (`id`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_medico_id_fk` FOREIGN KEY (`medico_id`) REFERENCES `medico` (`id`),
  ADD CONSTRAINT `factura_paciente_id_fk` FOREIGN KEY (`paciente_id`) REFERENCES `persona` (`id`);

--
-- Filtros para la tabla `medico`
--
ALTER TABLE `medico`
  ADD CONSTRAINT `med_especialidad_id_fk` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidadmedica` (`id`),
  ADD CONSTRAINT `med_localidad_id_fk` FOREIGN KEY (`localidad_id`) REFERENCES `localidad` (`id`);

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `per_localidad_id_fk` FOREIGN KEY (`localidad_id`) REFERENCES `localidad` (`id`),
  ADD CONSTRAINT `per_medico_cabecera_id_fk` FOREIGN KEY (`medico_cabecera_id`) REFERENCES `medico` (`id`),
  ADD CONSTRAINT `per_obra_social_id_fk` FOREIGN KEY (`obra_social_id`) REFERENCES `obrasocial` (`id`);

--
-- Filtros para la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  ADD CONSTRAINT `tratamiento_doctor_id_fk` FOREIGN KEY (`doctor_id`) REFERENCES `medico` (`id`),
  ADD CONSTRAINT `tratamiento_paciente_id_fk` FOREIGN KEY (`paciente_id`) REFERENCES `persona` (`id`);

--
-- Filtros para la tabla `tratamiento_medicamento`
--
ALTER TABLE `tratamiento_medicamento`
  ADD CONSTRAINT `tratamiento_med_fk` FOREIGN KEY (`tratamiento_id`) REFERENCES `tratamiento` (`id`);

--
-- Filtros para la tabla `turno`
--
ALTER TABLE `turno`
  ADD CONSTRAINT `turno_doctor_id_fk` FOREIGN KEY (`doctor_id`) REFERENCES `medico` (`id`),
  ADD CONSTRAINT `turno_paciente_id_fk` FOREIGN KEY (`paciente_id`) REFERENCES `persona` (`id`);

--
-- Filtros para la tabla `vacaciones`
--
ALTER TABLE `vacaciones`
  ADD CONSTRAINT `vacaciones_empleado_id_fk` FOREIGN KEY (`empleado_id`) REFERENCES `empleado` (`id`);

--
-- Filtros para la tabla `vacaciones_medico`
--
ALTER TABLE `vacaciones_medico`
  ADD CONSTRAINT `vacaciones_medico_id_fk` FOREIGN KEY (`medico_id`) REFERENCES `medico` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
