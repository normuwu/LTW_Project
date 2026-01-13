-- =============================================
-- CẬP NHẬT BẢNG DOCTORS
-- Chạy file này để thêm các cột mới cho bảng doctors
-- =============================================

USE `petvaccine`;

-- Thêm các cột mới cho bảng doctors (nếu chưa có)
ALTER TABLE `doctors` 
ADD COLUMN IF NOT EXISTS `specialty` varchar(100) DEFAULT 'Đa khoa' AFTER `image`,
ADD COLUMN IF NOT EXISTS `phone` varchar(20) DEFAULT NULL AFTER `specialty`,
ADD COLUMN IF NOT EXISTS `email` varchar(100) DEFAULT NULL AFTER `phone`,
ADD COLUMN IF NOT EXISTS `work_schedule` varchar(255) DEFAULT NULL AFTER `email`,
ADD COLUMN IF NOT EXISTS `is_active` tinyint(1) DEFAULT 1 AFTER `work_schedule`,
ADD COLUMN IF NOT EXISTS `created_at` timestamp DEFAULT CURRENT_TIMESTAMP AFTER `is_active`;

-- Cập nhật dữ liệu mẫu cho doctors
UPDATE `doctors` SET 
    `specialty` = 'Nội khoa thú y',
    `phone` = '0901234567',
    `work_schedule` = 'Thứ 2-6: 8h-17h',
    `is_active` = 1
WHERE `id` = 1;

UPDATE `doctors` SET 
    `specialty` = 'Ngoại khoa thú y',
    `phone` = '0901234568',
    `work_schedule` = 'Thứ 2-7: 8h-12h',
    `is_active` = 1
WHERE `id` = 2;

UPDATE `doctors` SET 
    `specialty` = 'Tiêm chủng & Phòng bệnh',
    `phone` = '0901234569',
    `work_schedule` = 'Thứ 2-6: 13h-20h',
    `is_active` = 1
WHERE `id` = 3;

SELECT 'Đã cập nhật bảng doctors thành công!' AS message;
