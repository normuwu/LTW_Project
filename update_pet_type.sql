USE petvaccine;

-- Thêm cột pet_type vào bảng appointments (nếu có)
-- Kiểm tra xem bảng appointments có tồn tại không
SHOW TABLES LIKE 'appointments';

-- Nếu bảng appointments tồn tại, thêm cột pet_type
-- ALTER TABLE appointments ADD COLUMN pet_type VARCHAR(50) DEFAULT 'Chó';

-- Tạo bảng appointments nếu chưa có
CREATE TABLE IF NOT EXISTS appointments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    owner_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    pet_name VARCHAR(100) NOT NULL,
    pet_type VARCHAR(50) DEFAULT 'Chó',
    appointment_date DATE NOT NULL,
    service_type VARCHAR(100) NOT NULL,
    doctor_name VARCHAR(100) NOT NULL,
    notes TEXT,
    status VARCHAR(50) DEFAULT 'Chờ xác nhận',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Thêm dữ liệu mẫu
INSERT INTO appointments (owner_name, phone, pet_name, pet_type, appointment_date, service_type, doctor_name, notes, status) VALUES
('Nguyễn Văn A', '0123456789', 'Mimi', 'Mèo', '2026-01-10', 'Tiêm vaccine', 'Bác sĩ Ngọc Thành', 'Tiêm vaccine 5 bệnh', 'Đã xác nhận'),
('Trần Thị B', '0987654321', 'Lucky', 'Chó', '2026-01-12', 'Khám tổng quát', 'Bác sĩ Huyền Trang', 'Khám sức khỏe định kỳ', 'Chờ xác nhận'),
('Lê Văn C', '0369852147', 'Kitty', 'Mèo', '2026-01-15', 'Spa & Grooming', 'Bác sĩ Mai Phạm', 'Cắt tỉa lông và tắm', 'Hoàn thành');

SELECT 'Bảng appointments đã được cập nhật với cột pet_type!' AS Message;