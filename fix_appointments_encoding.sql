-- Fix encoding cho bảng appointments
-- Chạy file này để sửa dữ liệu tiếng Việt bị lỗi

SET NAMES utf8mb4;

-- Xóa dữ liệu cũ bị lỗi encoding
DELETE FROM appointments WHERE customer_name LIKE '%?%' OR pet_type LIKE '%?%';

-- Thêm lại dữ liệu mẫu với encoding đúng
INSERT INTO appointments (user_id, customer_name, phone, pet_name, pet_type, service_id, doctor_id, booking_date, note, status) VALUES
(2, 'Nguyễn Văn An', '0901234567', 'Lucky', 'Chó', 1, 1, DATE_ADD(CURDATE(), INTERVAL 3 DAY), 'Khám sức khỏe định kỳ', 'Pending'),
(2, 'Nguyễn Văn An', '0901234567', 'Miu', 'Mèo', 3, 2, DATE_ADD(CURDATE(), INTERVAL 5 DAY), 'Tiêm vaccine dại', 'Confirmed'),
(NULL, 'Trần Thị Bình', '0912345678', 'Bông', 'Chó', 2, 1, DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'Phẫu thuật triệt sản', 'Pending'),
(NULL, 'Lê Văn Cường', '0923456789', 'Tom', 'Mèo', 4, NULL, DATE_ADD(CURDATE(), INTERVAL 2 DAY), 'Tắm spa và cắt tỉa lông', 'Confirmed'),
(NULL, 'Phạm Thị Dung', '0934567890', 'Rex', 'Chó', 5, NULL, DATE_ADD(CURDATE(), INTERVAL 10 DAY), 'Gửi khách sạn 3 ngày', 'Pending');

SELECT 'Đã fix encoding cho bảng appointments!' as Result;
