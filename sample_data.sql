-- =============================================
-- DỮ LIỆU MẪU ĐỂ TEST TẤT CẢ TÍNH NĂNG
-- =============================================

USE `petvaccine`;

-- =============================================
-- 1. USERS (Người dùng) - 15 users
-- =============================================
DELETE FROM `users` WHERE id > 0;
ALTER TABLE `users` AUTO_INCREMENT = 1;

INSERT INTO `users` (`username`, `password`, `fullname`, `email`, `role`, `status`, `phone`, `address`) VALUES
('admin', '123456', 'Quản trị viên', 'admin@petvaccine.com', 'admin', 'active', '0901234567', 'Số 1 Đường ABC, Quận 1, TP.HCM'),
('doctor1', '123456', 'Bác sĩ Ngọc Thành', 'doctor1@petvaccine.com', 'doctor', 'active', '0902345678', 'Số 2 Đường XYZ, Quận 2, TP.HCM'),
('doctor2', '123456', 'Bác sĩ Huyền Trang', 'doctor2@petvaccine.com', 'doctor', 'active', '0903456789', 'Số 3 Đường DEF, Quận 3, TP.HCM'),
('user1', '123456', 'Nguyễn Văn An', 'nguyenvanan@gmail.com', 'user', 'active', '0904567890', 'Số 10 Nguyễn Huệ, Quận 1, TP.HCM'),
('user2', '123456', 'Trần Thị Bình', 'tranthibinh@gmail.com', 'user', 'active', '0905678901', 'Số 20 Lê Lợi, Quận 1, TP.HCM'),
('user3', '123456', 'Lê Văn Cường', 'levancuong@gmail.com', 'user', 'active', '0906789012', 'Số 30 Hai Bà Trưng, Quận 3, TP.HCM'),
('user4', '123456', 'Phạm Thị Dung', 'phamthidung@gmail.com', 'user', 'active', '0907890123', 'Số 40 Điện Biên Phủ, Quận Bình Thạnh'),
('user5', '123456', 'Hoàng Văn Em', 'hoangvanem@gmail.com', 'user', 'active', '0908901234', 'Số 50 Cách Mạng Tháng 8, Quận 10'),
('user6', '123456', 'Võ Thị Phương', 'vothiphuong@gmail.com', 'user', 'active', '0909012345', 'Số 60 Nguyễn Thị Minh Khai, Quận 1'),
('user7', '123456', 'Đặng Văn Giang', 'dangvangiang@gmail.com', 'user', 'active', '0910123456', 'Số 70 Võ Văn Tần, Quận 3'),
('user8', '123456', 'Bùi Thị Hoa', 'buithihoa@gmail.com', 'user', 'active', '0911234567', 'Số 80 Pasteur, Quận 1'),
('user9', '123456', 'Ngô Văn Khoa', 'ngovankhoa@gmail.com', 'user', 'active', '0912345678', 'Số 90 Nam Kỳ Khởi Nghĩa, Quận 1'),
('user10', '123456', 'Lý Thị Lan', 'lythilan@gmail.com', 'user', 'active', '0913456789', 'Số 100 Trần Hưng Đạo, Quận 5'),
('user11', '123456', 'Trương Văn Minh', 'truongvanminh@gmail.com', 'user', 'inactive', '0914567890', 'Số 110 Lý Tự Trọng, Quận 1'),
('user12', '123456', 'Mai Thị Ngọc', 'maithingoc@gmail.com', 'user', 'active', '0915678901', 'Số 120 Nguyễn Đình Chiểu, Quận 3');

-- =============================================
-- 2. VACCINES (Vaccine) - 15 loại
-- =============================================
DELETE FROM `vaccines` WHERE id > 0;
ALTER TABLE `vaccines` AUTO_INCREMENT = 1;

