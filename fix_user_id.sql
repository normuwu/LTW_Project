-- Kiểm tra và thêm cột user_id nếu chưa có
-- Chạy script này trong MySQL

-- 1. Thêm cột user_id (nếu chưa có)
ALTER TABLE appointments ADD COLUMN IF NOT EXISTS user_id INT DEFAULT NULL;

-- 2. Cập nhật các lịch hẹn cũ - gán cho user có id = 2 (user1)
UPDATE appointments SET user_id = 2 WHERE user_id IS NULL;

-- 3. Kiểm tra kết quả
SELECT id, customer_name, user_id, status FROM appointments;
