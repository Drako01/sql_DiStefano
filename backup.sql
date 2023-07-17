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
-- Dumping data for table `diagnostico`
--

LOCK TABLES `diagnostico` WRITE;
/*!40000 ALTER TABLE `diagnostico` DISABLE KEYS */;
/*!40000 ALTER TABLE `diagnostico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (1,'Pedro','L├│pez','Masculino',28,'87654321','E1234','1995-10-15','Calle Principal 789','Argentina','pedrolopez@example.com','0123456789','Contacto Familiar','987654321012','Administrativo','2021-01-01','Licenciatura en Administraci├│n','Universidad ABC','Licenciatura en Administraci├│n','2020',NULL,NULL);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `especialidadmedica`
--

LOCK TABLES `especialidadmedica` WRITE;
/*!40000 ALTER TABLE `especialidadmedica` DISABLE KEYS */;
INSERT INTO `especialidadmedica` VALUES (88,'Cardiolog├¡a','Cardiolog├¡a Pedi├ítrica','ESP-CARD-001'),(89,'Dermatolog├¡a','Cirug├¡a Dermatol├│gica','ESP-DERM-001'),(90,'Gastroenterolog├¡a','Endoscopia Digestiva','ESP-GASTRO-001'),(91,'Hematolog├¡a','Hemato-Oncolog├¡a','ESP-HEMA-001'),(92,'Nefrolog├¡a','Nefrolog├¡a Pedi├ítrica','ESP-NEFRO-001'),(93,'Neumolog├¡a','Neumolog├¡a Intervencionista','ESP-NEUMO-001'),(94,'Oftalmolog├¡a','Oftalmolog├¡a Pedi├ítrica','ESP-OFTAL-001'),(95,'Oncolog├¡a','Oncolog├¡a M├®dica','ESP-ONCO-001'),(96,'Otorrinolaringolog├¡a','Otorrinolaringolog├¡a Pedi├ítrica','ESP-OTORRINO-001'),(97,'Pediatr├¡a','Neonatolog├¡a','ESP-PEDIA-001'),(98,'Psiquiatr├¡a','Psiquiatr├¡a Forense','ESP-PSIQ-001'),(99,'Reumatolog├¡a','Reumatolog├¡a Pedi├ítrica','ESP-REUMA-001'),(100,'Traumatolog├¡a','Traumatolog├¡a Deportiva','ESP-TRAUMA-001'),(101,'Urolog├¡a','Urolog├¡a Oncol├│gica','ESP-UROLO-001'),(102,'Anestesiolog├¡a',NULL,'ESP-ANEST-001'),(103,'Endocrinolog├¡a',NULL,'ESP-ENDO-001'),(104,'Ginecolog├¡a',NULL,'ESP-GINE-001'),(105,'Neurolog├¡a',NULL,'ESP-NEURO-001'),(106,'Radiolog├¡a','Radiolog├¡a Vascular e Intervencionista','ESP-RADIO-001'),(107,'Cirug├¡a General',NULL,'ESP-CIR-001'),(108,'Geriatria','Geriatria Oncologica','ESP-GERIA-001'),(109,'Infectologia','Infectologia Pediatrica','ESP-INFEC-001');
/*!40000 ALTER TABLE `especialidadmedica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `localidad`
--

LOCK TABLES `localidad` WRITE;
/*!40000 ALTER TABLE `localidad` DISABLE KEYS */;
INSERT INTO `localidad` VALUES (1,'La Plata','1900','Buenos Aires'),(2,'Quilmes','1878','Buenos Aires'),(3,'Avellaneda','1870','Buenos Aires'),(4,'Lan├║s','1824','Buenos Aires'),(5,'Banfield','1828','Buenos Aires'),(6,'Berazategui','1884','Buenos Aires'),(7,'Florencio Varela','1888','Buenos Aires'),(8,'San Justo','1754','Buenos Aires'),(9,'Mor├│n','1708','Buenos Aires'),(10,'Ituzaing├│','1714','Buenos Aires'),(11,'San Fernando','1646','Buenos Aires'),(12,'Tigre','1648','Buenos Aires'),(13,'Pilar','1629','Buenos Aires'),(14,'Escobar','1625','Buenos Aires'),(15,'San Miguel','1663','Buenos Aires'),(16,'San Isidro','1642','Buenos Aires'),(17,'Vicente L├│pez','1638','Buenos Aires'),(18,'Merlo','1722','Buenos Aires'),(19,'Ezeiza','1804','Buenos Aires'),(20,'Adrogu├®','1846','Buenos Aires'),(21,'Burzaco','1852','Buenos Aires'),(22,'General Pacheco','1617','Buenos Aires'),(23,'Mart├¡nez','1640','Buenos Aires'),(24,'Bernal','1876','Buenos Aires'),(25,'Ramos Mej├¡a','1704','Buenos Aires'),(26,'Don Torcuato','1611','Buenos Aires'),(27,'Temperley','1834','Buenos Aires'),(28,'Caseros','1678','Buenos Aires'),(29,'Jos├® C. Paz','1665','Buenos Aires'),(30,'San Vicente','1865','Buenos Aires');
/*!40000 ALTER TABLE `localidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_medico`
--

LOCK TABLES `log_medico` WRITE;
/*!40000 ALTER TABLE `log_medico` DISABLE KEYS */;
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
INSERT INTO `obrasocial` VALUES (1,'Obra Social del Trabajador','OST'),(2,'Salud Segura','SSA'),(3,'Cobertura M├®dica Integral','CMI'),(4,'Seguro de Salud Argentino','SSA'),(5,'Asistencia M├®dica Previsional','AMP'),(6,'Salud Protegida','SP'),(7,'Asistencia Integral M├®dica','AIM'),(8,'Cuidado Saludable','CS'),(9,'Protecci├│n M├®dica','PM'),(10,'Asistencia Sanitaria Nacional','ASN'),(11,'Cobertura de Salud Integral','CSI'),(12,'Seguridad M├®dica','SM'),(13,'Bienestar M├®dico','BM'),(14,'Salud Comunitaria','SC'),(15,'Cobertura M├®dica Nacional','CMN'),(16,'Asistencia Social Saludable','ASS'),(17,'Seguro M├®dico Argentino','SMA'),(18,'Asistencia M├®dica Nacional','AMN'),(19,'Protecci├│n Sanitaria','PS'),(20,'Cobertura de Salud Familiar','CSF');
/*!40000 ALTER TABLE `obrasocial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (5,'Ana','Rodr├¡guez','F',40,'87654321','1983-12-05 00:00:00.000000','Calle Principal','Argentina','ana@mimail.com','4321098765','000004','2021-04-01',NULL,NULL,NULL,4,4,2),(6,'Luis','Mart├¡nez','M',45,'34117890','1978-11-18 00:00:00.000000','Avenida Central','Argentina','luis@mimail.com','9012345678','000005','2021-05-01',NULL,NULL,NULL,5,5,3);
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_before_persona
BEFORE INSERT ON persona
FOR EACH ROW
BEGIN
    INSERT INTO log_persona (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se va a insertar un nuevo registro en la tabla persona.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripci├│n de la acci├│n que se realizar├í.
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_before_update_persona
BEFORE UPDATE ON persona
FOR EACH ROW
BEGIN
    INSERT INTO log_persona (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se va a actualizar un registro en la tabla persona.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripci├│n de la acci├│n que se realizar├í.
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `tratamiento`
--

LOCK TABLES `tratamiento` WRITE;
/*!40000 ALTER TABLE `tratamiento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tratamiento` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_after_tratamiento
AFTER INSERT ON tratamiento
FOR EACH ROW
BEGIN
    INSERT INTO log_tratamiento (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se ha insertado un nuevo registro en la tabla tratamiento.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripci├│n de la acci├│n que se realiz├│.
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_after_update_tratamiento
AFTER UPDATE ON tratamiento
FOR EACH ROW
BEGIN
    INSERT INTO log_tratamiento (usuario, fecha, hora, accion)
    VALUES (CURRENT_USER(), CURDATE(), CURTIME(), 'Se ha actualizado un registro en la tabla tratamiento.'); -- Se inserta el usuario actual, la fecha y la hora actual, junto con una descripci├│n de la acci├│n que se realiz├│.
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `tratamiento_medicamento`
--

LOCK TABLES `tratamiento_medicamento` WRITE;
/*!40000 ALTER TABLE `tratamiento_medicamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tratamiento_medicamento` ENABLE KEYS */;
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

-- Dump completed on 2023-07-17 18:16:01
