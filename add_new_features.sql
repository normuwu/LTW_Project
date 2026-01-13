-- =============================================
-- THÊM CÁC BẢNG MỚI CHO HỆ THỐNG TIÊM CHỦNG
-- Chạy file này sau khi đã có database petvaccine
-- =============================================

USE `petvaccine`;

-- =============================================
-- 1. BẢNG PETS (THÚ CƯNG CỦA USER)
-- =============================================
DROP TABLE IF EXISTS `pets`;
CREATE TABLE `pets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `species` varchar(50) DEFAULT 'Chó',
  `breed` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `gender` varchar(10) DEFAULT 'Đực',
  `birth_date` date DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dữ liệu mẫu cho pets
INSERT INTO `pets` (`user_id`, `name`, `species`, `breed`, `gender`, `birth_date`, `weight`, `color`, `notes`) VALUES
(2, 'Kiki', 'Chó', 'Poodle', 'Cái', '2023-05-15', 4.5, 'Trắng', 'Rất ngoan và thích chơi bóng'),
(2, 'Miu', 'Mèo', 'Mèo Anh lông ngắn', 'Đực', '2022-08-20', 5.2, 'Xám', 'Thích ngủ và ăn cá');

-- =============================================
-- 2. BẢNG VACCINES (DANH MỤC VACCINE)
-- =============================================
DROP TABLE IF EXISTS `vaccines`;
CREATE TABLE `vaccines` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `target_species` varchar(50) DEFAULT 'Tất cả',
  `manufacturer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `price` decimal(18,0) DEFAULT 0,
  `doses_required` int DEFAULT 1,
  `interval_days` int DEFAULT 21,
  `min_age_weeks` int DEFAULT 6,
  `stock_quantity` int DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dữ liệu mẫu cho vaccines
INSERT INTO `vaccines` (`name`, `description`, `target_species`, `manufacturer`, `price`, `doses_required`, `interval_days`, `min_age_weeks`, `stock_quantity`) VALUES
('Vaccine 5 bệnh chó (5in1)', 'Phòng Care, Parvo, Viêm gan, Ho cũi, Phó cúm', 'Chó', 'Nobivac', 250000, 3, 21, 6, 50),
('Vaccine 7 bệnh chó (7in1)', 'Phòng 5 bệnh + Lepto + Corona', 'Chó', 'Vanguard Plus', 350000, 3, 21, 8, 30),
('Vaccine dại (Rabisin)', 'Phòng bệnh dại cho chó mèo', 'Tất cả', 'Merial', 150000, 1, 365, 12, 100),
('Vaccine 3 bệnh mèo (FVRCP)', 'Phòng Viêm mũi khí quản, Calici, Giảm bạch cầu', 'Mèo', 'Felocell', 200000, 2, 28, 8, 40),
('Vaccine 4 bệnh mèo (FVRCP+FeLV)', 'Phòng 3 bệnh + Bạch cầu mèo', 'Mèo', 'Purevax', 300000, 2, 28, 8, 25),
('Vaccine Lepto (Leptospirosis)', 'Phòng bệnh Lepto cho chó', 'Chó', 'Nobivac Lepto', 180000, 2, 21, 12, 35),
('Vaccine KC (Kennel Cough)', 'Phòng ho cũi cho chó', 'Chó', 'Nobivac KC', 200000, 1, 365, 8, 20);

