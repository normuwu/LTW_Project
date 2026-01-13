-- =============================================
-- BẢNG HOTEL_BOOKINGS (ĐẶT PHÒNG KHÁCH SẠN THÚ CƯNG)
-- =============================================

DROP TABLE IF EXISTS `hotel_bookings`;
CREATE TABLE `hotel_bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `customer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) NOT NULL,
  `pet_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pet_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Mèo',
  `pet_weight` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `extra_services` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `total_nights` int DEFAULT 1,
  `total_price` decimal(18,0) DEFAULT 0,
  `status` varchar(50) DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dữ liệu mẫu cho hotel_bookings
INSERT INTO `hotel_bookings` (`user_id`, `customer_name`, `phone`, `pet_name`, `pet_type`, `pet_weight`, `room_type`, `check_in_date`, `check_out_date`, `extra_services`, `note`, `total_nights`, `total_price`, `status`) VALUES
(NULL, 'Nguyễn Văn A', '0112233445', 'Miu Miu', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-01-20', '2026-01-23', 'Chế độ ăn cao cấp (+50.000đ/ngày)', 'Bé nhát người, cần phòng yên tĩnh', 3, 600000, 'Confirmed'),
(NULL, 'Nguyễn Văn A', '0112233445', 'Lucky', 'Mèo', 'Trên 5kg', 'Phòng VIP (> 5kg) - 250.000đ/ngày', '2026-01-25', '2026-01-28', 'Vui chơi thêm 30 phút (+30.000đ/ngày),Cập nhật video hàng ngày (+20.000đ/ngày)', NULL, 3, 900000, 'Pending'),
(NULL, 'Trần Thị B', '0987654321', 'Bông', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-02-01', '2026-02-05', 'Tắm spa khi trả phòng (+150.000đ)', 'Có bệnh nền cần theo dõi', 4, 750000, 'Pending');


-- =============================================
-- BẢNG SPA_BOOKINGS (ĐẶT LỊCH SPA & GROOMING)
-- =============================================

DROP TABLE IF EXISTS `spa_bookings`;
CREATE TABLE `spa_bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `customer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) NOT NULL,
  `pet_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pet_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Chó',
  `spa_package` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_date` date NOT NULL,
  `preferred_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Sáng (9h-12h)',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `price` decimal(18,0) DEFAULT 0,
  `status` varchar(50) DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dữ liệu mẫu cho spa_bookings
INSERT INTO `spa_bookings` (`user_id`, `customer_name`, `phone`, `pet_name`, `pet_type`, `spa_package`, `booking_date`, `preferred_time`, `note`, `price`, `status`) VALUES
(NULL, 'Nguyễn Văn A', '0112233445', 'Kiki', 'Chó', 'Cắt tỉa toàn thân (< 5kg) - 350.000đ', '2026-01-18', 'Sáng (9h-12h)', 'Cắt kiểu Teddy bear', 350000, 'Confirmed'),
(NULL, 'Nguyễn Văn A', '0112233445', 'Miu Miu', 'Mèo', 'Tắm vệ sinh (< 5kg) - 150.000đ', '2026-01-20', 'Chiều (14h-17h)', NULL, 150000, 'Pending'),
(NULL, 'Lê Văn C', '0909123456', 'Bông', 'Chó', 'Combo VIP (Tắm + Cắt tỉa + Nhuộm) - Liên hệ', '2026-01-22', 'Sáng (9h-12h)', 'Nhuộm màu hồng nhạt ở tai', 0, 'Pending'),
(NULL, 'Phạm Thị D', '0912345678', 'Mochi', 'Chó', 'Cắt tỉa toàn thân (> 5kg) - 500.000đ', '2026-01-25', 'Tối (17h-19h)', 'Bé nhát người, cần nhẹ nhàng', 500000, 'Pending');
