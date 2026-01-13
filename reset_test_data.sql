-- =============================================
-- RESET VÀ THÊM DỮ LIỆU TEST MỚI
-- File này xóa dữ liệu cũ bị lỗi encoding
-- và thêm dữ liệu mới với tiếng Việt đầy đủ dấu
-- =============================================

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- =============================================
-- 1. XÓA DỮ LIỆU CŨ (theo thứ tự để tránh lỗi FK)
-- =============================================

-- Xóa vaccination_records trước (phụ thuộc pets, vaccines, appointments)
DELETE FROM vaccination_records;

-- Xóa cart (phụ thuộc users, products)
DELETE FROM cart;

-- Xóa reviews (phụ thuộc users, products)
DELETE FROM reviews;

-- Xóa appointments (phụ thuộc users, services, doctors)
DELETE FROM appointments;

-- Xóa hotel_bookings và spa_bookings
DELETE FROM hotel_bookings;
DELETE FROM spa_bookings;

-- Xóa pets (phụ thuộc users)
DELETE FROM pets;

-- Reset AUTO_INCREMENT
ALTER TABLE vaccination_records AUTO_INCREMENT = 1;
ALTER TABLE cart AUTO_INCREMENT = 1;
ALTER TABLE reviews AUTO_INCREMENT = 1;
ALTER TABLE appointments AUTO_INCREMENT = 1;
ALTER TABLE hotel_bookings AUTO_INCREMENT = 1;
ALTER TABLE spa_bookings AUTO_INCREMENT = 1;
ALTER TABLE pets AUTO_INCREMENT = 1;

-- =============================================
-- 2. THÊM DỮ LIỆU USERS MẪU (nếu chưa có)
-- =============================================

-- Kiểm tra và thêm user test nếu chưa có
INSERT IGNORE INTO users (id, username, password, fullname, email, phone, role, status) VALUES
(2, 'user1', '123456', 'Nguyễn Văn An', 'nguyenvanan@gmail.com', '0901234567', 'user', 'active'),
(3, 'user2', '123456', 'Trần Thị Bình', 'tranthibinh@gmail.com', '0912345678', 'user', 'active'),
(4, 'user3', '123456', 'Lê Văn Cường', 'levancuong@gmail.com', '0923456789', 'user', 'active'),
(5, 'user4', '123456', 'Phạm Thị Dung', 'phamthidung@gmail.com', '0934567890', 'user', 'active'),
(6, 'user5', '123456', 'Hoàng Văn Em', 'hoangvanem@gmail.com', '0945678901', 'user', 'active');

-- =============================================
-- 3. THÊM DỮ LIỆU PETS
-- =============================================

INSERT INTO pets (user_id, name, species, breed, gender, birth_date, weight, color, notes) VALUES
-- User 2 (Nguyễn Văn An)
(2, 'Lucky', 'Chó', 'Poodle', 'Đực', '2022-03-15', 5.5, 'Trắng', 'Rất ngoan và thân thiện'),
(2, 'Miu', 'Mèo', 'Mèo Anh lông ngắn', 'Cái', '2023-01-20', 4.2, 'Xám', 'Thích ngủ và ăn'),

-- User 3 (Trần Thị Bình)
(3, 'Bông', 'Chó', 'Corgi', 'Cái', '2021-08-10', 12.0, 'Vàng trắng', 'Năng động, thích chạy nhảy'),
(3, 'Tom', 'Mèo', 'Mèo Ba Tư', 'Đực', '2022-05-25', 5.0, 'Trắng', 'Lông dài, cần chải thường xuyên'),

-- User 4 (Lê Văn Cường)
(4, 'Rex', 'Chó', 'Golden Retriever', 'Đực', '2020-12-01', 28.0, 'Vàng', 'Rất thông minh và trung thành'),
(4, 'Kitty', 'Mèo', 'Mèo Munchkin', 'Cái', '2023-06-15', 3.5, 'Cam', 'Chân ngắn, rất dễ thương'),

