-- =============================================
-- DU LIEU MAU DE TEST - KHONG XOA DU LIEU CU
-- User IDs: 2=tthhaannhh07, 5=user1, 6=user2
-- =============================================

SET NAMES utf8mb4;

-- =============================================
-- 1. PETS (Thu cung) - 10 pets cho 3 users
-- =============================================
INSERT INTO `pets` (`user_id`, `name`, `species`, `breed`, `gender`, `birth_date`, `weight`, `color`, `image`, `notes`) VALUES
(2, 'Lucky', 'Cho', 'Golden Retriever', 'Duc', '2023-03-15', 25.50, 'Vang', 'webpic1.jpg', 'Rat than thien'),
(2, 'Miu Miu', 'Meo', 'Meo Anh long ngan', 'Cai', '2024-01-20', 4.20, 'Xam xanh', 'webpic2.jpg', 'Nhat nguoi'),
(2, 'Bong', 'Cho', 'Poodle', 'Cai', '2022-08-10', 5.80, 'Trang', 'webpic3.jpg', 'Da triet san'),
(5, 'Rex', 'Cho', 'German Shepherd', 'Duc', '2021-11-22', 32.00, 'Den nau', 'webpic4.jpg', 'Da huan luyen'),
(5, 'Kitty', 'Meo', 'Meo Xiem', 'Cai', '2024-02-14', 3.80, 'Kem den', 'webpic5.jpg', 'Nang dong'),
(5, 'Buddy', 'Cho', 'Labrador', 'Duc', '2022-05-30', 28.00, 'Den', 'webpic6.jpg', 'Thich boi loi'),
(6, 'Nala', 'Meo', 'Maine Coon', 'Cai', '2023-09-12', 6.50, 'Nau tabby', 'webpic7.jpg', 'Kich thuoc lon'),
(6, 'Max', 'Cho', 'Husky', 'Duc', '2023-01-08', 22.00, 'Trang xam', 'webpic8.jpg', 'Can van dong nhieu'),
(6, 'Luna', 'Meo', 'Ragdoll', 'Cai', '2024-04-20', 4.00, 'Trang xanh', 'webpic9.jpg', 'Rat hien lanh'),
(2, 'Coco', 'Cho', 'Corgi', 'Cai', '2023-07-18', 11.00, 'Vang trang', 'webpic10.jpg', 'Thong minh');

-- =============================================
-- 2. VACCINES - 10 loai vaccine
-- =============================================
INSERT INTO `vaccines` (`name`, `description`, `target_species`, `manufacturer`, `price`, `doses_required`, `interval_days`, `min_age_weeks`, `stock_quantity`, `is_active`) VALUES
('Vaccine 5 benh cho', 'Phong Care, Parvo, Viem gan, Ho cui, Pho cum', 'Cho', 'Nobivac', 250000, 3, 21, 6, 100, 1),
('Vaccine 7 benh cho', 'Phong 5 benh + Lepto + Corona', 'Cho', 'Vanguard Plus', 350000, 3, 21, 8, 80, 1),
('Vaccine dai', 'Phong benh dai cho cho meo', 'Tat ca', 'Merial', 150000, 1, 365, 12, 150, 1),
('Vaccine 4 benh meo', 'Phong Viem mui, Calici, Panleukopenia', 'Meo', 'Felocell', 280000, 2, 28, 8, 60, 1),
('Vaccine FeLV', 'Phong virus gay bach cau o meo', 'Meo', 'Purevax', 320000, 2, 21, 8, 40, 1),
('Vaccine Kennel Cough', 'Phong ho cui cho cho', 'Cho', 'Nobivac KC', 200000, 1, 365, 8, 50, 1),
('Vaccine Lepto', 'Phong benh Leptospirosis', 'Cho', 'Nobivac Lepto', 180000, 2, 21, 8, 45, 1),
('Vaccine Bordetella', 'Phong viem phe quan truyen nhiem', 'Cho', 'Bronchi-Shield', 190000, 1, 180, 8, 35, 1),
('Vaccine Corona cho', 'Phong virus Corona o cho', 'Cho', 'Duramune', 210000, 2, 21, 6, 40, 1),
('Vaccine cum cho', 'Phong virus cum H3N8/H3N2', 'Cho', 'Nobivac Flu', 280000, 2, 21, 8, 30, 1);

