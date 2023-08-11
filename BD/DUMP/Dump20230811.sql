-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: bd_teste
-- ------------------------------------------------------
-- Server version	5.7.42-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(100) DEFAULT NULL,
  `CIDADE` varchar(100) DEFAULT NULL,
  `UF` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_CLIENTE_NOME` (`NOME`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'João da Silva','São Paulo','SP'),(2,'Maria Oliveira','Rio de Janeiro','RJ'),(3,'Pedro Souza','Belo Horizonte','MG'),(4,'Ana Pereira','Salvador','BA'),(5,'Luiz Santos','Fortaleza','CE'),(6,'Carla Costa','Recife','PE'),(7,'Rafael Almeida','Brasília','DF'),(8,'Fernanda Lima','Manaus','AM'),(9,'Marcos Oliveira','Curitiba','PR'),(10,'Julia Rodrigues','Porto Alegre','RS'),(11,'Diego Costa','Belém','PA'),(12,'Camila Martins','Goiânia','GO'),(13,'Lucas Ferreira','São Luís','MA'),(14,'Mariana Carvalho','Natal','RN'),(15,'Gustavo Silva','João Pessoa','PB'),(16,'Amanda Sousa','Maceió','AL'),(17,'Daniel Rodrigues','Campo Grande','MS'),(18,'Larissa Oliveira','Teresina','PI'),(19,'Felipe Alves','Florianópolis','SC'),(20,'Isabela Santos','Vitória','ES'),(21,'Thiago Lima','Cuiabá','MT'),(22,'Carolina Fernandes','Aracaju','SE'),(23,'Eduardo Pereira','Porto Velho','RO'),(24,'Natália Costa','Palmas','TO'),(25,'Alexandre Almeida','Boa Vista','RR'),(26,'Patrícia Oliveira','Rio Branco','AC'),(27,'Marcelo Rodrigues','Macapá','AP'),(28,'Vanessa Souza','Porto Seguro','BA'),(29,'Ricardo Martins','Campos dos Goytacazes','RJ'),(30,'Fernanda Pereira','Petrópolis','RJ'),(31,'Luciana Silva','Niterói','RJ');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `NUMERO` int(11) NOT NULL,
  `DATA_EMISSAO` date DEFAULT NULL,
  `ID_CLIENTE` int(11) DEFAULT NULL,
  `VALOR_TOTAL` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`NUMERO`),
  KEY `FK_IDCLIENTE` (`ID_CLIENTE`),
  KEY `idx_PEDIDO_DATA_EMISSAO` (`DATA_EMISSAO`),
  CONSTRAINT `FK_IDCLIENTE` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,'2023-08-11',1,129.40);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_produto`
--

DROP TABLE IF EXISTS `pedido_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_produto` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NUMERO_PEDIDO` int(11) NOT NULL,
  `ID_PRODUTO` int(11) NOT NULL,
  `QUANTIDADE` decimal(10,0) DEFAULT NULL,
  `PRECO` decimal(10,2) DEFAULT NULL,
  `VALOR_TOTAL` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_NUMEROPEDIDO` (`NUMERO_PEDIDO`),
  KEY `FK_IDPRODUTO` (`ID_PRODUTO`),
  CONSTRAINT `FK_IDPRODUTO` FOREIGN KEY (`ID_PRODUTO`) REFERENCES `produto` (`ID`),
  CONSTRAINT `FK_NUMEROPEDIDO` FOREIGN KEY (`NUMERO_PEDIDO`) REFERENCES `pedido` (`NUMERO`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_produto`
--

LOCK TABLES `pedido_produto` WRITE;
/*!40000 ALTER TABLE `pedido_produto` DISABLE KEYS */;
INSERT INTO `pedido_produto` VALUES (3,1,1,1,39.90,39.90),(4,1,2,1,89.50,89.50);
/*!40000 ALTER TABLE `pedido_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(100) DEFAULT NULL,
  `PRECO` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_PRODUTO_DESCRICAO` (`DESCRICAO`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Camiseta Branca',39.90),(2,'Calça Jeans',89.50),(3,'Vestido Floral',129.99),(4,'Camisa Xadrez',49.75),(5,'Blusa de Tricô',59.25),(6,'Shorts Jeans',69.90),(7,'Jaqueta de Couro',149.50),(8,'Saia Plissada',34.99),(9,'Suéter de Cashmere',119.75),(10,'Calça Legging',29.25),(11,'Casaco de Inverno',99.90),(12,'Blusa de Manga Longa',39.50),(13,'Bermuda Esportiva',49.99),(14,'Macacão Jeans',89.75),(15,'Camiseta Estampada',44.25),(16,'Blazer Clássico',74.90),(17,'Vestido de Festa',169.50),(18,'Calça Social',59.99),(19,'Cardigã de Lã',49.25),(20,'Shorts Estampado',64.90),(21,'Jaqueta Corta-Vento',79.50),(22,'Saia Midi',39.75),(23,'Moletom Confortável',54.25),(24,'Legging Esportiva',29.90),(25,'Casaco Acolchoado',109.99),(26,'Blusa de Malha',34.75),(27,'Shorts de Praia',24.25),(28,'Macacão Floral',79.90),(29,'Camiseta Listrada',41.50),(30,'Terno Clássico',199.99),(31,'Vestido Longo',129.75),(32,'Calça Flare',59.25),(33,'Jaqueta Jeans',89.90),(34,'Saia Lápis',44.50),(35,'Moletom Estiloso',54.99),(36,'Legging Casual',34.75),(37,'Jaqueta Corta-Vento',79.25),(38,'Shorts Jeans Desbotado',59.90),(39,'Blusa de Tricô',49.50),(40,'Vestido Estampado',119.99),(41,'Calça Skinny',69.75),(42,'Blazer Moderno',89.25),(43,'Macacão de Linho',74.90),(44,'Camiseta Vintage',34.25),(45,'Casaco de Lã',129.50),(46,'Saia Plissada',49.99),(47,'Shorts de Corrida',29.75),(48,'Jaqueta de Algodão',44.25),(49,'Bermuda de Praia',54.90),(50,'Macacão de Verão',89.50),(51,'Camiseta Estampada',39.99),(52,'Blusa de Renda',59.75),(53,'Vestido Casual',74.25);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bd_teste'
--

--
-- Dumping routines for database 'bd_teste'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-11 11:14:15