-- User 5 (Phạm Thị Dung)
(5, 'Buddy', 'Chó', 'Husky', 'Đực', '2021-04-20', 22.0, 'Đen trắng', 'Thích hú và chạy'),
(5, 'Luna', 'Mèo', 'Mèo Ragdoll', 'Cái', '2022-09-10', 4.8, 'Trắng xám', 'Rất hiền và thích được ôm'),

-- User 6 (Hoàng Văn Em)
(6, 'Max', 'Chó', 'Shiba Inu', 'Đực', '2022-02-14', 10.0, 'Vàng', 'Biểu cảm hài hước'),
(6, 'Mochi', 'Mèo', 'Mèo Scottish Fold', 'Cái', '2023-03-08', 4.0, 'Xám trắng', 'Tai cụp rất đáng yêu');

-- =============================================
-- 4. THÊM DỮ LIỆU APPOINTMENTS
-- =============================================

INSERT INTO appointments (user_id, customer_name, phone, pet_name, pet_type, service_id, doctor_id, booking_date, note, status) VALUES
-- Lịch hẹn Pending
(2, 'Nguyễn Văn An', '0901234567', 'Lucky', 'Chó', 1, 1, DATE_ADD(CURDATE(), INTERVAL 2 DAY), 'Khám sức khỏe định kỳ cho Lucky', 'Pending'),
(3, 'Trần Thị Bình', '0912345678', 'Bông', 'Chó', 3, 2, DATE_ADD(CURDATE(), INTERVAL 3 DAY), 'Tiêm vaccine phòng dại cho Bông', 'Pending'),
(4, 'Lê Văn Cường', '0923456789', 'Rex', 'Chó', 2, 1, DATE_ADD(CURDATE(), INTERVAL 5 DAY), 'Phẫu thuật triệt sản cho Rex', 'Pending'),

-- Lịch hẹn Confirmed
(2, 'Nguyễn Văn An', '0901234567', 'Miu', 'Mèo', 3, 3, DATE_ADD(CURDATE(), INTERVAL 1 DAY), 'Tiêm vaccine tổng hợp cho Miu', 'Confirmed'),
(5, 'Phạm Thị Dung', '0934567890', 'Buddy', 'Chó', 4, NULL, DATE_ADD(CURDATE(), INTERVAL 4 DAY), 'Tắm spa và cắt tỉa lông cho Buddy', 'Confirmed'),
(6, 'Hoàng Văn Em', '0945678901', 'Max', 'Chó', 5, NULL, DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'Gửi khách sạn 3 ngày cho Max', 'Confirmed'),

-- Lịch hẹn Completed
(3, 'Trần Thị Bình', '0912345678', 'Tom', 'Mèo', 1, 2, DATE_SUB(CURDATE(), INTERVAL 5 DAY), 'Khám bệnh tiêu chảy cho Tom', 'Completed'),
(4, 'Lê Văn Cường', '0923456789', 'Kitty', 'Mèo', 3, 3, DATE_SUB(CURDATE(), INTERVAL 10 DAY), 'Tiêm vaccine cho Kitty', 'Completed'),

-- Lịch hẹn từ khách vãng lai (không có user_id)
(NULL, 'Võ Thị Hoa', '0956789012', 'Mèo Mun', 'Mèo', 1, 1, DATE_ADD(CURDATE(), INTERVAL 6 DAY), 'Khám mắt cho mèo', 'Pending'),
(NULL, 'Đặng Văn Khoa', '0967890123', 'Cún Con', 'Chó', 3, 2, DATE_ADD(CURDATE(), INTERVAL 8 DAY), 'Tiêm vaccine 5 bệnh', 'Pending');

-- =============================================
-- 5. THÊM DỮ LIỆU VACCINATION_RECORDS
-- =============================================

