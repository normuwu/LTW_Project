-- Cập nhật hoặc tạo tài khoản admin
-- Email: admin@gmail.com
-- Password: Admin@123

USE petvaccine;

-- Cách 1: Thử INSERT trước (nếu chưa có admin)
INSERT IGNORE INTO Users (username, password, fullname, email, role) 
VALUES ('admin', 'Admin@123', 'Administrator', 'admin@gmail.com', 'admin');

-- Cách 2: Nếu đã có thì UPDATE bằng id
UPDATE Users SET 
    password = 'Admin@123', 
    email = 'admin@gmail.com',
    fullname = 'Administrator',
    role = 'admin'
WHERE username = 'admin';

-- Kiểm tra kết quả
SELECT * FROM Users WHERE username = 'admin' OR email = 'admin@gmail.com';