-- =============================================
-- 3. APPOINTMENTS (Lich hen) - 10 appointments
-- =============================================
INSERT INTO `appointments` (`user_id`, `customer_name`, `phone`, `pet_name`, `pet_type`, `service_id`, `doctor_id`, `booking_date`, `note`, `status`) VALUES
(2, 'Thanh', '0901234567', 'Lucky', 'Cho', 3, 1, '2026-01-20', 'Tiem vaccine dai dinh ky', 'Confirmed'),
(2, 'Thanh', '0901234567', 'Miu Miu', 'Meo', 1, 2, '2026-01-21', 'Kham tong quat', 'Pending'),
(2, 'Thanh', '0901234567', 'Bong', 'Cho', 4, 3, '2026-01-22', 'Tam spa va cat tia long', 'Confirmed'),
(5, 'User 1', '0902345678', 'Rex', 'Cho', 1, 1, '2026-01-23', 'Kham da, nghi ngo nam', 'Pending'),
(5, 'User 1', '0902345678', 'Kitty', 'Meo', 2, 2, '2026-01-24', 'Phau thuat triet san', 'Confirmed'),
(5, 'User 1', '0902345678', 'Buddy', 'Cho', 3, 1, '2026-01-25', 'Tiem vaccine 7 benh', 'Pending'),
(6, 'User 2', '0903456789', 'Nala', 'Meo', 1, 3, '2026-01-26', 'Kham mat', 'Pending'),
(6, 'User 2', '0903456789', 'Max', 'Cho', 4, 1, '2026-01-27', 'Spa full combo', 'Confirmed'),
(6, 'User 2', '0903456789', 'Luna', 'Meo', 3, 2, '2026-01-28', 'Tiem vaccine FeLV', 'Pending'),
(2, 'Thanh', '0901234567', 'Coco', 'Cho', 5, 3, '2026-01-29', 'Gui khach san 3 ngay', 'Confirmed');


-- =============================================
-- 4. HOTEL_BOOKINGS - 10 bookings
-- =============================================
INSERT INTO `hotel_bookings` (`user_id`, `customer_name`, `phone`, `pet_name`, `pet_type`, `pet_weight`, `room_type`, `check_in_date`, `check_out_date`, `extra_services`, `note`, `total_nights`, `total_price`, `status`) VALUES
(2, 'Thanh', '0901234567', 'Miu Miu', 'Meo', 'Duoi 5kg', 'Phong Tieu chuan', '2026-01-25', '2026-01-28', 'Che do an cao cap', 'Be nhat nguoi', 3, 600000, 'Confirmed'),
(2, 'Thanh', '0901234567', 'Bong', 'Cho', 'Tren 5kg', 'Phong VIP', '2026-02-01', '2026-02-05', 'Vui choi them 30 phut', NULL, 4, 1200000, 'Pending'),
(5, 'User 1', '0902345678', 'Kitty', 'Meo', 'Duoi 5kg', 'Phong Tieu chuan', '2026-02-10', '2026-02-12', NULL, 'Can phong yen tinh', 2, 300000, 'Pending'),
(5, 'User 1', '0902345678', 'Rex', 'Cho', 'Tren 5kg', 'Phong VIP', '2026-02-15', '2026-02-20', 'Tam spa khi tra phong', 'Cho lon can phong rong', 5, 1400000, 'Confirmed'),
(6, 'User 2', '0903456789', 'Luna', 'Meo', 'Duoi 5kg', 'Phong Tieu chuan', '2026-02-20', '2026-02-22', 'Cap nhat video hang ngay', NULL, 2, 340000, 'Pending'),
(6, 'User 2', '0903456789', 'Nala', 'Meo', 'Tren 5kg', 'Phong VIP', '2026-02-25', '2026-02-28', 'Che do an cao cap', 'Maine Coon', 3, 900000, 'Confirmed'),
(2, 'Thanh', '0901234567', 'Coco', 'Cho', 'Tren 5kg', 'Phong VIP', '2026-03-01', '2026-03-03', NULL, 'Di cong tac', 2, 500000, 'Pending'),
(5, 'User 1', '0902345678', 'Buddy', 'Cho', 'Tren 5kg', 'Phong VIP', '2026-03-05', '2026-03-10', 'Vui choi them 30 phut,Tam spa khi tra phong', 'Labrador thich nuoc', 5, 1550000, 'Pending'),
(6, 'User 2', '0903456789', 'Max', 'Cho', 'Tren 5kg', 'Phong VIP', '2026-03-15', '2026-03-18', 'Che do an cao cap,Cap nhat video hang ngay', 'Husky can van dong', 3, 1050000, 'Confirmed'),
(2, 'Thanh', '0901234567', 'Lucky', 'Cho', 'Tren 5kg', 'Phong VIP', '2026-03-20', '2026-03-25', 'Tam spa khi tra phong', 'Golden than thien', 5, 1400000, 'Pending');