INSERT INTO `vaccines` (`name`, `description`, `target_species`, `manufacturer`, `price`, `doses_required`, `interval_days`, `min_age_weeks`, `stock_quantity`, `is_active`) VALUES
('Vaccine 5 bệnh chó (5in1)', 'Phòng Care, Parvo, Viêm gan, Ho cũi, Phó cúm', 'Chó', 'Nobivac', 250000, 3, 21, 6, 100, 1),
('Vaccine 7 bệnh chó (7in1)', 'Phòng 5 bệnh + Lepto + Corona', 'Chó', 'Vanguard Plus', 350000, 3, 21, 8, 80, 1),
('Vaccine dại (Rabisin)', 'Phòng bệnh dại cho chó mèo', 'Tất cả', 'Merial', 150000, 1, 365, 12, 150, 1),
('Vaccine 4 bệnh mèo (FVRCP)', 'Phòng Viêm mũi, Calici, Panleukopenia', 'Mèo', 'Felocell', 280000, 2, 28, 8, 60, 1),
('Vaccine FeLV (Bạch cầu mèo)', 'Phòng virus gây bạch cầu ở mèo', 'Mèo', 'Purevax', 320000, 2, 21, 8, 40, 1),
('Vaccine Kennel Cough', 'Phòng ho cũi cho chó', 'Chó', 'Nobivac KC', 200000, 1, 365, 8, 50, 1),
('Vaccine Lyme', 'Phòng bệnh Lyme do ve truyền', 'Chó', 'Merial', 380000, 2, 21, 12, 30, 1),
('Vaccine Giardia', 'Phòng ký sinh trùng Giardia', 'Chó', 'Fort Dodge', 220000, 2, 14, 8, 25, 1),
('Vaccine Lepto', 'Phòng bệnh Leptospirosis', 'Chó', 'Nobivac Lepto', 180000, 2, 21, 8, 45, 1),
('Vaccine FIP (Viêm phúc mạc mèo)', 'Phòng viêm phúc mạc truyền nhiễm', 'Mèo', 'Primucell', 450000, 2, 21, 16, 20, 1),
('Vaccine Bordetella', 'Phòng viêm phế quản truyền nhiễm', 'Chó', 'Bronchi-Shield', 190000, 1, 180, 8, 35, 1),
('Vaccine Chlamydia mèo', 'Phòng nhiễm Chlamydia ở mèo', 'Mèo', 'Felovax', 260000, 2, 21, 9, 28, 1),
('Vaccine Corona chó', 'Phòng virus Corona ở chó', 'Chó', 'Duramune', 210000, 2, 21, 6, 40, 1),
('Vaccine tổng hợp thỏ', 'Phòng VHD và Myxomatosis', 'Thỏ', 'Nobivac Myxo-RHD', 300000, 1, 365, 10, 15, 1),
('Vaccine cúm chó', 'Phòng virus cúm H3N8/H3N2', 'Chó', 'Nobivac Flu', 280000, 2, 21, 8, 30, 1);


-- =============================================
-- 3. PETS (Thú cưng) - 15 pets
-- =============================================
DELETE FROM `pets` WHERE id > 0;
ALTER TABLE `pets` AUTO_INCREMENT = 1;

INSERT INTO `pets` (`user_id`, `name`, `species`, `breed`, `gender`, `birth_date`, `weight`, `color`, `image`, `notes`) VALUES
(4, 'Lucky', 'Chó', 'Golden Retriever', 'Đực', '2023-03-15', 25.50, 'Vàng', 'pet_golden.jpg', 'Rất thân thiện, thích chơi bóng'),
(4, 'Miu Miu', 'Mèo', 'Mèo Anh lông ngắn', 'Cái', '2024-01-20', 4.20, 'Xám xanh', 'pet_british.jpg', 'Nhát người, cần chăm sóc nhẹ nhàng'),
(5, 'Bông', 'Chó', 'Poodle', 'Cái', '2022-08-10', 5.80, 'Trắng', 'pet_poodle.jpg', 'Đã triệt sản'),
(5, 'Mochi', 'Mèo', 'Mèo Ba Tư', 'Đực', '2023-06-05', 5.50, 'Trắng kem', 'pet_persian.jpg', 'Cần chải lông thường xuyên'),
(6, 'Rex', 'Chó', 'German Shepherd', 'Đực', '2021-11-22', 32.00, 'Đen nâu', 'pet_german.jpg', 'Đã huấn luyện cơ bản'),
(6, 'Kitty', 'Mèo', 'Mèo Xiêm', 'Cái', '2024-02-14', 3.80, 'Kem đen', 'pet_siamese.jpg', 'Rất năng động'),
(7, 'Buddy', 'Chó', 'Labrador', 'Đực', '2022-05-30', 28.00, 'Đen', 'pet_labrador.jpg', 'Thích bơi lội'),
(8, 'Nala', 'Mèo', 'Maine Coon', 'Cái', '2023-09-12', 6.50, 'Nâu tabby', 'pet_mainecoon.jpg', 'Kích thước lớn'),
(9, 'Max', 'Chó', 'Husky', 'Đực', '2023-01-08', 22.00, 'Trắng xám', 'pet_husky.jpg', 'Cần vận động nhiều'),
(10, 'Luna', 'Mèo', 'Ragdoll', 'Cái', '2024-04-20', 4.00, 'Trắng xanh', 'pet_ragdoll.jpg', 'Rất hiền lành'),
(11, 'Rocky', 'Chó', 'Bulldog Pháp', 'Đực', '2022-12-01', 12.50, 'Brindle', 'pet_frenchie.jpg', 'Có vấn đề hô hấp nhẹ'),
(12, 'Coco', 'Chó', 'Corgi', 'Cái', '2023-07-18', 11.00, 'Vàng trắng', 'pet_corgi.jpg', 'Rất thông minh'),
(13, 'Tom', 'Mèo', 'Mèo Mướp', 'Đực', '2022-04-25', 4.80, 'Vàng sọc', 'pet_tabby.jpg', 'Mèo hoang được cứu'),
(14, 'Bunny', 'Thỏ', 'Holland Lop', 'Cái', '2024-03-10', 1.80, 'Trắng nâu', 'pet_rabbit.jpg', 'Cần chế độ ăn đặc biệt'),
(15, 'Daisy', 'Chó', 'Shiba Inu', 'Cái', '2023-10-05', 9.50, 'Vàng cam', 'pet_shiba.jpg', 'Tính cách độc lập');

