-- Para generar el backup de la base de datos clinica, usar el siguiente comando:

-- Comando: mysqldump -u root -p [clinica] --no-create-info clinica > backup.sql
-- Base de datos: clinica 
-- Archivo: backup.sql
-- Para restaurar la base de datos clinica, usar el siguiente comando:
-- Comando: mysqldump -u root -p  [clinica] < backup.sql

-- Tablas incluidas en la base de datos "clinica":
-- - especialidadmedica
-- - localidad
-- - medico
-- - consultorios
-- - obrasocial
-- - persona
-- - turno
-- - log_medico
-- - log_turno
-- - empleado
-- - vacaciones
-- - vacaciones_medico

-----------------------------------------------------------------------------------------------------------------------------------


-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: clinica
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `consultorios`
--

LOCK TABLES `consultorios` WRITE;
/*!40000 ALTER TABLE `consultorios` DISABLE KEYS */;
/*!40000 ALTER TABLE `consultorios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `especialidadmedica`
--

LOCK TABLES `especialidadmedica` WRITE;
/*!40000 ALTER TABLE `especialidadmedica` DISABLE KEYS */;
INSERT INTO `especialidadmedica` VALUES (1,'Cardiolog├¡a','Electrofisiolog├¡a','001');
/*!40000 ALTER TABLE `especialidadmedica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `localidad`
--

LOCK TABLES `localidad` WRITE;
/*!40000 ALTER TABLE `localidad` DISABLE KEYS */;
INSERT INTO `localidad` VALUES (1,'Ciudad Aut├│noma de Buenos Aires','1000','Buenos Aires');
/*!40000 ALTER TABLE `localidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_medico`
--

LOCK TABLES `log_medico` WRITE;
/*!40000 ALTER TABLE `log_medico` DISABLE KEYS */;
INSERT INTO `log_medico` VALUES (1,'root@localhost','2023-06-30','08:23:30','Se va a insertar un nuevo registro en la tabla medico.'),(2,'root@localhost','2023-06-30','08:23:30','Se ha insertado un nuevo registro en la tabla medico.'),(3,'root@localhost','2023-06-30','08:23:30','Se va a insertar un nuevo registro en la tabla medico.'),(4,'root@localhost','2023-06-30','08:23:30','Se ha insertado un nuevo registro en la tabla medico.'),(5,'root@localhost','2023-06-30','08:23:30','Se va a insertar un nuevo registro en la tabla medico.'),(6,'root@localhost','2023-06-30','08:23:30','Se ha insertado un nuevo registro en la tabla medico.'),(7,'root@localhost','2023-06-30','08:23:30','Se va a insertar un nuevo registro en la tabla medico.'),(8,'root@localhost','2023-06-30','08:23:30','Se ha insertado un nuevo registro en la tabla medico.'),(9,'root@localhost','2023-06-30','08:23:30','Se va a insertar un nuevo registro en la tabla medico.'),(10,'root@localhost','2023-06-30','08:23:30','Se ha insertado un nuevo registro en la tabla medico.'),(11,'root@localhost','2023-06-30','08:23:30','Se va a insertar un nuevo registro en la tabla medico.'),(12,'root@localhost','2023-06-30','08:23:30','Se ha insertado un nuevo registro en la tabla medico.'),(13,'root@localhost','2023-06-30','08:23:30','Se va a insertar un nuevo registro en la tabla medico.'),(14,'root@localhost','2023-06-30','08:23:30','Se ha insertado un nuevo registro en la tabla medico.'),(15,'root@localhost','2023-06-30','08:23:30','Se va a insertar un nuevo registro en la tabla medico.'),(16,'root@localhost','2023-06-30','08:23:30','Se ha insertado un nuevo registro en la tabla medico.');
/*!40000 ALTER TABLE `log_medico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_turno`
--

LOCK TABLES `log_turno` WRITE;
/*!40000 ALTER TABLE `log_turno` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_turno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `medico`
--

LOCK TABLES `medico` WRITE;
/*!40000 ALTER TABLE `medico` DISABLE KEYS */;
INSERT INTO `medico` VALUES (1,'Pedro','G├│mez','11111111','Calle 1','Argentina','pedro@mimail.com','1111111111','MP-1111','MN-1111',1,1),(2,'Laura','Fern├índez','22222222','Avenida 2','Argentina','laura@mimail.com','2222222222','MP-2222','MN-2222',2,2),(3,'Roberto','S├ínchez','33333333','Ruta 3','Argentina','roberto@mimail.com','3333333333','MP-3333','MN-3333',1,3),(4,'Marcela','Gonz├ílez','44444444','Calle 4','Argentina','marcela@mimail.com','4444444444','MP-4444','MN-4444',2,4),(5,'Alejandro','L├│pez','55555555','Avenida 5','Argentina','alejandro@mimail.com','5555555555','MP-5555','MN-5555',1,5),(6,'Carolina','Mart├¡nez','66666666','Ruta 6','Argentina','carolina@mimail.com','6666666666','MP-6666','MN-6666',2,1),(7,'Sergio','Hern├índez','77777777','Calle 7','Argentina','sergio@mimail.com','7777777777','MP-7777','MN-7777',1,2),(8,'Mar├¡a','L├│pez','88888888','Avenida 8','Argentina','maria@mimail.com','8888888888','MP-8888','MN-8888',2,3);
/*!40000 ALTER TABLE `medico` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_before_medico
BEFORE INSERT ON medico
FOR EACH ROW
BEGIN
    INSERT INTO log_medico (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se va a insertar un nuevo registro en la tabla medico.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripci├│n de la acci├│n que se realizar├í.
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_after_medico
AFTER INSERT ON medico
FOR EACH ROW
BEGIN
    INSERT INTO log_medico (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se ha insertado un nuevo registro en la tabla medico.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripci├│n de la acci├│n que se realiz├│.
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `obrasocial`
--

LOCK TABLES `obrasocial` WRITE;
/*!40000 ALTER TABLE `obrasocial` DISABLE KEYS */;
INSERT INTO `obrasocial` VALUES (1,'Obra Social X','OSX');
/*!40000 ALTER TABLE `obrasocial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (5,'Luis','Mart├¡nez','M',45,'34117890','1978-11-18 00:00:00.000000','Avenida Central','Argentina','luis@mimail.com','9012345678','000005','2021-05-01',NULL,NULL,NULL,5,5,3);
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `turno`
--

LOCK TABLES `turno` WRITE;
/*!40000 ALTER TABLE `turno` DISABLE KEYS */;
/*!40000 ALTER TABLE `turno` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_before_turno
BEFORE DELETE ON turno
FOR EACH ROW
BEGIN
    INSERT INTO log_turno (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se va a eliminar un registro de la tabla turno.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripci├│n de la acci├│n que se realizar├í.
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_after_turno
AFTER DELETE ON turno
FOR EACH ROW
BEGIN
    INSERT INTO log_turno (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se ha eliminado un registro de la tabla turno.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripci├│n de la acci├│n que se realiz├│.
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `vacaciones`
--

LOCK TABLES `vacaciones` WRITE;
/*!40000 ALTER TABLE `vacaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `vacaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `vacaciones_medico`
--

LOCK TABLES `vacaciones_medico` WRITE;
/*!40000 ALTER TABLE `vacaciones_medico` DISABLE KEYS */;
/*!40000 ALTER TABLE `vacaciones_medico` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-30  8:27:31