-- =============================================
-- 5. SPA_BOOKINGS - 10 bookings
-- =============================================
INSERT INTO `spa_bookings` (`user_id`, `customer_name`, `phone`, `pet_name`, `pet_type`, `spa_package`, `booking_date`, `preferred_time`, `note`, `price`, `status`) VALUES
(2, 'Thanh', '0901234567', 'Lucky', 'Cho', 'Cat tia toan than (> 5kg) - 500.000d', '2026-01-20', 'Sang (9h-12h)', 'Cat kieu Teddy bear', 500000, 'Confirmed'),
(2, 'Thanh', '0901234567', 'Bong', 'Cho', 'Tam ve sinh (< 5kg) - 150.000d', '2026-01-22', 'Chieu (14h-17h)', NULL, 150000, 'Pending'),
(2, 'Thanh', '0901234567', 'Miu Miu', 'Meo', 'Tam ve sinh (< 5kg) - 150.000d', '2026-01-25', 'Sang (9h-12h)', 'Meo so nuoc', 150000, 'Pending'),
(5, 'User 1', '0902345678', 'Rex', 'Cho', 'Cat tia toan than (> 5kg) - 500.000d', '2026-01-26', 'Sang (9h-12h)', 'Cat ngan de cham soc', 500000, 'Confirmed'),
(5, 'User 1', '0902345678', 'Buddy', 'Cho', 'Tam ve sinh (> 5kg) - 250.000d', '2026-01-28', 'Toi (17h-19h)', 'Labrador thich nuoc', 250000, 'Pending'),
(5, 'User 1', '0902345678', 'Kitty', 'Meo', 'Tam ve sinh (< 5kg) - 150.000d', '2026-01-30', 'Chieu (14h-17h)', NULL, 150000, 'Confirmed'),
(6, 'User 2', '0903456789', 'Max', 'Cho', 'Combo VIP (Tam + Cat tia + Nhuom)', '2026-02-01', 'Sang (9h-12h)', 'Nhuom xanh nhat o tai', 800000, 'Pending'),
(6, 'User 2', '0903456789', 'Nala', 'Meo', 'Cat tia toan than (> 5kg) - 500.000d', '2026-02-03', 'Chieu (14h-17h)', 'Maine Coon long dai', 500000, 'Confirmed'),
(6, 'User 2', '0903456789', 'Luna', 'Meo', 'Tam ve sinh (< 5kg) - 150.000d', '2026-02-05', 'Sang (9h-12h)', 'Ragdoll hien lanh', 150000, 'Pending'),
(2, 'Thanh', '0901234567', 'Coco', 'Cho', 'Cat tia toan than (< 5kg) - 350.000d', '2026-02-08', 'Toi (17h-19h)', 'Kieu Corgi truyen thong', 350000, 'Confirmed');

-- =============================================
-- 6. CART (Gio hang) - 10 items
-- =============================================
INSERT INTO `cart` (`user_id`, `product_id`, `quantity`) VALUES
(2, 1, 2),
(2, 2, 1),
(2, 4, 3),
(5, 1, 1),
(5, 3, 2),
(5, 5, 1),
(6, 2, 2),
(6, 3, 1),
(6, 4, 2),
(2, 5, 1);

