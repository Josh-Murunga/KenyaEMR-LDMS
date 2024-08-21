-- MySQL dump 10.13  Distrib 5.6.16, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ldwh
-- ------------------------------------------------------
-- Server version	5.6.16-1~exp1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS ldwh;

USE ldwh;
--
-- Table structure for table `dataset_values`
--

DROP TABLE IF EXISTS `dataset_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_values` (
  `data_element` varchar(11) DEFAULT NULL,
  `category_option` varchar(25) DEFAULT NULL,
  `organization_unit` varchar(25) DEFAULT NULL,
  `period` int(11) DEFAULT NULL,
  `value` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_values`
--

LOCK TABLES `dataset_values` WRITE;
/*!40000 ALTER TABLE `dataset_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataset_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facility_info`
--

DROP TABLE IF EXISTS `facility_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility_info` (
  `mfl` int(11) DEFAULT NULL,
  `facility_name` text,
  `organization_unit` varchar(25) NOT NULL,
  `upload_status` varchar(45) DEFAULT 'pending',
  PRIMARY KEY (`organization_unit`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facility_info`
--

LOCK TABLES `facility_info` WRITE;
/*!40000 ALTER TABLE `facility_info` DISABLE KEYS */;
INSERT INTO `facility_info` VALUES (17894,'Bwiti Dispensary','A0Ln8q092qB','pending'),(11836,'Takaungu Dispensary','a4s2wKfJc30','complete'),(11254,'Bokole CDF Dispensary','a6KR1c7QXeL','complete'),(11368,'Eshu Dispensary','a9OHUtkxjO8','complete'),(11488,'Kishushe Dispensary','aABRCk8mJeG','complete'),(11423,'Jaffery Medical Clinic','acwrBDe6sW2','pending'),(16188,'Mariakani Community Health Care Services','aHPOWlrPB0l','pending'),(11208,'Al Farooq Hospital','aiD3lzUJBTy','complete'),(11630,'Mkundi Dispensary','Al89kMrg3Yt','pending'),(19189,'Kamkomani Dispensary','aN1Tlm1CJ1S','pending'),(11541,'Majengo Dispensary (Mombasa)','aNcnmaf1UCw','complete'),(18187,'Mahandakini Dispensary','aOVjR4sxcFF','pending'),(17646,'Nyango Dispensary','AqLdqbmRxuw','pending'),(20335,'Mwanguda Dispensary','AR8hK8NvYFa','pending'),(11463,'Kiangachinyi Dispensary','AXNHxgMDry0','pending'),(11636,'Mnarani Dispensary','aYdjz9VZhBX','complete'),(17893,'Mzizima (CDF) Dispensary','aZcZ3CdOcM0','pending'),(11221,'Amurt Health Centre (Likoni)','b0aLkuteIbm','pending'),(17822,'Miritini (MCM) Dispensary','b50DtgUAzgG','pending'),(11666,'Mtepeni Dispensary','B6rHrU256iw','complete'),(11495,'Kizibe Dispensary','b9PRSKsPyq0','complete'),(11441,'Joy Medical Clinic (Mwatate)','BeVClnWzOLi','pending'),(11473,'Kilibasi Dispensary','bGJEeoqpsS0','complete'),(17623,'Kisauni Drop In VCT','bHyL9kqP653','complete'),(11873,'Utange Dispensary','bJxj094HsZL','pending'),(11831,'State House Dispensary (Mombasa)','bKNoJXJZYXg','complete'),(20345,'Kijana Heri Medical Clinic','boDlBthOKF3','pending'),(11638,'Mnyenzeni Health Centre','bplF50Sazvt','complete'),(11896,'Watamu Maternity and Nursing Home','bq8XC39c2rE','complete'),(11758,'Roka Maweni Dispensary','Bq9L3QREUFy','complete'),(11522,'Likoni District Hospital','bvUg2vPkLWw','pending'),(11520,'Likoni Catholic Dispensary','bVvybxoOuLr','pending'),(21213,'Mjanaheri Dispensary','bXF0VY9kv3l','pending'),(11571,'Marikebuni Dispensary','CARbfjQWQR4','complete'),(11572,'Marungu Health Centre','ccal2qRq8My','complete'),(17346,'Makande Healthcare Services','cCWHaspoKZ0','pending'),(17233,'Maweni CDF Dispensary','cDWVOPhvdMX','complete'),(11879,'Vanga Health Centre','CFOmFTRmpEp','complete'),(11701,'Ndavaya Health centre','CJn1auuIZAo','complete'),(16549,'Mwananyamala CDF Dispensary','cOgv5EHeFRj','pending'),(17127,'Manoa Dispensary','CqE561275B7','pending'),(11601,'Mgamboni Dispensary','crwMVmc9804','pending'),(18212,'Kenya Ports Authority Medical Clinic','Ct9bQIfUoA3','pending'),(21256,'Gandini Dispensary (Kinango)','cYrHrtCUWDR','pending'),(19629,'Al Fridaus Medical Clinic','d2TqMWtDu8b','pending'),(16532,'Bakarani Community Clinic','d8KDRlVNVFA','pending'),(11712,'Ngathini Dispensary','dcM4sXObsyP','complete'),(29476,'Barani Dispensary','dHfz2Btkj1g','pending'),(11592,'Mbuta Model Health Centre','DkqZGBy1IPy','complete'),(29655,'Vikobani Dispensary','DNLEbCijBau','pending'),(11239,'Bamburi Dispensary','dO93Ue6OwRr','pending'),(11302,'Dembwa Dispensary','DOcBRLcGBUX','pending'),(16526,'St Benedetto Health Centre','DThwjc1ds5J','complete'),(11705,'Ndovu Health Centre','DUoMcSbpU37','complete'),(11489,'Kisimani Health Services','E4L1RgaAbiM','pending'),(11238,'Bamba Maternity Nursing Home','E7liN0388Dd','pending'),(11577,'Mata Dispensary (Taveta)','eBEloHL6afC','complete'),(18210,'Mlaleo CDF Health Centre','ebxBpxNXZP1','complete'),(11908,'Wundanyi Sub County Hospital','EDcCsYmI28j','complete'),(19024,'Dungicha Dispensary','edVT1j1E1yC','pending'),(17630,'Seaside Nursing Home','eFXM0R5IBB4','pending'),(11444,'Junju Dispensary','ehWIvgTwDHI','complete'),(23131,'Sister\'s of St. Josepth Catholic Dispensary','EIAsU8lMsZJ','complete'),(11497,'Kizingo Health Centre','EiHWFXmX21L','complete'),(11581,'Matuga Dispensary','eJFV4QoSfJT','complete'),(11748,'Rabai Rural Health Demonstration Centre','eMMojDvhND0','complete'),(11552,'Makwasinyi Dispensary','eqM0sRFaYP3','pending'),(11297,'Dagamra Dispensary','eqnv3W3wuKp','pending'),(11761,'Sabaki Dispensary','EqOqZ31xi3Y','complete'),(11787,'Shimba Hills Health Centre','erZvaDeCoQ3','complete'),(16554,'Mwashuma Dispensary (CDF)','eVzFQKlvAjO','pending'),(11262,'Bughuta Health Centre','eZjUr1BHgQw','complete'),(21544,'Jila Model Health Centre','f4qVre0RVQQ','pending'),(11243,'Baobab Clinic Bamburi Cement','F5QNnfbcxlE','pending'),(11499,'Kongowea Health Centre','f7VNgpLhVwW','complete'),(11477,'Kimorigho Dispensary','F8285BUIOVd','complete'),(11904,'Werugha Health Centre','FbVfA2p2Bon','complete'),(11695,'Mwatate Sub-County Hospital','fcY1fkS6bL1','complete'),(20321,'Khairat Medical Centre','fey434PjdTi','pending'),(11387,'Gede Health Centre','FkB4lcoQfnz','complete'),(11689,'Mwangatini Dispensary','fMaHgOPyJr9','pending'),(11446,'Kaderboy Medical Clinic (Old Town)','fN7KqlgwStu','pending'),(21545,'Kachororoni Dispensary','fNm4rcRIKUF','pending'),(11686,'Mwambirwa Dispensary','frYFcUIf8lC','pending'),(11493,'Kiwandani Dispensary','FYGO2TZZWuq','complete'),(11672,'Mtwapa Health Centre','g93vSYftyjR','complete'),(22165,'AAR Nyali Heallthcare(K) LTD Nyali','GaJDwc23dzp','pending'),(11507,'Kwale Sub County Hospital','gbQw8OQtjpj','complete'),(11853,'Tiwi RHTC','gEvZgtrunJY','complete'),(11545,'Makamini Dispensary','gfk5MBvovOM','pending'),(11610,'Mijomboni Dispensary','Ght4C4o0gse','complete'),(11713,'Ngerenya Dispensary','GJ4Cd9RXMop','complete'),(11455,'Kasigau Rdch','GJda6nR1YiA','complete'),(11718,'Njukini Health Centre','gLkdFvweeSd','complete'),(11532,'Madamani Dispensary','gNN3hkfq0Ty','complete'),(11891,'Wananchi Nursing Home','gNujOVxWPWY','complete'),(11867,'Ukunda Diani Catholic Dispensary','GqRPZuGWkm1','pending'),(11768,'Samburu Sub County Hospital','GRZc4EZ9PuV','complete'),(18302,'Maweni Community Clinic','GSMLIGa68Lp','pending'),(11893,'Watamu (SDA) Dispensary','Gtj9Z3IFCRZ','pending'),(11641,'Moi County Referral Hospital (Voi)','guF7zg2Bdcy','complete'),(17120,'Shelemba Dispensary','GVzSIlzeDDx','pending'),(11593,'Mbuwani Dispensary','gwB2ZiLFNyy','pending'),(20308,'Chamari Dispensary','gWOJcwZe4Jx','pending'),(11702,'Ndilidau Dispensary (Jipe)','gyhJyUbozV4','complete'),(11481,'Kinarani Dispensary','h4umoQOV2pq','pending'),(23309,'Joscare Medical Clinic','H5Mn5QSE0CM','pending'),(11881,'Vipingo Rural Demonstration Health Centre','hCnhN2p6C9T','complete'),(11415,'Horesha Medical Clinic','hd960rbac4q','pending'),(11755,'Rea Vipingo Dispensary','hFFWfOsBbqK','pending'),(11266,'Bwagamoyo Dispensary','HGLQF59nCsF','pending'),(11653,'Muryachakwe Dispensary','hhKVTn2Ynjl','pending'),(23323,'Mvindeni Dispensary','HhrPyREkyqN','complete'),(11826,'St Theresa Dispensary','hkGIxRAqS3b','pending'),(18601,'St Joseph Mission Dispensary Chumvini','HogroB7g3v3','pending'),(11696,'Mwawesa Medical Clinic','HpNKXuX3c1n','pending'),(11785,'Shika Adabu (MCM) Dispensary','HqFDy2vEQz6','pending'),(11401,'Gongoni Health Centre','hRvE0UfQ1LZ','complete'),(11838,'Taru Dispensary','hVc9GNgGPYF','complete'),(11474,'Kilifi County Hospital','HVsXeh7EatU','complete'),(11359,'Dzikunze Dispensary','HWKmcSTRCuv','complete'),(11425,'Jambo Medical Clinic','HwRb5Ackqm4','pending'),(11704,'Ndome Dispensary (Taita)','hZCDGLQWIdh','pending'),(11677,'Muyeye Health Centre (Municipal)','i091Ei10XBM','complete'),(23132,'Pongwe/Kidimu Dispensary','I1uyMohbaUS','complete'),(23925,'Uwanja wa Ndege Dispensary','I5TrVHHQiTO','pending'),(11667,'Mtondia Dispensary','IBlqC33L7rn','complete'),(11624,'Mivumoni (Catholic) Dispensary','IBO76lif4Fr','complete'),(18482,'Mavueni Dispensary','IcAY6Oco0YH','pending'),(11771,'Sau Health Services','iCZTk27AHph','complete'),(17469,'Kiteje Dispensary','ifilZzpttrk','pending'),(11764,'Sagala Health Centre','iHIbDSA0diT','complete'),(16190,'Vishakani Dispensary','iiAqayBXPQh','pending'),(11256,'Bombi Dispensary','iKAnCP0fHW9','pending'),(18211,'Railways Dispensary (Mombasa)','iM48NtgCfPO','complete'),(16552,'Ukunda Medical Clinic','Iup62QtD0aw','complete'),(11602,'Mgange Dawida Dispensary','iZg0Knh5nhS','complete'),(11603,'Mgange Nyika Health Centre','J2Twz5u5b4j','complete'),(11531,'Mackinon Road Dispensary','J6BZQiPUm4R','complete'),(11457,'David Kayanda Dispensary','JAJ7YX1wFAr','pending'),(18040,'Meditrust Health Care Services','JFawTT0Jmxy','complete'),(11517,'Lenga Dispensary','JJczCny1gT1','pending'),(17770,'Akemo Medical Clinic','jLCDKWdsW28','pending'),(11634,'Mlaleo Medical Clinic','JLycfrnh9yB','complete'),(11643,'Mombasa Hospital','jTY37uG4jRF','complete'),(18095,'Matumbi Dispensary','JUML6lzisNI','pending'),(11454,'Kanamai Health Care','JW0Lexz7zKS','complete'),(11605,'Miasenyi Dispensary','jYSPwpA0gha','pending'),(11447,'Kadzinuni Dispensary','k1gDvwc81yh','pending'),(11404,'Gotani Model Health Centre','K1YU8aOlHWu','complete'),(11544,'Majoreni Dispensary','k25SFxZn4B9','pending'),(18309,'Mtoroni Dispensary','K5j2UgJMhNI','pending'),(11381,'Meridian hospital','K6aZavAsVgS','pending'),(11740,'Port Reitz Sub County Hospital','K6JHRvs7bAu','complete'),(22086,'Ziwa La Ng\'ombe Health Centre','ke4moKRIpK6','pending'),(24115,'Chumani Dispensary','kELHw0BoPXc','pending'),(11469,'Kighombo Dispensary','kF0bKOP420A','pending'),(11887,'Vyongwani Dispensary','khbVI9AHqV9','pending'),(25168,'Kaembeni Dispensary','kIjD3LTfQD0','pending'),(11274,'Coast General Teaching and Referral Hospital (Chaani Outreach Centre)','kJ5MjZkaoSP','pending'),(11562,'Marafa Health Centre','kKVNAgtxsgI','complete'),(11573,'Mary Immaculate Cottage Hospital (Mombasa)','Koi29tuLeJa','pending'),(18071,'Barsheba Medical Clinic','KpP492AtgPu','pending'),(11543,'Majimoto Dispensary','ksNfsN3CiNc','pending'),(11480,'Kinango Sub County Hospital','KT34EaG36YR','complete'),(11716,'Nguuni Health Centre','KTMLdFBxIG6','pending'),(11432,'Jibana Sub District Hospital','kZ1VUENMMCn','complete'),(11448,'Kafuduni Dispensary','Lbmua1AMw7d','complete'),(11382,'Ganda Dispensary','LcbKtIpSxFP','complete'),(22464,'Mwangea Dispensary','LCELVppoBvS','pending'),(11217,'Amani Medical Clinic (Kilifi)','LGPVNsrp6og','complete'),(11379,'Fundi Issa Dispensary','Lm8o853knxl','pending'),(11912,'Oasis Medical Center','lmRB0IvtF1n','complete'),(20491,'Junda Dispensary','lR6W5tK8hAq','pending'),(11681,'Mwabila Dispensary','LunYFWqFNiA','pending'),(11654,'St Marys Msabaha Catholic Dispensary','LVgw150DT2K','pending'),(18572,'Royal Run Medical Clinic','lwITlY4Rd2j','pending'),(11697,'Mwembe Tayari Dispensary','lzOUpzvVUbj','pending'),(21694,'Kombani Dispensary','m3LmuT3zzVS','complete'),(17689,'Viragoni Dispensary','m7UbpJjPOIj','pending'),(11293,'Cowdray Dispensary','MBbMKKGM2wv','pending'),(11688,'Mwanda Health Centre (Taita Taveta)','mCDPsFqAZ7m','complete'),(18431,'Marimani CDF Dispensary','MD1tQdr3b1V','pending'),(21119,'Mwapula Dispensary','Mf2qlnhPutO','pending'),(11662,'Mtaa Dispensary','Mi57MBhhiet','pending'),(11566,'Mariakani Sub County Hospital','mITAGtWnWEK','complete'),(11436,'Jomvu Model Health Centre','MP8fPGLlphd','complete'),(11558,'Mamba Dispensary','MRQeZtlocOi','pending'),(19597,'Health Source Medical Centre','MRzPKSMo4gJ','pending'),(28293,'Kisauni MAT Clinic','msU3yyKbEFi','pending'),(19606,'Mrima Maternity Hospital','musLWYtdRpQ','pending'),(11464,'Kibandaongo Dispensary','MWEDyBsOpxM','pending'),(11527,'Lutsangani Dispensary','mWfiQXewlzK','complete'),(11526,'Lungalunga Sub County Hospital','mz64odxfFPq','complete'),(11738,'Pingilikani Dispensary','n3qj1uzKmsT','complete'),(11445,'Kadaina Community Dispensary','NBK0zdNYfl9','pending'),(24137,'Mtwapa dispensary-Shimo la Tewa','ng3BeGLyq7p','pending'),(22554,'St Mary\'s Health Care','nglM1rnUbDc','complete'),(11479,'Kinagoni Dispensary','NijIFuj8eTF','pending'),(11682,'Mwachinga Dispensary','nKyBwCMaG1X','pending'),(11658,'Msulwa Dispensary','nqpogjIlKtQ','pending'),(11894,'Watamu Community Health Centre','nrl4EXu8KV0','pending'),(11884,'Vitsangalaweni Dispensary','nTLGF3pu49r','complete'),(11659,'Msumarini Dispensary','NTzu6NwxPed','complete'),(11655,'Msambweni County Referral Hospital','nUFNIok7EwF','complete'),(11680,'Mvono Clinic','NyPWjP5knen','pending'),(25626,'Mbudzi Community Health Centre','O0RZADYsZKW','pending'),(11888,'Waa Dispensary','O6vTdQ8hQL1','complete'),(11559,'Mambrui Dispensary','O8cO0JfUo2l','complete'),(11430,'Jaribuni Dispensary','O9iiqr06g3S','complete'),(11714,'Ng\'ombeni Dispensary','OArtNCNolNl','complete'),(11802,'Sokoke Dispensary','oBdVZPgL1d9','pending'),(11282,'Chasimba Health Centre','oGBXTwGNwBb','complete'),(11248,'Baricho Dispensary','OGia3FphS8p','pending'),(11434,'Jocham Hospital','OjKfyArZa2J','complete'),(11830,'Star of Good Hope Medical Clinic','OjZbKpyClzL','pending'),(11537,'Magodzoni Dispensary','OQaFzTxqOby','complete'),(18858,'Maungu Model Health Centre','OTwG6MsbpwJ','complete'),(11386,'Geca Medical Clinic','otwzajK9xT1','pending'),(18454,'Likoni HIV Resource Centre','Ox8vvMZo7s8','complete'),(17017,'Kokotoni Dispensary','Oxj36jLUDn8','pending'),(17126,'Modambogho Dispensary','oXSYWYUv3SN','complete'),(11288,'Roka Medical Clinic (Chumani)','ozwn11j2cO0','pending'),(11383,'Ganze Health Centre','OZzaTu0NyK2','complete'),(23412,'Goldstar Drop In Centre','P0NgegX5uEG','complete'),(11498,'Kombeni Dispensary','pAb5dOqbI6V','pending'),(11451,'Kajire Dispensary','pHA17Xy4wZk','pending'),(11198,'Adu Dispensary','pkKPZUYXl5l','complete'),(11549,'Maktau Health Centre','PkLRGRtOY62','complete'),(11585,'Mazeras Health centre','pnHduTXb4hB','complete'),(11582,'Maunguja Dispensary','pnHWEUwoiUe','pending'),(18312,'Bura Health Centre (Taita Taveta)','pnyCZ07HZhN','complete'),(18374,'Ziani Dispensary','pONv529fYTR','pending'),(23958,'Zowerani Dispensary','pqlqyGfUJKO','pending'),(11589,'Mbale Health Centre','pThhj7hcUnM','complete'),(11253,'Bofu Dispensary','pUx9e19epql','pending'),(11828,'St Valeria Medical Clinic','py5vYZIHN6z','pending'),(11845,'Chamalo Medical Clinic','pyG9z3VbFRG','pending'),(11794,'Silaloni Dispensary','Q0oTmpiCXFG','pending'),(11618,'Mirihini Dispensary','qavGVyGtzJd','pending'),(11400,'Godo Dispensary','qBmMdCCXus8','complete'),(11508,'Kwa-Mnegwa Dispensary','qCmeLUpuw4b','pending'),(11770,'Santa Maria Medical Clinic','QFvQazQx4Lf','pending'),(11760,'Rumangao Dispensary','QGdYYPYx4xn','pending'),(11730,'Palakumi Dispensary','qgE64yhjxkr','pending'),(11687,'Mwanda Dispensary','QKJ6fVUHJhT','pending'),(11609,'Midoina Dispensary','qMNc3YVyu0P','pending'),(11805,'Sosoni Dispensary','qNME55udR97','complete'),(11745,'Ndongo Purple Clinic','qnPQajuLKr7','pending'),(11715,'Ngomeni Health Centre (Magarini)','QO0aBp9JWPI','complete'),(18870,'Optimum Care Medical Clinic','QOgmD5WtQLd','pending'),(17966,'The Omari Project VCT Centre','qQv1jWzru0A','complete'),(20771,'Kambi Ya Waya Dispensary','Qv92hTqycLz','complete'),(11861,'Tudor Sub County Hospital','QXYRGaSfPBL','complete'),(11683,'Mwakirunge Dispensary','qypRrdcvLie','pending'),(11553,'Malanga (AIC) Dispensary','qZIiCNR0SIG','complete'),(28424,'Chibarani Dispensary','r0QVOCbx6Rp','pending'),(11600,'Mewa Hospital','r1TbCZwi10y','complete'),(11196,'Adc Danisa Dispensary','rdvu0VThvPb','pending'),(11534,'Madunguni Dispensary','RELmuAM0tcj','complete'),(11684,'Mwaluphamba Dispensary','RhP9ywU9c7a','pending'),(11625,'Mizijini Dispensary','rmc0r2tMXfk','pending'),(20453,'Magaoni Health Centre','roHvB9P8Of1','pending'),(11676,'Muhaka Dispensary','Rqy8p7UOvvx','pending'),(11365,'Divine Mercy Eldoro (Catholic) Dispensary','Rre94o5TeOh','complete'),(11244,'Baolala Dispensary','RrxywQuOoio','complete'),(11591,'Mbulia Dispensary','rwi0IMJ2HhP','pending'),(22479,'ICRH Drop In Centre (Kilifi)','rWIwO9kmzvi','complete'),(11536,'Mafisini Dispensary','RYumT9hJ8Ss','pending'),(11859,'Tsangatsini Dispensary','s2g4LbaNE2w','complete'),(11476,'Kilimangodo Dispensary','S6X2QNJUj2g','complete'),(17672,'Mbaga Dispensary','S9itqWWPUqs','pending'),(11300,'Dawson Mwanyumba Dispensary','S9YgBWSHUsN','complete'),(11299,'Dawida Maternity Nursing Home','sC3admN8uCC','pending'),(11679,'Mvita Dispensary','SkwAFqB5xbI','complete'),(11276,'Chakama Dispensary','SLGEop85px5','pending'),(11763,'Sagaighu Dispensary','SNCOL32lKCU','pending'),(11384,'Garashi Dispensary','SqO6tJoEOCP','complete'),(11862,'Tudor Health Care','Sr1PmoSNFhb','pending'),(11453,'Kakuyuni Dispensary (Malindi)','sS95RyqYQ0d','complete'),(11816,'St Hillarias Medical Clinic','T99iA0NKS3P','pending'),(16546,'Gombato Dispensary (CDF)','TfsKMWO3CEU','complete'),(11629,'Mkongani Health Centre','THNDq8DTAhT','pending'),(11538,'Magongo (MCM) Dispensary','ThT4PxgmYQL','pending'),(11656,'Msau Dispensary','TmUqDq9wyrW','pending'),(11547,'Makanzani Dispensary','toCFIFoLvvy','complete'),(11580,'Matsangoni Model Health Centre','ttGIIqGqFOt','complete'),(11437,'Jomvu Kuu (MCM) Dispensary','ttlDLtD7gUI','pending'),(23128,'Mwena Dispensary','Tuwzk3ENvM5','complete'),(11273,'Cdc Ganjoni Dispensary','tvYS6hl4l6l','pending'),(11440,'Joy Medical Clinic (Jomvu)','U1QrV9EjWvR','pending'),(11883,'Vitengeni Health Centre','u6txfT5EKDc','complete'),(11756,'Ribe Dispensary','UAANSI2ssxg','pending'),(11380,'Gahaleni Dispensary','uApzQdVcBRc','complete'),(11305,'Dida Dispensary','uCHPPTPXtBt','complete'),(11304,'Diani Health Centre','uhuTgMdpGDx','complete'),(11668,'Mtondia Medical Clinic','Um0p6ZhwWFP','pending'),(11652,'Mrughua Dispensary','uo1WH5pbibv','pending'),(11590,'Mbuguni Dispensary','UpSJbkTCmSw','pending'),(11472,'Kikoneni Health Centre','UrRsO2NsxHZ','complete'),(11797,'Singawa Medical Clinic','UuvEzG4s7rr','pending'),(16203,'Kiwalwa Dispensary','UVO6t17NAk5','complete'),(11237,'Bamba Sub County Hospital','UvWDhQlknid','complete'),(23695,'Bethany Dispensary','uWZStRB5zxs','pending'),(17114,'Rekeke Model Health Centre','UZUsQXKij1U','complete'),(11645,'Mother Amadea Health Centre','V8D1wDlLKTR','pending'),(11829,'Star Hospital','v8TZZfCfq38','complete'),(11615,'Mikindani Medical Clinic','vGh67T1wnv9','complete'),(11720,'Nyache Health Centre','vGsSZnuccgd','complete'),(22679,'Mtwapa Drop in and resource centre','VrQHTaPqMWP','complete'),(23368,'Kombani Mat clinic','vstve0ATifu','complete'),(16189,'Shangia Dispensary','vuTWdCN7s7K','pending'),(11691,'Mwangulu Dispensary','VVcbqmCinwl','complete'),(17763,'California Medical Clinic','VvCOSaPl5IR','pending'),(20300,'Mshongoleni Community Dispensary','VxqDZoryqi4','pending'),(11392,'Giriama Mission Dispensary','VXqTYwgQvHx','pending'),(11555,'Malindi Sub-County Hospital','vzRh9ON9ZsM','complete'),(11255,'Bomani Dispensary','w84mh8esInK','complete'),(11843,'Tawfiq Muslim Hospital','Wcgkpv2BHcy','complete'),(11906,'Wesu Sub County Hospital','wCSn2WNV6Gq','complete'),(11627,'Mkang\'ombe Dispensary','we0DUGyAhOI','complete'),(16547,'Kinondo Kwetu Community Clinic','wEmj5Y6nGNJ','complete'),(11620,'Miritini CDF Dispensary','WF04P1pRp2f','pending'),(11650,'Mpinzinyi Health Centre','Wftkk5ibasq','complete'),(25221,'Coast General Teaching and Referral Hospital Vikwatani Outreach Centre','wi1we3OlD7A','pending'),(11813,'St Elizabeth Medical Clinic Bakarani','wNjdLhsWlAS','pending'),(11289,'Coast General Teaching and Referral Hospital','WQBUBXxXVe5','pending'),(11390,'Ghazi Dispensary','wt82nplSMIL','pending'),(21258,'Mbita Dispensary','wXwH1HE5zBG','pending'),(11895,'Watamu Dispensary','X7X4kKtcy0H','complete'),(11774,'Sayyida Fatimah Hospital','XBVHcByduVe','pending'),(11525,'Lukore Dispensary','XeJ5kJzSBTR','complete'),(11370,'Family Medical Centre (Kisauni)','xeJN8pFmFkk','pending'),(11563,'Marereni Dispensary','xFk3GI5SCCl','complete'),(11528,'Maamba Medical Clinic','xfYcuLK2GfY','pending'),(11661,'Mt Harmony Clinic','XH4Hly3VogG','pending'),(11840,'Taveta Sub County Hospital','xlKQSUOfy0y','complete'),(11651,'Mrima (Catholic) Dispensary','xmDX1o9oBG3','complete'),(11854,'Tononoka Ap Dispensary (Tononoka)','XNC30RIDLbz','pending'),(11673,'Mtwapa Nursing Home','xO3P9qyihvm','complete'),(11789,'Shimoni Dispensary','xOIShowo1zr','complete'),(21539,'Konjora Dispensary','XrHTTd5zyjn','complete'),(23134,'Mtumwa Dispensary','XuM0h7o9wot','pending'),(11657,'Msikiti Noor Medical Clinic','Y7tjIU4DR2a','pending'),(11880,'Vigurungani Dispensary','Yb2CWS6G5vL','complete'),(20059,'Drop In Service Centre','yEgTXDKNOGK','complete'),(17911,'Kisauni Health Centre','YJtzYxZ8W75','pending'),(17775,'Consolata Sisters Timbwani  Dispensary (Stella Maris)','yLhTPeusK9l','pending'),(11839,'Tausa Health Centre','ynPfWsPSnEZ','complete'),(23752,'Mleghwa Dispensary','yOLZXnYLCeD','pending'),(16191,'Chalani Dispensary','YoVeKFPle8w','pending'),(11769,'Sangekoro Dispensary','YSsiUEshEly','pending'),(11442,'Judy Medical Clinic','YymiTkFWN6F','pending'),(11278,'Challa Dispensary','yz82FAm3ygB','complete'),(11439,'Jordan Medical Clinic','yZv0nIvtuNa','pending'),(18496,'Pendo Medical Clinic','Z08KIZqMqp7','pending'),(11491,'Kitobo Dispensary (Taveta)','z2ur5RpGme8','complete'),(11433,'Jilore Dispensary','zaTjgZjfqxe','pending'),(11613,'Mikindani (MCM) Dispensary','Zbiixb1PWrk','complete'),(11260,'Borabu Medical Clinic','zMZlZZkLMsd','pending'),(11578,'Matolani Dispensary','znBMfGldUnB','pending'),(11452,'Kakoneni Dispensary','ZNYPhRxeNRt','pending'),(11240,'Bamburi Medicare','ZosyfWIzXWl','pending'),(17928,'Perani clinic','zqNKCbQy3AJ','pending');
/*!40000 ALTER TABLE `facility_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-12 15:39:22