INSERT INTO vaccination_records (pet_id, vaccine_id, doctor_id, vaccination_date, dose_number, batch_number, next_due_date, notes) VALUES
-- Lucky (pet_id = 1)
(1, 1, 1, DATE_SUB(CURDATE(), INTERVAL 30 DAY), 1, 'VAC2024-001', DATE_ADD(CURDATE(), INTERVAL 335 DAY), 'Tiêm vaccine dại mũi 1'),
(1, 2, 1, DATE_SUB(CURDATE(), INTERVAL 60 DAY), 1, 'VAC2024-002', DATE_ADD(CURDATE(), INTERVAL 305 DAY), 'Tiêm vaccine 5 bệnh mũi 1'),

-- Miu (pet_id = 2)
(2, 3, 2, DATE_SUB(CURDATE(), INTERVAL 45 DAY), 1, 'VAC2024-003', DATE_ADD(CURDATE(), INTERVAL 320 DAY), 'Tiêm vaccine tổng hợp mèo'),

-- Bông (pet_id = 3)
(3, 1, 2, DATE_SUB(CURDATE(), INTERVAL 20 DAY), 1, 'VAC2024-004', DATE_ADD(CURDATE(), INTERVAL 345 DAY), 'Tiêm vaccine dại'),
(3, 2, 2, DATE_SUB(CURDATE(), INTERVAL 50 DAY), 2, 'VAC2024-005', DATE_ADD(CURDATE(), INTERVAL 315 DAY), 'Tiêm vaccine 5 bệnh mũi 2'),

-- Rex (pet_id = 5)
(5, 1, 1, DATE_SUB(CURDATE(), INTERVAL 100 DAY), 1, 'VAC2024-006', DATE_ADD(CURDATE(), INTERVAL 265 DAY), 'Tiêm vaccine dại hàng năm'),
(5, 2, 1, DATE_SUB(CURDATE(), INTERVAL 120 DAY), 3, 'VAC2024-007', DATE_ADD(CURDATE(), INTERVAL 245 DAY), 'Tiêm vaccine 5 bệnh mũi 3 - hoàn thành'),

-- Buddy (pet_id = 7)
(7, 1, 3, DATE_SUB(CURDATE(), INTERVAL 15 DAY), 1, 'VAC2024-008', DATE_ADD(CURDATE(), INTERVAL 350 DAY), 'Tiêm vaccine dại cho Buddy');

-- =============================================
-- 6. THÊM DỮ LIỆU HOTEL_BOOKINGS
-- =============================================

INSERT INTO hotel_bookings (user_id, customer_name, phone, pet_name, pet_type, room_type, check_in_date, check_out_date, pet_weight, extra_services, note, status) VALUES
(2, 'Nguyễn Văn An', '0901234567', 'Lucky', 'Chó', 'Phòng VIP', DATE_ADD(CURDATE(), INTERVAL 10 DAY), DATE_ADD(CURDATE(), INTERVAL 13 DAY), '5.5 kg', 'Tắm, Cắt móng', 'Cần chăm sóc đặc biệt', 'Pending'),
(3, 'Trần Thị Bình', '0912345678', 'Tom', 'Mèo', 'Phòng thường', DATE_ADD(CURDATE(), INTERVAL 5 DAY), DATE_ADD(CURDATE(), INTERVAL 7 DAY), '5 kg', 'Tắm', 'Mèo nhút nhát', 'Confirmed'),
(5, 'Phạm Thị Dung', '0934567890', 'Luna', 'Mèo', 'Phòng cao cấp', DATE_ADD(CURDATE(), INTERVAL 15 DAY), DATE_ADD(CURDATE(), INTERVAL 20 DAY), '4.8 kg', 'Tắm, Chải lông, Massage', 'Cần phòng yên tĩnh', 'Pending'),
(NULL, 'Lý Văn Minh', '0978901234', 'Milo', 'Chó', 'Phòng thường', DATE_ADD(CURDATE(), INTERVAL 8 DAY), DATE_ADD(CURDATE(), INTERVAL 10 DAY), '8 kg', NULL, 'Chó hiền', 'Pending');

