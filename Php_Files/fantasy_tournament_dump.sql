-- MySQL dump 10.19  Distrib 10.3.38-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: fantasytourney
-- ------------------------------------------------------
-- Server version	10.3.38-MariaDB-0+deb10u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `active_matchups_with_votes`
--

DROP TABLE IF EXISTS `active_matchups_with_votes`;
/*!50001 DROP VIEW IF EXISTS `active_matchups_with_votes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `active_matchups_with_votes` AS SELECT
 1 AS `matchup_id`,
  1 AS `tournament_id`,
  1 AS `tournament_title`,
  1 AS `round_number`,
  1 AS `status`,
  1 AS `opens_at`,
  1 AS `closes_at`,
  1 AS `entryA_id`,
  1 AS `entryA_name`,
  1 AS `entryA_image`,
  1 AS `entryB_id`,
  1 AS `entryB_name`,
  1 AS `entryB_image`,
  1 AS `entryA_votes`,
  1 AS `entryB_votes`,
  1 AS `total_votes` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `entry`
--

DROP TABLE IF EXISTS `entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entry` (
  `entry_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL CHECK (`name` <> ''),
  `description` varchar(255) DEFAULT NULL,
  `image_URL` varchar(255) DEFAULT NULL,
  `seed` int(11) DEFAULT NULL,
  `tournament_id` int(11) NOT NULL,
  PRIMARY KEY (`entry_id`),
  KEY `entry_ibfk_1` (`tournament_id`),
  CONSTRAINT `entry_ibfk_1` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`tournament_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1897 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci `ENCRYPTION_KEY_ID`=100;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entry`
--

LOCK TABLES `entry` WRITE;
/*!40000 ALTER TABLE `entry` DISABLE KEYS */;
INSERT INTO `entry` VALUES (9,'Spider-Man','Your friendly neighborhood Spider-Man',NULL,1,2),(10,'Iron Man','Genius billionaire playboy philanthropist',NULL,8,2),(11,'Captain America','The first Avenger',NULL,4,2),(12,'Thor','God of Thunder',NULL,5,2),(13,'Black Widow','Master spy and assassin',NULL,3,2),(14,'Hulk','The strongest Avenger',NULL,6,2),(15,'Doctor Strange','Master of the Mystic Arts',NULL,2,2),(16,'Black Panther','King of Wakanda',NULL,7,2),(17,'Python','Versatile and beginner-friendly',NULL,1,3),(18,'JavaScript','The language of the web',NULL,8,3),(19,'Java','Enterprise standard',NULL,4,3),(20,'C++','High performance systems language',NULL,5,3),(21,'Go','Modern and efficient',NULL,3,3),(22,'Rust','Memory safe systems programming',NULL,6,3),(23,'TypeScript','JavaScript with types',NULL,2,3),(24,'C#','Microsoft powerhouse',NULL,7,3),(25,'The Matrix','Mind-bending sci-fi classic',NULL,1,4),(26,'Pulp Fiction','Tarantino masterpiece',NULL,16,4),(27,'Jurassic Park','Dinosaurs come to life',NULL,8,4),(28,'The Shawshank Redemption','Prison drama perfection',NULL,9,4),(29,'Forrest Gump','Life is like a box of chocolates',NULL,4,4),(30,'Titanic','Epic romance and tragedy',NULL,13,4),(31,'Fight Club','First rule: dont talk about it',NULL,5,4),(32,'The Sixth Sense','I see dead people',NULL,12,4),(33,'Goodfellas','Mob movie excellence',NULL,2,4),(34,'Saving Private Ryan','War film masterpiece',NULL,15,4),(35,'The Big Lebowski','The Dude abides',NULL,7,4),(36,'Fargo','Dark comedy crime thriller',NULL,10,4),(37,'American Beauty','Suburban drama',NULL,3,4),(38,'The Truman Show','Reality TV before reality TV',NULL,14,4),(39,'Toy Story','Pixar animation revolution',NULL,6,4),(40,'The Lion King','Circle of life',NULL,11,4),(41,'The Legend of Zelda: Ocarina of Time','N64 adventure classic',NULL,1,5),(42,'Super Mario 64','Revolutionary 3D platformer',NULL,16,5),(43,'Half-Life 2','FPS storytelling masterpiece',NULL,8,5),(44,'The Last of Us','Post-apocalyptic emotional journey',NULL,9,5),(45,'Red Dead Redemption 2','Wild West epic',NULL,4,5),(46,'Minecraft','Infinite creativity sandbox',NULL,13,5),(47,'Dark Souls','Brutal but rewarding challenge',NULL,5,5),(48,'Portal 2','Puzzle game perfection',NULL,12,5),(49,'The Witcher 3','Massive RPG adventure',NULL,2,5),(50,'God of War (2018)','Norse mythology action',NULL,15,5),(51,'Elden Ring','Open world souls-like',NULL,7,5),(52,'Hades','Roguelike with amazing story',NULL,10,5),(53,'Baldurs Gate 3','Modern CRPG masterpiece',NULL,3,5),(54,'Hollow Knight','Metroidvania excellence',NULL,14,5),(55,'Celeste','Platforming and mental health',NULL,6,5),(56,'Stardew Valley','Farming sim with heart',NULL,11,5),(57,'The Daily Grind','Local favorite with great vibes',NULL,1,6),(58,'Brew Haven','Artisan roasts and cozy atmosphere',NULL,4,6),(59,'Java Junction','Best espresso in town',NULL,2,6),(60,'Cafe Momentum','Fair trade and community focused',NULL,3,6),(61,'Golden Retriever','Friendly and loyal family dog',NULL,1,7),(62,'Corgi','Short legs, big personality',NULL,8,7),(63,'Husky','Beautiful blue eyes and fluffy',NULL,4,7),(64,'Pomeranian','Tiny fluffy cloud',NULL,5,7),(65,'Shiba Inu','Internet famous doge',NULL,3,7),(66,'French Bulldog','Compact and charming',NULL,6,7),(67,'Samoyed','Always smiling fluff ball',NULL,2,7),(68,'Beagle','Adorable floppy ears',NULL,7,7),(69,'Dune','Frank Herberts desert epic',NULL,1,8),(70,'Enders Game','Military sci-fi classic',NULL,8,8),(71,'Neuromancer','Cyberpunk foundation',NULL,4,8),(72,'The Left Hand of Darkness','Ursula K. Le Guin masterwork',NULL,5,8),(73,'Foundation','Asimovs galactic empire',NULL,3,8),(74,'Hyperion','Canterbury Tales in space',NULL,6,8),(75,'Snow Crash','Virtual reality and linguistics',NULL,2,8),(76,'The Hitchhikers Guide to the Galaxy','Dont panic!',NULL,7,8),(83,'TriggerTestPep','ok',NULL,1,9),(92,'Pepperoni','Classic and beloved pepperoni',NULL,1,11),(93,'Mushrooms','Earthy and savory mushrooms',NULL,8,11),(94,'Sausage','Italian sausage chunks',NULL,4,11),(95,'Green Peppers','Fresh green bell peppers',NULL,5,11),(96,'Onions','Sweet caramelized onions',NULL,3,11),(97,'Black Olives','Briny black olives',NULL,6,11),(98,'Extra Cheese','More cheese is always better',NULL,2,11),(99,'Bacon','Crispy bacon bits',NULL,7,11),(501,'a','','',1,54),(502,'b','','',2,54),(503,'c','','',3,54),(504,'d','','',4,54),(505,'e','','',5,54),(506,'f','','',6,54),(507,'g','','',7,54),(508,'h','','',8,54),(509,'i','','',9,54),(510,'j','','',10,54),(511,'k','','',11,54),(512,'l','','',12,54),(513,'m','','',13,54),(514,'n','','',14,54),(515,'o','','',15,54),(516,'p','','',16,54),(901,'Fullmetal Alchemist: Brotherhood','Alchemy, brotherhood, and sacrifice.',NULL,1,99),(902,'Attack on Titan','Humanity vs Titans.',NULL,8,99),(903,'Death Note','A notebook of death in the hands of a genius.',NULL,4,99),(904,'One Piece','The pirate adventure to end all.',NULL,5,99),(905,'Naruto','Ninja legacy and perseverance.',NULL,3,99),(906,'Steins;Gate','Time travel and heartbreak.',NULL,6,99),(907,'Demon Slayer','Beautifully animated demon battles.',NULL,2,99),(908,'Cowboy Bebop','Space bounty hunters with jazz.',NULL,7,99),(1001,'Alpha','First contender',NULL,1,100),(1002,'Bravo','Second contender',NULL,4,100),(1003,'Charlie','Third contender',NULL,2,100),(1004,'Delta','Fourth contender',NULL,3,100),(1011,'Sun','Brightest star',NULL,1,101),(1012,'Moon','Earth’s satellite',NULL,4,101),(1013,'Earth','Home planet',NULL,2,101),(1014,'Mars','The red planet',NULL,3,101),(1109,'squidward','','uploads/entry_images/108_1_1764659252_squidward.jpg',1,108),(1110,'no pickles','','uploads/entry_images/108_2_1764659252_nopickles.jpg',2,108),(1111,'bubble guy','','uploads/entry_images/108_3_1764659252_bubbleguy.jpg',3,108),(1112,'pearl','','uploads/entry_images/108_4_1764659252_pearl.jpg',4,108),(1113,'larry','','uploads/entry_images/108_5_1764659252_larry.jpg',5,108),(1114,'plankton','','uploads/entry_images/108_6_1764659252_plankton.jpg',6,108),(1115,'fancy squid','','uploads/entry_images/108_7_1764659252_squidlium.jpg',7,108),(1116,'diet dr kelp','','uploads/entry_images/108_8_1764659252_dietdrkelp.png',8,108),(1117,'sandy','','uploads/entry_images/108_9_1764659252_sandy.jpg',9,108),(1118,'mr krabs','','uploads/entry_images/108_10_1764659252_mrkrabs.jpg',10,108),(1119,'surfer dude','','uploads/entry_images/108_11_1764659252_surfer.jpg',11,108),(1120,'my leg!','','uploads/entry_images/108_12_1764659252_myleg.jpg',12,108),(1121,'gary','','uploads/entry_images/108_13_1764659252_gary.jpg',13,108),(1122,'spongebob','','uploads/entry_images/108_14_1764659252_spongebob.jpg',14,108),(1123,'mrs puff','','uploads/entry_images/108_15_1764659252_miss_puff.jpg',15,108),(1124,'patrick','','uploads/entry_images/108_16_1764659252_patrick_head.jpg',16,108),(1125,'1','',NULL,1,109),(1126,'2','',NULL,2,109),(1127,'3','',NULL,3,109),(1128,'4','',NULL,4,109),(1129,'5','',NULL,5,109),(1130,'6','',NULL,6,109),(1131,'7','',NULL,7,109),(1132,'8','',NULL,8,109),(1133,'9','',NULL,9,109),(1134,'10','',NULL,10,109),(1135,'11','',NULL,11,109),(1136,'12','',NULL,12,109),(1137,'13','',NULL,13,109),(1138,'14','',NULL,14,109),(1139,'15','',NULL,15,109),(1140,'16','',NULL,16,109),(1141,'a','',NULL,1,110),(1142,'b','',NULL,2,110),(1143,'c','',NULL,3,110),(1144,'d','',NULL,4,110),(1145,'e','',NULL,5,110),(1146,'f','',NULL,6,110),(1147,'g','',NULL,7,110),(1148,'h','',NULL,8,110),(1149,'i','',NULL,9,110),(1150,'j','',NULL,10,110),(1151,'k','',NULL,11,110),(1152,'l','',NULL,12,110),(1153,'m','',NULL,13,110),(1154,'n','',NULL,14,110),(1155,'o','',NULL,15,110),(1156,'p','',NULL,16,110),(1189,'111','',NULL,1,113),(1190,'222','',NULL,2,113),(1191,'313','',NULL,3,113),(1192,'455','',NULL,4,113),(1193,'6','',NULL,5,113),(1194,'67','',NULL,6,113),(1195,'32','',NULL,7,113),(1196,'84','',NULL,8,113),(1197,'98','',NULL,9,113),(1198,'00','',NULL,10,113),(1199,'001100','',NULL,11,113),(1200,'777','',NULL,12,113),(1201,'444','',NULL,13,113),(1202,'34','',NULL,14,113),(1203,'1111111','',NULL,15,113),(1204,'1212','',NULL,16,113),(1301,'a','',NULL,1,120),(1302,'asdf','',NULL,2,120),(1303,'fd','',NULL,3,120),(1304,'sd','',NULL,4,120),(1305,'s','',NULL,5,120),(1306,'d','',NULL,6,120),(1307,'f','',NULL,7,120),(1308,'g','',NULL,8,120),(1309,'z','',NULL,9,120),(1310,'x','',NULL,10,120),(1311,'c','',NULL,11,120),(1312,'v','',NULL,12,120),(1313,'b','',NULL,13,120),(1314,'n','',NULL,14,120),(1315,'m','',NULL,15,120),(1316,'h','',NULL,16,120),(1317,'f','',NULL,1,121),(1318,'a','',NULL,2,121),(1319,'s','',NULL,3,121),(1320,'d','',NULL,4,121),(1321,'q','',NULL,5,121),(1322,'w','',NULL,6,121),(1323,'wr','',NULL,7,121),(1324,'e','',NULL,8,121),(1325,'r','',NULL,9,121),(1326,'t','',NULL,10,121),(1327,'y','',NULL,11,121),(1328,'u','',NULL,12,121),(1329,'o','',NULL,13,121),(1330,'i','',NULL,14,121),(1331,'p','',NULL,15,121),(1332,'l','',NULL,16,121),(1458,'a','lets see the full description',NULL,1,130),(1459,'b','',NULL,2,130),(1460,'c','',NULL,3,130),(1461,'d','',NULL,4,130),(1462,'e','',NULL,5,130),(1463,'f','',NULL,6,130),(1464,'g','',NULL,7,130),(1465,'h','',NULL,8,130),(1466,'i','',NULL,9,130),(1467,'j','',NULL,10,130),(1468,'k','',NULL,11,130),(1469,'l','',NULL,12,130),(1470,'m','',NULL,13,130),(1471,'n','',NULL,14,130),(1472,'o','',NULL,15,130),(1473,'p','',NULL,16,130),(1474,'a','',NULL,1,131),(1475,'b','',NULL,2,131),(1476,'c','',NULL,3,131),(1477,'d','',NULL,4,131),(1478,'e','',NULL,5,131),(1479,'f','',NULL,6,131),(1480,'g','',NULL,7,131),(1481,'h','',NULL,8,131),(1482,'q','',NULL,9,131),(1483,'w','',NULL,10,131),(1484,'y','',NULL,12,131),(1485,'r','',NULL,13,131),(1534,'a','',NULL,1,135),(1535,'s','',NULL,2,135),(1536,'d','',NULL,3,135),(1537,'f','',NULL,4,135),(1538,'g','',NULL,5,135),(1539,'h','',NULL,6,135),(1540,'1','',NULL,7,135),(1541,'2','',NULL,8,135),(1542,'3','',NULL,9,135),(1543,'4','',NULL,10,135),(1544,'5','',NULL,11,135),(1545,'6','',NULL,12,135),(1546,'7','',NULL,13,135),(1547,'8','',NULL,14,135),(1548,'01','',NULL,15,135),(1549,'9','',NULL,16,135),(1550,'Commander Zilyana','The toughest female in the God Wars dungeon!','uploads/entry_images/136_1_1764823778_commander_zilyana.jpeg',1,136),(1551,'Callisto','Do you dare enter Callisto\'s den??','uploads/entry_images/136_2_1764823778_callisto.jpeg',2,136),(1552,'Vorkath','Watch out for its ice dragon breath attack!','uploads/entry_images/136_3_1764823778_vorkath.jpeg',3,136),(1553,'Corporeal Beast','Did you get an ely drop yet??','uploads/entry_images/136_4_1764823778_corporeal_beast.jpeg',4,136),(1554,'Jad','You must defeat him for a fire cape!','uploads/entry_images/136_5_1764823778_jad.jpeg',5,136),(1555,'Skotizo','If you have any totems feel free to enter his lair!','uploads/entry_images/136_6_1764823778_skotizo.jpeg',6,136),(1556,'Scorpia','Bring an anti-poison!','uploads/entry_images/136_7_1764823778_scorpia.jpeg',7,136),(1557,'Chaos Fanatic','This dude is crazy!!','uploads/entry_images/136_8_1764823778_chaos_fanatic.jpeg',8,136),(1558,'Venenatis','Watch out for her webs!','uploads/entry_images/136_9_1764823778_venenatis.jpeg',9,136),(1559,'Zulrah','Careful! It has different attack phases!','uploads/entry_images/136_10_1764823778_zulrah.jpeg',10,136),(1560,'Sarachnis','Look at the legs on this one!','uploads/entry_images/136_11_1764823778_sarachnis.jpeg',11,136),(1561,'Chaos Elemental','Did you get the pet?','uploads/entry_images/136_12_1764823778_chaoeselemental.jpeg',12,136),(1562,'King Black Dragon','It has 3 heads!!','uploads/entry_images/136_13_1764823778_Kbd.jpeg',13,136),(1563,'Cerberus','Whats your slayer level?','uploads/entry_images/136_14_1764823778_Cerberus.webp',14,136),(1564,'Yama','One of the toughest around, gg\'s','uploads/entry_images/136_15_1764823778_yama.jpeg',15,136),(1565,'General Graardor','Please tell me you got the bandos tassets already?!','uploads/entry_images/136_16_1764823778_GeneralGraardor.jpeg',16,136),(1566,'ba','',NULL,1,137),(1567,'ad','',NULL,2,137),(1568,'fag','',NULL,3,137),(1569,'hgwtr','',NULL,4,137),(1570,'gfafg','',NULL,5,137),(1571,'ghty','',NULL,6,137),(1572,'gsg','',NULL,7,137),(1573,'cvdf','',NULL,8,137),(1574,'fgs fgsf','',NULL,9,137),(1575,'gfgr rtr','',NULL,10,137),(1576,'gsfgs r','',NULL,11,137),(1577,'grsrt','',NULL,12,137),(1578,'fgsr g','',NULL,13,137),(1579,'fgr fg','',NULL,14,137),(1580,'rg sref','',NULL,15,137),(1581,'f srtr','',NULL,16,137),(1582,'Froakie','lil frogger','uploads/entry_images/138_1_1764828780_froakie.jpeg',1,138),(1583,'Fennekin','cute','uploads/entry_images/138_2_1764828780_fennekin.jpeg',2,138),(1584,'Chespin','Did you really pick him?','uploads/entry_images/138_3_1764828780_chespin.jpeg',3,138),(1585,'Oshawott','Loves his shell','uploads/entry_images/138_4_1764828780_oshawatt.jpeg',4,138),(1586,'Snivy','sneaky looking..','uploads/entry_images/138_5_1764828780_snivy.jpeg',5,138),(1587,'Tepig','oink','uploads/entry_images/138_6_1764828780_tepig.jpeg',6,138),(1588,'Piplup','\"Pip-lupluplup!\"','uploads/entry_images/138_7_1764828780_piplup.jpeg',7,138),(1589,'Chimchar','Who doesn\'t love having an infernape?','uploads/entry_images/138_8_1764828780_chimchar.png',8,138),(1590,'Turtwig','Leaf head boy','uploads/entry_images/138_9_1764828780_turtwig.jpeg',9,138),(1591,'Mudkip','Gotta love him','uploads/entry_images/138_10_1764828780_mudkip.jpeg',10,138),(1592,'Torchic','Spicy wings','uploads/entry_images/138_11_1764828780_torchick.jpeg',11,138),(1593,'Treecko','One of the best','uploads/entry_images/138_12_1764828780_treecko.jpeg',12,138),(1594,'Totodile','He bites!','uploads/entry_images/138_13_1764828780_totodile.jpeg',13,138),(1595,'Chikorita','Useless','uploads/entry_images/138_14_1764828780_chikorita.jpeg',14,138),(1596,'Cyndaquil','Cant beat em? Join em','uploads/entry_images/138_15_1764828780_cyndaquil.jpeg',15,138),(1597,'Pikachu','You know who this champ is!','uploads/entry_images/138_16_1764828780_pikachu.jpeg',16,138),(1598,'a','',NULL,1,139),(1599,'s','',NULL,2,139),(1600,'d','',NULL,3,139),(1601,'f','',NULL,4,139),(1602,'g','',NULL,5,139),(1603,'z','',NULL,6,139),(1604,'x','',NULL,7,139),(1605,'c','',NULL,8,139),(1606,'v','',NULL,9,139),(1607,'b','',NULL,10,139),(1608,'n','',NULL,11,139),(1609,'m','',NULL,12,139),(1610,'y','',NULL,13,139),(1611,'u','',NULL,14,139),(1612,'i','',NULL,15,139),(1613,'o','',NULL,16,139),(1629,'fad','',NULL,1,141),(1630,'ffg','',NULL,2,141),(1631,'hj','',NULL,3,141),(1632,'luku','',NULL,4,141),(1633,'gh','',NULL,5,141),(1634,'tt','',NULL,6,141),(1635,'hdrt','',NULL,7,141),(1636,'jtyh','',NULL,8,141),(1637,'tthr','',NULL,10,141),(1638,'dsfae','',NULL,11,141),(1639,'jakeeeee','','uploads/entry_images/141_12_1764829606_jake-gyllenhall-listening-to-music.jpg',12,141),(1640,'fae','',NULL,13,141),(1641,'efe','',NULL,15,141),(1642,'erefetret','',NULL,16,141),(1643,'a','',NULL,1,142),(1644,'s','',NULL,2,142),(1645,'d','',NULL,3,142),(1646,'f','',NULL,4,142),(1647,'1','',NULL,5,142),(1648,'2','',NULL,6,142),(1649,'3','',NULL,7,142),(1650,'4','',NULL,8,142),(1651,'5','',NULL,9,142),(1652,'6','',NULL,10,142),(1653,'7','',NULL,11,142),(1654,'8','',NULL,12,142),(1655,'9','',NULL,13,142),(1656,'10','',NULL,14,142),(1657,'11','',NULL,15,142),(1658,'12','',NULL,16,142),(1659,'asdf','',NULL,1,143),(1660,'sssss','',NULL,2,143),(1661,'d','',NULL,3,143),(1662,'f','',NULL,4,143),(1663,'a','',NULL,5,143),(1664,'s','',NULL,6,143),(1665,'111','',NULL,8,143),(1666,'1','',NULL,9,143),(1667,'12','',NULL,10,143),(1668,'31','',NULL,11,143),(1669,'24','',NULL,12,143),(1670,'555','',NULL,13,143),(1671,'666','',NULL,14,143),(1672,'777','',NULL,15,143),(1673,'777777','',NULL,16,143),(1674,'fafee','',NULL,1,144),(1675,'faere','',NULL,2,144),(1676,'bfgerf','',NULL,3,144),(1677,'ferea','',NULL,4,144),(1678,'zaaa','',NULL,5,144),(1679,'dfeawe','',NULL,6,144),(1680,'faef','',NULL,7,144),(1681,'fa ffad','',NULL,8,144),(1682,'tere','',NULL,9,144),(1683,'trfdvfsv','',NULL,10,144),(1684,'fafeerw','',NULL,11,144),(1685,'faewrew','',NULL,12,144),(1686,'wereadfdf','',NULL,13,144),(1687,'rartrga','',NULL,14,144),(1688,'faerar','',NULL,15,144),(1689,'fadfdesr','',NULL,16,144),(1690,'a','',NULL,1,145),(1691,'b','',NULL,2,145),(1692,'c','',NULL,3,145),(1693,'d','',NULL,4,145),(1694,'e','',NULL,5,145),(1695,'f','',NULL,6,145),(1696,'gh','',NULL,7,145),(1697,'h','',NULL,8,145),(1698,'t','',NULL,9,145),(1699,'er','',NULL,10,145),(1700,'eqer','',NULL,11,145),(1701,'gr','',NULL,12,145),(1702,'tr','',NULL,14,145),(1703,'tygf','',NULL,15,145),(1704,'ty','',NULL,16,145),(1737,'pink sprinkle','',NULL,1,148),(1738,'chocolate glazed','',NULL,2,148),(1739,'glazed','',NULL,3,148),(1740,'powdered sugar','',NULL,4,148),(1741,'bear claw','',NULL,5,148),(1742,'apple fritter','',NULL,6,148),(1743,'maple bar','',NULL,7,148),(1744,'blueberry','',NULL,8,148),(1745,'coconut','',NULL,9,148),(1746,'peanut crunch','',NULL,10,148),(1747,'chocolate sprinkle','',NULL,11,148),(1748,'cinnamon roll (not a donut)','',NULL,12,148),(1749,'apple cinnamon','',NULL,13,148),(1750,'twist','',NULL,14,148),(1751,'old fashioned','',NULL,15,148),(1752,'new fashioned','',NULL,16,148),(1753,'Redbull','',NULL,1,149),(1754,'Mercedes','',NULL,2,149),(1755,'Haas','',NULL,3,149),(1756,'Williams','',NULL,4,149),(1757,'Ferrari','',NULL,5,149),(1758,'Mclaren','',NULL,6,149),(1759,'Visa CashApp Racing Bulls','',NULL,7,149),(1760,'Kick Sauber','',NULL,8,149),(1761,'Aston Martin','',NULL,9,149),(1762,'Alpine','',NULL,10,149),(1763,'x','x',NULL,11,149),(1812,'One Piece','','uploads/entry_images/153_1_1764884382_download.jpeg',1,153),(1813,'1','',NULL,1,154),(1814,'2','',NULL,2,154),(1815,'3','',NULL,3,154),(1816,'4','',NULL,4,154),(1817,'5','',NULL,5,154),(1818,'6','',NULL,6,154),(1819,'7','',NULL,7,154),(1820,'8','',NULL,8,154),(1821,'9','',NULL,9,154),(1822,'10','',NULL,10,154),(1823,'11','',NULL,11,154),(1824,'12','',NULL,12,154),(1825,'13','',NULL,13,154),(1826,'14','',NULL,14,154),(1827,'15','',NULL,15,154),(1828,'16','',NULL,16,154),(1829,'hello','',NULL,1,155),(1830,'a','',NULL,2,155),(1831,'s','',NULL,3,155),(1832,'d','',NULL,4,155),(1833,'f','',NULL,5,155),(1834,'1','',NULL,6,155),(1835,'2','',NULL,7,155),(1836,'3','',NULL,8,155),(1837,'4','',NULL,9,155),(1838,'5','',NULL,10,155),(1839,'1111','',NULL,11,155),(1840,'09','',NULL,12,155),(1841,'76','',NULL,13,155),(1842,'87','',NULL,14,155),(1843,'66','','uploads/entry_images/155_15_1764884519_crown.jpeg',15,155),(1844,'1111111','','uploads/entry_images/155_16_1764884519_truedetective.png',16,155),(1849,'Chivas','',NULL,1,156),(1850,'America','',NULL,2,156),(1851,'Toluca','',NULL,3,156),(1852,'Cruz Azul','',NULL,4,156),(1853,'Monterrey','',NULL,5,156),(1854,'Tigres','',NULL,6,156),(1855,'Tijuana','',NULL,7,156),(1856,'Juarez','',NULL,8,156),(1857,'Atlas','',NULL,9,156),(1858,'Mazatlan','',NULL,10,156),(1859,'Pumas','',NULL,11,156),(1860,'Leon','',NULL,12,156),(1861,'San Luis','',NULL,13,156),(1862,'Necaxa','',NULL,14,156),(1863,'Santos','',NULL,15,156),(1864,'Queretaro','',NULL,16,156),(1865,'test','',NULL,1,157),(1866,'teset','',NULL,2,157),(1867,'wow','',NULL,4,157),(1868,'omg','',NULL,5,157),(1869,'gee','',NULL,6,157),(1870,'wefs','',NULL,7,157),(1871,'bdf','',NULL,8,157),(1872,'dbdf','',NULL,9,157),(1873,'hdfgdg','',NULL,10,157),(1874,'afsdfas','',NULL,11,157),(1875,'asdfasdf','',NULL,12,157),(1876,'gfdgdg','',NULL,13,157),(1877,'hhfdh','',NULL,14,157),(1878,'kaykya','',NULL,15,157),(1879,'asdfasdvfd','',NULL,16,157),(1880,'test','',NULL,1,158),(1881,'1','',NULL,3,158),(1882,'2','',NULL,4,158),(1883,'3','',NULL,5,158),(1884,'4','',NULL,6,158),(1885,'5','',NULL,7,158),(1886,'6','',NULL,8,158),(1887,'7','',NULL,9,158),(1888,'8','',NULL,10,158),(1889,'9','',NULL,11,158),(1890,'10','',NULL,12,158),(1891,'11','',NULL,13,158),(1892,'12','',NULL,14,158),(1893,'13','',NULL,15,158),(1894,'14','',NULL,16,158);
/*!40000 ALTER TABLE `entry` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`fantasytourney`@`localhost`*/ /*!50003 TRIGGER trg_entry_same_ins
BEFORE INSERT ON entry
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT 1
    FROM entry e
    WHERE e.tournament_id = NEW.tournament_id
      AND e.name = NEW.name
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Duplicate entry name in this tournament.';
  END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`fantasytourney`@`localhost`*/ /*!50003 TRIGGER trg_entry_same
BEFORE UPDATE ON entry
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT 1
    FROM entry e
    WHERE e.tournament_id = NEW.tournament_id
      AND e.name = NEW.name
      AND e.entry_id <> NEW.entry_id
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Duplicate entry name in this tournament.';
  END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`fantasytourney`@`localhost`*/ /*!50003 TRIGGER trg_entry_same_upd
BEFORE UPDATE ON entry
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT 1
    FROM entry e
    WHERE e.tournament_id = NEW.tournament_id
      AND e.name = NEW.name
      AND e.entry_id <> NEW.entry_id
  ) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Duplicate entry name in this tournament.';
  END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`fantasytourney`@`localhost`*/ /*!50003 TRIGGER trg_entry_prevent_delete_active
BEFORE DELETE ON entry
FOR EACH ROW
BEGIN
    DECLARE tourney_status VARCHAR(20);
    
    
    SELECT tourneystatus INTO tourney_status
    FROM tournament
    WHERE tournament_id = OLD.tournament_id;
    
    
    IF tourney_status = 'Active' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Safety Lock: Cannot delete an entry while the tournament is Active.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `matchup`
--

DROP TABLE IF EXISTS `matchup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchup` (
  `matchup_id` int(11) NOT NULL AUTO_INCREMENT,
  `round_number` int(11) NOT NULL,
  `status` enum('Upcoming','Active','Completed') NOT NULL,
  `opens_at` datetime NOT NULL,
  `closes_at` datetime NOT NULL,
  `tournament_id` int(11) NOT NULL,
  `entryA_id` int(11) DEFAULT NULL,
  `entryB_id` int(11) DEFAULT NULL,
  `winner_entry_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`matchup_id`),
  KEY `matchup_ibfk_1` (`tournament_id`),
  KEY `matchup_ibfk_2` (`entryA_id`),
  KEY `matchup_ibfk_3` (`entryB_id`),
  CONSTRAINT `matchup_ibfk_1` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`tournament_id`) ON DELETE CASCADE,
  CONSTRAINT `matchup_ibfk_2` FOREIGN KEY (`entryA_id`) REFERENCES `entry` (`entry_id`) ON DELETE CASCADE,
  CONSTRAINT `matchup_ibfk_3` FOREIGN KEY (`entryB_id`) REFERENCES `entry` (`entry_id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`entryA_id` <> `entryB_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1788 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci `ENCRYPTION_KEY_ID`=100;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchup`
--

LOCK TABLES `matchup` WRITE;
/*!40000 ALTER TABLE `matchup` DISABLE KEYS */;
INSERT INTO `matchup` VALUES (8,1,'Completed','2024-03-01 10:00:00','2024-03-08 23:59:59',2,9,10,9),(9,1,'Completed','2024-03-01 10:00:00','2024-03-08 23:59:59',2,15,16,15),(10,1,'Completed','2024-03-01 10:00:00','2024-03-08 23:59:59',2,11,12,11),(11,1,'Completed','2024-03-01 10:00:00','2024-03-08 23:59:59',2,13,14,14),(12,2,'Completed','2024-03-10 10:00:00','2024-03-17 23:59:59',2,9,15,9),(13,2,'Completed','2024-03-10 10:00:00','2024-03-17 23:59:59',2,11,14,11),(14,3,'Completed','2024-03-20 10:00:00','2024-04-01 23:59:59',2,9,11,9),(15,1,'Completed','2024-10-01 10:00:00','2024-10-10 23:59:59',3,17,18,17),(16,1,'Completed','2024-10-01 10:00:00','2024-10-10 23:59:59',3,23,24,23),(17,1,'Completed','2024-10-01 10:00:00','2024-10-10 23:59:59',3,19,20,19),(18,1,'Completed','2024-10-01 10:00:00','2024-10-10 23:59:59',3,21,22,22),(19,2,'Completed','2024-10-15 10:00:00','2024-10-25 23:59:59',3,17,23,17),(20,2,'Completed','2024-10-15 10:00:00','2024-10-25 23:59:59',3,19,22,22),(21,3,'Completed','2024-10-28 10:00:00','2024-11-15 23:59:59',3,17,22,17),(22,1,'Completed','2024-11-01 10:00:00','2024-11-05 23:59:59',4,25,26,25),(23,1,'Completed','2024-11-01 10:00:00','2024-11-05 23:59:59',4,27,28,28),(24,1,'Completed','2024-11-01 10:00:00','2024-11-05 23:59:59',4,29,30,29),(25,1,'Completed','2024-11-01 10:00:00','2024-11-05 23:59:59',4,31,32,31),(26,1,'Completed','2024-11-01 10:00:00','2024-11-05 23:59:59',4,33,34,33),(27,1,'Completed','2024-11-01 10:00:00','2024-11-05 23:59:59',4,35,36,35),(28,1,'Completed','2024-11-01 10:00:00','2024-11-05 23:59:59',4,37,38,38),(29,1,'Completed','2024-11-01 10:00:00','2024-11-05 23:59:59',4,39,40,39),(30,2,'Completed','2024-11-07 10:00:00','2024-11-12 23:59:59',4,25,28,25),(31,2,'Completed','2024-11-07 10:00:00','2024-11-12 23:59:59',4,29,31,29),(32,2,'Completed','2024-11-07 10:00:00','2024-11-12 23:59:59',4,33,35,33),(33,2,'Completed','2024-11-07 10:00:00','2024-11-12 23:59:59',4,39,38,39),(34,3,'Completed','2024-11-14 10:00:00','2024-11-20 23:59:59',4,25,29,25),(35,3,'Completed','2024-11-14 10:00:00','2024-11-20 23:59:59',4,33,39,39),(36,4,'Completed','2024-11-22 10:00:00','2024-11-30 23:59:59',4,25,33,25),(37,1,'Completed','2024-11-10 10:00:00','2024-11-14 23:59:59',5,41,42,41),(38,1,'Completed','2024-11-10 10:00:00','2024-11-14 23:59:59',5,43,44,44),(39,1,'Completed','2024-11-10 10:00:00','2024-11-14 23:59:59',5,45,46,45),(40,1,'Completed','2024-11-10 10:00:00','2024-11-14 23:59:59',5,47,48,48),(41,1,'Completed','2024-11-10 10:00:00','2024-11-14 23:59:59',5,49,50,49),(42,1,'Completed','2024-11-10 10:00:00','2024-11-14 23:59:59',5,51,52,51),(43,1,'Completed','2024-11-10 10:00:00','2024-11-14 23:59:59',5,53,54,53),(44,1,'Completed','2024-11-10 10:00:00','2024-11-14 23:59:59',5,55,56,56),(45,2,'Completed','2024-11-16 10:00:00','2024-11-22 23:59:59',5,41,44,41),(46,2,'Completed','2024-11-16 10:00:00','2024-11-22 23:59:59',5,45,48,45),(47,2,'Completed','2024-11-16 10:00:00','2024-11-22 23:59:59',5,49,51,51),(48,2,'Completed','2024-11-16 10:00:00','2024-11-22 23:59:59',5,53,56,53),(49,3,'Completed','2024-11-24 10:00:00','2024-11-29 23:59:59',5,41,45,41),(50,3,'Completed','2024-11-24 10:00:00','2024-11-29 23:59:59',5,49,53,49),(51,4,'Completed','2024-12-01 10:00:00','2024-12-07 23:59:59',5,41,49,41),(52,1,'Completed','2024-12-01 10:00:00','2024-12-07 23:59:59',6,57,58,57),(53,1,'Completed','2024-12-01 10:00:00','2024-12-07 23:59:59',6,59,60,59),(54,2,'Completed','2024-12-09 10:00:00','2024-12-15 23:59:59',6,57,59,57),(55,1,'Completed','2024-12-15 10:00:00','2024-12-20 23:59:59',7,61,62,61),(56,1,'Completed','2024-12-15 10:00:00','2024-12-20 23:59:59',7,67,68,67),(57,1,'Completed','2024-12-15 10:00:00','2024-12-20 23:59:59',7,63,64,63),(58,1,'Completed','2024-12-15 10:00:00','2024-12-20 23:59:59',7,65,66,65),(59,2,'Completed','2024-12-22 10:00:00','2024-12-27 23:59:59',7,61,67,61),(60,2,'Completed','2024-12-22 10:00:00','2024-12-27 23:59:59',7,63,65,63),(61,3,'Completed','2024-12-29 10:00:00','2025-01-03 23:59:59',7,61,63,61),(62,1,'Completed','2025-01-05 10:00:00','2025-01-10 23:59:59',8,69,70,69),(63,1,'Completed','2025-01-05 10:00:00','2025-01-10 23:59:59',8,75,76,75),(64,1,'Completed','2025-01-05 10:00:00','2025-01-10 23:59:59',8,71,72,71),(65,1,'Completed','2025-01-05 10:00:00','2025-01-10 23:59:59',8,73,74,73),(66,2,'Completed','2025-01-12 10:00:00','2025-01-17 23:59:59',8,69,75,69),(67,2,'Completed','2025-01-12 10:00:00','2025-01-17 23:59:59',8,71,73,71),(68,3,'Completed','2025-01-19 10:00:00','2025-01-24 23:59:59',8,69,71,69),(466,1,'Completed','2025-11-30 03:37:56','2025-11-30 03:38:14',54,501,516,501),(467,1,'Completed','2025-11-30 03:37:56','2025-11-30 03:38:14',54,502,515,502),(468,1,'Completed','2025-11-30 03:37:56','2025-11-30 03:38:14',54,503,514,503),(469,1,'Completed','2025-11-30 03:37:56','2025-11-30 03:38:14',54,504,513,504),(470,1,'Completed','2025-11-30 03:37:56','2025-11-30 03:38:14',54,505,512,505),(471,1,'Completed','2025-11-30 03:37:56','2025-11-30 03:38:14',54,506,511,506),(472,1,'Completed','2025-11-30 03:37:56','2025-11-30 03:38:14',54,507,510,507),(473,1,'Completed','2025-11-30 03:37:56','2025-11-30 03:38:14',54,508,509,508),(474,2,'Completed','2025-11-30 03:38:14','2025-11-30 03:38:32',54,501,502,501),(475,2,'Completed','2025-11-30 03:38:14','2025-11-30 03:38:32',54,503,504,503),(476,2,'Completed','2025-11-30 03:38:14','2025-11-30 03:38:32',54,505,506,505),(477,2,'Completed','2025-11-30 03:38:14','2025-11-30 03:38:32',54,507,508,507),(478,3,'Completed','2025-11-30 03:38:32','2025-11-30 03:38:50',54,501,503,501),(479,3,'Completed','2025-11-30 03:38:32','2025-11-30 03:38:50',54,505,507,505),(480,4,'Completed','2025-11-30 03:38:50','2025-11-30 03:39:08',54,501,505,501),(991,1,'Completed','2025-11-01 10:00:00','2025-11-10 23:59:59',99,901,902,901),(992,1,'Completed','2025-11-01 10:00:00','2025-11-10 23:59:59',99,903,904,903),(993,1,'Completed','2025-11-01 10:00:00','2025-11-10 23:59:59',99,905,906,905),(994,1,'Completed','2025-11-01 10:00:00','2025-11-10 23:59:59',99,907,908,907),(995,2,'Completed','2025-11-30 11:23:43','2025-11-30 14:23:43',99,901,903,901),(996,2,'Completed','2025-11-30 11:23:43','2025-11-30 14:23:43',99,905,907,905),(997,3,'Completed','2025-12-01 10:00:00','2025-12-07 23:59:59',99,901,905,901),(1001,1,'Completed','2025-11-30 12:29:58','2025-11-30 12:30:13',100,1001,1002,1001),(1002,1,'Completed','2025-11-30 12:29:58','2025-11-30 12:30:13',100,1003,1004,1003),(1011,1,'Completed','2025-11-30 12:31:43','2025-11-30 12:33:43',101,1011,1012,1012),(1012,1,'Completed','2025-11-30 12:31:43','2025-11-30 12:33:43',101,1013,1014,1013),(1087,1,'Completed','2025-12-01 23:07:32','2025-12-01 23:07:50',108,1109,1124,1109),(1088,1,'Completed','2025-12-01 23:07:32','2025-12-01 23:07:50',108,1110,1123,1123),(1089,1,'Completed','2025-12-01 23:07:32','2025-12-01 23:07:50',108,1111,1122,1111),(1090,1,'Completed','2025-12-01 23:07:32','2025-12-01 23:07:50',108,1112,1121,1112),(1091,1,'Completed','2025-12-01 23:07:32','2025-12-01 23:07:50',108,1113,1120,1113),(1092,1,'Completed','2025-12-01 23:07:32','2025-12-01 23:07:50',108,1114,1119,1114),(1093,1,'Completed','2025-12-01 23:07:32','2025-12-01 23:07:50',108,1115,1118,1115),(1094,1,'Completed','2025-12-01 23:07:32','2025-12-01 23:07:50',108,1116,1117,1116),(1095,2,'Completed','2025-12-01 23:07:50','2025-12-01 23:08:08',108,1109,1123,1109),(1096,2,'Completed','2025-12-01 23:07:50','2025-12-01 23:08:08',108,1111,1112,1111),(1097,2,'Completed','2025-12-01 23:07:50','2025-12-01 23:08:08',108,1113,1114,1113),(1098,2,'Completed','2025-12-01 23:07:50','2025-12-01 23:08:08',108,1115,1116,1115),(1099,3,'Completed','2025-12-01 23:08:08','2025-12-01 23:08:26',108,1109,1111,1109),(1100,3,'Completed','2025-12-01 23:08:08','2025-12-01 23:08:26',108,1113,1115,1113),(1101,4,'Completed','2025-12-01 23:08:26','2025-12-01 23:08:44',108,1109,1113,1109),(1102,1,'Completed','2025-12-01 23:26:44','2025-12-01 23:27:02',109,1125,1140,1125),(1103,1,'Completed','2025-12-01 23:26:44','2025-12-01 23:27:02',109,1126,1139,1139),(1104,1,'Completed','2025-12-01 23:26:44','2025-12-01 23:27:02',109,1127,1138,1127),(1105,1,'Completed','2025-12-01 23:26:44','2025-12-01 23:27:02',109,1128,1137,1128),(1106,1,'Completed','2025-12-01 23:26:44','2025-12-01 23:27:02',109,1129,1136,1129),(1107,1,'Completed','2025-12-01 23:26:44','2025-12-01 23:27:02',109,1130,1135,1130),(1108,1,'Completed','2025-12-01 23:26:44','2025-12-01 23:27:02',109,1131,1134,1131),(1109,1,'Completed','2025-12-01 23:26:44','2025-12-01 23:27:02',109,1132,1133,1132),(1110,2,'Completed','2025-12-01 23:27:02','2025-12-01 23:27:20',109,1125,1139,1125),(1111,2,'Completed','2025-12-01 23:27:02','2025-12-01 23:27:20',109,1127,1128,1127),(1112,2,'Completed','2025-12-01 23:27:02','2025-12-01 23:27:20',109,1129,1130,1129),(1113,2,'Completed','2025-12-01 23:27:02','2025-12-01 23:27:20',109,1131,1132,1132),(1114,3,'Completed','2025-12-01 23:27:20','2025-12-01 23:27:38',109,1125,1127,1127),(1115,3,'Completed','2025-12-01 23:27:20','2025-12-01 23:27:38',109,1129,1132,1132),(1116,4,'Completed','2025-12-01 23:27:38','2025-12-01 23:27:56',109,1127,1132,1127),(1117,1,'Completed','2025-12-02 00:03:32','2025-12-02 00:03:50',110,1141,1156,1141),(1118,1,'Completed','2025-12-02 00:03:32','2025-12-02 00:03:50',110,1142,1155,1142),(1119,1,'Completed','2025-12-02 00:03:32','2025-12-02 00:03:50',110,1143,1154,1143),(1120,1,'Completed','2025-12-02 00:03:32','2025-12-02 00:03:50',110,1144,1153,1144),(1121,1,'Completed','2025-12-02 00:03:32','2025-12-02 00:03:50',110,1145,1152,1145),(1122,1,'Completed','2025-12-02 00:03:32','2025-12-02 00:03:50',110,1146,1151,1146),(1123,1,'Completed','2025-12-02 00:03:32','2025-12-02 00:03:50',110,1147,1150,1147),(1124,1,'Completed','2025-12-02 00:03:32','2025-12-02 00:03:50',110,1148,1149,1148),(1125,2,'Completed','2025-12-02 00:03:50','2025-12-02 00:04:08',110,1141,1142,1141),(1126,2,'Completed','2025-12-02 00:03:50','2025-12-02 00:04:08',110,1143,1144,1143),(1127,2,'Completed','2025-12-02 00:03:50','2025-12-02 00:04:08',110,1145,1146,1145),(1128,2,'Completed','2025-12-02 00:03:50','2025-12-02 00:04:08',110,1147,1148,1147),(1129,3,'Completed','2025-12-02 00:04:08','2025-12-02 00:04:26',110,1141,1143,1143),(1130,3,'Completed','2025-12-02 00:04:08','2025-12-02 00:04:26',110,1145,1147,1145),(1131,4,'Completed','2025-12-02 00:04:26','2025-12-02 00:04:44',110,1143,1145,1143),(1162,1,'Completed','2025-12-02 00:15:00','2025-12-02 00:15:18',113,1189,1204,1189),(1163,1,'Completed','2025-12-02 00:15:00','2025-12-02 00:15:18',113,1190,1203,1190),(1164,1,'Completed','2025-12-02 00:15:00','2025-12-02 00:15:18',113,1191,1202,1191),(1165,1,'Completed','2025-12-02 00:15:00','2025-12-02 00:15:18',113,1192,1201,1192),(1166,1,'Completed','2025-12-02 00:15:00','2025-12-02 00:15:18',113,1193,1200,1193),(1167,1,'Completed','2025-12-02 00:15:00','2025-12-02 00:15:18',113,1194,1199,1194),(1168,1,'Completed','2025-12-02 00:15:00','2025-12-02 00:15:18',113,1195,1198,1195),(1169,1,'Completed','2025-12-02 00:15:00','2025-12-02 00:15:18',113,1196,1197,1196),(1170,2,'Completed','2025-12-02 00:15:18','2025-12-02 00:15:36',113,1189,1190,1189),(1171,2,'Completed','2025-12-02 00:15:18','2025-12-02 00:15:36',113,1191,1192,1191),(1172,2,'Completed','2025-12-02 00:15:18','2025-12-02 00:15:36',113,1193,1194,1193),(1173,2,'Completed','2025-12-02 00:15:18','2025-12-02 00:15:36',113,1195,1196,1195),(1174,3,'Completed','2025-12-02 00:15:36','2025-12-02 00:15:54',113,1189,1191,1189),(1175,3,'Completed','2025-12-02 00:15:36','2025-12-02 00:15:54',113,1193,1195,1193),(1176,4,'Completed','2025-12-02 00:15:54','2025-12-02 00:16:12',113,1189,1193,1189),(1267,1,'Completed','2025-12-02 00:44:49','2025-12-02 00:45:07',120,1301,1316,1301),(1268,1,'Completed','2025-12-02 00:44:49','2025-12-02 00:45:07',120,1302,1315,1302),(1269,1,'Completed','2025-12-02 00:44:49','2025-12-02 00:45:07',120,1303,1314,1303),(1270,1,'Completed','2025-12-02 00:44:49','2025-12-02 00:45:07',120,1304,1313,1304),(1271,1,'Completed','2025-12-02 00:44:49','2025-12-02 00:45:07',120,1305,1312,1305),(1272,1,'Completed','2025-12-02 00:44:49','2025-12-02 00:45:07',120,1306,1311,1306),(1273,1,'Completed','2025-12-02 00:44:49','2025-12-02 00:45:07',120,1307,1310,1307),(1274,1,'Completed','2025-12-02 00:44:49','2025-12-02 00:45:07',120,1308,1309,1308),(1275,2,'Completed','2025-12-02 00:45:07','2025-12-02 00:45:25',120,1301,1302,1301),(1276,2,'Completed','2025-12-02 00:45:07','2025-12-02 00:45:25',120,1303,1304,1303),(1277,2,'Completed','2025-12-02 00:45:07','2025-12-02 00:45:25',120,1305,1306,1305),(1278,2,'Completed','2025-12-02 00:45:07','2025-12-02 00:45:25',120,1307,1308,1307),(1279,3,'Completed','2025-12-02 00:45:25','2025-12-02 00:45:43',120,1301,1303,1301),(1280,3,'Completed','2025-12-02 00:45:25','2025-12-02 00:45:43',120,1305,1307,1305),(1281,4,'Completed','2025-12-02 00:45:43','2025-12-02 00:46:01',120,1301,1305,1301),(1282,1,'Completed','2025-12-02 00:50:52','2025-12-02 00:51:10',121,1317,1332,1317),(1283,1,'Completed','2025-12-02 00:50:52','2025-12-02 00:51:10',121,1318,1331,1318),(1284,1,'Completed','2025-12-02 00:50:52','2025-12-02 00:51:10',121,1319,1330,1319),(1285,1,'Completed','2025-12-02 00:50:52','2025-12-02 00:51:10',121,1320,1329,1320),(1286,1,'Completed','2025-12-02 00:50:52','2025-12-02 00:51:10',121,1321,1328,1321),(1287,1,'Completed','2025-12-02 00:50:52','2025-12-02 00:51:10',121,1322,1327,1322),(1288,1,'Completed','2025-12-02 00:50:52','2025-12-02 00:51:10',121,1323,1326,1323),(1289,1,'Completed','2025-12-02 00:50:52','2025-12-02 00:51:10',121,1324,1325,1324),(1290,2,'Completed','2025-12-02 00:51:10','2025-12-02 00:51:28',121,1317,1318,1317),(1291,2,'Completed','2025-12-02 00:51:10','2025-12-02 00:51:28',121,1319,1320,1319),(1292,2,'Completed','2025-12-02 00:51:10','2025-12-02 00:51:28',121,1321,1322,1321),(1293,2,'Completed','2025-12-02 00:51:10','2025-12-02 00:51:28',121,1323,1324,1323),(1294,3,'Completed','2025-12-02 00:51:28','2025-12-02 00:51:46',121,1317,1319,1317),(1295,3,'Completed','2025-12-02 00:51:28','2025-12-02 00:51:46',121,1321,1323,1321),(1296,4,'Completed','2025-12-02 00:51:46','2025-12-02 00:52:04',121,1317,1321,1317),(1393,1,'Completed','2025-12-03 00:35:20','2025-12-03 00:35:38',130,1458,1473,1458),(1394,1,'Completed','2025-12-03 00:35:20','2025-12-03 00:35:38',130,1459,1472,1459),(1395,1,'Completed','2025-12-03 00:35:20','2025-12-03 00:35:38',130,1460,1471,1471),(1396,1,'Completed','2025-12-03 00:35:20','2025-12-03 00:35:38',130,1461,1470,1461),(1397,1,'Completed','2025-12-03 00:35:20','2025-12-03 00:35:38',130,1462,1469,1462),(1398,1,'Completed','2025-12-03 00:35:20','2025-12-03 00:35:38',130,1463,1468,1463),(1399,1,'Completed','2025-12-03 00:35:20','2025-12-03 00:35:38',130,1464,1467,1464),(1400,1,'Completed','2025-12-03 00:35:20','2025-12-03 00:35:38',130,1465,1466,1465),(1401,2,'Completed','2025-12-03 00:35:38','2025-12-03 00:35:56',130,1458,1459,1458),(1402,2,'Completed','2025-12-03 00:35:38','2025-12-03 00:35:56',130,1471,1461,1461),(1403,2,'Completed','2025-12-03 00:35:38','2025-12-03 00:35:56',130,1462,1463,1462),(1404,2,'Completed','2025-12-03 00:35:38','2025-12-03 00:35:56',130,1464,1465,1464),(1405,3,'Completed','2025-12-03 00:35:56','2025-12-03 00:36:14',130,1458,1461,1458),(1406,3,'Completed','2025-12-03 00:35:56','2025-12-03 00:36:14',130,1462,1464,1462),(1407,4,'Completed','2025-12-03 00:36:14','2025-12-03 00:36:32',130,1458,1462,1458),(1408,1,'Completed','2025-12-03 19:19:13','2025-12-03 22:05:41',131,1474,1485,1474),(1409,1,'Completed','2025-12-03 19:19:13','2025-12-03 22:05:41',131,1475,1485,1485),(1410,1,'Completed','2025-12-03 19:19:13','2025-12-03 22:05:41',131,1476,1485,1476),(1411,1,'Completed','2025-12-03 19:19:13','2025-12-03 22:05:41',131,1477,1485,1477),(1412,1,'Completed','2025-12-03 19:19:13','2025-12-03 22:05:41',131,1478,1484,1478),(1413,1,'Completed','2025-12-03 19:19:13','2025-12-03 22:05:41',131,1479,1483,1479),(1414,1,'Completed','2025-12-03 19:19:13','2025-12-03 22:05:41',131,1480,1483,1480),(1415,1,'Completed','2025-12-03 19:19:13','2025-12-03 22:05:41',131,1481,1482,1481),(1416,2,'Completed','2025-12-03 22:05:41','2025-12-03 22:06:10',131,1474,1485,1474),(1417,2,'Completed','2025-12-03 22:05:41','2025-12-03 22:06:10',131,1476,1477,1476),(1418,2,'Completed','2025-12-03 22:05:41','2025-12-03 22:06:10',131,1478,1479,1478),(1419,2,'Completed','2025-12-03 22:05:41','2025-12-03 22:06:10',131,1480,1481,1480),(1420,3,'Completed','2025-12-03 22:06:10','2025-12-03 22:06:39',131,1474,1476,1474),(1421,3,'Completed','2025-12-03 22:06:10','2025-12-03 22:06:39',131,1478,1480,1478),(1422,4,'Completed','2025-12-03 22:06:39','2025-12-03 22:07:08',131,1474,1478,1474),(1468,1,'Completed','2025-12-03 20:07:49','2025-12-03 20:08:19',135,1534,1549,1534),(1469,1,'Completed','2025-12-03 20:07:49','2025-12-03 20:08:19',135,1535,1548,1535),(1470,1,'Completed','2025-12-03 20:07:49','2025-12-03 20:08:19',135,1536,1547,1536),(1471,1,'Completed','2025-12-03 20:07:49','2025-12-03 20:08:19',135,1537,1546,1537),(1472,1,'Completed','2025-12-03 20:07:49','2025-12-03 20:08:19',135,1538,1545,1538),(1473,1,'Completed','2025-12-03 20:07:49','2025-12-03 20:08:19',135,1539,1544,1539),(1474,1,'Completed','2025-12-03 20:07:49','2025-12-03 20:08:19',135,1540,1543,1540),(1475,1,'Completed','2025-12-03 20:07:49','2025-12-03 20:08:19',135,1541,1542,1541),(1476,2,'Completed','2025-12-03 20:08:19','2025-12-03 20:08:49',135,1534,1535,1534),(1477,2,'Completed','2025-12-03 20:08:19','2025-12-03 20:08:49',135,1536,1537,1536),(1478,2,'Completed','2025-12-03 20:08:19','2025-12-03 20:08:49',135,1538,1539,1538),(1479,2,'Completed','2025-12-03 20:08:19','2025-12-03 20:08:49',135,1540,1541,1540),(1480,3,'Completed','2025-12-03 20:08:49','2025-12-03 20:09:19',135,1534,1536,1534),(1481,3,'Completed','2025-12-03 20:08:49','2025-12-03 20:09:19',135,1538,1540,1538),(1482,4,'Completed','2025-12-03 20:09:19','2025-12-03 20:09:49',135,1534,1538,1534),(1483,1,'Completed','2025-12-03 20:49:38','2025-12-03 20:50:08',136,1550,1565,1550),(1484,1,'Completed','2025-12-03 20:49:38','2025-12-03 20:50:08',136,1551,1564,1564),(1485,1,'Completed','2025-12-03 20:49:38','2025-12-03 20:50:08',136,1552,1563,1552),(1486,1,'Completed','2025-12-03 20:49:38','2025-12-03 20:50:08',136,1553,1562,1562),(1487,1,'Completed','2025-12-03 20:49:38','2025-12-03 20:50:08',136,1554,1561,1554),(1488,1,'Completed','2025-12-03 20:49:38','2025-12-03 20:50:08',136,1555,1560,1555),(1489,1,'Completed','2025-12-03 20:49:38','2025-12-03 20:50:08',136,1556,1559,1556),(1490,1,'Completed','2025-12-03 20:49:38','2025-12-03 20:50:08',136,1557,1558,1557),(1491,2,'Completed','2025-12-03 20:50:08','2025-12-03 20:50:38',136,1550,1564,1550),(1492,2,'Completed','2025-12-03 20:50:08','2025-12-03 20:50:38',136,1552,1562,1552),(1493,2,'Completed','2025-12-03 20:50:08','2025-12-03 20:50:38',136,1554,1555,1554),(1494,2,'Completed','2025-12-03 20:50:08','2025-12-03 20:50:38',136,1556,1557,1557),(1495,3,'Completed','2025-12-03 20:50:38','2025-12-03 20:51:08',136,1550,1552,1550),(1496,3,'Completed','2025-12-03 20:50:38','2025-12-03 20:51:08',136,1554,1557,1554),(1497,4,'Completed','2025-12-03 20:51:08','2025-12-03 20:51:38',136,1550,1554,1554),(1498,1,'Completed','2025-12-03 22:04:16','2025-12-03 22:04:46',137,1566,1581,1566),(1499,1,'Completed','2025-12-03 22:04:16','2025-12-03 22:04:46',137,1567,1580,1567),(1500,1,'Completed','2025-12-03 22:04:16','2025-12-03 22:04:46',137,1568,1579,1579),(1501,1,'Completed','2025-12-03 22:04:16','2025-12-03 22:04:46',137,1569,1578,1569),(1502,1,'Completed','2025-12-03 22:04:16','2025-12-03 22:04:46',137,1570,1577,1570),(1503,1,'Completed','2025-12-03 22:04:16','2025-12-03 22:04:46',137,1571,1576,1571),(1504,1,'Completed','2025-12-03 22:04:16','2025-12-03 22:04:46',137,1572,1575,1572),(1505,1,'Completed','2025-12-03 22:04:16','2025-12-03 22:04:46',137,1573,1574,1573),(1506,2,'Completed','2025-12-03 22:04:46','2025-12-03 22:05:16',137,1566,1567,1566),(1507,2,'Completed','2025-12-03 22:04:46','2025-12-03 22:05:16',137,1579,1569,1579),(1508,2,'Completed','2025-12-03 22:04:46','2025-12-03 22:05:16',137,1570,1571,1571),(1509,2,'Completed','2025-12-03 22:04:46','2025-12-03 22:05:16',137,1572,1573,1572),(1510,3,'Completed','2025-12-03 22:05:16','2025-12-03 22:05:46',137,1566,1579,1566),(1511,3,'Completed','2025-12-03 22:05:16','2025-12-03 22:05:46',137,1571,1572,1572),(1512,4,'Completed','2025-12-03 22:05:46','2025-12-03 22:06:16',137,1566,1572,1566),(1513,1,'Completed','2025-12-03 22:13:00','2025-12-03 22:13:30',138,1582,1597,1597),(1514,1,'Completed','2025-12-03 22:13:00','2025-12-03 22:13:30',138,1583,1596,1583),(1515,1,'Completed','2025-12-03 22:13:00','2025-12-03 22:13:30',138,1584,1595,1584),(1516,1,'Completed','2025-12-03 22:13:00','2025-12-03 22:13:30',138,1585,1594,1585),(1517,1,'Completed','2025-12-03 22:13:00','2025-12-03 22:13:30',138,1586,1593,1586),(1518,1,'Completed','2025-12-03 22:13:00','2025-12-03 22:13:30',138,1587,1592,1592),(1519,1,'Completed','2025-12-03 22:13:00','2025-12-03 22:13:30',138,1588,1591,1588),(1520,1,'Completed','2025-12-03 22:13:00','2025-12-03 22:13:30',138,1589,1590,1590),(1521,2,'Completed','2025-12-03 22:13:30','2025-12-03 22:14:00',138,1597,1583,1583),(1522,2,'Completed','2025-12-03 22:13:30','2025-12-03 22:14:00',138,1584,1585,1584),(1523,2,'Completed','2025-12-03 22:13:30','2025-12-03 22:14:00',138,1586,1592,1586),(1524,2,'Completed','2025-12-03 22:13:30','2025-12-03 22:14:00',138,1588,1590,1588),(1525,3,'Completed','2025-12-03 22:14:00','2025-12-03 22:14:30',138,1583,1584,1583),(1526,3,'Completed','2025-12-03 22:14:00','2025-12-03 22:14:30',138,1586,1588,1586),(1527,4,'Completed','2025-12-03 22:14:30','2025-12-03 22:15:00',138,1583,1586,1583),(1528,1,'Completed','2025-12-03 22:17:24','2025-12-03 22:17:54',139,1598,1613,1613),(1529,1,'Completed','2025-12-03 22:17:24','2025-12-03 22:17:54',139,1599,1612,1599),(1530,1,'Completed','2025-12-03 22:17:24','2025-12-03 22:17:54',139,1600,1611,1600),(1531,1,'Completed','2025-12-03 22:17:24','2025-12-03 22:17:54',139,1601,1610,1601),(1532,1,'Completed','2025-12-03 22:17:24','2025-12-03 22:17:54',139,1602,1609,1602),(1533,1,'Completed','2025-12-03 22:17:24','2025-12-03 22:17:54',139,1603,1608,1603),(1534,1,'Completed','2025-12-03 22:17:24','2025-12-03 22:17:54',139,1604,1607,1604),(1535,1,'Completed','2025-12-03 22:17:24','2025-12-03 22:17:54',139,1605,1606,1605),(1536,2,'Completed','2025-12-03 22:17:54','2025-12-03 22:18:24',139,1613,1599,1599),(1537,2,'Completed','2025-12-03 22:17:54','2025-12-03 22:18:24',139,1600,1601,1600),(1538,2,'Completed','2025-12-03 22:17:54','2025-12-03 22:18:24',139,1602,1603,1602),(1539,2,'Completed','2025-12-03 22:17:54','2025-12-03 22:18:24',139,1604,1605,1604),(1540,3,'Completed','2025-12-03 22:18:24','2025-12-03 22:18:54',139,1599,1600,1599),(1541,3,'Completed','2025-12-03 22:18:24','2025-12-03 22:18:54',139,1602,1604,1602),(1542,4,'Completed','2025-12-03 22:18:54','2025-12-03 22:19:24',139,1599,1602,1599),(1558,1,'Completed','2025-12-03 22:26:46','2025-12-03 22:27:16',141,1629,1642,1629),(1559,1,'Completed','2025-12-03 22:26:46','2025-12-03 22:27:16',141,1630,1641,1641),(1560,1,'Completed','2025-12-03 22:26:46','2025-12-03 22:27:16',141,1631,1640,1631),(1561,1,'Completed','2025-12-03 22:26:46','2025-12-03 22:27:16',141,1632,1640,1632),(1562,1,'Completed','2025-12-03 22:26:46','2025-12-03 22:27:16',141,1633,1639,1639),(1563,1,'Completed','2025-12-03 22:26:46','2025-12-03 22:27:16',141,1634,1638,1634),(1564,1,'Completed','2025-12-03 22:26:46','2025-12-03 22:27:16',141,1635,1637,1635),(1565,2,'Completed','2025-12-03 22:27:16','2025-12-03 22:27:46',141,NULL,NULL,NULL),(1566,2,'Completed','2025-12-03 22:27:16','2025-12-03 22:27:46',141,NULL,NULL,NULL),(1567,2,'Completed','2025-12-03 22:27:16','2025-12-03 22:27:46',141,NULL,NULL,NULL),(1568,2,'Completed','2025-12-03 22:27:16','2025-12-03 22:27:46',141,NULL,NULL,NULL),(1569,3,'Completed','2025-12-03 22:27:46','2025-12-03 22:28:16',141,NULL,NULL,NULL),(1570,3,'Completed','2025-12-03 22:27:46','2025-12-03 22:28:16',141,NULL,NULL,NULL),(1571,4,'Completed','2025-12-03 22:28:16','2025-12-03 22:28:46',141,NULL,NULL,NULL),(1572,1,'Completed','2025-12-03 22:44:42','2025-12-03 22:45:12',142,1643,1658,1643),(1573,1,'Completed','2025-12-03 22:44:42','2025-12-03 22:45:12',142,1644,1657,1657),(1574,1,'Completed','2025-12-03 22:44:42','2025-12-03 22:45:12',142,1645,1656,1645),(1575,1,'Completed','2025-12-03 22:44:42','2025-12-03 22:45:12',142,1646,1655,1646),(1576,1,'Completed','2025-12-03 22:44:42','2025-12-03 22:45:12',142,1647,1654,1647),(1577,1,'Completed','2025-12-03 22:44:42','2025-12-03 22:45:12',142,1648,1653,1648),(1578,1,'Completed','2025-12-03 22:44:42','2025-12-03 22:45:12',142,1649,1652,1649),(1579,1,'Completed','2025-12-03 22:44:42','2025-12-03 22:45:12',142,1650,1651,1650),(1580,2,'Completed','2025-12-03 22:45:12','2025-12-03 22:45:42',142,1643,1657,1643),(1581,2,'Completed','2025-12-03 22:45:12','2025-12-03 22:45:42',142,1645,1646,1645),(1582,2,'Completed','2025-12-03 22:45:12','2025-12-03 22:45:42',142,1647,1648,1647),(1583,2,'Completed','2025-12-03 22:45:12','2025-12-03 22:45:42',142,1649,1650,1649),(1584,3,'Completed','2025-12-03 22:45:42','2025-12-03 22:46:12',142,1643,1645,1643),(1585,3,'Completed','2025-12-03 22:45:42','2025-12-03 22:46:12',142,1647,1649,1647),(1586,4,'Completed','2025-12-03 22:46:12','2025-12-03 22:46:42',142,1643,1647,1643),(1587,1,'Completed','2025-12-03 22:50:07','2025-12-03 22:50:37',143,1659,1673,1659),(1588,1,'Completed','2025-12-03 22:50:07','2025-12-03 22:50:37',143,1660,1672,1660),(1589,1,'Completed','2025-12-03 22:50:07','2025-12-03 22:50:37',143,1661,1671,1661),(1590,1,'Completed','2025-12-03 22:50:07','2025-12-03 22:50:37',143,1662,1670,1662),(1591,1,'Completed','2025-12-03 22:50:07','2025-12-03 22:50:37',143,1663,1669,1663),(1592,1,'Completed','2025-12-03 22:50:07','2025-12-03 22:50:37',143,1664,1668,1664),(1593,1,'Completed','2025-12-03 22:50:07','2025-12-03 22:50:37',143,1664,1667,1664),(1594,1,'Completed','2025-12-03 22:50:07','2025-12-03 22:50:37',143,1665,1666,1665),(1595,2,'Completed','2025-12-03 22:50:37','2025-12-03 22:51:07',143,1659,1660,1659),(1596,2,'Completed','2025-12-03 22:50:37','2025-12-03 22:51:07',143,1661,1662,1661),(1597,2,'Completed','2025-12-03 22:50:37','2025-12-03 22:51:07',143,1663,1664,1663),(1598,2,'Completed','2025-12-03 22:50:37','2025-12-03 22:51:07',143,1664,1665,1664),(1599,3,'Completed','2025-12-03 22:51:07','2025-12-03 22:51:37',143,1659,1661,1659),(1600,3,'Completed','2025-12-03 22:51:07','2025-12-03 22:51:37',143,1663,1664,1663),(1601,4,'Completed','2025-12-03 22:51:37','2025-12-03 22:52:07',143,1659,1663,1659),(1602,1,'Completed','2025-12-03 22:52:38','2025-12-03 22:53:08',144,1674,1689,1674),(1603,1,'Completed','2025-12-03 22:52:38','2025-12-03 22:53:08',144,1675,1688,1675),(1604,1,'Completed','2025-12-03 22:52:38','2025-12-03 22:53:08',144,1676,1687,1676),(1605,1,'Completed','2025-12-03 22:52:38','2025-12-03 22:53:08',144,1677,1686,1677),(1606,1,'Completed','2025-12-03 22:52:38','2025-12-03 22:53:08',144,1678,1685,1678),(1607,1,'Completed','2025-12-03 22:52:38','2025-12-03 22:53:08',144,1679,1684,1679),(1608,1,'Completed','2025-12-03 22:52:38','2025-12-03 22:53:08',144,1680,1683,1680),(1609,1,'Completed','2025-12-03 22:52:38','2025-12-03 22:53:08',144,1681,1682,1681),(1610,2,'Completed','2025-12-03 22:53:08','2025-12-03 22:53:38',144,1674,1675,1674),(1611,2,'Completed','2025-12-03 22:53:08','2025-12-03 22:53:38',144,1676,1677,1676),(1612,2,'Completed','2025-12-03 22:53:08','2025-12-03 22:53:38',144,1678,1679,1678),(1613,2,'Completed','2025-12-03 22:53:08','2025-12-03 22:53:38',144,1680,1681,1680),(1614,3,'Completed','2025-12-03 22:53:38','2025-12-03 22:54:08',144,1674,1676,1674),(1615,3,'Completed','2025-12-03 22:53:38','2025-12-03 22:54:08',144,1678,1680,1678),(1616,4,'Completed','2025-12-03 22:54:08','2025-12-03 22:54:38',144,1674,1678,1674),(1617,1,'Completed','2025-12-04 11:18:39','2025-12-04 11:19:09',145,1690,1704,1690),(1618,1,'Completed','2025-12-04 11:18:39','2025-12-04 11:19:09',145,1691,1703,1691),(1619,1,'Completed','2025-12-04 11:18:39','2025-12-04 11:19:09',145,1692,1702,1692),(1620,1,'Completed','2025-12-04 11:18:39','2025-12-04 11:19:09',145,1693,1701,1693),(1621,1,'Completed','2025-12-04 11:18:39','2025-12-04 11:19:09',145,1694,1701,1694),(1622,1,'Completed','2025-12-04 11:18:39','2025-12-04 11:19:09',145,1695,1700,1695),(1623,1,'Completed','2025-12-04 11:18:39','2025-12-04 11:19:09',145,1696,1699,1696),(1624,1,'Completed','2025-12-04 11:18:39','2025-12-04 11:19:09',145,1697,1698,1697),(1625,2,'Completed','2025-12-04 11:19:09','2025-12-04 11:19:39',145,1690,1691,1690),(1626,2,'Completed','2025-12-04 11:19:09','2025-12-04 11:19:39',145,1692,1693,1692),(1627,2,'Completed','2025-12-04 11:19:09','2025-12-04 11:19:39',145,1694,1695,1694),(1628,2,'Completed','2025-12-04 11:19:09','2025-12-04 11:19:39',145,1696,1697,1696),(1629,3,'Completed','2025-12-04 11:19:39','2025-12-04 11:20:09',145,1690,1692,1690),(1630,3,'Completed','2025-12-04 11:19:39','2025-12-04 11:20:09',145,1694,1696,1694),(1631,4,'Completed','2025-12-04 11:20:09','2025-12-04 11:20:39',145,1690,1694,1690),(1654,1,'Completed','2025-12-04 13:34:46','2025-12-05 13:42:02',148,1737,1752,1737),(1655,1,'Completed','2025-12-04 13:34:46','2025-12-05 13:42:02',148,1738,1751,1738),(1656,1,'Completed','2025-12-04 13:34:46','2025-12-05 13:42:02',148,1739,1750,1739),(1657,1,'Completed','2025-12-04 13:34:46','2025-12-05 13:42:02',148,1740,1749,1740),(1658,1,'Completed','2025-12-04 13:34:46','2025-12-05 13:42:02',148,1741,1748,1741),(1659,1,'Completed','2025-12-04 13:34:46','2025-12-05 13:42:02',148,1742,1747,1742),(1660,1,'Completed','2025-12-04 13:34:46','2025-12-05 13:42:02',148,1743,1746,1743),(1661,1,'Completed','2025-12-04 13:34:46','2025-12-05 13:42:02',148,1744,1745,1744),(1662,2,'Completed','2025-12-04 13:35:16','2025-12-05 13:42:02',148,1737,1738,1737),(1663,2,'Completed','2025-12-04 13:35:16','2025-12-05 13:42:02',148,1739,1740,1739),(1664,2,'Completed','2025-12-04 13:35:16','2025-12-05 13:42:02',148,1741,1742,1741),(1665,2,'Completed','2025-12-04 13:35:16','2025-12-05 13:42:02',148,1743,1744,1743),(1666,3,'Completed','2025-12-04 13:35:46','2025-12-05 13:42:02',148,1737,1739,1737),(1667,3,'Completed','2025-12-04 13:35:46','2025-12-05 13:42:02',148,1741,1743,1741),(1668,4,'Completed','2025-12-04 13:36:16','2025-12-05 13:42:02',148,1737,1741,1737),(1669,1,'Completed','2025-12-04 13:35:04','2025-12-04 13:35:34',149,1753,1763,1753),(1670,1,'Completed','2025-12-04 13:35:04','2025-12-04 13:35:34',149,1754,1763,1754),(1671,1,'Completed','2025-12-04 13:35:04','2025-12-04 13:35:34',149,1755,1763,1755),(1672,1,'Completed','2025-12-04 13:35:04','2025-12-04 13:35:34',149,1756,1763,1756),(1673,1,'Completed','2025-12-04 13:35:04','2025-12-04 13:35:34',149,1757,1763,1757),(1674,1,'Completed','2025-12-04 13:35:04','2025-12-04 13:35:34',149,1758,1763,1758),(1675,1,'Completed','2025-12-04 13:35:04','2025-12-04 13:35:34',149,1759,1762,1759),(1676,1,'Completed','2025-12-04 13:35:04','2025-12-04 13:35:34',149,1760,1761,1760),(1677,2,'Completed','2025-12-04 13:35:34','2025-12-04 13:36:04',149,1753,1754,1753),(1678,2,'Completed','2025-12-04 13:35:34','2025-12-04 13:36:04',149,1755,1756,1756),(1679,2,'Completed','2025-12-04 13:35:34','2025-12-04 13:36:04',149,1757,1758,1757),(1680,2,'Completed','2025-12-04 13:35:34','2025-12-04 13:36:04',149,1759,1760,1759),(1681,3,'Completed','2025-12-04 13:36:04','2025-12-04 13:36:34',149,1753,1756,1753),(1682,3,'Completed','2025-12-04 13:36:04','2025-12-04 13:36:34',149,1757,1759,1757),(1683,4,'Completed','2025-12-04 13:36:34','2025-12-04 13:37:04',149,1753,1757,1753),(1705,2,'Completed','2025-12-04 13:40:12','2025-12-04 13:40:42',153,NULL,NULL,NULL),(1706,2,'Completed','2025-12-04 13:40:12','2025-12-04 13:40:42',153,NULL,NULL,NULL),(1707,2,'Completed','2025-12-04 13:40:12','2025-12-04 13:40:42',153,NULL,NULL,NULL),(1708,2,'Completed','2025-12-04 13:40:12','2025-12-04 13:40:42',153,NULL,NULL,NULL),(1709,3,'Completed','2025-12-04 13:40:42','2025-12-04 13:41:12',153,NULL,NULL,NULL),(1710,3,'Completed','2025-12-04 13:40:42','2025-12-04 13:41:12',153,NULL,NULL,NULL),(1711,4,'Completed','2025-12-04 13:41:12','2025-12-04 13:41:42',153,NULL,NULL,NULL),(1712,1,'Completed','2025-12-04 13:41:58','2025-12-04 13:42:28',154,1813,1828,1813),(1713,1,'Completed','2025-12-04 13:41:58','2025-12-04 13:42:28',154,1814,1827,1814),(1714,1,'Completed','2025-12-04 13:41:58','2025-12-04 13:42:28',154,1815,1826,1815),(1715,1,'Completed','2025-12-04 13:41:58','2025-12-04 13:42:28',154,1816,1825,1816),(1716,1,'Completed','2025-12-04 13:41:58','2025-12-04 13:42:28',154,1817,1824,1817),(1717,1,'Completed','2025-12-04 13:41:58','2025-12-04 13:42:28',154,1818,1823,1818),(1718,1,'Completed','2025-12-04 13:41:58','2025-12-04 13:42:28',154,1819,1822,1819),(1719,1,'Completed','2025-12-04 13:41:58','2025-12-04 13:42:28',154,1820,1821,1820),(1720,2,'Completed','2025-12-04 13:42:28','2025-12-04 13:42:58',154,1813,1814,1814),(1721,2,'Completed','2025-12-04 13:42:28','2025-12-04 13:42:58',154,1815,1816,1816),(1722,2,'Completed','2025-12-04 13:42:28','2025-12-04 13:42:58',154,1817,1818,1817),(1723,2,'Completed','2025-12-04 13:42:28','2025-12-04 13:42:58',154,1819,1820,1819),(1724,3,'Completed','2025-12-04 13:42:58','2025-12-04 13:43:28',154,1814,1816,1814),(1725,3,'Completed','2025-12-04 13:42:58','2025-12-04 13:43:28',154,1817,1819,1817),(1726,4,'Completed','2025-12-04 13:43:28','2025-12-04 13:43:58',154,1814,1817,1814),(1727,1,'Completed','2025-12-04 13:41:59','2025-12-04 13:42:29',155,1829,1844,1829),(1728,1,'Completed','2025-12-04 13:41:59','2025-12-04 13:42:29',155,1830,1843,1830),(1729,1,'Completed','2025-12-04 13:41:59','2025-12-04 13:42:29',155,1831,1842,1842),(1730,1,'Completed','2025-12-04 13:41:59','2025-12-04 13:42:29',155,1832,1841,1832),(1731,1,'Completed','2025-12-04 13:41:59','2025-12-04 13:42:29',155,1833,1840,1833),(1732,1,'Completed','2025-12-04 13:41:59','2025-12-04 13:42:29',155,1834,1839,1834),(1733,1,'Completed','2025-12-04 13:41:59','2025-12-04 13:42:29',155,1835,1838,1835),(1734,1,'Completed','2025-12-04 13:41:59','2025-12-04 13:42:29',155,1836,1837,1836),(1735,2,'Completed','2025-12-04 13:42:29','2025-12-04 13:42:59',155,1829,1830,1829),(1736,2,'Completed','2025-12-04 13:42:29','2025-12-04 13:42:59',155,1842,1832,1842),(1737,2,'Completed','2025-12-04 13:42:29','2025-12-04 13:42:59',155,1833,1834,1833),(1738,2,'Completed','2025-12-04 13:42:29','2025-12-04 13:42:59',155,1835,1836,1836),(1739,3,'Completed','2025-12-04 13:42:59','2025-12-04 13:43:29',155,1829,1842,1829),(1740,3,'Completed','2025-12-04 13:42:59','2025-12-04 13:43:29',155,1833,1836,1833),(1741,4,'Completed','2025-12-04 13:43:29','2025-12-04 13:43:59',155,1829,1833,1829),(1742,1,'Completed','2025-12-08 11:12:51','2025-12-08 11:13:21',156,1849,1864,1849),(1743,1,'Completed','2025-12-08 11:12:51','2025-12-08 11:13:21',156,1850,1863,1850),(1744,1,'Completed','2025-12-08 11:12:51','2025-12-08 11:13:21',156,1851,1862,1851),(1745,1,'Completed','2025-12-08 11:12:51','2025-12-08 11:13:21',156,1852,1861,1852),(1746,1,'Completed','2025-12-08 11:12:51','2025-12-08 11:13:21',156,1853,1860,1853),(1747,1,'Completed','2025-12-08 11:12:51','2025-12-08 11:13:21',156,1854,1859,1854),(1748,1,'Completed','2025-12-08 11:12:51','2025-12-08 11:13:21',156,1855,1858,1855),(1749,1,'Completed','2025-12-08 11:12:51','2025-12-08 11:13:21',156,1856,1857,1857),(1750,2,'Completed','2025-12-08 11:13:21','2025-12-08 11:13:51',156,1849,1850,1849),(1751,2,'Completed','2025-12-08 11:13:21','2025-12-08 11:13:51',156,1851,1852,1851),(1752,2,'Completed','2025-12-08 11:13:21','2025-12-08 11:13:51',156,1853,1854,1854),(1753,2,'Completed','2025-12-08 11:13:21','2025-12-08 11:13:51',156,1855,1857,1857),(1754,3,'Completed','2025-12-08 11:13:51','2025-12-08 11:14:21',156,1849,1851,1849),(1755,3,'Completed','2025-12-08 11:13:51','2025-12-08 11:14:21',156,1854,1857,1854),(1756,4,'Completed','2025-12-08 11:14:21','2025-12-08 11:14:51',156,1849,1854,1849),(1757,1,'Completed','2025-12-09 12:09:56','2025-12-09 12:10:26',157,1865,1879,1865),(1758,1,'Completed','2025-12-09 12:09:56','2025-12-09 12:10:26',157,1866,1878,1866),(1759,1,'Completed','2025-12-09 12:09:56','2025-12-09 12:10:26',157,1866,1877,1866),(1760,1,'Completed','2025-12-09 12:09:56','2025-12-09 12:10:26',157,1867,1876,1867),(1761,1,'Completed','2025-12-09 12:09:56','2025-12-09 12:10:26',157,1868,1875,1868),(1762,1,'Completed','2025-12-09 12:09:56','2025-12-09 12:10:26',157,1869,1874,1869),(1763,1,'Completed','2025-12-09 12:09:56','2025-12-09 12:10:26',157,1870,1873,1870),(1764,1,'Completed','2025-12-09 12:09:56','2025-12-09 12:10:26',157,1871,1872,1871),(1765,2,'Completed','2025-12-09 12:10:26','2025-12-09 12:10:56',157,1865,1866,1865),(1766,2,'Completed','2025-12-09 12:10:26','2025-12-09 12:10:56',157,1866,1867,1866),(1767,2,'Completed','2025-12-09 12:10:26','2025-12-09 12:10:56',157,1868,1869,1868),(1768,2,'Completed','2025-12-09 12:10:26','2025-12-09 12:10:56',157,1870,1871,1870),(1769,3,'Completed','2025-12-09 12:10:56','2025-12-09 12:11:26',157,1865,1866,1865),(1770,3,'Completed','2025-12-09 12:10:56','2025-12-09 12:11:26',157,1868,1870,1868),(1771,4,'Completed','2025-12-09 12:11:26','2025-12-09 12:11:56',157,1865,1868,1865),(1772,1,'Completed','2025-12-09 12:11:09','2025-12-09 12:11:39',158,1880,1894,1880),(1773,1,'Completed','2025-12-09 12:11:09','2025-12-09 12:11:39',158,1880,1893,1880),(1774,1,'Completed','2025-12-09 12:11:09','2025-12-09 12:11:39',158,1881,1892,1881),(1775,1,'Completed','2025-12-09 12:11:09','2025-12-09 12:11:39',158,1882,1891,1882),(1776,1,'Completed','2025-12-09 12:11:09','2025-12-09 12:11:39',158,1883,1890,1883),(1777,1,'Completed','2025-12-09 12:11:09','2025-12-09 12:11:39',158,1884,1889,1884),(1778,1,'Completed','2025-12-09 12:11:09','2025-12-09 12:11:39',158,1885,1888,1885),(1779,1,'Completed','2025-12-09 12:11:09','2025-12-09 12:11:39',158,1886,1887,1886),(1780,2,'Completed','2025-12-09 12:11:39','2025-12-09 12:12:09',158,NULL,NULL,NULL),(1781,2,'Completed','2025-12-09 12:11:39','2025-12-09 12:12:09',158,1881,1882,1881),(1782,2,'Completed','2025-12-09 12:11:39','2025-12-09 12:12:09',158,1883,1884,1883),(1783,2,'Active','2025-12-09 12:11:39','2025-12-09 12:12:09',158,1885,1886,NULL),(1784,3,'Completed','2025-12-09 12:12:09','2025-12-09 12:12:39',158,NULL,NULL,NULL),(1785,3,'Completed','2025-12-09 12:12:09','2025-12-09 12:12:39',158,NULL,NULL,NULL),(1786,4,'Completed','2025-12-09 12:12:39','2025-12-09 12:13:09',158,NULL,NULL,NULL);
/*!40000 ALTER TABLE `matchup` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`fantasytourney`@`localhost`*/ /*!50003 TRIGGER trg_matchup_select_winner
BEFORE UPDATE ON matchup
FOR EACH ROW
BEGIN
  DECLARE votesA INT DEFAULT 0;
  DECLARE votesB INT DEFAULT 0;
  DECLARE seedA  INT DEFAULT NULL;
  DECLARE seedB  INT DEFAULT NULL;

  
  IF NEW.status = 'Completed' AND OLD.status <> 'Completed' THEN

    
    SELECT COUNT(*) INTO votesA
      FROM vote
      WHERE matchup_id = NEW.matchup_id
        AND entry_id = NEW.entryA_id;

    SELECT COUNT(*) INTO votesB
      FROM vote
      WHERE matchup_id = NEW.matchup_id
        AND entry_id = NEW.entryB_id;

    
    IF votesA > 0 OR votesB > 0 THEN

        IF votesA > votesB THEN
            SET NEW.winner_entry_id = NEW.entryA_id;

        ELSEIF votesB > votesA THEN
            SET NEW.winner_entry_id = NEW.entryB_id;

        ELSE
            
            SELECT seed INTO seedA FROM entry WHERE entry_id = NEW.entryA_id;
            SELECT seed INTO seedB FROM entry WHERE entry_id = NEW.entryB_id;

            SET seedA = COALESCE(seedA, 9999);
            SET seedB = COALESCE(seedB, 9999);

            IF seedA < seedB THEN
                SET NEW.winner_entry_id = NEW.entryA_id;
            ELSE
                SET NEW.winner_entry_id = NEW.entryB_id;
            END IF;

        END IF;

    ELSE
        
        SELECT seed INTO seedA FROM entry WHERE entry_id = NEW.entryA_id;
        SELECT seed INTO seedB FROM entry WHERE entry_id = NEW.entryB_id;

        SET seedA = COALESCE(seedA, 9999);
        SET seedB = COALESCE(seedB, 9999);

        IF seedA < seedB THEN
            SET NEW.winner_entry_id = NEW.entryA_id;
        ELSE
            SET NEW.winner_entry_id = NEW.entryB_id;
        END IF;

    END IF;

  END IF;

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`fantasytourney`@`localhost`*/ /*!50003 TRIGGER trg_matchup_min_votes_upd
BEFORE UPDATE ON matchup
FOR EACH ROW
BEGIN
  IF NEW.status = 'Completed' AND OLD.status <> 'Completed' THEN
    IF (SELECT COUNT(*) FROM vote WHERE matchup_id = NEW.matchup_id) < 1 THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot complete matchup: minimum vote threshold not met.';
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tournament`
--

DROP TABLE IF EXISTS `tournament`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tournament` (
  `tournament_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL CHECK (`title` <> ''),
  `description` varchar(255) NOT NULL CHECK (`description` <> ''),
  `start_at` datetime NOT NULL,
  `end_at` datetime DEFAULT NULL,
  `tourneystatus` enum('Upcoming','Active','Completed') NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`tournament_id`),
  UNIQUE KEY `title` (`title`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tournament_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci `ENCRYPTION_KEY_ID`=100;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament`
--

LOCK TABLES `tournament` WRITE;
/*!40000 ALTER TABLE `tournament` DISABLE KEYS */;
INSERT INTO `tournament` VALUES (2,'Ultimate Marvel Hero','Which Marvel superhero reigns supreme?','2024-03-01 00:00:00','2025-11-25 00:00:00','Completed',1),(3,'Top Programming Languages','Battle of the best coding languages','2024-10-01 00:00:00','2025-11-25 00:00:00','Completed',2),(4,'Best 90s Movie','Nostalgia bracket - vote for the greatest 90s film','2024-11-01 00:00:00',NULL,'Active',1),(5,'Greatest Video Game','Tournament to crown the GOAT of gaming','2024-11-10 00:00:00',NULL,'Active',2),(6,'Best Coffee Shop','Local coffee shop championship','2024-12-01 00:00:00',NULL,'Active',1),(7,'Cutest Dog Breed','Which dog breed is the cutest? You decide!','2024-12-15 00:00:00',NULL,'Active',2),(8,'Best Sci-Fi Novel','Classic and modern sci-fi books face off','2025-01-05 00:00:00',NULL,'Active',1),(9,'Trigger Test Tourney','sandbox','2025-11-18 00:00:00',NULL,'Active',1),(11,'Best Pizza Toppings 2024','Vote for the ultimate pizza topping','2024-01-15 00:00:00','2024-02-15 00:00:00','Completed',1),(54,'Test Test Test...','working?','2025-12-09 06:00:00','2025-12-10 03:00:00','Completed',27),(99,'Best Anime Series','Vote for the greatest anime series of all time!','2025-11-30 00:00:00',NULL,'Active',1),(100,'Speed Bracket Test','Each round ends in 15 seconds!','2025-11-30 00:00:00',NULL,'Active',1),(101,'Bracket Auto-Advance Demo','Each round lasts 2 minutes to test winner advancement.','2025-11-30 00:00:00',NULL,'Active',1),(108,'Spongebob Characters','come vote quick!','2025-12-04 00:00:00','2025-12-05 00:00:00','Completed',22),(109,'lest test','yo','2025-12-02 00:00:00','2025-12-05 00:00:00','Completed',27),(110,'Favorite letter??','know your abc\'s?','2025-12-03 00:00:00','2025-12-05 00:00:00','Completed',27),(113,'NUMMSS','fav int?','2025-12-03 00:00:00','2025-12-05 00:00:00','Completed',27),(120,'asdf','asdf','2025-12-02 00:00:00','2025-12-02 00:00:00','Completed',27),(121,'newwwwwww','w','2025-12-12 00:00:00','2025-12-30 00:00:00','Upcoming',27),(130,'lets see','bio','2025-12-12 00:00:00','2025-12-03 00:00:00','Completed',25),(131,'hey','hi','2025-12-03 07:00:00','2025-12-03 00:00:00','Completed',31),(135,'checking round timer','yooooo','2025-12-03 00:00:00','2025-12-26 00:00:00','Active',22),(136,'Favorite Runescape Boss','Love Old School Runescape?? Come vote for your favorite boss!','2025-12-04 00:00:00','2025-12-04 00:00:00','Completed',22),(137,'final test','should work prply','2025-12-03 00:00:00','2025-12-03 00:00:00','Completed',25),(138,'Favorite Pokemon Starter','Choose your favorite starter pokemon among the various generations!','2025-12-03 00:00:00','2025-12-05 00:00:00','Completed',22),(139,'another test','yup','2025-12-03 00:00:00','2025-12-04 00:00:00','Completed',22),(141,'one more time','less go','2025-12-03 00:00:00','2025-12-03 00:00:00','Completed',25),(142,'yoyoyoyoyo','testing testing','2025-12-03 00:00:00','2025-12-04 00:00:00','Completed',22),(143,'yrdydyd','asdfasf','2025-12-01 02:00:00','2025-12-05 00:03:00','Completed',27),(144,'live test 1','dfadsfaadsfewa','2025-12-04 03:00:00','2025-12-04 06:00:00','Completed',25),(145,'test','test before demo','2025-12-04 00:00:00','2025-12-04 00:00:00','Completed',25),(148,'Best donut','you know what it is','2025-12-04 00:00:00','2025-12-05 13:40:52','Completed',38),(149,'Best Formula 1 Team','Description','2025-12-04 00:00:00','2025-12-04 00:00:00','Completed',37),(153,'anime','One Piece','2025-12-01 00:00:00','2025-12-11 00:00:00','Active',48),(154,'ndiwjndiwd','podjwndwd','2025-12-05 00:00:00','2025-12-06 00:00:00','Completed',41),(155,'random','haha','2025-12-04 00:00:00','2025-12-05 00:00:00','Completed',27),(156,'Liga MX Teams','Top Teams In Liga MX','2025-12-08 00:00:00','2025-12-09 00:00:00','Completed',29),(157,'testtest','test','2025-12-09 00:00:00','2025-12-10 00:00:00','Completed',29),(158,'ajsfdlkajsfd','tset jasldfj','2025-12-09 00:00:00','2025-12-10 00:00:00','Completed',29);
/*!40000 ALTER TABLE `tournament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL CHECK (`email` <> ''),
  `role` enum('admin','player','guest') NOT NULL,
  `displayname` varchar(100) NOT NULL CHECK (`displayname` <> ''),
  `password` varchar(255) NOT NULL CHECK (`password` <> ''),
  `profile_picture` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci `ENCRYPTION_KEY_ID`=100;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin@fantasytourney.com','admin','TourneyMaster','$2y$10$mWcRXcYdR6ciai6hYehiuOPIVW4krqFEQwpylC.WvGe69/Ax9GK5i',NULL,NULL),(2,'sarah.chen@email.com','admin','SarahC','$2y$10$0XJut5TZ4Zzsxm3bKKpn5.r0AkCrs4.Q3AMwDztNf/iYtYbRgna/u',NULL,NULL),(3,'marcus.johnson@gmail.com','player','MarcusJ','$2y$10$Z.jzlpcuu10hdxoHvAlMWOTvEel6le7wyX6Ceml6jeRUPMf7bc1oi',NULL,NULL),(4,'emily.rodriguez@yahoo.com','player','EmilyR','$2y$10$99xmI1dzZ3kVD2FfVJFZYeOe5Lq0bqfI5a7T4W58bIkAsJYohnHLG',NULL,NULL),(5,'james.williams@email.com','player','JWilliams','$2y$10$j7xo7GKHAHIWDZOddHB3Ju8bp6PRLRDUBEQTS6d5kOZ1rJXnGbrza',NULL,NULL),(6,'priya.patel@gmail.com','player','PriyaP','$2y$10$MkL1mnQXW8Fe8Kwr0c5fWuuoe3cClTcXC1P2zfC7ULpoK5xkWkKz6',NULL,NULL),(7,'david.kim@email.com','player','DaveKim','$2y$10$nuSTWhMF7bcUtYP.z2JE7.sT/7onwhgIT9u3lCS2VmM.siJJ/G.oy',NULL,NULL),(8,'jessica.brown@yahoo.com','player','JessBrown','$2y$10$QRfzIW0dVm1mIZwfZ54NRulRQrTAfSIJJEOqJ9fkfpQEAnF8L2LAO',NULL,NULL),(9,'michael.lee@gmail.com','player','MikeLee','$2y$10$VIW2gHurfIu8L3EpkqNd.eICmpL6cVjb7Wn6rZ1DmXbhlxmAX6nxW',NULL,NULL),(10,'amanda.garcia@email.com','player','AmandaG','$2y$10$mfHZfXEevdxmxkfrc0e83Ord96.QmbC7xi.dMZrN7Avaa.1KSpQVy',NULL,NULL),(11,'ryan.nguyen@gmail.com','player','RyanN','$2y$10$kZYU3lACKt80i1/yguLljeL19b4Kn5HIAdCZ1XzSJJg7/Y9ubhb9G',NULL,NULL),(12,'sophia.martinez@yahoo.com','player','SophiaM','$2y$10$jQJ6OZpMg28wc2Flcd/EAuowxckfBcyfh970BfsxI0CsudQ0uf.vO',NULL,NULL),(13,'daniel.anderson@email.com','player','DanA','$2y$10$3ec86OZgQW8fzjgi96rLeeWOTQfRmLkbLWmCicc69mkKOxczy8jPO',NULL,NULL),(14,'olivia.taylor@gmail.com','player','OliviaT','$2y$10$x87PaokqOcgZuHE8l9aGD.l57c7TqVAjI/BHZVvFgdHc.BszzkS4C',NULL,NULL),(15,'ethan.thomas@email.com','player','EthanT','$2y$10$0wg6X.Utr6q8XTFAGRZSxu18Y/9j7aYsjswVBDbRL9EXGTkJ9Covy',NULL,NULL),(16,'isabella.white@yahoo.com','player','IsabellaW','$2y$10$y.l3AB7Nj2IZjG4GFU63x.MAkbSfzx2rwF4F2X0eEsJhlfGLJRiFi',NULL,NULL),(17,'noah.harris@gmail.com','player','NoahH','$2y$10$zbNeBPdJbj0fQI5UXY8Mc.tFYQWFOsnGD.5gEZ26WsVJ4xr4lxko6',NULL,NULL),(18,'guest_user1@temp.com','guest','GuestUser1','$2y$10$zwauicQ0K3xNyCjr30kNQewrPOfSgOY9F2Odpg/uy5x1wlAoyg1RK',NULL,NULL),(19,'guest_user2@temp.com','guest','GuestUser2','$2y$10$V07rRtQcCPy4.SkYIk5RmefOIG/k3R/odctBaYXjQruUoInesp/zW',NULL,NULL),(20,'guest_user3@temp.com','guest','GuestUser3','$2y$10$GgNeXcaZQmy4US4iMoO1Oe5WkvzBhViVpvxqSE4L0VMCkc/cqdEA.',NULL,NULL),(21,'newuser@gmail.com','player','NewUser','$2y$10$MVvk1p8eu.fyxDYVndbih.JGQ0N7yzKnr8l.XdiAbCvpjSR8cotcu',NULL,NULL),(22,'jsoto24@csub.edu','player','Slug','$2y$10$RnV5uw200x.KPt.X.Ep1ZO3lBAZFmTeGVy8rAjt9.TWpzPnSIIz6i','uploads/profile_pics/22_1764741020_bubbleguy.jpg','leedle leedle leedle leedle leeeee'),(23,'thisisatest@gmail.com','player','test','$2y$10$VHtknopqKsb4KDDEiI4RA.WAq2a09zmyriZtmD69LeMZtaeaTQdM.',NULL,NULL),(25,'krrithikezhil30@gmail.com','admin','krrithik30','$2y$10$WNW1JRjlxwqRj8y80ujLNO5zHAQhIBQBwrxfdQOzvrB0jzRO2ziBq',NULL,'hello there!'),(26,'test453@gmail.com','admin','Dude123','$2y$10$g3X/Zb5UCJW0ksmH2bMevON9fJ.xaWZUNzpEkVkqTr6PS0NzBgB0S',NULL,NULL),(27,'jacinto1997@aol.com','admin','Matthew','$2y$10$w0B.TwoBgNx6TXDKBzILVOetL1GZeZRq9QOFSgBfQVvq.j.rQSg9i','uploads/profile_pics/27_1764655328_patrick head.jpg','yoooooooooo'),(28,'amoreno126@csub.edu','admin','Angel','$2y$10$H6FIRLYeM.pMVIgoAoCYU.jUbvto4164rZugVQSbqAGe331JxfL2C',NULL,''),(29,'morenoeangel1018@gmail.com','player','ദ്ദി(ᵔᗜᵔ)','$2y$10$qIKS060yArXkW/M995Kwde5BsMWVG.zd5mbjBfurD0vGOBf9GBmUW',NULL,''),(30,'nimohos115@httpsu.com','player','Messiisgoat','$2y$10$kb93x6WHvmyqIbIWXYWJJuUTPdnPPkE7qJK8KdGkiOc72PiYkqsvq',NULL,NULL),(31,'k@gmail.com','player','kkk','$2y$10$m..ghHaFtKHU8xcIdze.ZOHuzzkEY5OB.X/jBY/FZ3MlWuyzSVhNa',NULL,NULL),(34,'b@gmail.com','player','b','$2y$10$31dqikG.LBQ0o3MNgZ/YIODaDS.xgKCsIbqayEU/Pp1lbBd27Zwu6',NULL,NULL),(35,'GC@gmail.com','admin','GC','$2y$10$1dTB/KkrWcaplXtEKJ38vO/xUaboPqu1fu/S5t2GyhRp2IvGQsvSW','uploads/profile_pics/35_1764828880_whyDoesItWork.jpg','HelloWorld(\"print\")'),(37,'username@username.com','player','username','$2y$10$k68U0o2eyjq//Hi/v6js5OWtAAmA69C6WmVfkKHPN49AZHYeDFeFO',NULL,NULL),(38,'nick@tooth.com','player','tooth','$2y$10$.7zmILtY6EVPAVljsd4zPOcTeY7CBweod7UHLNdzsmlrzkAQr9vTG',NULL,NULL),(39,'soap@gmail.com','player','scrub','$2y$10$IOB8D6.IcbPyIp7/UDA2yuFlSt3wxxo4TummtVJwL4.VqDhNM/VWi','uploads/profile_pics/39_1764884071_QITEYZ22ABMF3CEKJLKRAGUJEM.avif',''),(40,'test@gmail.com','player','enioiemkfdasmfi','$2y$10$KYWtFXavFb5Nov9SeVw.U.VcjZ3UjSs8X8YXPf8tPc134/7x16ih6',NULL,'jdiaopfkjiaowjfiajr'),(41,'Jixzlyk@gmail.com','player','lol','$2y$10$/79sYi6UqF1urx0kcdm0PeFTSk8wwlAmZz.stXgwuqgS8Rgac57aW','uploads/profile_pics/41_1764883929_funny.jpg',''),(42,'haha@gmail.com','player','test account','$2y$10$3t4aPnNXNeHv6ItU6Pp.Lu8.NIASRLAKpNuuzWUx9YXxV1FFGSiuy','uploads/profile_pics/42_1764883961_pikachu.jpeg','haha'),(43,'obeltran-beltran@csub.edu','player','Valdo','$2y$10$HbE07AlWCBCx28w7ZBL4Uux1awbrey/Rv2bbyy2Ph7RKjBWErNoKy',NULL,NULL),(44,'jaja@gmail.com','player','jaja','$2y$10$iGLCTDsamlXelvS4cY/l8O//4pt5jC/J/RQcjI8hc72ZKV3O3JqwW','uploads/profile_pics/44_1764884168_frank.jpg',''),(45,'a@a.com','player','bob','$2y$10$m98Eh.I/SmRCSxu9vUY2rOa7pDBbXkL5l2QU7v3v/EuliU8219CT2','uploads/profile_pics/45_1764884050_grilled cheese.jpg',''),(46,'rbravo17@csub.edu','player','Roman','$2y$10$s/FRsd9srsRU8gMmhyGdVeQ.1XllH3De4yJ9RBWWp6XuP0wH0zfau',NULL,NULL),(48,'yoru@gmail.com','player','asa','$2y$10$7i1Vd5uW9vMU8Osf7Fl35uNZ5ck1UOf6Lkx7TEl9coKvVtB1A11Xy',NULL,NULL),(49,'hjex@csub.edu','player','VinnieStromboli','$2y$10$Q6xFU8eK2eF3tVHlQ67bUOWOpB5x7gcMCzKzLiBjIoYs7Jwe.w/uy',NULL,NULL),(50,'obeltranbelt@cs.csub.edu','player','Valdo2','$2y$10$hNyGAvs/5dqQsWhqJc/wqe49CCghBGi0JUmMM1aa0TsvouS0ovzF6','uploads/profile_pics/50_1764884322_meatwad.jpg',''),(51,'dchu1@csub.edu','player','Chufam','$2y$10$19vEPRNtAyuQvhN/gymOjuoBjiC3IaRsIA7SSQ/4in73WN.qvJDuO',NULL,NULL),(52,'test2837@gmail.com','player','test2837','$2y$10$VBKTq2MZ3bPN8HTZTMiYquUqq3LRa5.LhxRSS6O/egWbRr5kBiEf2',NULL,NULL),(53,'admin@csub.edu','admin','csub-admin','$2y$10$ykWghYZ3byKeiF7CaLXFwO8k7SxMp0XBG2Jr2IlBuLGnmwJCWd9V2',NULL,NULL),(54,'player@csub.edu','player','csub-player','$2y$10$KNd5dgnPPyftC08szjXXjeilT6/C.4I6ylvNurTXrwOEUcnUZ.vRS',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `view_active_tournaments`
--

DROP TABLE IF EXISTS `view_active_tournaments`;
/*!50001 DROP VIEW IF EXISTS `view_active_tournaments`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_active_tournaments` AS SELECT
 1 AS `tournament_id`,
  1 AS `title`,
  1 AS `description`,
  1 AS `start_at`,
  1 AS `end_at`,
  1 AS `tourneystatus`,
  1 AS `user_id` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_tournament_entries`
--

DROP TABLE IF EXISTS `view_tournament_entries`;
/*!50001 DROP VIEW IF EXISTS `view_tournament_entries`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_tournament_entries` AS SELECT
 1 AS `tournament_id`,
  1 AS `tournament_title`,
  1 AS `entry_id`,
  1 AS `entry_name`,
  1 AS `image_url` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_tournament_summary`
--

DROP TABLE IF EXISTS `view_tournament_summary`;
/*!50001 DROP VIEW IF EXISTS `view_tournament_summary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_tournament_summary` AS SELECT
 1 AS `tournament_id`,
  1 AS `title`,
  1 AS `description`,
  1 AS `tourneystatus`,
  1 AS `start_at`,
  1 AS `end_at`,
  1 AS `user_id` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vote`
--

DROP TABLE IF EXISTS `vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vote` (
  `user_id` int(11) NOT NULL,
  `matchup_id` int(11) NOT NULL,
  `entry_id` int(11) NOT NULL,
  `cast_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`,`matchup_id`),
  KEY `vote_ibfk_2` (`matchup_id`),
  KEY `vote_ibfk_3` (`entry_id`),
  CONSTRAINT `vote_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `vote_ibfk_2` FOREIGN KEY (`matchup_id`) REFERENCES `matchup` (`matchup_id`) ON DELETE CASCADE,
  CONSTRAINT `vote_ibfk_3` FOREIGN KEY (`entry_id`) REFERENCES `entry` (`entry_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci `ENCRYPTION_KEY_ID`=100;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote`
--

LOCK TABLES `vote` WRITE;
/*!40000 ALTER TABLE `vote` DISABLE KEYS */;
INSERT INTO `vote` VALUES (3,8,9,'2024-03-01 12:20:33'),(3,10,11,'2024-03-01 14:20:15'),(3,12,9,'2024-03-10 11:15:30'),(3,14,9,'2024-03-20 10:20:33'),(3,15,17,'2024-10-01 11:25:40'),(3,17,19,'2024-10-02 10:30:22'),(3,19,17,'2024-10-15 11:20:30'),(3,21,17,'2024-10-28 10:15:22'),(3,22,25,'2024-11-01 11:30:15'),(3,24,29,'2024-11-01 13:25:40'),(3,27,35,'2024-11-01 16:25:22'),(3,30,25,'2024-11-07 11:20:33'),(3,32,33,'2024-11-07 13:40:15'),(3,34,25,'2024-11-14 10:30:15'),(3,37,41,'2024-11-10 11:30:15'),(3,39,45,'2024-11-10 13:25:40'),(3,42,51,'2024-11-10 16:25:22'),(3,45,41,'2024-11-16 10:30:15'),(4,9,15,'2024-03-01 13:30:22'),(4,12,15,'2024-03-11 13:22:44'),(4,14,11,'2024-03-21 14:35:11'),(4,15,17,'2024-10-02 14:18:22'),(4,19,17,'2024-10-17 14:35:22'),(4,21,17,'2024-10-29 14:22:11'),(4,23,28,'2024-11-01 12:15:30'),(4,26,33,'2024-11-01 15:40:15'),(4,29,39,'2024-11-01 18:20:15'),(4,30,28,'2024-11-08 14:35:11'),(4,32,33,'2024-11-08 16:22:40'),(4,34,29,'2024-11-15 14:20:44'),(4,38,44,'2024-11-10 12:15:30'),(4,41,49,'2024-11-10 15:40:15'),(4,44,56,'2024-11-10 18:20:15'),(4,45,44,'2024-11-17 14:20:44'),(5,8,9,'2024-03-02 14:35:11'),(5,11,14,'2024-03-02 10:25:40'),(5,13,11,'2024-03-10 12:30:22'),(5,14,11,'2024-03-23 12:15:44'),(5,15,18,'2024-10-03 10:33:11'),(5,18,22,'2024-10-01 14:25:40'),(5,20,22,'2024-10-15 12:40:15'),(5,21,22,'2024-10-31 09:30:45'),(5,22,25,'2024-11-02 14:20:44'),(5,25,31,'2024-11-01 14:20:30'),(5,28,38,'2024-11-01 17:15:30'),(5,30,28,'2024-11-09 12:15:44'),(5,33,39,'2024-11-07 14:25:22'),(5,34,29,'2024-11-16 11:45:22'),(5,37,41,'2024-11-11 14:20:44'),(5,40,48,'2024-11-10 14:20:30'),(5,43,53,'2024-11-10 17:15:30'),(5,45,44,'2024-11-18 11:45:22'),(6,8,10,'2024-03-03 10:15:44'),(6,12,9,'2024-03-12 10:40:18'),(6,14,9,'2024-03-25 16:22:28'),(6,15,17,'2024-10-05 16:44:55'),(6,19,17,'2024-10-19 10:15:44'),(6,21,17,'2024-11-02 16:11:33'),(6,23,28,'2024-11-02 15:22:44'),(6,27,36,'2024-11-02 13:22:11'),(6,30,25,'2024-11-10 16:22:28'),(6,33,39,'2024-11-08 17:22:11'),(6,35,33,'2024-11-14 11:15:30'),(6,38,44,'2024-11-11 15:22:44'),(6,41,49,'2024-11-11 12:22:40'),(6,44,56,'2024-11-11 15:35:40'),(6,46,45,'2024-11-16 11:15:30'),(7,8,9,'2024-03-04 16:22:28'),(7,11,14,'2024-03-03 14:18:22'),(7,13,14,'2024-03-11 14:15:44'),(7,14,9,'2024-03-27 11:40:15'),(7,15,17,'2024-10-07 12:20:33'),(7,18,22,'2024-10-03 16:18:22'),(7,20,22,'2024-10-17 15:22:40'),(7,21,22,'2024-11-05 11:44:28'),(7,23,28,'2024-11-03 11:40:18'),(7,26,33,'2024-11-02 12:22:40'),(7,29,39,'2024-11-02 15:35:40'),(7,31,29,'2024-11-07 12:30:22'),(7,34,25,'2024-11-17 16:15:33'),(7,37,42,'2024-11-12 10:45:22'),(7,40,47,'2024-11-11 11:35:22'),(7,43,53,'2024-11-11 14:22:44'),(7,46,48,'2024-11-17 15:22:44'),(8,9,16,'2024-03-02 15:11:44'),(8,12,9,'2024-03-14 15:25:33'),(8,14,9,'2024-03-29 09:18:50'),(8,15,18,'2024-10-08 09:35:11'),(8,21,17,'2024-11-08 13:20:15'),(8,22,26,'2024-11-03 10:45:22'),(8,26,34,'2024-11-03 16:10:28'),(8,30,25,'2024-11-11 11:40:15'),(8,34,25,'2024-11-18 09:40:11'),(8,38,43,'2024-11-12 11:40:18'),(8,42,52,'2024-11-11 13:22:11'),(8,45,41,'2024-11-19 16:15:33'),(9,10,12,'2024-03-03 11:35:44'),(9,13,11,'2024-03-13 11:40:28'),(9,16,23,'2024-10-01 13:15:44'),(9,19,23,'2024-10-21 16:50:11'),(9,21,17,'2024-11-10 10:05:44'),(9,24,29,'2024-11-02 16:18:22'),(9,28,38,'2024-11-02 14:22:44'),(9,31,29,'2024-11-08 15:11:44'),(9,35,39,'2024-11-15 15:22:44'),(9,38,44,'2024-11-13 13:25:33'),(9,42,51,'2024-11-12 09:30:45'),(9,47,51,'2024-11-16 12:20:15'),(10,10,11,'2024-03-04 13:22:28'),(10,13,11,'2024-03-14 16:22:15'),(10,16,24,'2024-10-03 15:22:28'),(10,23,27,'2024-11-04 13:25:33'),(10,27,35,'2024-11-03 09:30:45'),(10,31,31,'2024-11-09 13:25:33'),(10,34,29,'2024-11-19 13:25:30'),(10,39,45,'2024-11-11 16:18:22'),(10,43,54,'2024-11-12 10:40:18'),(10,46,45,'2024-11-18 12:40:18'),(11,8,9,'2024-03-05 11:40:15'),(11,12,9,'2024-03-15 09:18:40'),(11,14,9,'2024-03-30 13:30:22'),(11,16,23,'2024-10-05 11:40:15'),(11,19,17,'2024-10-23 09:22:33'),(11,21,22,'2024-11-12 15:33:22'),(11,24,30,'2024-11-03 12:33:11'),(11,28,37,'2024-11-03 10:40:18'),(11,30,28,'2024-11-12 09:18:50'),(11,35,33,'2024-11-16 12:40:18'),(11,37,41,'2024-11-13 16:15:33'),(11,41,50,'2024-11-12 16:10:28'),(11,46,45,'2024-11-19 10:25:33'),(12,9,15,'2024-03-04 12:25:33'),(12,14,11,'2024-03-31 15:11:44'),(12,17,20,'2024-10-04 13:11:44'),(12,20,19,'2024-10-19 11:10:28'),(12,22,25,'2024-11-04 16:15:33'),(12,26,33,'2024-11-04 10:55:19'),(12,31,29,'2024-11-10 10:40:18'),(12,35,39,'2024-11-17 10:25:33'),(12,38,44,'2024-11-14 10:18:50'),(12,42,51,'2024-11-13 14:11:33'),(12,47,49,'2024-11-17 16:35:40'),(13,10,11,'2024-03-06 15:10:33'),(13,16,23,'2024-10-07 14:18:50'),(13,25,31,'2024-11-02 11:35:22'),(13,29,40,'2024-11-03 11:22:28'),(13,32,35,'2024-11-09 14:10:28'),(13,39,46,'2024-11-12 12:33:11'),(13,43,53,'2024-11-13 15:25:33'),(13,47,51,'2024-11-18 13:22:28'),(14,9,16,'2024-03-05 10:40:18'),(14,17,19,'2024-10-06 12:25:33'),(14,20,22,'2024-10-21 13:55:19'),(14,23,28,'2024-11-05 10:18:50'),(14,28,38,'2024-11-04 15:25:33'),(14,32,33,'2024-11-10 11:55:19'),(14,35,39,'2024-11-18 14:18:50'),(14,40,48,'2024-11-12 15:15:44'),(14,44,55,'2024-11-12 11:22:28'),(14,48,53,'2024-11-16 13:25:22'),(15,8,10,'2024-03-06 09:18:50'),(15,17,20,'2024-10-08 10:40:18'),(15,22,25,'2024-11-05 09:40:11'),(15,27,35,'2024-11-04 14:11:33'),(15,31,29,'2024-11-11 14:55:40'),(15,37,41,'2024-11-14 09:40:11'),(15,41,49,'2024-11-13 10:55:19'),(15,47,51,'2024-11-19 11:40:11'),(16,9,15,'2024-03-06 14:55:40'),(16,18,21,'2024-10-05 11:33:11'),(16,24,29,'2024-11-04 14:44:55'),(16,29,39,'2024-11-04 16:40:11'),(16,33,38,'2024-11-09 15:30:45'),(16,39,45,'2024-11-13 14:44:55'),(16,44,56,'2024-11-13 16:40:11'),(16,48,56,'2024-11-17 17:22:11'),(17,11,13,'2024-03-05 12:33:11'),(17,18,22,'2024-10-07 13:44:55'),(17,25,32,'2024-11-03 15:15:44'),(17,33,39,'2024-11-10 12:11:33'),(17,40,48,'2024-11-13 09:50:11'),(17,48,53,'2024-11-18 14:30:45'),(18,11,14,'2024-03-07 16:44:55'),(18,25,31,'2024-11-04 09:50:11'),(18,48,56,'2024-11-19 12:11:33'),(19,34,25,'2024-11-18 15:22:10'),(19,45,41,'2024-11-18 17:15:40'),(20,35,39,'2024-11-19 16:33:25'),(20,46,48,'2024-11-19 18:20:55'),(22,1087,1109,'2025-12-01 23:07:39'),(22,1088,1123,'2025-12-01 23:07:48'),(22,1095,1109,'2025-12-01 23:07:54'),(22,1096,1111,'2025-12-01 23:07:56'),(22,1483,1550,'2025-12-03 20:49:48'),(22,1484,1564,'2025-12-03 20:49:51'),(22,1485,1552,'2025-12-03 20:49:53'),(22,1486,1562,'2025-12-03 20:49:56'),(22,1487,1554,'2025-12-03 20:49:58'),(22,1488,1555,'2025-12-03 20:50:02'),(22,1489,1556,'2025-12-03 20:50:04'),(22,1490,1557,'2025-12-03 20:50:07'),(22,1491,1550,'2025-12-03 20:50:23'),(22,1492,1552,'2025-12-03 20:50:30'),(22,1493,1554,'2025-12-03 20:50:21'),(22,1494,1557,'2025-12-03 20:50:25'),(22,1497,1554,'2025-12-03 20:51:38'),(22,1513,1597,'2025-12-03 22:13:05'),(22,1514,1583,'2025-12-03 22:13:08'),(22,1515,1584,'2025-12-03 22:13:11'),(22,1517,1586,'2025-12-03 22:13:15'),(22,1518,1592,'2025-12-03 22:13:24'),(22,1519,1588,'2025-12-03 22:13:18'),(22,1520,1590,'2025-12-03 22:13:20'),(22,1527,1583,'2025-12-03 22:14:53'),(22,1528,1613,'2025-12-03 22:17:44'),(22,1536,1599,'2025-12-03 22:18:17'),(22,1572,1643,'2025-12-03 22:44:46'),(22,1573,1657,'2025-12-03 22:44:48'),(22,1574,1645,'2025-12-03 22:45:00'),(22,1575,1646,'2025-12-03 22:45:05'),(22,1576,1647,'2025-12-03 22:44:50'),(22,1577,1648,'2025-12-03 22:44:55'),(22,1578,1649,'2025-12-03 22:44:51'),(22,1579,1650,'2025-12-03 22:44:53'),(22,1580,1643,'2025-12-03 22:45:24'),(22,1581,1645,'2025-12-03 22:45:26'),(22,1582,1647,'2025-12-03 22:45:28'),(22,1583,1649,'2025-12-03 22:45:29'),(25,34,25,'2025-11-28 13:21:15'),(25,35,39,'2025-11-28 13:18:42'),(25,995,901,'2025-11-30 12:24:51'),(25,996,905,'2025-11-30 12:25:13'),(25,1393,1458,'2025-12-03 00:35:25'),(25,1395,1471,'2025-12-03 00:35:28'),(25,1396,1461,'2025-12-03 00:35:32'),(25,1405,1458,'2025-12-03 00:36:02'),(25,1498,1566,'2025-12-03 22:04:19'),(25,1500,1579,'2025-12-03 22:04:22'),(25,1501,1569,'2025-12-03 22:04:25'),(25,1505,1573,'2025-12-03 22:04:34'),(25,1507,1579,'2025-12-03 22:04:50'),(25,1508,1571,'2025-12-03 22:04:54'),(25,1510,1566,'2025-12-03 22:05:24'),(25,1511,1572,'2025-12-03 22:05:28'),(25,1512,1566,'2025-12-03 22:05:50'),(25,1558,1629,'2025-12-03 22:26:57'),(25,1559,1641,'2025-12-03 22:27:00'),(25,1562,1639,'2025-12-03 22:26:52'),(25,1563,1634,'2025-12-03 22:27:03'),(25,1564,1635,'2025-12-03 22:27:05'),(25,1602,1674,'2025-12-03 22:52:41'),(25,1603,1675,'2025-12-03 22:52:54'),(25,1613,1680,'2025-12-03 22:53:15'),(25,1614,1674,'2025-12-03 22:53:41'),(25,1616,1674,'2025-12-03 22:54:15'),(25,1617,1690,'2025-12-04 11:18:44'),(25,1618,1691,'2025-12-04 11:18:48'),(25,1625,1690,'2025-12-04 11:19:13'),(25,1626,1692,'2025-12-04 11:19:17'),(25,1627,1694,'2025-12-04 11:19:24'),(27,1102,1125,'2025-12-01 23:26:47'),(27,1103,1139,'2025-12-01 23:26:49'),(27,1106,1129,'2025-12-01 23:26:51'),(27,1108,1131,'2025-12-01 23:26:57'),(27,1110,1125,'2025-12-01 23:27:07'),(27,1111,1127,'2025-12-01 23:27:08'),(27,1112,1129,'2025-12-01 23:27:13'),(27,1113,1132,'2025-12-01 23:27:10'),(27,1114,1127,'2025-12-01 23:27:23'),(27,1115,1132,'2025-12-01 23:27:26'),(27,1116,1127,'2025-12-01 23:27:44'),(27,1117,1141,'2025-12-02 00:04:35'),(27,1129,1143,'2025-12-02 00:04:46'),(27,1602,1674,'2025-12-03 22:52:45'),(27,1603,1688,'2025-12-03 22:52:46'),(27,1604,1676,'2025-12-03 22:52:48'),(27,1606,1678,'2025-12-03 22:52:50'),(27,1608,1680,'2025-12-03 22:53:06'),(27,1609,1681,'2025-12-03 22:53:03'),(27,1616,1674,'2025-12-03 22:54:24'),(27,1727,1829,'2025-12-04 13:42:15'),(27,1728,1843,'2025-12-04 13:42:19'),(27,1735,1829,'2025-12-04 13:42:37'),(29,1742,1849,'2025-12-08 11:12:56'),(29,1743,1850,'2025-12-08 11:12:59'),(29,1744,1851,'2025-12-08 11:13:02'),(29,1745,1852,'2025-12-08 11:13:05'),(29,1746,1853,'2025-12-08 11:13:08'),(29,1747,1854,'2025-12-08 11:13:12'),(29,1748,1855,'2025-12-08 11:13:17'),(29,1749,1857,'2025-12-08 11:13:22'),(29,1750,1849,'2025-12-08 11:13:28'),(29,1751,1851,'2025-12-08 11:13:31'),(29,1752,1854,'2025-12-08 11:13:35'),(29,1753,1857,'2025-12-08 11:13:38'),(29,1754,1849,'2025-12-08 11:13:56'),(29,1755,1854,'2025-12-08 11:13:59'),(29,1756,1849,'2025-12-08 11:14:25'),(29,1772,1880,'2025-12-09 12:11:15'),(29,1773,1880,'2025-12-09 12:11:17'),(31,995,901,'2025-11-30 12:26:58'),(31,996,905,'2025-11-30 12:27:03'),(31,997,905,'2025-12-01 19:05:40'),(31,1011,1012,'2025-11-30 12:31:57'),(31,1012,1013,'2025-11-30 12:32:00'),(31,1408,1474,'2025-12-03 19:19:17'),(31,1409,1485,'2025-12-03 19:19:30'),(35,1609,1681,'2025-12-03 22:53:05'),(35,1616,1678,'2025-12-03 22:54:21'),(37,1669,1753,'2025-12-04 13:35:15'),(37,1670,1754,'2025-12-04 13:35:18'),(37,1671,1755,'2025-12-04 13:35:21'),(37,1672,1756,'2025-12-04 13:35:23'),(37,1673,1757,'2025-12-04 13:35:26'),(37,1674,1758,'2025-12-04 13:35:29'),(37,1677,1753,'2025-12-04 13:35:55'),(37,1678,1756,'2025-12-04 13:35:57'),(37,1679,1757,'2025-12-04 13:36:00'),(37,1680,1759,'2025-12-04 13:36:02'),(37,1681,1753,'2025-12-04 13:36:09'),(37,1682,1757,'2025-12-04 13:36:12'),(37,1683,1753,'2025-12-04 13:36:39'),(37,1735,1830,'2025-12-04 13:42:45'),(37,1736,1842,'2025-12-04 13:42:48'),(37,1737,1834,'2025-12-04 13:42:52'),(37,1738,1836,'2025-12-04 13:42:55'),(37,1739,1842,'2025-12-04 13:43:03'),(37,1740,1833,'2025-12-04 13:43:06'),(38,997,901,'2025-12-04 13:35:03'),(38,1712,1828,'2025-12-04 13:42:13'),(38,1713,1814,'2025-12-04 13:42:17'),(38,1719,1820,'2025-12-04 13:42:20'),(38,1720,1814,'2025-12-04 13:42:37'),(38,1723,1819,'2025-12-04 13:42:33'),(39,1712,1813,'2025-12-04 13:42:07'),(39,1714,1815,'2025-12-04 13:42:13'),(39,1720,1814,'2025-12-04 13:42:57'),(39,1721,1816,'2025-12-04 13:42:41'),(39,1723,1820,'2025-12-04 13:42:45'),(39,1724,1814,'2025-12-04 13:43:05'),(39,1725,1817,'2025-12-04 13:43:07'),(44,1727,1844,'2025-12-04 13:42:19'),(44,1728,1830,'2025-12-04 13:42:22'),(44,1735,1830,'2025-12-04 13:42:42'),(44,1737,1833,'2025-12-04 13:42:39'),(44,1738,1836,'2025-12-04 13:42:47'),(46,1712,1813,'2025-12-04 13:42:15'),(46,1713,1814,'2025-12-04 13:42:19'),(46,1721,1815,'2025-12-04 13:42:38'),(46,1722,1817,'2025-12-04 13:42:46'),(46,1724,1814,'2025-12-04 13:43:05'),(48,1712,1828,'2025-12-04 13:42:11'),(49,997,901,'2025-12-04 13:41:45'),(49,1712,1813,'2025-12-04 13:42:22'),(49,1713,1827,'2025-12-04 13:42:27'),(49,1720,1813,'2025-12-04 13:42:40'),(49,1721,1816,'2025-12-04 13:42:44'),(49,1722,1817,'2025-12-04 13:42:50'),(49,1723,1819,'2025-12-04 13:42:38'),(49,1724,1814,'2025-12-04 13:43:04'),(49,1725,1819,'2025-12-04 13:43:08'),(49,1741,1829,'2025-12-04 13:43:34'),(50,1735,1829,'2025-12-04 13:42:38'),(50,1736,1832,'2025-12-04 13:42:43'),(50,1739,1829,'2025-12-04 13:43:05'),(50,1740,1836,'2025-12-04 13:43:10'),(50,1741,1833,'2025-12-04 13:43:32'),(51,1727,1829,'2025-12-04 13:42:16'),(51,1728,1830,'2025-12-04 13:42:19'),(51,1729,1842,'2025-12-04 13:42:23'),(51,1730,1832,'2025-12-04 13:42:28'),(51,1735,1829,'2025-12-04 13:42:36'),(51,1736,1842,'2025-12-04 13:42:39'),(51,1737,1833,'2025-12-04 13:42:44'),(51,1738,1835,'2025-12-04 13:42:47'),(51,1739,1829,'2025-12-04 13:43:03'),(51,1740,1833,'2025-12-04 13:43:07'),(51,1741,1829,'2025-12-04 13:43:33');
/*!40000 ALTER TABLE `vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `active_matchups_with_votes`
--

/*!50001 DROP VIEW IF EXISTS `active_matchups_with_votes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`fantasytourney`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `active_matchups_with_votes` AS select `m`.`matchup_id` AS `matchup_id`,`t`.`tournament_id` AS `tournament_id`,`t`.`title` AS `tournament_title`,`m`.`round_number` AS `round_number`,`m`.`status` AS `status`,`m`.`opens_at` AS `opens_at`,`m`.`closes_at` AS `closes_at`,`e1`.`entry_id` AS `entryA_id`,`e1`.`name` AS `entryA_name`,`e1`.`image_URL` AS `entryA_image`,`e2`.`entry_id` AS `entryB_id`,`e2`.`name` AS `entryB_name`,`e2`.`image_URL` AS `entryB_image`,count(distinct case when `v`.`entry_id` = `m`.`entryA_id` then `v`.`user_id` end) AS `entryA_votes`,count(distinct case when `v`.`entry_id` = `m`.`entryB_id` then `v`.`user_id` end) AS `entryB_votes`,count(distinct `v`.`user_id`) AS `total_votes` from ((((`matchup` `m` join `tournament` `t` on(`m`.`tournament_id` = `t`.`tournament_id`)) join `entry` `e1` on(`m`.`entryA_id` = `e1`.`entry_id`)) join `entry` `e2` on(`m`.`entryB_id` = `e2`.`entry_id`)) left join `vote` `v` on(`m`.`matchup_id` = `v`.`matchup_id`)) where `m`.`status` = 'Active' group by `m`.`matchup_id`,`t`.`tournament_id`,`t`.`title`,`m`.`round_number`,`m`.`status`,`m`.`opens_at`,`m`.`closes_at`,`e1`.`entry_id`,`e1`.`name`,`e1`.`image_URL`,`e2`.`entry_id`,`e2`.`name`,`e2`.`image_URL` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_active_tournaments`
--

/*!50001 DROP VIEW IF EXISTS `view_active_tournaments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`fantasytourney`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_active_tournaments` AS select `tournament`.`tournament_id` AS `tournament_id`,`tournament`.`title` AS `title`,`tournament`.`description` AS `description`,`tournament`.`start_at` AS `start_at`,`tournament`.`end_at` AS `end_at`,`tournament`.`tourneystatus` AS `tourneystatus`,`tournament`.`user_id` AS `user_id` from `tournament` where `tournament`.`tourneystatus` = 'active' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_tournament_entries`
--

/*!50001 DROP VIEW IF EXISTS `view_tournament_entries`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`fantasytourney`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_tournament_entries` AS select `t`.`tournament_id` AS `tournament_id`,`t`.`title` AS `tournament_title`,`e`.`entry_id` AS `entry_id`,`e`.`name` AS `entry_name`,`e`.`image_URL` AS `image_url` from (`tournament` `t` join `entry` `e` on(`t`.`tournament_id` = `e`.`tournament_id`)) order by `t`.`tournament_id`,`e`.`entry_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_tournament_summary`
--

/*!50001 DROP VIEW IF EXISTS `view_tournament_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`fantasytourney`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_tournament_summary` AS select `t`.`tournament_id` AS `tournament_id`,`t`.`title` AS `title`,`t`.`description` AS `description`,`t`.`tourneystatus` AS `tourneystatus`,`t`.`start_at` AS `start_at`,`t`.`end_at` AS `end_at`,`t`.`user_id` AS `user_id` from `tournament` `t` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-10 12:24:47
