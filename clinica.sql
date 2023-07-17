-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-07-2023 a las 23:16:34
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
(1, 'Pedro', 'López', 'Masculino', 28, '87654321', 'E1234', '1995-10-15', 'Calle Principal 789', 'Argentina', 'pedrolopez@example.com', '0123456789', 'Contacto Familiar', '987654321012', 'Administrativo', '2021-01-01', 'Licenciatura en Administración', 'Universidad ABC', 'Licenciatura en Administración', '2020', NULL, NULL);

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
(88, 'Cardiología', 'Cardiología Pediátrica', 'ESP-CARD-001'),
(89, 'Dermatología', 'Cirugía Dermatológica', 'ESP-DERM-001'),
(90, 'Gastroenterología', 'Endoscopia Digestiva', 'ESP-GASTRO-001'),
(91, 'Hematología', 'Hemato-Oncología', 'ESP-HEMA-001'),
(92, 'Nefrología', 'Nefrología Pediátrica', 'ESP-NEFRO-001'),
(93, 'Neumología', 'Neumología Intervencionista', 'ESP-NEUMO-001'),
(94, 'Oftalmología', 'Oftalmología Pediátrica', 'ESP-OFTAL-001'),
(95, 'Oncología', 'Oncología Médica', 'ESP-ONCO-001'),
(96, 'Otorrinolaringología', 'Otorrinolaringología Pediátrica', 'ESP-OTORRINO-001'),
(97, 'Pediatría', 'Neonatología', 'ESP-PEDIA-001'),
(98, 'Psiquiatría', 'Psiquiatría Forense', 'ESP-PSIQ-001'),
(99, 'Reumatología', 'Reumatología Pediátrica', 'ESP-REUMA-001'),
(100, 'Traumatología', 'Traumatología Deportiva', 'ESP-TRAUMA-001'),
(101, 'Urología', 'Urología Oncológica', 'ESP-UROLO-001'),
(102, 'Anestesiología', NULL, 'ESP-ANEST-001'),
(103, 'Endocrinología', NULL, 'ESP-ENDO-001'),
(104, 'Ginecología', NULL, 'ESP-GINE-001'),
(105, 'Neurología', NULL, 'ESP-NEURO-001'),
(106, 'Radiología', 'Radiología Vascular e Intervencionista', 'ESP-RADIO-001'),
(107, 'Cirugía General', NULL, 'ESP-CIR-001'),
(108, 'Geriatria', 'Geriatria Oncologica', 'ESP-GERIA-001'),
(109, 'Infectologia', 'Infectologia Pediatrica', 'ESP-INFEC-001');

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
(1, 'Pedro', 'Gómez', '11111111', 'Calle 1', 'Argentina', 'pedro@mimail.com', '1111111111', 'MP-1111', 'MN-1111', 1, 1),
(2, 'Laura', 'Fernández', '22222222', 'Avenida 2', 'Argentina', 'laura@mimail.com', '2222222222', 'MP-2222', 'MN-2222', 2, 2),
(3, 'Roberto', 'Sánchez', '33333333', 'Ruta 3', 'Argentina', 'roberto@mimail.com', '3333333333', 'MP-3333', 'MN-3333', 1, 3),
(4, 'Marcela', 'González', '44444444', 'Calle 4', 'Argentina', 'marcela@mimail.com', '4444444444', 'MP-4444', 'MN-4444', 2, 4),
(5, 'Alejandro', 'López', '55555555', 'Avenida 5', 'Argentina', 'alejandro@mimail.com', '5555555555', 'MP-5555', 'MN-5555', 1, 5),
(6, 'Carolina', 'Martínez', '66666666', 'Ruta 6', 'Argentina', 'carolina@mimail.com', '6666666666', 'MP-6666', 'MN-6666', 2, 1),
(7, 'Sergio', 'Hernández', '77777777', 'Calle 7', 'Argentina', 'sergio@mimail.com', '7777777777', 'MP-7777', 'MN-7777', 1, 2),
(8, 'María', 'López', '88888888', 'Avenida 8', 'Argentina', 'maria@mimail.com', '8888888888', 'MP-8888', 'MN-8888', 2, 3);

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
(5, 'Ana', 'Rodríguez', 'F', 40, '87654321', '1983-12-05 00:00:00.000000', 'Calle Principal', 'Argentina', 'ana@mimail.com', '4321098765', '000004', '2021-04-01', NULL, NULL, NULL, 4, 4, 2),
(6, 'Luis', 'Martínez', 'M', 45, '34117890', '1978-11-18 00:00:00.000000', 'Avenida Central', 'Argentina', 'luis@mimail.com', '9012345678', '000005', '2021-05-01', NULL, NULL, NULL, 5, 5, 3);

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
  ADD UNIQUE KEY `anio_egreso` (`anio_egreso`),
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
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `diagnostico`
--
ALTER TABLE `diagnostico`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `especialidadmedica`
--
ALTER TABLE `especialidadmedica`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

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
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `obrasocial`
--
ALTER TABLE `obrasocial`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tratamiento_medicamento`
--
ALTER TABLE `tratamiento_medicamento`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `turno`
--
ALTER TABLE `turno`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

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