-- =============================================
-- 7. THÊM DỮ LIỆU SPA_BOOKINGS
-- =============================================

INSERT INTO spa_bookings (user_id, customer_name, phone, pet_name, pet_type, spa_package, preferred_time, booking_date, note, status) VALUES
(2, 'Nguyễn Văn An', '0901234567', 'Lucky', 'Chó', 'Gói cơ bản', 'Sáng (8h-12h)', DATE_ADD(CURDATE(), INTERVAL 3 DAY), 'Tắm và sấy khô', 'Pending'),
(4, 'Lê Văn Cường', '0923456789', 'Rex', 'Chó', 'Gói cao cấp', 'Chiều (13h-17h)', DATE_ADD(CURDATE(), INTERVAL 4 DAY), 'Tắm, cắt tỉa lông, vệ sinh tai', 'Confirmed'),
(5, 'Phạm Thị Dung', '0934567890', 'Buddy', 'Chó', 'Gói VIP', 'Sáng (8h-12h)', DATE_ADD(CURDATE(), INTERVAL 6 DAY), 'Full service bao gồm massage', 'Pending'),
(6, 'Hoàng Văn Em', '0945678901', 'Mochi', 'Mèo', 'Gói cơ bản', 'Chiều (13h-17h)', DATE_ADD(CURDATE(), INTERVAL 2 DAY), 'Chỉ tắm nhẹ nhàng', 'Confirmed'),
(NULL, 'Ngô Thị Oanh', '0989012345', 'Bé Bông', 'Chó', 'Gói cao cấp', 'Sáng (8h-12h)', DATE_ADD(CURDATE(), INTERVAL 5 DAY), 'Cắt tỉa kiểu Hàn Quốc', 'Pending');

-- =============================================
-- 8. THÊM DỮ LIỆU CART
-- =============================================

INSERT INTO cart (user_id, product_id, quantity) VALUES
(2, 1, 2),
(2, 3, 1),
(3, 2, 1),
(3, 5, 3),
(4, 1, 1),
(4, 4, 2),
(5, 6, 1),
(6, 2, 2);

-- =============================================
-- 9. THÊM DỮ LIỆU REVIEWS
-- =============================================

INSERT INTO reviews (user_id, product_id, rating, comment) VALUES
(2, 1, 5, 'Sản phẩm rất tốt, thú cưng của tôi rất thích!'),
(2, 3, 4, 'Chất lượng ổn, giao hàng nhanh'),
(3, 2, 5, 'Tuyệt vời! Sẽ mua lại lần sau'),
(3, 1, 4, 'Sản phẩm đúng mô tả, đóng gói cẩn thận'),
(4, 5, 5, 'Rất hài lòng với sản phẩm này'),
(5, 4, 3, 'Bình thường, không có gì đặc biệt'),
(6, 2, 5, 'Chất lượng xuất sắc, giá cả hợp lý'),
(6, 6, 4, 'Tốt, nhưng giá hơi cao');

-- =============================================
-- HOÀN THÀNH
-- =============================================

SELECT 'Đã reset và thêm dữ liệu test mới thành công!' as Result;
SELECT CONCAT('Tổng pets: ', COUNT(*)) as Info FROM pets;
SELECT CONCAT('Tổng appointments: ', COUNT(*)) as Info FROM appointments;
SELECT CONCAT('Tổng vaccination_records: ', COUNT(*)) as Info FROM vaccination_records;
SELECT CONCAT('Tổng hotel_bookings: ', COUNT(*)) as Info FROM hotel_bookings;
SELECT CONCAT('Tổng spa_bookings: ', COUNT(*)) as Info FROM spa_bookings;