-- =============================================
-- 7. REVIEWS (Danh gia san pham) - 10 reviews
-- =============================================
INSERT INTO `reviews` (`product_id`, `user_id`, `rating`, `comment`) VALUES
(1, 2, 5, 'San pham rat tot, meo nha minh rat thich an'),
(1, 5, 4, 'Chat luong on, giao hang nhanh'),
(2, 2, 5, 'Meo con nha minh lon nhanh va khoe manh'),
(2, 6, 4, 'Tot nhung gia hoi cao'),
(3, 5, 5, 'Meo bi soi than, dung loai nay da cai thien'),
(3, 6, 4, 'Bac si khuyen dung, hieu qua tot'),
(4, 2, 5, 'Pate ngon, meo thich'),
(4, 5, 3, 'Binh thuong, meo nha minh khong thich lam'),
(5, 6, 5, 'Pate cho meo con rat mem, de an'),
(5, 2, 4, 'Chat luong tot, gia ca hop ly');

-- =============================================
-- 8. VACCINATION_RECORDS - 10 records
-- =============================================
-- Lay pet_id tu pets vua them (gia su bat dau tu id 1)
INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `appointment_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) 
SELECT p.id, 1, NULL, 1, '2025-06-15', 1, 'NB2025061501', '2025-07-06', 'Mui 1 vaccine 5 benh'
FROM pets p WHERE p.user_id = 2 AND p.name = 'Lucky' LIMIT 1;

INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `appointment_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) 
SELECT p.id, 3, NULL, 2, '2025-07-15', 1, 'RB2025071501', '2026-07-15', 'Vaccine dai'
FROM pets p WHERE p.user_id = 2 AND p.name = 'Lucky' LIMIT 1;

INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `appointment_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) 
SELECT p.id, 4, NULL, 2, '2025-03-20', 1, 'FC2025032001', '2025-04-17', 'Mui 1 vaccine 4 benh meo'
FROM pets p WHERE p.user_id = 2 AND p.name = 'Miu Miu' LIMIT 1;

INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `appointment_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) 
SELECT p.id, 2, NULL, 1, '2025-01-10', 1, 'VP2025011001', '2025-01-31', 'Mui 1 vaccine 7 benh'
FROM pets p WHERE p.user_id = 2 AND p.name = 'Bong' LIMIT 1;

INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `appointment_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) 
SELECT p.id, 1, NULL, 3, '2024-12-22', 1, 'NB2024122201', '2025-01-12', 'Mui 1 vaccine 5 benh'
FROM pets p WHERE p.user_id = 5 AND p.name = 'Rex' LIMIT 1;

INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `appointment_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) 
SELECT p.id, 4, NULL, 2, '2025-04-14', 1, 'FC2025041401', '2025-05-12', 'Mui 1 vaccine 4 benh meo'
FROM pets p WHERE p.user_id = 5 AND p.name = 'Kitty' LIMIT 1;

INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `appointment_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) 
SELECT p.id, 2, NULL, 1, '2024-08-30', 1, 'VP2024083001', '2024-09-20', 'Mui 1 vaccine 7 benh'
FROM pets p WHERE p.user_id = 5 AND p.name = 'Buddy' LIMIT 1;

INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `appointment_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) 
SELECT p.id, 5, NULL, 3, '2025-11-12', 1, 'PV2025111201', '2025-12-03', 'Mui 1 vaccine FeLV'
FROM pets p WHERE p.user_id = 6 AND p.name = 'Nala' LIMIT 1;

INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `appointment_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) 
SELECT p.id, 1, NULL, 1, '2025-03-08', 1, 'NB2025030801', '2025-03-29', 'Mui 1 vaccine 5 benh'
FROM pets p WHERE p.user_id = 6 AND p.name = 'Max' LIMIT 1;

INSERT INTO `vaccination_records` (`pet_id`, `vaccine_id`, `appointment_id`, `doctor_id`, `vaccination_date`, `dose_number`, `batch_number`, `next_due_date`, `notes`) 
SELECT p.id, 4, NULL, 2, '2025-06-20', 1, 'FC2025062001', '2025-07-18', 'Mui 1 vaccine 4 benh meo'
FROM pets p WHERE p.user_id = 6 AND p.name = 'Luna' LIMIT 1;
