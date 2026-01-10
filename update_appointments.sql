-- Thêm cột user_id vào bảng appointments
ALTER TABLE appointments ADD COLUMN user_id INT DEFAULT NULL;

-- Thêm foreign key (optional)
ALTER TABLE appointments ADD CONSTRAINT fk_user_appointment 
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL;

-- Cập nhật các lịch hẹn cũ (nếu có) - gán cho user1 làm demo
UPDATE appointments SET user_id = 2 WHERE user_id IS NULL;
