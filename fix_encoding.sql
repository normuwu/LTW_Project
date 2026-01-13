-- =============================================
-- SCRIPT SỬA LỖI ENCODING TIẾNG VIỆT
-- Chạy file này trong MySQL Workbench hoặc command line
-- =============================================

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

USE `petvaccine`;

-- 1. Đảm bảo database sử dụng UTF-8
ALTER DATABASE `petvaccine` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Cập nhật encoding cho các bảng chính
ALTER TABLE `users` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `doctors` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `services` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `appointments` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `blogposts` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `products` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `features` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `careitems` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 3. Cập nhật encoding cho các bảng mới (nếu có)
ALTER TABLE `pets` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `vaccines` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `vaccination_records` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- =============================================
-- 4. SỬA DỮ LIỆU BỊ LỖI ENCODING (NẾU CÓ)
-- =============================================

-- Sửa services nếu bị lỗi
UPDATE `services` SET 
    `name` = 'Khám & Điều trị',
    `description` = 'Khám tổng quát và điều trị bệnh',
    `category` = 'Khám chữa bệnh'
WHERE `id` = 1;

UPDATE `services` SET 
    `name` = 'Phẫu thuật',
    `description` = 'Phẫu thuật các loại',
    `category` = 'Phẫu thuật'
WHERE `id` = 2;

UPDATE `services` SET 
    `name` = 'Tiêm phòng Vaccine',
    `description` = 'Tiêm vaccine phòng bệnh',
    `category` = 'Tiêm chủng'
WHERE `id` = 3;

UPDATE `services` SET 
    `name` = 'Spa & Làm đẹp',
    `description` = 'Tắm, cắt tỉa lông, làm đẹp',
    `category` = 'Spa & Grooming'
WHERE `id` = 4;

UPDATE `services` SET 
    `name` = 'Khách Sạn Thú Cưng',
    `description` = 'Gửi thú cưng qua đêm',
    `category` = 'Lưu trú'
WHERE `id` = 5;

-- Sửa vaccines nếu bị lỗi
UPDATE `vaccines` SET 
    `name` = 'Vaccine 5 bệnh chó (5in1)',
    `description` = 'Phòng Care, Parvo, Viêm gan, Ho cũi, Phó cúm',
    `target_species` = 'Chó'
WHERE `id` = 1;

UPDATE `vaccines` SET 
    `name` = 'Vaccine 7 bệnh chó (7in1)',
    `description` = 'Phòng 5 bệnh + Lepto + Corona',
    `target_species` = 'Chó'
WHERE `id` = 2;

UPDATE `vaccines` SET 
    `name` = 'Vaccine dại (Rabisin)',
    `description` = 'Phòng bệnh dại cho chó mèo',
    `target_species` = 'Tất cả'
WHERE `id` = 3;

UPDATE `vaccines` SET 
    `name` = 'Vaccine 3 bệnh mèo (FVRCP)',
    `description` = 'Phòng Viêm mũi khí quản, Calici, Giảm bạch cầu',
    `target_species` = 'Mèo'
WHERE `id` = 4;

UPDATE `vaccines` SET 
    `name` = 'Vaccine 4 bệnh mèo (FVRCP+FeLV)',
    `description` = 'Phòng 3 bệnh + Bạch cầu mèo',
    `target_species` = 'Mèo'
WHERE `id` = 5;

UPDATE `vaccines` SET 
    `name` = 'Vaccine Lepto (Leptospirosis)',
    `description` = 'Phòng bệnh Lepto cho chó',
    `target_species` = 'Chó'
WHERE `id` = 6;

UPDATE `vaccines` SET 
    `name` = 'Vaccine KC (Kennel Cough)',
    `description` = 'Phòng ho cũi cho chó',
    `target_species` = 'Chó'
WHERE `id` = 7;

-- Sửa doctors specialty
UPDATE `doctors` SET `specialty` = 'Đa khoa' WHERE `specialty` IS NULL OR `specialty` = '';
UPDATE `doctors` SET `specialty` = 'Nội khoa thú y' WHERE `id` = 1;
UPDATE `doctors` SET `specialty` = 'Ngoại khoa thú y' WHERE `id` = 2;
UPDATE `doctors` SET `specialty` = 'Tiêm chủng & Phòng bệnh' WHERE `id` = 3;

-- Sửa pets
UPDATE `pets` SET 
    `species` = 'Chó',
    `gender` = 'Cái'
WHERE `id` = 1;

UPDATE `pets` SET 
    `species` = 'Mèo',
    `gender` = 'Đực'
WHERE `id` = 2;

-- Sửa vaccination_records notes
UPDATE `vaccination_records` SET `notes` = 'Mũi 1 - Phản ứng bình thường' WHERE `id` = 1;
UPDATE `vaccination_records` SET `notes` = 'Mũi 2 - Tốt' WHERE `id` = 2;
UPDATE `vaccination_records` SET `notes` = 'Mũi 3 - Hoàn thành liệu trình' WHERE `id` = 3;
UPDATE `vaccination_records` SET `notes` = 'Tiêm dại lần đầu' WHERE `id` = 4;
UPDATE `vaccination_records` SET `notes` = 'Mũi 1 vaccine mèo' WHERE `id` = 5;
UPDATE `vaccination_records` SET `notes` = 'Mũi 2 - Hoàn thành' WHERE `id` = 6;

-- =============================================
-- 5. KIỂM TRA KẾT QUẢ
-- =============================================
SELECT 'Kiểm tra Services:' AS '';
SELECT id, name, category FROM services;

SELECT 'Kiểm tra Vaccines:' AS '';
SELECT id, name, target_species FROM vaccines;

SELECT 'Kiểm tra Doctors:' AS '';
SELECT id, name, specialty FROM doctors LIMIT 5;

SELECT 'Kiểm tra Pets:' AS '';
SELECT id, name, species, gender FROM pets;

SELECT 'Đã sửa encoding thành công!' AS message;
