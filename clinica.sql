-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-07-2023 a las 00:42:52
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

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_edad` (`birth_date` DATE) RETURNS INT(11)  BEGIN
  DECLARE age INT;
  SET age = TIMESTAMPDIFF(YEAR, birth_date, CURDATE());
  RETURN age;
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
(1, 'Cardiología', 'Electrofisiología', '001');

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
(1, 'Ciudad Autónoma de Buenos Aires', '1000', 'Buenos Aires');

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

--
-- Volcado de datos para la tabla `log_medico`
--

INSERT INTO `log_medico` (`id`, `usuario`, `fecha`, `hora`, `accion`) VALUES
(1, 'root@localhost', '2023-06-30', '08:23:30', 'Se va a insertar un nuevo registro en la tabla medico.'),
(2, 'root@localhost', '2023-06-30', '08:23:30', 'Se ha insertado un nuevo registro en la tabla medico.'),
(3, 'root@localhost', '2023-06-30', '08:23:30', 'Se va a insertar un nuevo registro en la tabla medico.'),
(4, 'root@localhost', '2023-06-30', '08:23:30', 'Se ha insertado un nuevo registro en la tabla medico.'),
(5, 'root@localhost', '2023-06-30', '08:23:30', 'Se va a insertar un nuevo registro en la tabla medico.'),
(6, 'root@localhost', '2023-06-30', '08:23:30', 'Se ha insertado un nuevo registro en la tabla medico.'),
(7, 'root@localhost', '2023-06-30', '08:23:30', 'Se va a insertar un nuevo registro en la tabla medico.'),
(8, 'root@localhost', '2023-06-30', '08:23:30', 'Se ha insertado un nuevo registro en la tabla medico.'),
(9, 'root@localhost', '2023-06-30', '08:23:30', 'Se va a insertar un nuevo registro en la tabla medico.'),
(10, 'root@localhost', '2023-06-30', '08:23:30', 'Se ha insertado un nuevo registro en la tabla medico.'),
(11, 'root@localhost', '2023-06-30', '08:23:30', 'Se va a insertar un nuevo registro en la tabla medico.'),
(12, 'root@localhost', '2023-06-30', '08:23:30', 'Se ha insertado un nuevo registro en la tabla medico.'),
(13, 'root@localhost', '2023-06-30', '08:23:30', 'Se va a insertar un nuevo registro en la tabla medico.'),
(14, 'root@localhost', '2023-06-30', '08:23:30', 'Se ha insertado un nuevo registro en la tabla medico.'),
(15, 'root@localhost', '2023-06-30', '08:23:30', 'Se va a insertar un nuevo registro en la tabla medico.'),
(16, 'root@localhost', '2023-06-30', '08:23:30', 'Se ha insertado un nuevo registro en la tabla medico.');

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
(1, 'Obra Social X', 'OSX');

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
(5, 'Luis', 'Martínez', 'M', 45, '34117890', '1978-11-18 00:00:00.000000', 'Avenida Central', 'Argentina', 'luis@mimail.com', '9012345678', '000005', '2021-05-01', NULL, NULL, NULL, 5, 5, 3);

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
-- Estructura para la vista `vista_consultorios_disponibles`
--
DROP TABLE IF EXISTS `vista_consultorios_disponibles`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_consultorios_disponibles`  AS SELECT `c`.`id` AS `id`, `c`.`nombre` AS `nombre`, `c`.`ocupado` AS `ocupado`, `m`.`nombre` AS `medico` FROM (`consultorios` `c` left join `medico` `m` on(`c`.`medico_id` = `m`.`id`)) WHERE `c`.`ocupado` = 0 OR `c`.`ocupado` is null ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_empleados`
--
DROP TABLE IF EXISTS `vista_empleados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_empleados`  AS SELECT `e`.`id` AS `id`, `e`.`nombre` AS `nombre`, `e`.`apellido` AS `apellido`, `e`.`puesto` AS `puesto`, `l`.`nombre` AS `localidad` FROM (`empleado` `e` join `localidad` `l` on(`e`.`localidad_id` = `l`.`id`)) ;

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
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `especialidadmedica`
--
ALTER TABLE `especialidadmedica`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `localidad`
--
ALTER TABLE `localidad`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `log_medico`
--
ALTER TABLE `log_medico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_localidad_id_fk` FOREIGN KEY (`localidad_id`) REFERENCES `localidad` (`id`),
  ADD CONSTRAINT `empleado_obra_social_id_fk` FOREIGN KEY (`obra_social_id`) REFERENCES `obrasocial` (`id`);

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
