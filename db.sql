CREATE DATABASE  IF NOT EXISTS `petvaccine` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `petvaccine`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: petvaccine
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blogposts`
--

DROP TABLE IF EXISTS `blogposts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogposts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_date` varchar(50) DEFAULT NULL,
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogposts`
--

LOCK TABLES `blogposts` WRITE;
/*!40000 ALTER TABLE `blogposts` DISABLE KEYS */;
INSERT INTO `blogposts` VALUES (1,'5 Dấu hiệu nhận biết mèo đang bị stress','blog1.jpg','Tâm lý thú cưng','19/12/2025','Bs. Ngọc Thành','Mèo là loài động vật nhạy cảm. Thay đổi môi trường sống hoặc tiếng ồn lớn có thể khiến chúng bị stress nặng. Hãy cùng tìm hiểu các dấu hiệu...'),(2,'Lịch tiêm phòng đầy đủ cho cún con từ A-Z','blog2.jpg','Sức khỏe','18/12/2025','Bs. Huyền Trang','Tiêm vaccine là cách tốt nhất để bảo vệ cún cưng khỏi các bệnh nguy hiểm như Care, Parvo. Đừng bỏ lỡ các mốc thời gian vàng này nhé.'),(3,'Review các loại cát vệ sinh tốt nhất hiện nay','blog3.jpg','Review Sản phẩm','15/12/2025','Admin','Cát đất sét, cát gỗ hay cát đậu nành? Loại nào khử mùi tốt nhất và tiết kiệm nhất? Bài viết này sẽ giúp bạn chọn được loại cát chân ái.'),(4,'Câu chuyện cảm động về chú chó Hachiko','blog4.jpg','Chuyện bên lề','10/12/2025','Sưu tầm','Lòng trung thành của loài chó luôn là điều khiến con người rơi nước mắt. Cùng đọc lại câu chuyện kinh điển về Hachiko đợi chủ.'),(5,'Chế độ dinh dưỡng cho mèo bị sỏi thận','blog5.jpg','Dinh dưỡng','05/12/2025','Bs. Mai Phạm','Mèo bị sỏi thận cần kiêng ăn gì? Tại sao nên cho ăn nhiều thức ăn ướt hơn hạt khô? Lời khuyên từ chuyên gia dinh dưỡng.'),(6,'Top 10 loại thực phẩm của người TUYỆT ĐỐI không cho chó mèo ăn','blog6.jpg','Dinh dưỡng','01/12/2025','Bs. Ngọc Thành','Socola, hành tây, nho... là những món ăn quen thuộc với con người nhưng lại là thuốc độc với thú cưng. Cùng điểm danh để tránh xa nhé.'),(7,'Ve, rận và bọ chét: Kẻ thù thầm lặng và cách tiêu diệt tận gốc','blog7.jpg','Sức khỏe','28/11/2025','Bs. Sterenn Genewe','Mùa ẩm ướt là thời điểm ve rận sinh sôi mạnh nhất. Chúng không chỉ gây ngứa mà còn truyền ký sinh trùng máu nguy hiểm. Đây là giải pháp cho bạn.'),(8,'Sốc nhiệt ở chó: Dấu hiệu nhận biết và cách sơ cứu khẩn cấp','blog8.jpg','Cấp cứu','25/11/2025','Bs. Mai Phạm','Chó không thể toát mồ hôi như người. Khi nhiệt độ tăng cao, sốc nhiệt có thể cướp đi tính mạng cún cưng chỉ trong vài phút. Hãy học cách sơ cứu ngay.'),(9,'Hướng dẫn cắt móng cho mèo tại nhà mà không bị \"hoàng thượng\" cào','blog9.jpg','Chăm sóc','20/11/2025','Admin','Việc cắt móng cho mèo thường là cuộc chiến đẫm máu. Bài viết này sẽ chia sẻ mẹo nhỏ giúp mèo ngoan ngoãn nằm im cho bạn cắt tỉa.'),(10,'Tại sao chó sủa nhiều? Bí quyết huấn luyện để giảm tiếng ồn','blog10.jpg','Huấn luyện','15/11/2025','Huấn luyện viên','Chó sủa khi có người lạ, sủa khi ở một mình hay sủa vì đòi ăn? Hiểu rõ nguyên nhân sẽ giúp bạn có phương pháp điều chỉnh hành vi hiệu quả.'),(11,'Giải mã tiếng \"Grừ..ừ\" (Purr) bí ẩn của loài mèo','blog11.jpg','Chuyện bên lề','10/11/2025','Sưu tầm','Mèo rừ khi vui, nhưng đôi khi cũng rừ khi đau đớn. Tần số tiếng rừ của mèo còn được chứng minh là có khả năng chữa lành xương khớp.'),(12,'Nên nuôi mèo trong nhà hay thả rông? Lợi ích và rủi ro','blog12.jpg','Góc nhìn','05/11/2025','Bs. Quốc Trí','Tranh cãi muôn thuở của cộng đồng yêu mèo. Nuôi trong nhà thì an toàn nhưng sợ mèo buồn? Thả rông thì tự do nhưng nhiều nguy hiểm?');
/*!40000 ALTER TABLE `blogposts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `careitems`
--

DROP TABLE IF EXISTS `careitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `careitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `careitems`
--

LOCK TABLES `careitems` WRITE;
/*!40000 ALTER TABLE `careitems` DISABLE KEYS */;
INSERT INTO `careitems` VALUES (1,'Đồng hành cùng với bạn','<p>Thú cưng của bạn không thể cho chúng ta biết bất cứ điều gì về cuộc sống hoặc các triệu chứng của các bé. Đó là lý do tại sao dịch vụ chăm sóc thú cưng của ADI bắt đầu bằng việc xây dựng mối quan hệ chặt chẽ giữa bác sĩ thú y và những người chủ</p><p>Vì vậy, ưu tiên hàng đầu của chúng tôi là lắng nghe những người chủ vật nuôi và hợp tác chặt chẽ để cùng nhau mang đến cho những người bạn đồng hành thân yêu của mình một cuộc sống hạnh phúc và khỏe mạnh hơn.</p>'),(2,'Trung thực và minh bạch','<p>Là cha mẹ của các bé, bạn hoàn toàn có quyền minh bạch về mọi thứ liên quan đến chăm sóc y tế cho thú cưng của bạn. Đó là lý do tại sao ADI muốn bạn tham gia vào mọi quyết định liên quan đến việc điều trị cho thú cưng của bạn.</p>'),(3,'Nguyên tắc tảng băng trôi','<p>Phần lớn những gì đặc trưng cho các tiêu chuẩn chăm sóc cao của chúng tôi diễn ra ở hậu trường và do đó khách hàng của chúng tôi không nhìn thấy được.</p>'),(4,'Mục Tiêu','<p>Mọi thứ chúng tôi đề xuất cho thú cưng của bạn là kết quả của quá trình nghiên cứu, cống hiến và chuyên môn tuyệt vời để đảm bảo rằng mọi phương pháp điều trị đều mang lại lợi ích tốt nhất cho thú cưng của bạn.</p>'),(5,'Kỹ thuật xuất sắc','<p>Thú y không chỉ là công việc kinh doanh của chúng tôi. Sức khỏe và phúc lợi động vật là sứ mệnh và niềm đam mê của Animal Doctors International. Thú cưng của bạn là ưu tiên hàng đầu của chúng tôi tại đây.</p><p>Chúng tôi cam kết với đội ngũ bác sĩ thú y có trình độ chuyên môn cao, đội ngũ nhân viên hỗ trợ chuyên nghiệp sẽ giúp cho thú cưng của bạn có được một sức khoẻ tốt nhất.</p>'),(6,'Cách tiếp cận phù hợp','<p>Tại ADI, chúng tôi nhận ra rằng mỗi thú cưng đều có nhu cầu, thói quen và lối sống riêng. Vì vậy, mọi thứ chúng tôi làm cho thú cưng của bạn đều phù hợp với nhu cầu cá nhân của chúng.</p>'),(7,'Công tác đào tạo','<p>Chúng tôi đầu tư vào việc liên tục đào tạo cho các bác sĩ thú y của mình để giúp họ theo kịp những phát triển mới nhất trong ngành thú y. Việc cập nhật liên tục giữ cho kiến ​​thức và kỹ năng của bác sĩ thú y của chúng tôi ở đẳng cấp thế giới.</p><p>Một phòng khám thú ý tốt không chỉ riêng bác sĩ thú y giỏi mà còn nhờ có một đội ngũ xuất sắc phía sau. Nhân viên hỗ trợ của chúng tôi được đào tạo chuyên sâu để liên tục duy trì mức độ xuất sắc.</p>');
/*!40000 ALTER TABLE `careitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `specialty` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `work_schedule` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Bác sĩ Ngọc Thành','webpic14.jpg','Nội khoa','0901111111','ngocthanh@petvaccine.com','Thứ 2-6: 8h-17h',1,NOW()),(2,'Bác sĩ Huyền Trang','webpic15.jpg','Ngoại khoa','0901111112','huyentrang@petvaccine.com','Thứ 2-6: 8h-17h',1,NOW()),(3,'Bác sĩ Sterenn Genewe','webpic16.jpg','Da liễu','0901111113','sterenn@petvaccine.com','Thứ 3,5,7: 9h-18h',1,NOW()),(4,'Bác sĩ Mai Phạm','webpic17.jpg','Dinh dưỡng','0901111114','maipham@petvaccine.com','Thứ 2-6: 8h-17h',1,NOW()),(5,'Bác sĩ Sterenn Genewe','webpic18.jpg','Phẫu thuật','0901111115','sterenn2@petvaccine.com','Thứ 2,4,6: 8h-17h',1,NOW()),(6,'Bác sĩ Quốc Trí','webpic19.jpg','Nội khoa','0901111116','quoctri@petvaccine.com','Thứ 2-7: 8h-12h',1,NOW()),(7,'Bác sĩ Emily Davis','webpic20.jpg','Tiêm chủng','0901111117','emily@petvaccine.com','Thứ 2-6: 8h-17h',1,NOW()),(8,'Bác sĩ Michael Brown','webpic21.jpg','Ngoại khoa','0901111118','michael@petvaccine.com','Thứ 2-6: 13h-20h',1,NOW()),(9,'Bác sĩ Jessica Wilson','webpic22.jpg','Nha khoa','0901111119','jessica@petvaccine.com','Thứ 3,5,7: 8h-17h',1,NOW()),(10,'Bác sĩ Ngọc Linh','webpic23.jpg','Siêu âm','0901111120','ngoclinh@petvaccine.com','Thứ 2-6: 8h-17h',1,NOW()),(11,'Bác sĩ Hoàng Long','webpic24.jpg','Xét nghiệm','0901111121','hoanglong@petvaccine.com','Thứ 2-7: 7h-15h',1,NOW()),(12,'Bác sĩ Thanh Thảo','webpic25.jpg','Cấp cứu','0901111122','thanhthao@petvaccine.com','24/7',1,NOW());
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features` (
  `id` int NOT NULL AUTO_INCREMENT,
  `icon` varchar(100) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,'bx bxs-graduation','Đội ngũ chuyên gia quốc tế','Các bác sĩ được đào tạo bài bản từ các trường đại học danh tiếng.'),(2,'bx bxs-heart','Chăm sóc bằng cả trái tim','Chúng tôi đối xử với thú cưng của bạn như chính thú cưng của mình.'),(3,'bx bxs-first-aid','Trang thiết bị tối tân','Hệ thống máy móc chẩn đoán hình ảnh và xét nghiệm hiện đại nhất.');
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(18,0) DEFAULT NULL,
  `old_price` decimal(18,0) DEFAULT '0',
  `discount` int DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Thức Ăn Hạt Cho Mèo Trưởng Thành Nuôi Trong Nhà Royal Canin Indoor 27','prod_royal1.jpg',132000,0,0,'Thức ăn hạt cao cấp dành cho mèo trưởng thành nuôi trong nhà'),(2,'Thức Ăn Hạt Cho Mèo Con Royal Canin Kitten 36','prod_royal2.jpg',135000,0,0,'Thức ăn hạt dinh dưỡng cho mèo con từ 4-12 tháng tuổi'),(3,'Thức Ăn Hạt Cho Mèo Sỏi Thận Royal Canin Urinary S/O','prod_royal3.jpg',185000,0,0,'Thức ăn chuyên dụng hỗ trợ điều trị sỏi thận cho mèo'),(4,'Pate Cho Mèo Trưởng Thành Royal Canin Instinctive 85g','prod_royal4.jpg',27000,34000,20,'Pate thơm ngon cho mèo trưởng thành'),(5,'Pate Cho Mèo Con Royal Canin Kitten Instinctive 85g','prod_royal5.jpg',30000,0,0,'Pate dinh dưỡng cho mèo con');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'petvaccine'
--

--
-- Dumping routines for database 'petvaccine'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-21 23:14:24


-- =============================================
-- BẢNG USERS CHO TÍNH NĂNG ĐĂNG NHẬP
-- =============================================

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` varchar(20) DEFAULT 'user',
  `status` varchar(20) DEFAULT 'active',
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Thêm tài khoản demo
INSERT INTO `users` (`username`, `password`, `fullname`, `email`, `role`, `status`, `phone`, `address`) VALUES
('admin', 'Admin@123', 'Quản trị viên', 'admin@gmail.com', 'admin', 'active', '0901234567', 'Số 1 Đường ABC, Quận 1, TP.HCM'),
('doctor1', '123456', 'Bác sĩ Ngọc Thành', 'doctor1@petvaccine.com', 'doctor', 'active', '0902345678', 'Số 2 Đường XYZ, Quận 2, TP.HCM'),
('user1', 'Thanh@123', 'Nguyễn Văn A', 'user1@gmail.com', 'user', 'active', '0904567890', 'Số 10 Nguyễn Huệ, Quận 1, TP.HCM');


-- =============================================
-- BẢNG SERVICES (DỊCH VỤ)
-- =============================================

DROP TABLE IF EXISTS `services`;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` varchar(100) DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'Khám chữa bệnh',
  `duration_minutes` int DEFAULT 30,
  `is_active` tinyint(1) DEFAULT 1,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `services` (`id`, `name`, `price`, `description`, `category`, `duration_minutes`, `is_active`) VALUES
(1, 'Khám & Điều trị', '150,000đ', 'Khám tổng quát và điều trị bệnh', 'Khám chữa bệnh', 30, 1),
(2, 'Phẫu thuật', 'Theo ca', 'Phẫu thuật các loại', 'Phẫu thuật', 120, 1),
(3, 'Tiêm phòng Vaccine', 'Tùy loại', 'Tiêm vaccine phòng bệnh', 'Tiêm chủng', 15, 1),
(4, 'Spa & Làm đẹp', '350,000đ', 'Tắm, cắt tỉa lông, làm đẹp', 'Spa & Grooming', 60, 1),
(5, 'Khách Sạn Thú Cưng', '200,000đ/ngày', 'Gửi thú cưng qua đêm', 'Lưu trú', 1440, 1);

-- =============================================
-- BẢNG APPOINTMENTS (LỊCH HẸN)
-- =============================================

DROP TABLE IF EXISTS `appointments`;
CREATE TABLE `appointments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `customer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) NOT NULL,
  `pet_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `pet_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'Chó',
  `service_id` int DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `booking_date` date NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `status` varchar(50) DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `service_id` (`service_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `user_id` (`user_id`),
  FOREIGN KEY (`service_id`) REFERENCES `services`(`id`),
  FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Thêm dữ liệu mẫu cho appointments (user_id = 2 là user1)
INSERT INTO `appointments` (`user_id`, `customer_name`, `phone`, `pet_name`, `pet_type`, `service_id`, `doctor_id`, `booking_date`, `note`, `status`) VALUES
(2, 'Nguyễn Văn A', '0112233445', 'kiki', 'Chó', 1, 1, '2025-12-24', 'Khám sức khỏe tổng quát', 'Pending'),
(2, 'Nguyễn Văn A', '0112233445', 'kiki', 'Mèo', 1, 1, '2025-12-24', 'Khám lại sau điều trị', 'Confirmed'),
(NULL, 'Phạm Văn B', '0112233442', 'mx', 'Mèo', 3, 12, '2026-01-09', 'Tiêm vaccine định kỳ', 'Pending');

-- =============================================
-- BẢNG VACCINES (Vaccine)
-- =============================================

DROP TABLE IF EXISTS `vaccines`;
CREATE TABLE `vaccines` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `target_species` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `manufacturer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `price` decimal(18,0) DEFAULT NULL,
  `doses_required` int DEFAULT 1,
  `interval_days` int DEFAULT NULL,
  `min_age_weeks` int DEFAULT NULL,
  `stock_quantity` int DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Thêm dữ liệu mẫu vaccines
INSERT INTO `vaccines` (`name`, `description`, `target_species`, `manufacturer`, `price`, `doses_required`, `interval_days`, `min_age_weeks`, `stock_quantity`, `is_active`) VALUES
('Vaccine 5 bệnh chó (5in1)', 'Phòng Care, Parvo, Viêm gan, Ho cũi, Phó cúm', 'Chó', 'Nobivac', 250000, 3, 21, 6, 100, 1),
('Vaccine 7 bệnh chó (7in1)', 'Phòng 5 bệnh + Lepto + Corona', 'Chó', 'Vanguard Plus', 350000, 3, 21, 8, 80, 1),
('Vaccine dại (Rabisin)', 'Phòng bệnh dại cho chó mèo', 'Tất cả', 'Merial', 150000, 1, 365, 12, 150, 1),
('Vaccine 4 bệnh mèo (FVRCP)', 'Phòng Viêm mũi, Calici, Panleukopenia', 'Mèo', 'Felocell', 280000, 2, 28, 8, 60, 1),
('Vaccine FeLV (Bạch cầu mèo)', 'Phòng virus gây bạch cầu ở mèo', 'Mèo', 'Purevax', 320000, 2, 21, 8, 40, 1);

-- =============================================
-- BẢNG PETS (Thú cưng)
-- =============================================

DROP TABLE IF EXISTS `pets`;
CREATE TABLE `pets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `species` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `breed` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `gender` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Thêm dữ liệu mẫu pets
INSERT INTO `pets` (`user_id`, `name`, `species`, `breed`, `gender`, `birth_date`, `weight`, `color`, `image`, `notes`) VALUES
(3, 'Lucky', 'Chó', 'Golden Retriever', 'Đực', '2023-03-15', 25.50, 'Vàng', 'pet_golden.jpg', 'Rất thân thiện, thích chơi bóng'),
(3, 'Miu Miu', 'Mèo', 'Mèo Anh lông ngắn', 'Cái', '2024-01-20', 4.20, 'Xám xanh', 'pet_british.jpg', 'Nhát người, cần chăm sóc nhẹ nhàng');

-- =============================================
-- BẢNG VACCINATION_RECORDS (Lịch sử tiêm chủng)
-- =============================================

DROP TABLE IF EXISTS `vaccination_records`;
CREATE TABLE `vaccination_records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pet_id` int DEFAULT NULL,
  `vaccine_id` int DEFAULT NULL,
  `appointment_id` int DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `vaccination_date` date NOT NULL,
  `dose_number` int DEFAULT 1,
  `batch_number` varchar(50) DEFAULT NULL,
  `next_due_date` date DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pet_id` (`pet_id`),
  KEY `vaccine_id` (`vaccine_id`),
  KEY `appointment_id` (`appointment_id`),
  KEY `doctor_id` (`doctor_id`),
  FOREIGN KEY (`pet_id`) REFERENCES `pets`(`id`),
  FOREIGN KEY (`vaccine_id`) REFERENCES `vaccines`(`id`),
  FOREIGN KEY (`appointment_id`) REFERENCES `appointments`(`id`),
  FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Thêm dữ liệu mẫu vaccination_records
INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `appointment_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) VALUES
(1, 1, NULL, 1, '2023-05-15', 1, 'NB2023051501', '2023-06-05', 'Mũi 1 vaccine 5 bệnh'),
(1, 3, NULL, 2, '2023-07-15', 1, 'RB2023071501', '2024-07-15', 'Vaccine dại'),
(2, 4, NULL, 2, '2024-03-20', 1, 'FC2024032001', '2024-04-17', 'Mũi 1 vaccine 4 bệnh mèo');

-- =============================================
-- BẢNG HOTEL_BOOKINGS (Đặt phòng khách sạn)
-- =============================================

DROP TABLE IF EXISTS `hotel_bookings`;
CREATE TABLE `hotel_bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `customer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) NOT NULL,
  `pet_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `pet_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `pet_weight` varchar(50) DEFAULT NULL,
  `room_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `extra_services` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `total_nights` int DEFAULT NULL,
  `total_price` decimal(18,0) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Thêm dữ liệu mẫu hotel_bookings
INSERT INTO `hotel_bookings` (`user_id`, `customer_name`, `phone`, `pet_name`, `pet_type`, `pet_weight`, `room_type`, `check_in_date`, `check_out_date`, `extra_services`, `note`, `total_nights`, `total_price`, `status`) VALUES
(3, 'Nguyễn Văn A', '0904567890', 'Miu Miu', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-01-20', '2026-01-23', 'Chế độ ăn cao cấp (+50.000đ/ngày)', 'Bé nhát người', 3, 600000, 'Confirmed'),
(NULL, 'Nguyễn Thị Hương', '0916789012', 'Mèo Mập', 'Mèo', 'Trên 5kg', 'Phòng VIP (> 5kg) - 250.000đ/ngày', '2026-01-18', '2026-01-20', NULL, NULL, 2, 500000, 'Pending');

-- =============================================
-- BẢNG SPA_BOOKINGS (Đặt lịch Spa)
-- =============================================

DROP TABLE IF EXISTS `spa_bookings`;
CREATE TABLE `spa_bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `customer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) NOT NULL,
  `pet_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `pet_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `spa_package` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `booking_date` date NOT NULL,
  `preferred_time` varchar(50) DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `price` decimal(18,0) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Thêm dữ liệu mẫu spa_bookings
INSERT INTO `spa_bookings` (`user_id`, `customer_name`, `phone`, `pet_name`, `pet_type`, `spa_package`, `booking_date`, `preferred_time`, `note`, `price`, `status`) VALUES
(3, 'Nguyễn Văn A', '0904567890', 'Lucky', 'Chó', 'Cắt tỉa toàn thân (> 5kg) - 500.000đ', '2026-01-18', 'Sáng (9h-12h)', 'Cắt kiểu Teddy bear', 500000, 'Confirmed'),
(NULL, 'Trần Văn Phúc', '0925678901', 'Milo', 'Chó', 'Tắm vệ sinh (< 5kg) - 150.000đ', '2026-01-25', 'Chiều (14h-17h)', 'Chó con 4 tháng', 150000, 'Pending');

-- =============================================
-- BẢNG CART (Giỏ hàng)
-- =============================================

DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT 1,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Thêm dữ liệu mẫu cart
INSERT INTO `cart` (`user_id`, `product_id`, `quantity`) VALUES
(3, 1, 2),
(3, 2, 1),
(3, 4, 3);

-- =============================================
-- BẢNG REVIEWS (Đánh giá sản phẩm)
-- =============================================

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Thêm dữ liệu mẫu reviews
INSERT INTO `reviews` (`product_id`, `user_id`, `rating`, `comment`) VALUES
(1, 3, 5, 'Sản phẩm rất tốt, mèo nhà mình rất thích ăn. Lông mượt hẳn sau 2 tuần sử dụng.'),
(2, 3, 5, 'Mèo con nhà mình lớn nhanh và khỏe mạnh nhờ loại hạt này.');
