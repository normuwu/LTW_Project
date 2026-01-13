-- Thêm cột phone và address vào bảng users
ALTER TABLE users ADD COLUMN phone VARCHAR(20) DEFAULT NULL AFTER email;
ALTER TABLE users ADD COLUMN address VARCHAR(255) DEFAULT NULL AFTER phone;