-- =============================================
-- 4. APPOINTMENTS (Lịch hẹn) - 15 appointments
-- =============================================
DELETE FROM `appointments` WHERE id > 0;
ALTER TABLE `appointments` AUTO_INCREMENT = 1;

INSERT INTO `appointments` (`user_id`, `customer_name`, `phone`, `pet_name`, `pet_type`, `service_id`, `doctor_id`, `booking_date`, `note`, `status`) VALUES
(4, 'Nguyễn Văn An', '0904567890', 'Lucky', 'Chó', 3, 1, '2026-01-15', 'Tiêm vaccine dại định kỳ', 'Confirmed'),
(4, 'Nguyễn Văn An', '0904567890', 'Miu Miu', 'Mèo', 1, 2, '2026-01-16', 'Khám tổng quát, bé biếng ăn', 'Pending'),
(5, 'Trần Thị Bình', '0905678901', 'Bông', 'Chó', 4, 3, '2026-01-17', 'Tắm spa và cắt tỉa lông', 'Confirmed'),
(5, 'Trần Thị Bình', '0905678901', 'Mochi', 'Mèo', 3, 1, '2026-01-18', 'Tiêm vaccine 4 bệnh mèo', 'Pending'),
(6, 'Lê Văn Cường', '0906789012', 'Rex', 'Chó', 1, 2, '2026-01-19', 'Khám da, nghi ngờ nấm', 'Completed'),
(6, 'Lê Văn Cường', '0906789012', 'Kitty', 'Mèo', 2, 4, '2026-01-20', 'Phẫu thuật triệt sản', 'Confirmed'),
(7, 'Phạm Thị Dung', '0907890123', 'Buddy', 'Chó', 3, 1, '2026-01-21', 'Tiêm vaccine 7 bệnh', 'Pending'),
(8, 'Hoàng Văn Em', '0908901234', 'Nala', 'Mèo', 1, 2, '2026-01-22', 'Khám mắt, chảy nước mắt nhiều', 'Pending'),
(9, 'Võ Thị Phương', '0909012345', 'Max', 'Chó', 4, 3, '2026-01-23', 'Spa full combo', 'Confirmed'),
(10, 'Đặng Văn Giang', '0910123456', 'Luna', 'Mèo', 3, 1, '2026-01-24', 'Tiêm vaccine FeLV', 'Pending'),
(11, 'Bùi Thị Hoa', '0911234567', 'Rocky', 'Chó', 1, 2, '2026-01-25', 'Khám hô hấp định kỳ', 'Cancelled'),
(12, 'Ngô Văn Khoa', '0912345678', 'Coco', 'Chó', 5, 5, '2026-01-26', 'Gửi khách sạn 3 ngày', 'Confirmed'),
(13, 'Lý Thị Lan', '0913456789', 'Tom', 'Mèo', 1, 1, '2026-01-27', 'Khám sức khỏe tổng quát', 'Pending'),
(14, 'Trương Văn Minh', '0914567890', 'Bunny', 'Thỏ', 3, 2, '2026-01-28', 'Tiêm vaccine thỏ', 'Pending'),
(15, 'Mai Thị Ngọc', '0915678901', 'Daisy', 'Chó', 4, 3, '2026-01-29', 'Cắt tỉa lông kiểu Nhật', 'Confirmed');