-- =============================================
-- 3. BẢNG VACCINATION_RECORDS (LỊCH SỬ TIÊM CHỦNG)
-- =============================================
DROP TABLE IF EXISTS `vaccination_records`;
CREATE TABLE `vaccination_records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pet_id` int NOT NULL,
  `vaccine_id` int NOT NULL,
  `appointment_id` int DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `vaccination_date` date NOT NULL,
  `dose_number` int DEFAULT 1,
  `batch_number` varchar(50) DEFAULT NULL,
  `next_due_date` date DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pet_id` (`pet_id`),
  KEY `vaccine_id` (`vaccine_id`),
  KEY `appointment_id` (`appointment_id`),
  KEY `doctor_id` (`doctor_id`),
  FOREIGN KEY (`pet_id`) REFERENCES `pets`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`vaccine_id`) REFERENCES `vaccines`(`id`),
  FOREIGN KEY (`appointment_id`) REFERENCES `appointments`(`id`) ON DELETE SET NULL,
  FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dữ liệu mẫu cho vaccination_records
INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) VALUES
(1, 1, 1, '2023-07-01', 1, 'NB2023001', '2023-07-22', 'Mũi 1 - Phản ứng bình thường'),
(1, 1, 1, '2023-07-22', 2, 'NB2023002', '2023-08-12', 'Mũi 2 - Tốt'),
(1, 1, 2, '2023-08-12', 3, 'NB2023003', '2024-08-12', 'Mũi 3 - Hoàn thành liệu trình'),
(1, 3, 1, '2023-09-01', 1, 'RB2023001', '2024-09-01', 'Tiêm dại lần đầu'),
(2, 4, 3, '2022-10-15', 1, 'FC2022001', '2022-11-12', 'Mũi 1 vaccine mèo'),
(2, 4, 3, '2022-11-12', 2, 'FC2022002', '2023-11-12', 'Mũi 2 - Hoàn thành');

-- =============================================
-- 4. CẬP NHẬT BẢNG SERVICES (THÊM THÔNG TIN CHI TIẾT)
-- =============================================
ALTER TABLE `services` 
ADD COLUMN `category` varchar(50) DEFAULT 'Khám chữa bệnh' AFTER `description`,
ADD COLUMN `duration_minutes` int DEFAULT 30 AFTER `category`,
ADD COLUMN `is_active` tinyint(1) DEFAULT 1 AFTER `duration_minutes`,
ADD COLUMN `image` varchar(255) DEFAULT NULL AFTER `is_active`;

-- Cập nhật dữ liệu services
UPDATE `services` SET `category` = 'Khám chữa bệnh', `duration_minutes` = 30 WHERE `id` = 1;
UPDATE `services` SET `category` = 'Phẫu thuật', `duration_minutes` = 120 WHERE `id` = 2;
UPDATE `services` SET `category` = 'Tiêm chủng', `duration_minutes` = 15 WHERE `id` = 3;
UPDATE `services` SET `category` = 'Spa & Grooming', `duration_minutes` = 60 WHERE `id` = 4;
UPDATE `services` SET `category` = 'Lưu trú', `duration_minutes` = 1440 WHERE `id` = 5;

-- Thêm thêm dịch vụ
INSERT INTO `services` (`name`, `price`, `description`, `category`, `duration_minutes`) VALUES
('Xét nghiệm máu', '300,000đ', 'Xét nghiệm công thức máu, sinh hóa', 'Xét nghiệm', 20),
('Siêu âm', '250,000đ', 'Siêu âm ổ bụng, tim', 'Chẩn đoán hình ảnh', 30),
('X-Quang', '200,000đ', 'Chụp X-quang các vùng', 'Chẩn đoán hình ảnh', 20),
('Triệt sản', '1,500,000đ', 'Phẫu thuật triệt sản chó mèo', 'Phẫu thuật', 90),
('Cạo vôi răng', '400,000đ', 'Làm sạch răng, cạo vôi', 'Nha khoa', 45);

-- =============================================
-- 5. THÊM CỘT CHO BẢNG APPOINTMENTS
-- =============================================
ALTER TABLE `appointments`
ADD COLUMN `pet_id` int DEFAULT NULL AFTER `user_id`,
ADD COLUMN `vaccine_id` int DEFAULT NULL AFTER `service_id`;

-- Thêm foreign key
ALTER TABLE `appointments`
ADD FOREIGN KEY (`pet_id`) REFERENCES `pets`(`id`) ON DELETE SET NULL,
ADD FOREIGN KEY (`vaccine_id`) REFERENCES `vaccines`(`id`) ON DELETE SET NULL;

-- =============================================
-- HOÀN TẤT
-- =============================================
SELECT 'Đã thêm các bảng mới thành công!' AS message;
