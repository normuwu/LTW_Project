-- Tạo bảng Reviews cho đánh giá sản phẩm
USE petvaccine;

CREATE TABLE IF NOT EXISTS Reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

-- Thêm một số đánh giá mẫu
INSERT INTO Reviews (product_id, user_id, rating, comment) VALUES
(1, 1, 5, 'Sản phẩm rất tốt, mèo nhà mình rất thích!'),
(1, 2, 4, 'Chất lượng ổn, giao hàng nhanh'),
(2, 1, 5, 'Thức ăn chất lượng cao, đóng gói cẩn thận');