-- =============================================
-- 5. VACCINATION_RECORDS (Lịch sử tiêm chủng) - 15 records
-- =============================================
DELETE FROM `vaccination_records` WHERE id > 0;
ALTER TABLE `vaccination_records` AUTO_INCREMENT = 1;

INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `appointment_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) VALUES
(1, 1, 1, 1, '2023-05-15', 1, 'NB2023051501', '2023-06-05', 'Mũi 1 vaccine 5 bệnh'),
(1, 1, NULL, 1, '2023-06-05', 2, 'NB2023060502', '2023-06-26', 'Mũi 2 vaccine 5 bệnh'),
(1, 1, NULL, 1, '2023-06-26', 3, 'NB2023062603', '2024-06-26', 'Mũi 3 vaccine 5 bệnh - hoàn thành'),
(1, 3, NULL, 2, '2023-07-15', 1, 'RB2023071501', '2024-07-15', 'Vaccine dại'),
(2, 4, NULL, 2, '2024-03-20', 1, 'FC2024032001', '2024-04-17', 'Mũi 1 vaccine 4 bệnh mèo'),
(2, 4, NULL, 2, '2024-04-17', 2, 'FC2024041702', '2025-04-17', 'Mũi 2 vaccine 4 bệnh mèo - hoàn thành'),
(3, 2, NULL, 1, '2022-10-10', 1, 'VP2022101001', '2022-10-31', 'Mũi 1 vaccine 7 bệnh'),
(3, 2, NULL, 1, '2022-10-31', 2, 'VP2022103102', '2022-11-21', 'Mũi 2 vaccine 7 bệnh'),
(3, 2, NULL, 1, '2022-11-21', 3, 'VP2022112103', '2023-11-21', 'Mũi 3 vaccine 7 bệnh - hoàn thành'),
(5, 1, NULL, 3, '2022-01-22', 1, 'NB2022012201', '2022-02-12', 'Mũi 1 vaccine 5 bệnh'),
(7, 2, NULL, 1, '2022-07-30', 1, 'VP2022073001', '2022-08-20', 'Mũi 1 vaccine 7 bệnh'),
(9, 1, NULL, 2, '2023-03-08', 1, 'NB2023030801', '2023-03-29', 'Mũi 1 vaccine 5 bệnh'),
(10, 4, NULL, 1, '2024-06-20', 1, 'FC2024062001', '2024-07-18', 'Mũi 1 vaccine 4 bệnh mèo'),
(12, 6, NULL, 3, '2023-09-18', 1, 'KC2023091801', '2024-09-18', 'Vaccine Kennel Cough'),
(14, 14, NULL, 2, '2024-05-10', 1, 'MR2024051001', '2025-05-10', 'Vaccine tổng hợp thỏ');

-- =============================================
-- 6. HOTEL_BOOKINGS (Đặt phòng khách sạn) - 15 bookings
-- =============================================
DELETE FROM `hotel_bookings` WHERE id > 0;
ALTER TABLE `hotel_bookings` AUTO_INCREMENT = 1;

INSERT INTO `hotel_bookings` (`user_id`, `customer_name`, `phone`, `pet_name`, `pet_type`, `pet_weight`, `room_type`, `check_in_date`, `check_out_date`, `extra_services`, `note`, `total_nights`, `total_price`, `status`) VALUES
(4, 'Nguyễn Văn An', '0904567890', 'Miu Miu', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-01-20', '2026-01-23', 'Chế độ ăn cao cấp (+50.000đ/ngày)', 'Bé nhát người', 3, 600000, 'Confirmed'),
(5, 'Trần Thị Bình', '0905678901', 'Mochi', 'Mèo', 'Trên 5kg', 'Phòng VIP (> 5kg) - 250.000đ/ngày', '2026-01-25', '2026-01-30', 'Vui chơi thêm 30 phút (+30.000đ/ngày),Cập nhật video hàng ngày (+20.000đ/ngày)', NULL, 5, 1500000, 'Pending'),
(6, 'Lê Văn Cường', '0906789012', 'Kitty', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-02-01', '2026-02-03', NULL, 'Cần phòng yên tĩnh', 2, 300000, 'Pending'),
(8, 'Hoàng Văn Em', '0908901234', 'Nala', 'Mèo', 'Trên 5kg', 'Phòng VIP (> 5kg) - 250.000đ/ngày', '2026-02-05', '2026-02-10', 'Tắm spa khi trả phòng (+150.000đ)', 'Maine Coon cần phòng rộng', 5, 1400000, 'Confirmed'),
(10, 'Đặng Văn Giang', '0910123456', 'Luna', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-02-14', '2026-02-16', 'Chế độ ăn cao cấp (+50.000đ/ngày)', 'Dịp Valentine', 2, 400000, 'Pending'),
(NULL, 'Nguyễn Thị Hương', '0916789012', 'Mèo Mập', 'Mèo', 'Trên 5kg', 'Phòng VIP (> 5kg) - 250.000đ/ngày', '2026-01-18', '2026-01-20', NULL, NULL, 2, 500000, 'Completed'),
(NULL, 'Trần Văn Hùng', '0917890123', 'Miu', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-01-22', '2026-01-25', 'Cập nhật video hàng ngày (+20.000đ/ngày)', 'Lần đầu gửi', 3, 510000, 'Confirmed'),
(NULL, 'Lê Thị Mai', '0918901234', 'Bé Bông', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-02-08', '2026-02-12', 'Chế độ ăn cao cấp (+50.000đ/ngày),Vui chơi thêm 30 phút (+30.000đ/ngày)', NULL, 4, 920000, 'Pending'),
(NULL, 'Phạm Văn Nam', '0919012345', 'Simba', 'Mèo', 'Trên 5kg', 'Phòng VIP (> 5kg) - 250.000đ/ngày', '2026-02-20', '2026-02-25', 'Tắm spa khi trả phòng (+150.000đ)', 'Mèo lớn tuổi', 5, 1400000, 'Pending'),
(NULL, 'Hoàng Thị Oanh', '0920123456', 'Mèo Con', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-01-28', '2026-01-30', NULL, 'Mèo con 6 tháng', 2, 300000, 'Cancelled'),
(4, 'Nguyễn Văn An', '0904567890', 'Miu Miu', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-03-01', '2026-03-05', 'Chế độ ăn cao cấp (+50.000đ/ngày),Cập nhật video hàng ngày (+20.000đ/ngày)', 'Đi công tác', 4, 880000, 'Pending'),
(NULL, 'Võ Văn Quang', '0921234567', 'Mướp', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-01-15', '2026-01-17', NULL, NULL, 2, 300000, 'Completed'),
(NULL, 'Đỗ Thị Rạng', '0922345678', 'Mèo Đen', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-02-28', '2026-03-02', 'Vui chơi thêm 30 phút (+30.000đ/ngày)', NULL, 2, 360000, 'Pending'),
(NULL, 'Bùi Văn Sơn', '0923456789', 'Mèo Vàng', 'Mèo', 'Trên 5kg', 'Phòng VIP (> 5kg) - 250.000đ/ngày', '2026-03-10', '2026-03-15', 'Chế độ ăn cao cấp (+50.000đ/ngày),Tắm spa khi trả phòng (+150.000đ)', 'Cần chăm sóc đặc biệt', 5, 1650000, 'Pending'),
(NULL, 'Ngô Thị Tâm', '0924567890', 'Miu Trắng', 'Mèo', 'Dưới 5kg', 'Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày', '2026-01-10', '2026-01-12', NULL, NULL, 2, 300000, 'Completed');


-- =============================================
-- 7. SPA_BOOKINGS (Đặt lịch Spa) - 15 bookings
-- =============================================
DELETE FROM `spa_bookings` WHERE id > 0;
ALTER TABLE `spa_bookings` AUTO_INCREMENT = 1;

INSERT INTO `spa_bookings` (`user_id`, `customer_name`, `phone`, `pet_name`, `pet_type`, `spa_package`, `booking_date`, `preferred_time`, `note`, `price`, `status`) VALUES
(4, 'Nguyễn Văn An', '0904567890', 'Lucky', 'Chó', 'Cắt tỉa toàn thân (> 5kg) - 500.000đ', '2026-01-18', 'Sáng (9h-12h)', 'Cắt kiểu Teddy bear', 500000, 'Confirmed'),
(5, 'Trần Thị Bình', '0905678901', 'Bông', 'Chó', 'Tắm vệ sinh (< 5kg) - 150.000đ', '2026-01-19', 'Chiều (14h-17h)', NULL, 150000, 'Pending'),
(6, 'Lê Văn Cường', '0906789012', 'Rex', 'Chó', 'Cắt tỉa toàn thân (> 5kg) - 500.000đ', '2026-01-20', 'Sáng (9h-12h)', 'Cắt ngắn, dễ chăm sóc', 500000, 'Confirmed'),
(7, 'Phạm Thị Dung', '0907890123', 'Buddy', 'Chó', 'Tắm vệ sinh (> 5kg) - 250.000đ', '2026-01-21', 'Tối (17h-19h)', 'Labrador thích nước', 250000, 'Pending'),
(9, 'Võ Thị Phương', '0909012345', 'Max', 'Chó', 'Combo VIP (Tắm + Cắt tỉa + Nhuộm) - Liên hệ', '2026-01-22', 'Sáng (9h-12h)', 'Nhuộm xanh nhạt ở tai', 0, 'Confirmed'),
(12, 'Ngô Văn Khoa', '0912345678', 'Coco', 'Chó', 'Cắt tỉa toàn thân (< 5kg) - 350.000đ', '2026-01-23', 'Chiều (14h-17h)', 'Giữ lông dài ở đuôi', 350000, 'Pending'),
(15, 'Mai Thị Ngọc', '0915678901', 'Daisy', 'Chó', 'Cắt tỉa toàn thân (< 5kg) - 350.000đ', '2026-01-24', 'Sáng (9h-12h)', 'Kiểu Shiba truyền thống', 350000, 'Confirmed'),
(NULL, 'Trần Văn Phúc', '0925678901', 'Milo', 'Chó', 'Tắm vệ sinh (< 5kg) - 150.000đ', '2026-01-25', 'Chiều (14h-17h)', 'Chó con 4 tháng', 150000, 'Pending'),
(NULL, 'Lê Thị Quỳnh', '0926789012', 'Cún Con', 'Chó', 'Cắt tỉa toàn thân (< 5kg) - 350.000đ', '2026-01-26', 'Tối (17h-19h)', NULL, 350000, 'Pending'),
(NULL, 'Phạm Văn Rồng', '0927890123', 'Vàng', 'Chó', 'Tắm vệ sinh (> 5kg) - 250.000đ', '2026-01-27', 'Sáng (9h-12h)', 'Chó ta lông ngắn', 250000, 'Cancelled'),
(4, 'Nguyễn Văn An', '0904567890', 'Miu Miu', 'Mèo', 'Tắm vệ sinh (< 5kg) - 150.000đ', '2026-01-28', 'Chiều (14h-17h)', 'Mèo sợ nước, cần nhẹ nhàng', 150000, 'Pending'),
(NULL, 'Hoàng Thị Sen', '0928901234', 'Bé Đen', 'Chó', 'Combo VIP (Tắm + Cắt tỉa + Nhuộm) - Liên hệ', '2026-01-29', 'Sáng (9h-12h)', 'Nhuộm hồng pastel', 0, 'Confirmed'),
(NULL, 'Võ Văn Tài', '0929012345', 'Poodle', 'Chó', 'Cắt tỉa toàn thân (< 5kg) - 350.000đ', '2026-01-30', 'Chiều (14h-17h)', 'Kiểu Continental', 350000, 'Pending'),
(NULL, 'Đặng Thị Uyên', '0930123456', 'Bông Bông', 'Chó', 'Tắm vệ sinh (< 5kg) - 150.000đ', '2026-01-15', 'Sáng (9h-12h)', NULL, 150000, 'Completed'),
(NULL, 'Bùi Văn Vinh', '0931234567', 'Mập', 'Chó', 'Cắt tỉa toàn thân (> 5kg) - 500.000đ', '2026-01-16', 'Tối (17h-19h)', 'Bulldog, cần cẩn thận vùng mặt', 500000, 'Completed');

-- =============================================
-- 8. CART (Giỏ hàng) - 15 items
-- =============================================
DELETE FROM `cart` WHERE id > 0;
ALTER TABLE `cart` AUTO_INCREMENT = 1;

INSERT INTO `cart` (`user_id`, `product_id`, `quantity`) VALUES
(4, 1, 2),
(4, 2, 1),
(4, 4, 3),
(5, 1, 1),
(5, 3, 2),
(6, 2, 2),
(6, 5, 1),
(7, 1, 3),
(8, 3, 1),
(9, 4, 2),
(10, 1, 1),
(10, 2, 1),
(11, 5, 4),
(12, 3, 1),
(13, 4, 2);

-- =============================================
-- 9. REVIEWS (Đánh giá sản phẩm) - 15 reviews
-- =============================================
DELETE FROM `reviews` WHERE id > 0;
ALTER TABLE `reviews` AUTO_INCREMENT = 1;

INSERT INTO `reviews` (`product_id`, `user_id`, `rating`, `comment`) VALUES
(1, 4, 5, 'Sản phẩm rất tốt, mèo nhà mình rất thích ăn. Lông mượt hẳn sau 2 tuần sử dụng.'),
(1, 5, 4, 'Chất lượng ổn, giao hàng nhanh. Sẽ mua lại.'),
(1, 6, 5, 'Royal Canin luôn là lựa chọn số 1 của mình cho mèo.'),
(2, 4, 5, 'Mèo con nhà mình lớn nhanh và khỏe mạnh nhờ loại hạt này.'),
(2, 7, 4, 'Tốt nhưng giá hơi cao so với các loại khác.'),
(2, 8, 5, 'Đóng gói cẩn thận, hạt thơm, mèo ăn ngon miệng.'),
(3, 5, 5, 'Mèo bị sỏi thận, dùng loại này 3 tháng đã cải thiện rõ rệt.'),
(3, 9, 4, 'Bác sĩ khuyên dùng, hiệu quả tốt.'),
(3, 10, 5, 'Sản phẩm chuyên dụng, đáng tin cậy.'),
(4, 6, 4, 'Pate ngon, mèo thích. Nhưng hộp hơi nhỏ.'),
(4, 11, 5, 'Mèo kén ăn mà vẫn thích loại pate này.'),
(4, 12, 3, 'Bình thường, mèo nhà mình không thích lắm.'),
(5, 4, 5, 'Pate cho mèo con rất mềm, dễ ăn. Bé nhà mình rất thích.'),
(5, 13, 4, 'Chất lượng tốt, giá cả hợp lý.'),
(5, 14, 5, 'Mua cho mèo con mới đón về, bé ăn rất ngon.');

-- =============================================
-- 10. CẬP NHẬT PRODUCTS (Thêm sản phẩm mới)
-- =============================================
DELETE FROM `products` WHERE id > 5;

INSERT INTO `products` (`name`, `image`, `price`, `old_price`, `discount`) VALUES
('Thức Ăn Hạt Cho Chó Con Royal Canin Mini Puppy', 'prod_royal6.jpg', 145000, 0, 0),
('Thức Ăn Hạt Cho Chó Trưởng Thành Royal Canin Maxi Adult', 'prod_royal7.jpg', 165000, 0, 0),
('Pate Cho Chó Royal Canin Mini Adult 85g', 'prod_royal8.jpg', 32000, 40000, 20),
('Snack Thưởng Cho Mèo Temptations 85g', 'prod_tempt1.jpg', 45000, 0, 0),
('Cát Vệ Sinh Cho Mèo Catsan 5L', 'prod_catsan.jpg', 95000, 120000, 21),
('Sữa Tắm Cho Chó Mèo Bio-Groom 355ml', 'prod_biogroom.jpg', 280000, 0, 0),
('Bàn Chải Lông Cho Thú Cưng FURminator', 'prod_furmin.jpg', 450000, 550000, 18),
('Vòng Cổ Chống Ve Rận Seresto', 'prod_seresto.jpg', 650000, 0, 0),
('Nhà Vệ Sinh Cho Mèo Có Nắp', 'prod_litterbox.jpg', 350000, 400000, 13),
('Đồ Chơi Cần Câu Lông Vũ Cho Mèo', 'prod_cattoy.jpg', 55000, 0, 0);
